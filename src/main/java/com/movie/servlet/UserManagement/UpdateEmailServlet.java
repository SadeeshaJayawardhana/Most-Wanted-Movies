package com.movie.servlet.UserManagement;

import com.movie.model.User;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle the updating of a user's email address.
 * URL Mapping: /updateEmail
 */
@WebServlet("/updateEmail")
public class UpdateEmailServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the username and new email from the request
        String username = request.getParameter("username");
        String newEmail = request.getParameter("newEmail");

        // Load the list of users
        List<User> users = FileHandler.loadUsers();
        boolean updated = false;  // Flag to check if the update was successful

        // Iterate through the users list to find the user by username
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                // Update the user's email if found
                user.setEmail(newEmail);
                updated = true;  // Mark as updated
                break;  // Exit loop once the user is found
            }
        }

        // Retrieve the current session to set success/error message
        HttpSession session = request.getSession();

        if (updated) {
            // Save the updated user list to storage
            FileHandler.saveAllUsers(users);
            // Set success message in session to notify user
            session.setAttribute("updateSuccess", "Email updated successfully.");
        } else {
            // Set error message if user wasn't found
            session.setAttribute("updateError", "User not found.");
        }

        // Redirect to the profile page to display the result
        response.sendRedirect("profile.jsp");
    }
}
