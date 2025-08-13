<%@ page import="com.movie.model.Review" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove Review</title>
</head>
<body>

<h2>Remove Review</h2>

<table border="1">
    <tr>
        <th>Movie Title</th>
        <th>Username</th>
        <th>Comment</th>
        <th>Action</th>
    </tr>
    <%
        for (Review review : FileHandler.loadReviews()) {
    %>
    <tr>
        <td><%= review.getMovieTitle() %></td>
        <td><%= review.getUsername() %></td>
        <td><%= review.getComment() %></td>
        <td>
            <form action="RemoveReviewServlet" method="post" style="display:inline;">
                <input type="hidden" name="username" value="<%= review.getUsername() %>">
                <input type="hidden" name="title" value="<%= review.getMovieTitle() %>">
                <input type="hidden" name="comment" value="<%= review.getComment() %>">
                <input type="submit" value="Remove" onclick="return confirm('Delete this review?');">
            </form>
        </td>
    </tr>
    <%
        }
    %>
</table>

<a href="admin_dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
