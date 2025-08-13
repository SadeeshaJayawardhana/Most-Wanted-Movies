package com.movie.servlet.WatchLaterListManagement;

import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet to handle adding a movie to the "Watch Later" list.
 * Triggered via POST request (e.g., from a form or button click).
 * URL mapping: /AddWatchLaterServlet
 */
@WebServlet("/AddWatchLaterServlet")
public class AddWatchLaterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve the currently logged-in username from the session
        String username = (String) request.getSession().getAttribute("username");

        // 2. Get the movie title from the request parameter
        String title = request.getParameter("title");

        // 3. Validate input: ensure both username and title are present and valid
        if (username != null && title != null && !title.trim().isEmpty()) {
            // 4. Add the movie to the user's "Watch Later" list using FileHandler
            FileHandler.addWatchLater(username, title);
        }

        // 5. Redirect the user back to the movies page
        response.sendRedirect("movies.jsp");
    }
}
