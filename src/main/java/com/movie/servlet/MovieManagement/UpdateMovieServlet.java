package com.movie.servlet.MovieManagement;

import com.movie.model.Movie;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for updating the genre and rating of a movie.
 * Triggered via POST request from update_movie.jsp or similar admin form.
 */
@WebServlet("/UpdateMovieServlet")
public class UpdateMovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Extract movie details from request parameters
        String title = request.getParameter("title");
        String newGenre = request.getParameter("genre");
        double newRating = Double.parseDouble(request.getParameter("rating"));
        String watchUrl = request.getParameter("watchUrl"); // Unused, may be for future use

        // 2. Load the existing movie list
        List<Movie> movies = FileHandler.loadMovies();

        // 3. Search for the movie by title and update genre and rating
        for (Movie movie : movies) {
            if (movie.getTitle().equalsIgnoreCase(title)) {
                movie.setGenre(newGenre);
                movie.setRating(newRating);
                break; // Stop once the target movie is updated
            }
        }

        // 4. Save the updated movie list
        FileHandler.saveAllMovies(movies);

        // 5. Redirect to update page with success flag
        response.sendRedirect("update_movie.jsp?success=true");
    }
}
