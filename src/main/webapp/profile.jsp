<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page import="com.movie.utils.RentalManager" %>
<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.model.User" %>
<%@ page import="java.util.*" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Movie> rentedMovies = RentalManager.getRentedMovies(username);
    List<User> users = FileHandler.loadUsers();
    String email = "";
    for (User u : users) {
        if (u.getUsername().equals(username)) {
            email = u.getEmail();
            break;
        }
    }

    String message = (String) session.getAttribute("updateSuccess");
    String error = (String) session.getAttribute("updateError");
    session.removeAttribute("updateSuccess");
    session.removeAttribute("updateError");
%>

<!DOCTYPE html>
<html>
<head>
    <title>User Profile</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0e0e0e;
            color: #ffffff;
            margin: 0;
            padding: 0;
        }

        .profile-container {
            max-width: 700px;
            margin: 60px auto;
            background-color: #1c1c1c;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            position: relative;
        }

        h2 {
            font-size: 28px;
            margin-bottom: 20px;
            color: #00A8E1;
        }

        .home-button {
            position: absolute;
            right: 30px;
            top: 30px;
            background-color: #28a745;
            color: white;
            padding: 10px 18px;
            border-radius: 8px;
            text-decoration: none;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        .home-button:hover {
            background-color: #218838;
        }

        .info, .form-group {
            margin-bottom: 25px;
        }

        .info strong {
            color: #ccc;
        }

        input[type="password"], input[type="email"] {
            width: 100%;
            padding: 12px;
            border: none;
            border-radius: 8px;
            background-color: #2c2c2c;
            color: white;
            margin-top: 5px;
        }

        input[type="password"]:focus, input[type="email"]:focus {
            outline: none;
            box-shadow: 0 0 5px #00A8E1;
        }

        button {
            background-color: #00A8E1;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            font-weight: bold;
        }

        button:hover {
            background-color: #00A8E1;
        }

        .message {
            padding: 12px;
            border-radius: 8px;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .success {
            background-color: #28a745;
            color: #fff;
        }

        .error {
            background-color: #dc3545;
            color: #fff;
        }

        ul {
            list-style-type: square;
            padding-left: 20px;
        }

        ul li {
            margin-bottom: 5px;
        }

        .delete-button {
            background-color: #b00610;
        }

        .delete-button:hover {
            background-color: #b00610;
        }

        h3 {
            color: #ffffff;
            font-size: 20px;
            margin-top: 30px;
        }
    </style>
</head>
<body>
<div class="profile-container">
    <a href="movies.jsp" class="home-button">Back to Home</a>
    <h2>User Profile</h2>

    <% if (message != null) { %>
    <div class="message success"><%= message %></div>
    <% } else if (error != null) { %>
    <div class="message error"><%= error %></div>
    <% } %>

    <div class="info">
        <p><strong>Username:</strong> <%= username %></p>
        <p><strong>Email:</strong> <%= email %></p>
    </div>

    <div class="form-group">
        <form action="updatePassword" method="post">
            <label for="newPassword">New Password:</label>
            <input type="password" name="newPassword" id="newPassword" required>
            <input type="hidden" name="username" value="<%= username %>">
            <br><br>
            <button type="submit">Update Password</button>
        </form>
    </div>

    <div class="form-group">
        <form action="updateEmail" method="post">
            <label for="newEmail">New Email:</label>
            <input type="email" name="newEmail" id="newEmail" required>
            <input type="hidden" name="username" value="<%= username %>">
            <br><br>
            <button type="submit">Update Email</button>
        </form>
    </div>

    <div class="form-group">
        <form action="deleteAccount" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This action cannot be undone.');">
            <input type="hidden" name="username" value="<%= username %>">
            <button type="submit" class="delete-button">Delete Account</button>
        </form>
    </div>

    <div class="info">
        <h3>Rented Movies</h3>
        <% if (rentedMovies.isEmpty()) { %>
        <p>You haven't rented any movies yet.</p>
        <% } else { %>
        <ul>
            <% for (Movie m : rentedMovies) { %>
            <li><%= m.getTitle() %></li>
            <% } %>
        </ul>
        <% } %>
    </div>
</div>
</body>
</html>
