<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.movie.utils.RentalManager" %>

<%
    String title = request.getParameter("title");
    if (title != null && !title.isEmpty()) {
        RentalManager.rentMovie(session, title);
    }
%>

<html>
<head>
    <title>Payment Success</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0e0e0e;
            color: #ffffff;
            text-align: center;
            padding-top: 100px;
            margin: 0;
        }

        .message {
            background-color: #1c1c1c;
            display: inline-block;
            padding: 40px 50px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
        }

        h2 {
            color: #00ff88;
            font-size: 26px;
            margin-bottom: 20px;
        }

        p {
            font-size: 16px;
            margin-bottom: 30px;
            color: #ccc;
        }

        a {
            display: inline-block;
            text-decoration: none;
            background-color: #28a745;
            color: white;
            padding: 10px 20px;
            border-radius: 8px;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        a:hover {
            background-color: #218838;
        }
    </style>
</head>
<body>
<div class="message">
    <h2>🎉 Payment Successful!</h2>
    <p>Your movie "<strong><%= title %></strong>" has been rented. Enjoy watching!</p>
    <a href="movies.jsp">Back to Movies</a>
</div>
</body>
</html>
