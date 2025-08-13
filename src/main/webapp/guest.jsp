<%@ page import="java.util.*, com.movie.model.Movie, com.movie.model.Review, com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Guest | Movie Mania</title>
  <style>
    body {
      margin: 0;
      font-family: Arial, sans-serif;
      background-color: #141414;
      color: #fff;
    }
    header {
      background-color: #111;
      padding: 20px;
      text-align: right;
    }
    header a {
      color: #fff;
      text-decoration: none;
      font-weight: bold;
      background-color: #e50914;
      padding: 10px 20px;
      border-radius: 5px;
    }
    h1 {
      text-align: center;
      margin-top: 30px;
      font-size: 32px;
      color: #e50914;
    }

    .main-heading {
      text-align: center;
      font-size: 64px;
      color: white;
      font-weight: bold;
      margin-top: 30px;
      text-shadow: 0 0 10px #ffffff;
    }

    .movie-container {
      display: flex;
      flex-wrap: wrap;
      justify-content: center;
      padding: 20px;
      gap: 30px;
    }
    .movie-card {
      background-color: #222;
      border-radius: 10px;
      padding: 15px;
      width: 250px;
      box-shadow: 0 0 10px rgba(0,0,0,0.5);
      transition: transform 0.3s ease;
      display: flex;
      flex-direction: column;
      align-items: center;
    }
    .movie-card:hover {
      transform: scale(1.03);
    }
    .movie-poster {
      width: 100%;
      height: 350px;
      object-fit: cover;
      border-radius: 5px;
      margin-bottom: 15px;
    }
    .movie-title {
      font-size: 20px;
      font-weight: bold;
      color: #fff;
      margin-bottom: 5px;
      text-align: center;
    }
    .movie-genre, .movie-rating {
      font-size: 14px;
      color: #ccc;
      margin: 2px 0;
    }
    .review-section {
      margin-top: 10px;
      padding-top: 10px;
      border-top: 1px solid #444;
      width: 100%;
    }
    .review {
      font-size: 13px;
      margin: 4px 0;
      color: #aaa;
    }
    .image-container {
      display: flex;
      justify-content: center;
      align-items: center;
      margin-top: 50px; /* Optional: Adjust margin as per your layout */
    }

    .image-container img {
      max-width: 100%;
      height: auto;
    }
  </style>
</head>
<body>
<header>
  <a href="index.jsp">Login</a>
</header>

<div class="image-container">
  <img src="images/MostWantedMovies.png" alt="Movies" style="height: 250px; width: auto;">
</div>



<div class="movie-container">
  <%
    List<Movie> movies = FileHandler.loadMovies();
    List<Review> allReviews = FileHandler.loadReviews();

    for (Movie movie : movies) {
  %>
  <div class="movie-card">
    <img class="movie-poster" src="<%= movie.getPosterUrl() %>" alt="<%= movie.getTitle() %> Poster">
    <div class="movie-title"><%= movie.getTitle() %></div>
    <div class="movie-genre">Genre: <%= movie.getGenre() %></div>
    <div class="movie-rating">Rating: <%= movie.getRating() %>/5</div>

    <div class="review-section">
      <strong>Reviews:</strong><br/>
      <%
        for (Review review : allReviews) {
          if (review.getMovieTitle().equalsIgnoreCase(movie.getTitle())) {
      %>
      <div class="review"><%= review.getUsername() %>: <%= review.getComment() %></div>
      <%
          }
        }
      %>
    </div>
  </div>
  <% } %>
</div>
</body>
</html>
