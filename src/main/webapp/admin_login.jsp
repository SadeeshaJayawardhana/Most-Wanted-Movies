<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Admin Login</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background: #2c3e50;
            color: white;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 100vh;
        }
        .login-box {
            background: #34495e;
            padding: 20px;
            border-radius: 8px;
        }
        input {
            padding: 8px;
            margin: 8px 0;
            width: 100%;
        }
        button {
            padding: 10px;
            background: #27ae60;
            border: none;
            color: white;
            cursor: pointer;
            width: 100%;
        }
    </style>
</head>
<body>
<div class="login-box">
    <h2>Admin Login</h2>
    <form action="AdminLoginServlet" method="post">
        <label>Username:</label><br>
        <input type="text" name="username" required><br>
        <label>Password:</label><br>
        <input type="password" name="password" required><br>
        <button type="submit">Login as Admin</button>
    </form>
</div>
</body>
</html>
