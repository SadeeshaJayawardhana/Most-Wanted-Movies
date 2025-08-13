package com.movie.servlet.MovieManagement;

import com.movie.model.Movie;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for adding a new movie to the system.
 * Triggered via POST request from an admin form.
 */
@WebServlet("/AddMovieServlet")
public class AddMovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve form parameters
        String title = request.getParameter("title");
        String genre = request.getParameter("genre");
        double rating = Double.parseDouble(request.getParameter("rating"));
        String posterUrl = request.getParameter("posterUrl");
        String description = request.getParameter("description");
        String watchUrl = request.getParameter("watchUrl");

        // 2. Create a new Movie object using the input data
        Movie movie = new Movie(title, genre, rating, posterUrl, description, watchUrl);

        // 3. Load the existing list of movies (optional step if appending only)
        List<Movie> movies = FileHandler.loadMovies();
        movies.add(movie); // Optional if FileHandler.saveMovie only appends

        // 4. Save the new movie to file
        FileHandler.saveMovie(movie);

        // 5. Redirect admin to dashboard after adding
        response.sendRedirect("admin_dashboard.jsp");
    }
}
