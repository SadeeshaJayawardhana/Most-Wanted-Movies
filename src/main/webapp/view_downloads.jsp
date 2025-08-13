<%@ page import="java.util.List" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.model.Download" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    String username = (String) session.getAttribute("username");

    // Load all downloads
    List<Download> allDownloads = FileHandler.loadDownloads(FileHandler.getDownloadFilePath());

    // Filter downloads by current user
    List<Download> userDownloads = new java.util.ArrayList<>();
    for (Download d : allDownloads) {
        if (d.getUsername().equals(username)) {
            userDownloads.add(d);
        }
    }

    // Load movies
    List<Movie> allMovies = FileHandler.loadMovies();
%>

<html>
<head>
    <title>Downloaded Movies</title>
    <style>
        body {
            background-color: #121212;
            color: white;
            font-family: Arial, sans-serif;
            padding: 40px;
        }

        .movie-card {
            background-color: #1f1f1f;
            padding: 20px;
            margin-bottom: 20px;
            border-radius: 10px;
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .movie-card img {
            width: 120px;
            border-radius: 8px;
        }

        .movie-info {
            flex: 1;
        }

        .actions button {
            margin-right: 10px;
            padding: 8px 14px;
            background-color: #007bff;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
        }

        .actions button.delete {
            background-color: #dc3545;
        }
    </style>
</head>
<body>

<h1>Your Downloads</h1>

<%
    if (userDownloads.isEmpty()) {
%>
<p>You haven't downloaded any movies yet.</p>
<%
} else {
    for (Download download : userDownloads) {
        for (Movie m : allMovies) {
            if (m.getTitle().equalsIgnoreCase(download.getTitle())) {
%>
<div class="movie-card">
    <img src="<%= m.getPosterUrl() %>" alt="Poster">
    <div class="movie-info">
        <h3><%= m.getTitle() %></h3>
        <p><%= m.getDescription() %></p>
        <p><small>Downloaded on: <%= download.getDownloadDate() %></small></p>
        <div class="actions">
            <form action="DeleteDownloadServlet" method="post" style="display:inline;">
                <input type="hidden" name="title" value="<%= m.getTitle() %>">
                <button class="delete" type="submit">Delete</button>
            </form>
            <a href="watch.jsp?title=<%= m.getTitle() %>">
                <button type="button">Watch</button>
            </a>
        </div>
    </div>
</div>
<%
                }
            }
        }
    }
%>

</body>
</html>