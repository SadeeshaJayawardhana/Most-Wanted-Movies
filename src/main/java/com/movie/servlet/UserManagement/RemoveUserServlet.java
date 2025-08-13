package com.movie.servlet.UserManagement;

import com.movie.model.User;
import com.movie.utils.FileHandler;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

/**
 * Servlet to handle the removal of a user by an admin or system action.
 * URL Mapping: /RemoveUserServlet
 */
@WebServlet("/RemoveUserServlet")
public class RemoveUserServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Retrieve the username to remove from the request
        String username = request.getParameter("username");

        // Load all users from storage
        List<User> users = FileHandler.loadUsers();

        // Remove the user with a matching username (case-insensitive)
        users.removeIf(user -> user.getUsername().equalsIgnoreCase(username));

        // Save the updated list of users back to storage
        FileHandler.saveAllUsers(users);

        // Redirect back to the admin/user removal confirmation page with a success flag
        response.sendRedirect("remove_user.jsp?success=true");
    }
}
