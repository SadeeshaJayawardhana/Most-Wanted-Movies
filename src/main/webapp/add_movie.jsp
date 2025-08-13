<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Add Movie</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      padding: 20px;
    }

    h2 {
      color: #333;
    }

    form {
      margin-bottom: 20px;
    }

    label {
      display: inline-block;
      width: 120px;
    }

    input[type="text"], input[type="number"] {
      padding: 5px;
      margin: 5px 0;
      width: 300px;
    }

    input[type="submit"] {
      padding: 6px 12px;
      background-color: #28a745;
      color: white;
      border: none;
      cursor: pointer;
    }

    table {
      border-collapse: collapse;
      width: 100%;
      margin-top: 30px;
    }

    th, td {
      border: 1px solid #ccc;
      padding: 8px;
      text-align: left;
    }

    th {
      background-color: #f2f2f2;
    }

    a {
      text-decoration: none;
      color: #007bff;
    }

    a:hover {
      text-decoration: underline;
    }

    .back-link {
      margin-top: 20px;
      display: inline-block;
    }
  </style>
</head>
<body>

<h2>Add New Movie</h2>

<form action="AddMovieServlet" method="post">
  <label>Title:</label>
  <input type="text" name="title" required><br>

  <label>Genre:</label>
  <input type="text" name="genre" required><br>

  <label>Rating:</label>
  <input type="number" name="rating" step="0.1" min="0" max="10" required><br>

  <label>Poster URL:</label>
  <input type="text" name="posterUrl"><br>

  <label>Description:</label>
  <input type="text" name="description"><br>

  <label>Watch URL:</label>
  <input type="text" name="watchUrl"><br>

  <input type="submit" value="Add Movie">
</form>

<hr>

<h3>Existing Movies</h3>
<table>
  <tr>
    <th>Title</th>
    <th>Genre</th>
    <th>Rating</th>
    <th>Watch URL</th>
  </tr>
  <%
    for (Movie movie : FileHandler.loadMovies()) {
  %>
  <tr>
    <td><%= movie.getTitle() %></td>
    <td><%= movie.getGenre() %></td>
    <td><%= movie.getRating() %></td>
    <td><a href="<%= movie.getWatchUrl() %>" target="_blank">Watch</a></td>
  </tr>
  <%
    }
  %>
</table>

<a class="back-link" href="admin_dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
