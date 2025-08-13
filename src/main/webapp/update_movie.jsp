<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Update Movie</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
        }

        h2 {
            color: #333;
        }

        table {
            border-collapse: collapse;
            width: 100%;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        input[type="text"], input[type="number"] {
            width: 100%;
            padding: 6px;
        }

        input[type="submit"] {
            padding: 6px 12px;
            background-color: #007bff;
            color: white;
            border: none;
            cursor: pointer;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
        }
    </style>
</head>
<body>

<h2>Update Movie</h2>

<table>
    <tr>
        <th>Title</th>
        <th>Genre</th>
        <th>Rating</th>
        <th>Watch URL</th>
        <th>Action</th>
    </tr>
    <%
        for (Movie movie : FileHandler.loadMovies()) {
    %>
    <tr>
        <form action="UpdateMovieServlet" method="post">
            <td><input type="text" name="title" value="<%= movie.getTitle() %>" required></td>
            <td><input type="text" name="genre" value="<%= movie.getGenre() %>" required></td>
            <td><input type="number" name="rating" step="0.1" min="0" max="10" value="<%= movie.getRating() %>" required></td>
            <td><input type="text" name="watchUrl" value="<%= movie.getWatchUrl() %>"></td>
            <td>
                <input type="hidden" name="originalTitle" value="<%= movie.getTitle() %>">
                <input type="submit" value="Update">
            </td>
        </form>
    </tr>
    <%
        }
    %>
</table>

<a class="back-link" href="admin_dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
