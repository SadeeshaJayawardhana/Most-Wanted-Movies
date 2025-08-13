<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Movie Rental Platform - Login/Register</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: Arial, sans-serif;
            background: url("images/background.jpg") no-repeat center center fixed;
            background-size: cover;
            height: 100vh;
            position: relative;
        }

        .dark-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0, 0, 0, 0.7);
            z-index: 0;
        }

        .overlay {
            position: relative;
            z-index: 1;
            background-color: rgba(0, 0, 0, 0.6);
            padding: 40px;
            border-radius: 16px;
            box-shadow: 0 0 20px rgba(0,0,0,0.4);
            max-width: 500px;
            width: 100%;
            color: white;
            margin: auto;
            top: 50%;
            transform: translateY(-50%);
        }

        .main-heading {
            text-align: center;
            font-size: 64px;
            color: white;
            font-weight: bold;
            margin-bottom: 30px;
            text-shadow: 0 0 10px #ffffff;
        }

        .tabs {
            display: flex;
            justify-content: center;
            margin-bottom: 20px;
        }

        .tabs button {
            padding: 10px 20px;
            margin: 0 5px;
            border: none;
            background-color: #ccc;
            color: black;
            cursor: pointer;
            border-radius: 5px;
        }

        .tabs button.active {
            background-color: #00A8E1;
            color: white;
        }

        input[type="text"], input[type="password"], input[type="email"], input[type="submit"] {
            width: 100%;
            padding: 12px;
            margin-top: 10px;
            border-radius: 8px;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #00A8E1;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #0077A8;
        }

        .toggle-container {
            font-size: 14px;
            margin-top: 8px;
        }

        .error {
            color: #ff6666;
            text-align: center;
            margin-bottom: 10px;
        }

        .admin-button {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }

        .admin-button button {
            padding: 8px 16px;
            background-color: #444;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .admin-button button:hover {
            background-color: #666;
        }

        .guest-button {
            display: flex;
            justify-content: center;
            margin-top: 25px;
        }

        .guest-button button {
            padding: 10px 20px;
            background-color: #00A8E1;
            color: white;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 16px;
        }

        .guest-button button:hover {
            background-color: #0077A8;
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

    <script>
        function showForm(type) {
            document.getElementById("login-form").style.display = (type === 'login') ? 'block' : 'none';
            document.getElementById("register-form").style.display = (type === 'register') ? 'block' : 'none';
            document.getElementById("login-tab").classList.toggle('active', type === 'login');
            document.getElementById("register-tab").classList.toggle('active', type === 'register');
        }

        function togglePassword(id) {
            const input = document.getElementById(id);
            input.type = input.type === "password" ? "text" : "password";
        }

        function validateRegisterForm() {
            const emailField = document.getElementById("registerEmail");
            const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

            if (!emailRegex.test(emailField.value)) {
                alert("Please enter a valid email address.");
                return false;
            }
            return true;
        }
    </script>
</head>

<body onload="showForm('login')">

<div class="dark-overlay"></div>

<div class="overlay">
    <div class="image-container">
        <img src="images/MostWantedMovies.png" alt="Movies" style="height: 450px; width: auto;">
    </div>


    <div class="tabs">
        <button id="login-tab" onclick="showForm('login')">Login</button>
        <button id="register-tab" onclick="showForm('register')">Register</button>
    </div>

    <% if ("true".equals(request.getParameter("error"))) { %>
    <p class="error">Invalid username or password.</p>
    <% } %>

    <!-- Login Form -->
    <form id="login-form" action="login" method="post" style="display: none;">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" id="loginPassword" required>
        <div class="toggle-container">
            <input type="checkbox" onclick="togglePassword('loginPassword')"> Show Password
        </div>
        <input type="submit" value="Login">
    </form>

    <!-- Admin Login Button -->
    <div class="admin-button">
        <form action="admin_login.jsp" method="get" target="_blank">
            <button type="submit">Admin Login</button>
        </form>
    </div>

    <!-- Register Form -->
    <form id="register-form" action="register" method="post" style="display: none;" onsubmit="return validateRegisterForm()">
        <input type="text" name="username" placeholder="Username" required>
        <input type="password" name="password" placeholder="Password" id="registerPassword" required>
        <div class="toggle-container">
            <input type="checkbox" onclick="togglePassword('registerPassword')"> Show Password
        </div>
        <input type="email" name="email" placeholder="Email" id="registerEmail" required>
        <input type="submit" value="Register">
    </form>

    <!-- Guest Login Button -->
    <div class="guest-button">
        <form action="guest.jsp" method="get">
            <button type="submit">Continue as Guest</button>
        </form>
    </div>
</div>

</body>
</html>
