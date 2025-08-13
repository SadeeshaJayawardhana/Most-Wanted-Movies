package com.movie.servlet.UserManagement;

import com.movie.model.User;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet for deleting a user account.
 * Mapped to: /deleteAccount
 */
@WebServlet("/deleteAccount")
public class DeleteAccountServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Get the username from the form/request
        String username = request.getParameter("username");

        // Load all users from storage
        List<User> users = FileHandler.loadUsers();

        // Remove the user that matches the provided username
        users.removeIf(user -> user.getUsername().equals(username));

        // Save the updated user list back to storage
        FileHandler.saveAllUsers(users); // Make sure this method is public and working in FileHandler

        // Invalidate the current session to log the user out
        HttpSession session = request.getSession();
        session.invalidate();

        // Redirect to the login page
        response.sendRedirect("index.jsp");
    }
}
