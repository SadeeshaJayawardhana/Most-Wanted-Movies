package com.movie.servlet.UserManagement;

import com.movie.model.User;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle updating of a user's password.
 * URL Mapping: /updatePassword
 */
@WebServlet("/updatePassword")
public class UpdatePasswordServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the username and the new password from the request parameters
        String username = request.getParameter("username");
        String newPassword = request.getParameter("newPassword");

        // Load the list of users from the file
        List<User> users = FileHandler.loadUsers();
        boolean updated = false;  // Flag to check if the password update was successful

        // Iterate through the users list to find the user by username
        for (User user : users) {
            if (user.getUsername().equals(username)) {
                // Update the user's password if found
                user.setPassword(newPassword);
                updated = true;  // Mark as updated
                break;  // Exit loop once the user is found
            }
        }

        // Get the session to store the result message (success or error)
        HttpSession session = request.getSession();

        if (updated) {
            // Save the updated user list back to the file
            FileHandler.saveAllUsers(users);
            // Set success message in the session for the user
            session.setAttribute("updateSuccess", "Password updated successfully.");
        } else {
            // Set error message if user wasn't found
            session.setAttribute("updateError", "User not found.");
        }

        // Redirect to the profile page to display the result of the update
        response.sendRedirect("profile.jsp");
    }
}
