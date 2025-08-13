package com.movie.servlet.UserManagement;

import com.movie.model.User;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;
import java.util.Set;

/**
 * Servlet that handles user login.
 * Mapped to: /login
 */
@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get login credentials from the form
        String inputUsername = request.getParameter("username");
        String inputPassword = request.getParameter("password");

        // Load all users from storage
        List<User> users = FileHandler.loadUsers();

        // Check for a matching username and password
        for (User user : users) {
            if (user.getUsername().equals(inputUsername) && user.getPassword().equals(inputPassword)) {
                // If match found, create a new session
                HttpSession session = request.getSession();
                session.setAttribute("username", inputUsername); // Save username in session

                // Load user's rented movies and store in session
                Set<String> rentedMovies = FileHandler.loadRentedMovies(inputUsername);
                session.setAttribute("rentedMovies", rentedMovies);

                // Redirect to the main movies page
                response.sendRedirect("movies.jsp");
                return;
            }
        }

        // If credentials are incorrect, forward back to login with error message
        request.setAttribute("error", "Invalid username or password.");
        request.getRequestDispatcher("index.jsp").forward(request, response);
    }
}
