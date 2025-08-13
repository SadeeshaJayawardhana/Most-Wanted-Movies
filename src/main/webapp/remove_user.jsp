<%@ page import="com.movie.model.User" %>
<%@ page import="com.movie.utils.FileHandler" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Remove User</title>
    <style>
        /* CSS styles */
    </style>
</head>
<body>

<h2>Remove User</h2>

<table>
    <tr>
        <th>Username</th>
        <th>Email</th>
        <th>Action</th>
    </tr>
    <%
        for (User user : FileHandler.loadUsers()) {
    %>
    <tr>
        <td><%= user.getUsername() %></td>
        <td><%= user.getEmail() %></td>
        <td>
            <form action="RemoveUserServlet" method="post" style="display:inline;">
                <input type="hidden" name="username" value="<%= user.getUsername() %>">
                <input type="submit" value="Remove" onclick="return confirm('Are you sure you want to remove this user?');">
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
