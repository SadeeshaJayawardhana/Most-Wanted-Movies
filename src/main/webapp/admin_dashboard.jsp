<%@ page import="com.movie.model.Movie, com.movie.model.User, com.movie.model.Review, com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%
    List<Movie> movies = FileHandler.loadMovies();
    List<User> users = FileHandler.loadUsers();
    List<Review> reviews = FileHandler.loadReviews();
%>
<html>
<head>
    <title>Admin Dashboard</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        h1, h2 {
            color: #2c3e50;
        }

        nav {
            margin-bottom: 20px;
        }

        nav a {
            text-decoration: none;
            padding: 10px 15px;
            margin-right: 10px;
            background-color: #3498db;
            color: white;
            border-radius: 5px;
        }

        nav a:hover {
            background-color: #2980b9;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-bottom: 30px;
        }

        table, th, td {
            border: 1px solid #ddd;
        }

        th, td {
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        .section {
            margin-bottom: 40px;
        }

        .logout {
            float: right;
            background-color: #e74c3c;
        }

        .logout:hover {
            background-color: #c0392b;
        }
    </style>
</head>
<body>

<h1>Admin Dashboard</h1>

<nav>
    <a href="add_movie.jsp">Add Movie</a>
    <a href="delete_movie.jsp">Delete Movie</a>
    <a href="update_movie.jsp">Update Movie</a>
    <a href="remove_user.jsp">Remove User</a>
    <a href="remove_review.jsp">Remove Review</a>
    <a href="index.jsp" class="logout">Logout</a>
</nav>

<div class="section">
    <h2>All Movies</h2>
    <table>
        <tr><th>Title</th><th>Genre</th><th>Rating</th></tr>
        <% for (Movie movie : movies) { %>
        <tr>
            <td><%= movie.getTitle() %></td>
            <td><%= movie.getGenre() %></td>
            <td><%= movie.getRating() %></td>
        </tr>
        <% } %>
    </table>
</div>

<div class="section">
    <h2>All Users</h2>
    <table>
        <tr><th>Username</th><th>Password</th><th>Email</th></tr>
        <% for (User user : users) { %>
        <tr>
            <td><%= user.getUsername() %></td>
            <td><%= user.getPassword() %></td>
            <td><%= user.getEmail() %></td>
        </tr>
        <% } %>
    </table>
</div>

<div class="section">
    <h2>All Reviews</h2>
    <table>
        <tr><th>Username</th><th>Movie Title</th><th>Comment</th></tr>
        <% for (Review review : reviews) { %>
        <tr>
            <td><%= review.getUsername() %></td>
            <td><%= review.getMovieTitle() %></td>
            <td><%= review.getComment() %></td>
        </tr>
        <% } %>
    </table>
</div>

</body>
</html>
