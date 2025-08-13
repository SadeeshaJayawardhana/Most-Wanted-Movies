package com.movie.servlet.UserManagement;

import com.movie.model.User;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

/**
 * Servlet to handle user registration.
 * Triggered when a user submits the registration form.
 * URL mapping: /register
 */
@WebServlet("/register")
public class UserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Retrieve form data from the registration page
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");

        // 2. Create a new User object with the provided data
        User user = new User(username, password, email);

        // 3. Save the new user to a persistent file using FileHandler
        FileHandler.saveUser(user);

        // 4. Start a session and store the username (login the user automatically)
        HttpSession session = request.getSession();
        session.setAttribute("username", username);

        // 5. Redirect the user to the main movies page after successful registration
        response.sendRedirect("movies.jsp");
    }
}
