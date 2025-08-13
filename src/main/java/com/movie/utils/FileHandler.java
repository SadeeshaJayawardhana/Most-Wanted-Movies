package com.movie.utils;

import com.movie.model.*;

import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.Path;
import java.io.*;
import java.util.*;
import java.util.stream.Collectors;

import static com.movie.utils.RentalManager.RECENTLY_WATCHED_MAX_SIZE;

public class FileHandler {

    // File paths for storing user data, movie data, etc.
    private static final String USER_FILE = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\users.txt";
    private static final String MOVIE_FILE = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\movies.txt";
    private static final String REVIEW_FILE = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\reviews.txt";
    private static final String RENTED_FILE = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\rented_movies.txt";
    private static final String WATCH_LATER_FILE = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\watch_later.txt";
    private static final String DOWNLOAD_FILE = "C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\downloads.txt";


    // ---------------- USER OPERATIONS ----------------

    // Loads all users from the file
    public static List<User> loadUsers() {
        List<User> users = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(USER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 3) {
                    users.add(new User(parts[0], parts[1], parts[2]));
                }
            }
        } catch (IOException e) {
            System.out.println("Couldn't load users: " + e.getMessage());
        }
        return users;
    }

    // Appends a new user to the file
    public static void saveUser(User user) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(USER_FILE, true))) {
            writer.write(user.toString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Couldn't save user: " + e.getMessage());
        }
    }

    // Overwrites the user file with a new list of users
    public static void saveAllUsers(List<User> users) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(USER_FILE))) {
            for (User user : users) {
                bw.write(user.getUsername() + "," + user.getPassword() + "," + user.getEmail());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ---------------- MOVIE OPERATIONS ----------------

    // Loads all movies from the movie file
    public static List<Movie> loadMovies() {
        List<Movie> movies = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(MOVIE_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|\\|\\|", 6);
                if (parts.length == 6) {
                    movies.add(new Movie(parts[0], parts[1], Double.parseDouble(parts[2]), parts[3], parts[4], parts[5]));
                }
            }
        } catch (IOException e) {
            System.out.println("Couldn't load movies: " + e.getMessage());
        }
        return movies;
    }

    // Overwrites the movie file with a new list of movies
    public static void saveAllMovies(List<Movie> movies) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(MOVIE_FILE))) {
            for (Movie movie : movies) {
                bw.write(movie.getTitle() + "|||"
                        + movie.getGenre() + "|||"
                        + movie.getRating() + "|||"
                        + movie.getPosterUrl() + "|||"
                        + movie.getDescription() + "|||"
                        + movie.getWatchUrl());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Appends a new movie to the file, with newline safety
    public static void saveMovie(Movie movie) {
        try {
            File file = new File(MOVIE_FILE);
            boolean needsNewLine = false;

            if (file.exists() && file.length() > 0) {
                RandomAccessFile raf = new RandomAccessFile(file, "r");
                raf.seek(file.length() - 1);
                if (raf.read() != '\n') {
                    needsNewLine = true;
                }
                raf.close();
            }

            try (BufferedWriter writer = new BufferedWriter(new FileWriter(file, true))) {
                if (needsNewLine) writer.newLine();
                writer.write(movie.getTitle() + "|||"
                        + movie.getGenre() + "|||"
                        + movie.getRating() + "|||"
                        + movie.getPosterUrl() + "|||"
                        + movie.getDescription() + "|||"
                        + movie.getWatchUrl());
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Couldn't save movie: " + e.getMessage());
        }
    }

    // Deletes a movie by title
    public static void deleteMovie(String title) {
        List<Movie> movies = loadMovies();
        movies.removeIf(movie -> movie.getTitle().equalsIgnoreCase(title));
        saveAllMovies(movies);
    }

    // ---------------- REVIEW OPERATIONS ----------------

    // Loads all reviews
    public static List<Review> loadReviews() {
        List<Review> reviews = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(REVIEW_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 3);
                if (parts.length == 3) {
                    reviews.add(new Review(parts[0], parts[1], parts[2]));
                }
            }
        } catch (IOException e) {
            System.out.println("Couldn't load reviews: " + e.getMessage());
        }
        return reviews;
    }

    // Appends a review to the file
    public static void saveReview(Review review) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REVIEW_FILE, true))) {
            writer.write(review.getUsername() + "," + review.getMovieTitle() + "," + review.getComment());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Couldn't save review: " + e.getMessage());
        }
    }

    // Overwrites the review file with a list of reviews
    public static void saveReviews(List<Review> reviews) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(REVIEW_FILE))) {
            for (Review review : reviews) {
                writer.write(review.getUsername() + "," + review.getMovieTitle() + "," + review.getComment());
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Couldn't save all reviews: " + e.getMessage());
        }
    }

    // Deletes a specific review
    public static void deleteReview(String username, String title, String comment) {
        List<Review> reviews = loadReviews();
        List<Review> updated = new ArrayList<>();
        boolean deleted = false;

        for (Review r : reviews) {
            if (!deleted &&
                    r.getUsername().trim().equalsIgnoreCase(username.trim()) &&
                    r.getMovieTitle().trim().equalsIgnoreCase(title.trim()) &&
                    r.getComment().trim().equals(comment.trim())) {
                deleted = true;
                continue;
            }
            updated.add(r);
        }

        saveReviews(updated);
    }

    // ---------------- RENTED MOVIES OPERATIONS ----------------

    // Saves a new rental entry
    public static void saveRentedMovie(String username, String title) {
        saveRental(new Rental(username, title, java.time.LocalDate.now().toString()));
    }

    // Appends a rental to the file
    public static void saveRental(Rental rental) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RENTED_FILE, true))) {
            writer.write(rental.toString());
            writer.newLine();
        } catch (IOException e) {
            System.out.println("Couldn't save rental: " + e.getMessage());
        }
    }

    // Loads titles rented by a specific user
    public static Set<String> loadRentedMovies(String username) {
        Set<String> rentedTitles = new HashSet<>();
        for (Rental rental : loadAllRentals()) {
            if (rental.getUsername().equals(username)) {
                rentedTitles.add(rental.getTitle());
            }
        }
        return rentedTitles;
    }

    // Loads all rentals from file
    public static List<Rental> loadAllRentals() {
        List<Rental> rentals = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(RENTED_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 3);
                if (parts.length >= 2) {
                    String date = parts.length == 3 ? parts[2] : java.time.LocalDate.now().toString();
                    rentals.add(new Rental(parts[0], parts[1], date));
                }
            }
        } catch (IOException e) {
            System.out.println("Couldn't load rentals: " + e.getMessage());
        }
        return rentals;
    }

    // Removes a rental by username and movie title
    public static void removeRentedMovie(String username, String title) {
        List<Rental> rentals = loadAllRentals();
        rentals.removeIf(r -> r.getUsername().equals(username) && r.getTitle().equals(title));
        saveAllRentals(rentals);
    }

    // Overwrites the rentals file
    public static void saveAllRentals(List<Rental> rentals) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(RENTED_FILE))) {
            for (Rental rental : rentals) {
                writer.write(rental.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            System.out.println("Couldn't save all rentals: " + e.getMessage());
        }
    }

    // ---------------- RECENTLY WATCHED MOVIES OPERATIONS ----------------

    // Save the stack to a file (only the latest 10 movies)
    public static void saveRecentlyWatched(StringStack stack, String username) {
        List<String> allLines = readLines("data/recently_watched.txt");

        // Remove existing entries for this user
        allLines.removeIf(line -> line.startsWith(username + ","));

        // Add new entries (oldest first)
        List<String> userEntries = stack.toList().stream()
                .map(title -> username + "," + title)
                .collect(Collectors.toList());

        allLines.addAll(userEntries);
        writeLines("C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\recently_watched.txt", allLines);
    }

    // Load the stack from a file
    public static StringStack loadRecentlyWatched(String username) {
        // Use the public constant from RentalManager
        StringStack stack = new StringStack(RentalManager.RECENTLY_WATCHED_MAX_SIZE);

        List<String> lines = readLines("C:\\Users\\Jayawardhana\\Desktop\\Project\\MovieRentalReviewPlatform\\src\\main\\webapp\\data\\recently_watched.txt");
        for (String line : lines) {
            String[] parts = line.split(",", 2);
            if (parts.length == 2 && parts[0].equals(username)) {
                if (!stack.isFull()) {
                    stack.push(parts[1]);
                }
            }
        }
        return stack;
    }

    // Generic read/write helpers
    public static List<String> readLines(String filePath) {
        try {
            Path path = Paths.get(filePath);

            // Create file and parent directories if they don't exist
            if (!Files.exists(path)) {
                Files.createDirectories(path.getParent());
                Files.createFile(path);
            }

            return Files.readAllLines(path);
        } catch (IOException e) {
            System.err.println("Error reading file: " + e.getMessage());
            e.printStackTrace();
            return new ArrayList<>(); // Return empty list on error
        }
    }

    // Helper method to write lines to a file
    private static void writeLines(String path, List<String> lines) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
            for (String line : lines) {
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // ---------------- WATCH-LATER MOVIES OPERATIONS ----------------

    // Saves all watch later entries
    public static void saveWatchLater(List<WatchLater> entries) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(WATCH_LATER_FILE))) {
            for (WatchLater entry : entries) {
                writer.write(entry.toString());
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Loads all watch later entries
    public static List<WatchLater> loadAllWatchLater() {
        List<WatchLater> list = new ArrayList<>();
        try (BufferedReader reader = new BufferedReader(new FileReader(WATCH_LATER_FILE))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",", 2);
                if (parts.length == 2) {
                    list.add(new WatchLater(parts[0], parts[1]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Loads only the titles for a user
    public static Set<String> loadWatchLaterTitles(String username) {
        Set<String> titles = new HashSet<>();
        for (WatchLater entry : loadAllWatchLater()) {
            if (entry.getUsername().equals(username)) {
                titles.add(entry.getTitle());
            }
        }
        return titles;
    }

    // Adds a movie to watch later
    public static void addWatchLater(String username, String title) {
        List<WatchLater> list = loadAllWatchLater();
        list.add(new WatchLater(username, title));
        saveWatchLater(list);
    }

    // Removes a movie from watch later
    public static void removeWatchLater(String username, String title) {
        List<WatchLater> list = loadAllWatchLater();
        list.removeIf(entry -> entry.getUsername().equals(username) && entry.getTitle().equals(title));
        saveWatchLater(list);
    }

    // ---------------- DOWNLOADED MOVIES OPERATIONS ----------------

    // Saves all downloads to a specified file
    public static void saveDownloads(List<Download> downloads, String filepath) {
        try (BufferedWriter bw = new BufferedWriter(new FileWriter(filepath))) {
            for (Download d : downloads) {
                bw.write(d.toString());
                bw.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    // Loads all downloads from a specified file
    public static List<Download> loadDownloads(String filepath) {
        List<Download> downloads = new ArrayList<>();
        try (BufferedReader br = new BufferedReader(new FileReader(filepath))) {
            String line;
            while ((line = br.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 3) {
                    downloads.add(new Download(parts[0], parts[1], parts[2]));
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
        return downloads;
    }

    // Returns the path for the default download file
    public static String getDownloadFilePath() {
        return DOWNLOAD_FILE;
    }

    // Deletes a specific download entry
    public static void deleteDownload(String username, String title, String filepath) {
        List<Download> downloads = loadDownloads(filepath);
        downloads.removeIf(d -> d.getUsername().equals(username) && d.getTitle().equals(title));
        saveDownloads(downloads, filepath);
    }
}
