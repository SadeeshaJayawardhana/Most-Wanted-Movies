package com.movie.servlet.MovieManagement;

import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet for handling movie deletion by title.
 * Invoked via a POST request (e.g., from an admin panel).
 */
@WebServlet("/DeleteMovieServlet")
public class DeleteMovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get the movie title from the request parameter
        String title = request.getParameter("title");

        // 2. Call the FileHandler utility method to delete the movie from storage
        FileHandler.deleteMovie(title);

        // 3. Redirect to confirmation or management page
        response.sendRedirect("delete_movie.jsp");
    }
}
