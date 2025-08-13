<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.model.Review" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page import="com.movie.utils.RentalManager" %>
<%@ page import="java.util.List" %>

<%
    String title = request.getParameter("title");
    String username = (String) session.getAttribute("username");
    Movie selectedMovie = null;

    if (title != null) {
        List<Movie> movies = FileHandler.loadMovies();
        for (Movie movie : movies) {
            if (movie.getTitle().equalsIgnoreCase(title)) {
                selectedMovie = movie;
                break;
            }
        }

        // Add to recently watched
        if (selectedMovie != null && username != null) {
            RentalManager.addWatchedMovie(username, title);
        }
    }

    if (selectedMovie == null) {
%>
<p>Movie not found or not selected.</p>
<a href="movies.jsp">Back to Movies</a>
<%
        return;
    }

    String youtubeSearchUrl = "https://www.youtube.com/results?search_query=" + java.net.URLEncoder.encode(selectedMovie.getTitle() + " trailer", "UTF-8");
    List<Review> reviews = FileHandler.loadReviews();
%>

<html>
<head>
    <title>Watch <%= selectedMovie.getTitle() %></title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            background-color: #121212;
            color: #fff;
            margin: 0;
            padding: 40px;
        }

        .container {
            max-width: 1000px;
            margin: auto;
            background-color: #1e1e1e;
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 0 20px rgba(0,0,0,0.4);
            display: flex;
            gap: 30px;
            align-items: flex-start;
        }

        .poster {
            flex: 1;
        }

        .poster img {
            width: 100%;
            max-width: 350px;
            border-radius: 12px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.3);
        }

        .details {
            flex: 2;
        }

        .details h1 {
            font-size: 32px;
            margin-bottom: 10px;
        }

        .meta {
            color: #ccc;
            font-size: 14px;
            margin-bottom: 20px;
        }

        .description {
            font-size: 18px;
            line-height: 1.8;
            margin: 20px 0 40px 0;
            color: #e0e0e0;
            font-weight: 400;
        }


        .buttons a {
            text-decoration: none;
            color: white;
            background-color: #007bff;
            padding: 10px 20px;
            border-radius: 8px;
            margin-right: 15px;
            transition: background-color 0.2s;
        }

        .buttons a:hover {
            background-color: #0056b3;
        }

        .reviews {
            margin-top: 40px;
        }

        .review {
            background-color: #2c2c2c;
            padding: 10px 15px;
            border-radius: 6px;
            margin-bottom: 10px;
        }

        .review strong {
            color: #4caf50;
        }
        .buttons a.disabled {
            pointer-events: none;
            opacity: 0.6;
        }

    </style>
</head>
<body>

<div class="container">
    <div class="poster">
        <img src="<%= selectedMovie.getPosterUrl() %>" alt="<%= selectedMovie.getTitle() %> Poster">
    </div>
    <div class="details">
        <h1><%= selectedMovie.getTitle() %></h1>
        <div class="meta">
            Genre: <%= selectedMovie.getGenre() %> | Rating: <%= selectedMovie.getRating() %>
        </div>
        <div class="description">
            <%= selectedMovie.getDescription() %>
        </div>
        <div class="buttons">
            <a href="<%= youtubeSearchUrl %>" target="_blank">Watch Trailer</a>
            <a href='images/loading.mp4'>Watch Movie</a>
            <a href="#" id="downloadBtn" onclick="downloadMovie('<%= selectedMovie.getTitle() %>'); return false;">
                Download
            </a>
            <span id="loadingSpinner" style="display:none; margin-left:10px;">⏳ Downloading...</span>


        </div>


        <!-- Existing Reviews -->
        <div class="reviews">
            <h3>Reviews:</h3>
            <%
                boolean foundReview = false;
                for (Review review : reviews) {
                    if (review.getTitle().equalsIgnoreCase(selectedMovie.getTitle())) {
                        foundReview = true;
            %>
            <div class="review">
                <strong><%= review.getUsername() %>:</strong> <%= review.getComment() %>
            </div>
            <%
                    }
                }
                if (!foundReview) {
            %>
            <p>No reviews yet.</p>
            <%
                }
            %>
        </div>
    </div>
</div>
<script>
    function downloadMovie(title) {
        const button = document.getElementById("downloadBtn");
        const spinner = document.getElementById("loadingSpinner");

        // Disable button and show spinner
        button.classList.add('disabled');
        spinner.style.display = 'inline';

        fetch('DownloadServlet', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: 'title=' + encodeURIComponent(title)
        }).then(response => {
            if (response.ok) {
                spinner.innerText = "✅ Downloaded";
            } else {
                alert("Download failed.");
                button.classList.remove('disabled');
                spinner.style.display = 'none';
            }
        }).catch(error => {
            console.error("Download error:", error);
            alert("An error occurred while downloading.");
            button.classList.remove('disabled');
            spinner.style.display = 'none';
        });
    }

</script>



</body>
</html>
