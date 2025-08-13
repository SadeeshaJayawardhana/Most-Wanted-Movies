<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String title = request.getParameter("title");
    if (title == null || title.isEmpty()) {
        response.sendRedirect("movies.jsp");
        return;
    }
%>
<html>
<head>
    <title>Payment Portal</title>
    <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #0e0e0e;
            color: #ffffff;
            padding: 30px;
            margin: 0;
        }

        .payment-container {
            max-width: 500px;
            margin: 60px auto;
            background: #1c1c1c;
            padding: 30px 40px;
            border-radius: 16px;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            position: relative;
        }

        h2 {
            font-size: 24px;
            text-align: center;
            color: #00A8E1;
            margin-bottom: 25px;
        }

        input[type="text"],
        input[type="number"],
        input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            margin-bottom: 20px;
            border: none;
            border-radius: 8px;
            background-color: #2c2c2c;
            color: white;
        }

        input[type="text"]:focus,
        input[type="number"]:focus {
            outline: none;
            box-shadow: 0 0 5px #00A8E1;
        }

        input[type="submit"] {
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
            font-weight: bold;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover {
            background-color: #218838;
        }

        label {
            font-weight: bold;
            color: #ccc;
        }

        .confirmation {
            text-align: center;
            background: #2c2c2c;
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            color: #00ff88;
            font-weight: bold;
            box-shadow: 0 0 10px rgba(0, 255, 136, 0.2);
        }
    </style>
</head>
<body>

<div class="payment-container">
    <div class="confirmation">
        ✅ You are renting: <strong><%= title %></strong>
    </div>

    <h2>Movie Rental Payment</h2>
    <form action="payment-success.jsp" method="post">
        <input type="hidden" name="title" value="<%= title %>">

        <label>Cardholder Name</label>
        <input type="text" name="cardName" required>

        <label>Card Number</label>
        <input type="text" name="cardNumber" maxlength="16" required>

        <label>Expiry Date</label>
        <input type="text" name="expiry" placeholder="MM/YY" required>

        <label>CVV</label>
        <input type="number" name="cvv" maxlength="3" required>

        <input type="submit" value="Pay Now">
    </form>
</div>

</body>
</html>
