package com.movie.servlet.AdminLogin;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/AdminLoginServlet")
public class AdminLoginServlet extends HttpServlet {

    // Predefined admin credentials (for simple authentication)
    private static final String ADMIN_USERNAME = "admin";
    private static final String ADMIN_PASSWORD = "admin";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // 1. Get login credentials from the request
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // 2. Validate credentials (check if they match the predefined admin values)
        if (ADMIN_USERNAME.equals(username) && ADMIN_PASSWORD.equals(password)) {
            // 3. If valid, create a session and set "admin" attribute to true
            HttpSession session = request.getSession();
            session.setAttribute("admin", true);

            // 4. Redirect to admin dashboard
            response.sendRedirect("admin_dashboard.jsp");
        } else {
            // 5. If invalid credentials, redirect back to admin login page with error message
            response.sendRedirect("admin_login.jsp?error=invalid");
        }
    }
}
