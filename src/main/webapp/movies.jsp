<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page import="com.movie.utils.RentalManager" %>
<%@ page import="com.movie.model.Review" %>
<%@ page import="com.movie.utils.StringStack" %>
<%@ page import="java.util.*" %>

<%
    String username = (String) session.getAttribute("username");
    if (username == null) {
        response.sendRedirect("index.jsp");
        return;
    }

    List<String> rentedTitles = new ArrayList<>();
    if (username != null) {
        Set<String> rentedSet = FileHandler.loadRentedMovies(username);
        rentedTitles = new ArrayList<>(rentedSet); // convert Set to List
    }

    List<Movie> movies = FileHandler.loadMovies();
    List<Review> allReviews = FileHandler.loadReviews();
    StringStack watchedMovies = RentalManager.getRecentlyWatched(session);

    // Bubble Sort (to sort movies by rating)

    for (int i = 0; i < movies.size() - 1; i++) {
        for (int j = 0; j < movies.size() - i - 1; j++) {
            if (movies.get(j).getRating() < movies.get(j + 1).getRating()) {
                Movie temp = movies.get(j);
                movies.set(j, movies.get(j + 1));
                movies.set(j + 1, temp);
            }
        }
    }

    String openReviewId = request.getParameter("openReview");
%>

<html>
<head>
    <title>Movies</title>
    <style>
        .dropdown {
            position: relative;
            display: inline-block;
        }

        .dropdown-btn {
            background: none;
            border: none;
            color: white;
            font-size: 20px;
            cursor: pointer;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            min-width: 160px;
            box-shadow: 0px 8px 16px rgba(0,0,0,0.2);
            z-index: 1;
        }

        .dropdown-content.right {
            left: 100%; /* show to right side */
            top: 0;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }


        .movie-card {
            width: 200px;
            margin: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            border-radius: 10px;
            overflow: hidden;
            background-color: #000;
        }

        .movie-card:hover {
            transform: scale(1.05);
            box-shadow: 0 10px 20px rgba(0,0,0,0.6);
        }

        .movie-card img {
            width: 100%;
            height: 300px;
            object-fit: cover;
        }

        body::before {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url("images/rDJegQJaCyGaYysj2g5XWY.jpg") no-repeat center center fixed;
            background-size: cover;
            filter: blur(4px);
            z-index: -2;
        }

        body::after {
            content: "";
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.6);
            z-index: -1;
        }

        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            background-color: #0d1117;
            color: #fff;
        }

        .header {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            margin-bottom: 30px;
        }

        .header h2 {
            font-size: 48px;
            font-weight: bold;
            color: #58a6ff;
            text-shadow: 2px 2px 4px rgba(0, 0, 0, 0.7);
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin-bottom: 20px;


        }
        .left-buttons {
            display: flex;
            flex-direction: column; /* Stack buttons vertically */
            gap: 10px;
            margin-top: 15px; /* Move buttons slightly below the title */
        }

        .left-buttons a {
            display: inline-block;
            font-size: 18px;
            font-weight: bold;
            color: #fff; /* Visible text */
            text-decoration: none;
            background: none; /* Transparent background */
            border: none;
            cursor: pointer;
            transition: transform 0.3s ease, color 0.3s ease; /* Smooth size increase and color change */
        }

        .left-buttons a:hover {
            transform: scale(1.2); /* Slightly enlarge text */
            color: #58a6ff; /* Highlight color */
        }

        .right-buttons {
            display: flex;
            gap: 15px; /* Space between profile and logout buttons */
        }

        .right-buttons a {
            font-size: 18px;
            font-weight: bold;
            color: #fff; /* Transparent button style */
            text-decoration: none;
            background: none;
            border: none;
            cursor: pointer;
            transition: transform 0.3s ease, color 0.3s ease;
        }

        .right-buttons a:hover {
            transform: scale(1.2); /* Slightly enlarge text */
            color: #58a6ff; /* Highlight color */
        }


        .movie-grid {
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            gap: 25px;
        }

        .movie-card {
            background-color: transparent; /* Slightly transparent, darker tone */
            border-radius: 12px;
            overflow: hidden;
            width: 220px;
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.5);
            transition: transform 0.3s;
            backdrop-filter: blur(8px); /* Apply a blur effect to the background */
        }

        .movie-card:hover {
            transform: scale(1.05);
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
            margin: 0 0 8px 0;
            font-size: 18px;
            color: #58a6ff;
        }

        .movie-info p {
            margin: 4px 0;
            font-size: 14px;
        }

        .movie-buttons {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 10px;
        }

        .movie-buttons a, .movie-buttons button {
            flex: 1;
            text-align: center;
            text-decoration: none;
            color: white;
            background-color: #238636;
            padding: 6px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }

        .movie-buttons button:hover, .movie-buttons a:hover {
            background-color: #2ea043;
        }

        .reviews-section {
            margin-top: 10px;
            background-color: #21262d;
            padding: 10px;
            border-radius: 8px;
        }

        .review-box textarea {
            width: 100%;
            height: 60px;
            border-radius: 6px;
            border: none;
            padding: 8px;
            margin-top: 8px;
        }

        .review-submit {
            background-color: #238636;
            margin-top: 6px;
        }

        .edit-btn, .update-btn, .delete-btn {
            margin-left: 6px;
            padding: 5px 8px;
            border-radius: 6px;
            border: none;
            cursor: pointer;
        }

        .edit-btn { background-color: #0969da; }
        .update-btn { background-color: #f0b429; }
        .delete-btn { background-color: #da3633; }

        /* Recently Watched Scroll */
        .recent-container {
            position: relative;
            margin-bottom: 30px;
        }

        .recent-scroll {
            display: flex;
            overflow-x: auto;
            gap: 20px;
            padding: 10px;
            scroll-behavior: smooth;
        }

        .recent-scroll::-webkit-scrollbar {
            display: none;
        }

        .scroll-btn {
            position: absolute;
            top: 35%;
            background-color: #161b22;
            color: #58a6ff;
            border: none;
            font-size: 22px;
            cursor: pointer;
            padding: 5px 10px;
            z-index: 2;
        }

        .scroll-left {
            left: -10px;
        }

        .scroll-right {
            right: -10px;
        }

        .recent-card {
            background: #161b22;
            padding: 10px;
            border-radius: 10px;
            min-width: 200px;
            flex: 0 0 auto;
            text-align: center;
        }

        .recent-card a {
            display: block;
            margin-top: 8px;
            color: #58a6ff;
            text-decoration: none;
        }
    </style>

    <script>

        function toggleMenu(id) {
            const menu = document.getElementById("menu-" + id);
            menu.style.display = (menu.style.display === 'block') ? 'none' : 'block';
        }

        function toggleReviews(id) {
            const section = document.getElementById('reviews-' + id);
            section.style.display = (section.style.display === 'none' || section.style.display === '') ? 'block' : 'none';
        }

        function enableEdit(btn) {
            const container = document.getElementById(btn.dataset.reviewBoxId);
            const username = btn.dataset.username;
            const title = decodeURIComponent(btn.dataset.title);
            const comment = decodeURIComponent(btn.dataset.comment);
            const openReview = title.replaceAll(" ", "_");

            const escapeHtml = (str) =>
                str.replace(/&/g, "&amp;")
                    .replace(/</g, "&lt;")
                    .replace(/>/g, "&gt;")
                    .replace(/"/g, "&quot;")
                    .replace(/'/g, "&#039;");

            const formHtml =
                '<form action="submitReview" method="post">' +
                '<input type="hidden" name="username" value="' + escapeHtml(username) + '">' +
                '<input type="hidden" name="title" value="' + escapeHtml(title) + '">' +
                '<input type="hidden" name="oldComment" value="' + escapeHtml(comment) + '">' +
                '<input type="hidden" name="openReview" value="' + escapeHtml(openReview) + '">' +
                '<textarea name="comment">' + escapeHtml(comment) + '</textarea><br>' +
                '<button class="update-btn" type="submit" name="action" value="update">Update</button>' +
                '<button class="delete-btn" type="submit" name="action" value="delete">Delete</button>' +
                '</form>';

            container.innerHTML = formHtml;
        }

        function scrollRecent(dir) {
            const container = document.getElementById("recentScroll");
            const scrollAmount = 250;
            container.scrollBy({ left: dir === 'left' ? -scrollAmount : scrollAmount, behavior: 'smooth' });
        }

        window.onload = function () {
            const urlParams = new URLSearchParams(window.location.search);
            const openId = urlParams.get("openReview");
            if (openId) {
                const section = document.getElementById("reviews-" + openId);
                if (section) {
                    section.style.display = "block";
                }
            }
        }
    </script>
</head>
<body>

<div class="header">
    <img src="images/MostWantedMovies.png" alt="Movies" style="height: 150px; width: auto;">

    <div class="right-buttons">
        <a href="view_downloads.jsp">View Downloads</a>
        <a href="watch_later.jsp">Watch Later</a>
        <a href="rented_movies.jsp">Rented Movies</a>
        <a href="profile.jsp">Profile</a>
        <a href="logout">Logout</a>
    </div>
</div>


<% if (!watchedMovies.isEmpty()) { %>
<h3>Recently Watched</h3>
<div class="recent-container">
    <button class="scroll-btn scroll-left" onclick="scrollRecent('left')">◀</button>
    <div id="recentScroll" class="recent-scroll">
        <%
            // THIS IS THE CORRECTED SECTION
            List<String> reversedWatched = new ArrayList<>();
            StringStack tempStack = FileHandler.loadRecentlyWatched(username);
            while (!tempStack.isEmpty()) {
                reversedWatched.add(tempStack.pop());
            }

            for (String title : reversedWatched) {
                Movie watchedMovie = null;
                for (Movie m : movies) {
                    if (m.getTitle().equals(title)) {
                        watchedMovie = m;
                        break;
                    }
                }
                if (watchedMovie != null) {
                    String movieId = watchedMovie.getTitle().replaceAll("\\s+", "_");
        %>
        <div class="movie-card">
            <img src="<%= watchedMovie.getPosterUrl() %>" alt="Poster">
            <div class="movie-info">
                <h3><%= watchedMovie.getTitle() %></h3>
                <p>⭐ <%= watchedMovie.getRating() %> | <%= watchedMovie.getGenre() %></p>
                <div class="movie-buttons">
                    <a href="watch.jsp?title=<%= watchedMovie.getTitle() %>">Watch Again</a>
                </div>
            </div>
        </div>
        <%
                }
            }
        %>
    </div>
    <button class="scroll-btn scroll-right" onclick="scrollRecent('right')">▶</button>
</div>
<% } %>


<div class="movie-grid">
    <%
        for (Movie movie : movies) {
            boolean isRented = RentalManager.isMovieRented(session, movie.getTitle());
            String movieId = movie.getTitle().replaceAll("\\s+", "_");
    %>
    <div class="movie-card">
        <img src="<%= movie.getPosterUrl() %>" alt="Poster">

        <div class="movie-actions">
            <% if (rentedTitles.contains(movie.getTitle())) { %>

                <input type="hidden" name="title" value="<%= movie.getTitle() %>"/>

            </form>
            <% } else { %>

                <input type="hidden" name="title" value="<%= movie.getTitle() %>"/>

            </form>
            <% } %>

            <!-- 3-dot menu -->
            <% if (username != null) { %>
            <div class="dropdown">
                <button class="dropdown-btn">⋮</button>
                <div class="dropdown-content right">
                    <form action="AddWatchLaterServlet" method="post">
                        <input type="hidden" name="title" value="<%= movie.getTitle() %>">
                        <button type="submit">Add to Watch Later</button>
                    </form>
                </div>
            </div>
            <% } %>

        </div>


        <div class="movie-info">
            <h3><%= movie.getTitle() %></h3>
            <p>⭐ <%= movie.getRating() %> | <%= movie.getGenre() %></p>
            <div class="movie-buttons">
                <% if (isRented) { %>
                <a href="watch.jsp?title=<%= movie.getTitle() %>">Watch</a>
                <% } else { %>
                <a href="payment.jsp?title=<%= movie.getTitle() %>">Rent</a>
                <% } %>
                <button onclick="toggleReviews('<%= movieId %>')">Reviews</button>
            </div>
        </div>
        <div class="reviews-section" id="reviews-<%= movieId %>" style="display: <%= (movieId.equals(openReviewId)) ? "block" : "none" %>">
            <h4>Reviews:</h4>
            <%
                int reviewCount = 0;
                for (Review review : allReviews) {
                    if (review.getMovieTitle().equals(movie.getTitle())) {
                        String reviewBoxId = "review-" + movieId + "-" + reviewCount++;
            %>
            <div id="<%= reviewBoxId %>">
                <strong><%= review.getUsername() %>:</strong> <%= review.getComment() %>
                <% if (review.getUsername().equals(username)) { %>
                <button class="edit-btn"
                        data-review-box-id="<%= reviewBoxId %>"
                        data-username="<%= username %>"
                        data-title="<%= movie.getTitle().replace("\"", "&quot;") %>"
                        data-comment="<%= review.getComment().replace("\"", "&quot;") %>"
                        onclick="enableEdit(this)">Edit</button>
                <% } %>
            </div>
            <% } } %>

            <% if (isRented) { %>
            <div class="review-box">
                <form action="submitReview" method="post">
                    <textarea name="comment" placeholder="Write your review..."></textarea>
                    <input type="hidden" name="username" value="<%= username %>">
                    <input type="hidden" name="title" value="<%= movie.getTitle() %>">
                    <input type="hidden" name="openReview" value="<%= movieId %>">
                    <button class="review-submit" type="submit" name="action" value="submit">Post Review</button>
                </form>
            </div>
            <% } %>
        </div>
    </div>
    <% } %>
</div>
</body>
</html>
