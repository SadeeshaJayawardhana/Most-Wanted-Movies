<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.model.Rental" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page import="com.movie.utils.RentalManager" %>
<%@ page import="java.util.*" %>
<%@ page import="com.movie.model.Review" %>


<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<Movie> rentedMovies = RentalManager.getRentedMovies(username);

%>


<html>
<head>
    <title>Rented Movies</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #0d1117;
            color: white;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
        }

        .header a {
            margin-left: 15px;
            background-color: #dc3545;
            color: white;
            padding: 6px 12px;
            border-radius: 8px;
            text-decoration: none;
        }

        .movie-grid {
            display: flex;
            flex-wrap: wrap;
            gap: 25px;
            justify-content: center;
        }

        .movie-card {
            background-color: #161b22;
            border-radius: 12px;
            overflow: hidden;
            width: 220px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
            transition: transform 0.3s;
        }

        .movie-card img {
            width: 100%;
            height: 320px;
            object-fit: cover;
        }

        .movie-info {
            padding: 15px;
        }

        .movie-info h3 {
            color: #58a6ff;
            margin: 0 0 8px;
        }

        .movie-buttons a {
            display: inline-block;
            text-decoration: none;
            color: white;
            background-color: #238636;
            padding: 6px 10px;
            border-radius: 6px;
            margin-top: 8px;
        }

        .movie-buttons a:hover {
            background-color: #2ea043;
        }
    </style>
</head>
<body>

<div class="header">
    <h2>🎥 Rented Movies</h2>
    <div class="user-info">
        👤 <strong><%= username %></strong>
        <a href="movies.jsp">Back to Movies</a>
        <a href="logout">Logout</a>
    </div>
</div>

<div class="movie-grid">
    <% if (rentedMovies.isEmpty()) { %>
    <p>You haven't rented any movies yet.</p>
    <% } else {
        for (Movie movie : rentedMovies) {
    %>
    <div class="movie-card">
        <img src="<%= movie.getPosterUrl() %>" alt="Poster">
        <div class="movie-info">
            <h3><%= movie.getTitle() %></h3>
            <p>⭐ <%= movie.getRating() %> | <%= movie.getGenre() %></p>
            <div class="movie-buttons">
                <a href="watch.jsp?title=<%= movie.getTitle() %>">▶ Watch</a>
                <form action="refundMovie" method="post" style="display:inline;">
                    <input type="hidden" name="title" value="<%= movie.getTitle() %>">
                    <button type="submit" style="background-color: #dc3545; color: white; border: none; padding: 6px 10px; border-radius: 6px;">💸 Refund</button>
                </form>

            </div>
        </div>
    </div>
    <% } } %>
</div>

</body>
</html>
