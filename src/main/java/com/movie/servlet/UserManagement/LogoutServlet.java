package com.movie.servlet.UserManagement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet that handles user logout.
 * Mapped to: /logout
 */
@WebServlet("/logout")
public class LogoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the current session if it exists (do not create a new one)
        HttpSession session = request.getSession(false);

        // If a session is active, invalidate it to log the user out
        if (session != null) {
            session.invalidate();
        }

        // Redirect the user back to the login page after logout
        response.sendRedirect("index.jsp");
    }
}
