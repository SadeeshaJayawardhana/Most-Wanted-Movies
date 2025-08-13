<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page import="java.util.*" %>
<%@ page import="com.movie.utils.RentalManager" %>


<%
  String username = (String) session.getAttribute("username");
  List<Movie> allMovies = FileHandler.loadMovies();
  Set<String> savedWatchLater = username != null ? FileHandler.loadWatchLaterTitles(username) : new HashSet<>();
%>

<html>
<head>
  <title>Watch Later</title>
  <style>
    body {
      background-color: #121212;
      font-family: Arial, sans-serif;
      color: #fff;
      padding: 20px;
    }

    h2 {
      text-align: center;
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

    .movie-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      gap: 20px;
      margin-top: 30px;
    }

    .movie-card {
      width: 200px;
      background-color: #1c1c1c;
      border-radius: 10px;
      overflow: hidden;
      color: #fff;
      transition: transform 0.2s;
      box-shadow: 0 4px 8px rgba(0,0,0,0.3);
    }

    .movie-card:hover {
      transform: scale(1.05);
    }

    .movie-poster {
      width: 100%;
      height: 300px;
      object-fit: cover;
    }

    .movie-details {
      padding: 10px;
      text-align: center;
    }

    .movie-title {
      font-size: 16px;
      font-weight: bold;
    }

    .watch-later-button {
      margin-top: 10px;
      background-color: #ff9800;
      color: #fff;
      border: none;
      padding: 8px 10px;
      border-radius: 5px;
      cursor: pointer;
    }
  </style>
</head>
<body>
<h2>Your Watch Later List</h2>
<div class="user-info">
  <div class="header">
    <div class="user-info">
      <a href="movies.jsp">Back to Movies</a>
    </div>
  </div>
</div>
<div class="movie-container">
  <% for (Movie movie : allMovies) {
    if (savedWatchLater.contains(movie.getTitle())) {
      boolean isRented = RentalManager.isMovieRented(session, movie.getTitle());
  %>
  <div class="movie-card">
    <img class="movie-poster" src="<%= movie.getPosterUrl() %>" alt="<%= movie.getTitle() %>">
    <div class="movie-details">
      <div class="movie-title"><%= movie.getTitle() %></div>

      <% if (isRented) { %>
      <!-- Watch button -->
      <form action="watch.jsp" method="get" style="margin-top: 10px;">
        <input type="hidden" name="title" value="<%= movie.getTitle() %>">
        <button type="submit" class="watch-later-button">Watch</button>
      </form>

      <!-- Review section (Add/Update/Delete) -->
      <form action="movies.jsp" method="get">
        <input type="hidden" name="title" value="<%= movie.getTitle() %>">
        <button type="submit" class="watch-later-button">Reviews</button>
      </form>

      <% } else { %>
      <!-- Rent button -->
      <form action="payment.jsp" method="post" style="margin-top: 10px;">
        <input type="hidden" name="title" value="<%= movie.getTitle() %>">
        <input type="hidden" name="username" value="<%= username %>">
        <button type="submit" class="watch-later-button">Rent</button>
      </form>

      <!-- View-only reviews -->
      <form action="movies.jsp" method="get">
        <input type="hidden" name="title" value="<%= movie.getTitle() %>">
        <button type="submit" class="watch-later-button">View Reviews</button>
      </form>
      <% } %>

      <!-- Remove from Watch Later -->
      <form action="RemoveWatchLaterServlet" method="post" style="margin-top: 5px;">
        <input type="hidden" name="title" value="<%= movie.getTitle() %>">
        <button type="submit" class="watch-later-button" style="background-color: #e53935;">Remove</button>
      </form>
    </div>
  </div>
  <% } } %>
</div>

</body>
</html>
