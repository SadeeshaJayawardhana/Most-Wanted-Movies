package com.movie.utils;

import com.movie.model.Movie;
import com.movie.model.Rental;
import java.util.HashMap;
import java.util.Map;
import javax.servlet.http.HttpSession;
import java.util.*;

/**
 * Utility class for managing rental operations and recently watched movies.
 * Handles rental persistence in the session and file system,
 * and also tracks recently watched movies per user.
 */
public class RentalManager {

    // Key used to store rented movies in the user session
    private static final String RENTED_MOVIES_SESSION_KEY = "rentedMovies";

    public static final int RECENTLY_WATCHED_MAX_SIZE = 10; // Limit to 10 movies
    // Map to keep recently watched movies per user in memory
    private static Map<String, StringStack> watchedMoviesMap = new HashMap<>();

    /**
     * Rent a movie for the currently logged-in user.
     * Adds the movie to the session and persists it to file storage.
     */
    public static void rentMovie(HttpSession session, String title) {
        // Retrieve the rented movies set from session
        Set<String> rentedMovies = (Set<String>) session.getAttribute(RENTED_MOVIES_SESSION_KEY);

        // Initialize the set if it's not yet present
        if (rentedMovies == null) {
            rentedMovies = new HashSet<>();
        }

        // Add the new movie to the set
        rentedMovies.add(title);
        session.setAttribute(RENTED_MOVIES_SESSION_KEY, rentedMovies);

        // Persist rental if the user is logged in
        String username = (String) session.getAttribute("username");
        if (username != null) {
            FileHandler.saveRentedMovie(username, title);
        }
    }

    /**
     * Checks if a specific movie is currently rented by the user (in session).
     */
    public static boolean isMovieRented(HttpSession session, String title) {
        Set<String> rentedMovies = (Set<String>) session.getAttribute(RENTED_MOVIES_SESSION_KEY);
        return rentedMovies != null && rentedMovies.contains(title);
    }

    /**
     * Retrieves a list of Movie objects the user has rented.
     * Matches rented titles with the full movie list.
     */
    public static List<Movie> getRentedMovies(String username) {
        Set<String> rentedTitles = FileHandler.loadRentedMovies(username);
        List<Movie> allMovies = FileHandler.loadMovies();
        List<Movie> rentedMovies = new ArrayList<>();

        // Match rented titles to full movie objects
        for (Movie movie : allMovies) {
            if (rentedTitles.contains(movie.getTitle())) {
                rentedMovies.add(movie);
            }
        }

        return rentedMovies;
    }

    /**
     * Unrents a movie: removes it from the session and persistent storage.
     */
    public static void unrentMovie(String username, String title, HttpSession session) {
        // Remove from persistent file
        FileHandler.removeRentedMovie(username, title);

        // Remove from session set
        Set<String> rentedMovies = (Set<String>) session.getAttribute(RENTED_MOVIES_SESSION_KEY);
        if (rentedMovies != null) {
            rentedMovies.remove(title);
            session.setAttribute(RENTED_MOVIES_SESSION_KEY, rentedMovies);
        }
    }

    /**
     * Adds a movie to the user's recently watched stack.
     * Prevents duplicates if the last watched movie is the same.
     */
    // Add a movie to the user's recently watched stack
    public static void addWatchedMovie(String username, String title) {
        // Always load from file first to ensure freshness
        StringStack stack = FileHandler.loadRecentlyWatched(username);

        // Avoid duplicates
        if (!stack.isEmpty() && stack.peek().equals(title)) return;

        // Remove oldest item if stack is full
        if (stack.size() >= RECENTLY_WATCHED_MAX_SIZE) {
            StringStack temp = new StringStack(RECENTLY_WATCHED_MAX_SIZE);
            // Remove the oldest item (bottom of the stack)
            for (int i = 1; i < stack.size(); i++) {
                temp.push(stack.toList().get(i));
            }
            stack = temp;
        }

        stack.push(title);
        FileHandler.saveRecentlyWatched(stack, username); // Persist immediately
    }

    /**
     * Gets the user's recently watched movies stack.
     * Loaded from memory or file if not cached.
     */
    // Retrieve the user's recently watched stack
    public static StringStack getRecentlyWatched(HttpSession session) {
        String username = (String) session.getAttribute("username");
        return FileHandler.loadRecentlyWatched(username); // Always load from file
    }
}
