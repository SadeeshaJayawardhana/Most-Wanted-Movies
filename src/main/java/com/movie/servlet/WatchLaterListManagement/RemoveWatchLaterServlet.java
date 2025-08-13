package com.movie.servlet.WatchLaterListManagement;

import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to handle removing a movie from the "Watch Later" list.
 * Triggered via POST request (e.g., from a form or button).
 * URL mapping: /RemoveWatchLaterServlet
 */
@WebServlet("/RemoveWatchLaterServlet")
public class RemoveWatchLaterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve movie title from request parameters
        String movieTitle = request.getParameter("title");

        // 2. Get current user's username from the session
        HttpSession session = request.getSession();
        String username = (String) session.getAttribute("username");

        // 3. Validate inputs and remove the movie if valid
        if (username != null && movieTitle != null) {
            FileHandler.removeWatchLater(username, movieTitle);
        }

        // 4. Redirect to the watch later list page
        response.sendRedirect("watch_later.jsp");
    }
}
