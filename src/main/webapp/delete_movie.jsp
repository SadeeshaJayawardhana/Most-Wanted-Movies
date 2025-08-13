<%@ page import="com.movie.model.Movie" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Delete Movie</title>
    <style>
        /* CSS styles */
    </style>
</head>
<body>

<h2>Delete Movie</h2>

<table>
    <tr>
        <th>Title</th>
        <th>Genre</th>
        <th>Rating</th>
        <th>Action</th>
    </tr>
    <%
        for (Movie movie : FileHandler.loadMovies()) {
    %>
    <tr>
        <td><%= movie.getTitle() %></td>
        <td><%= movie.getGenre() %></td>
        <td><%= movie.getRating() %></td>
        <td>
            <form action="DeleteMovieServlet" method="post" style="display:inline;">
                <input type="hidden" name="title" value="<%= movie.getTitle() %>">
                <input type="submit" value="Delete" onclick="return confirm('Are you sure you want to delete this movie?');">
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>

<a class="back-link" href="admin_dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
