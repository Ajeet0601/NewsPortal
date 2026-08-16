<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Login - NewsPortal</title>
</head>
<body style="font-family: Arial; display: flex; justify-content: center; align-items: center; min-height: 90vh;">
    <div style="width: 320px; padding: 20px; border: 1px solid #ddd; border-radius: 6px;">
        <h2 style="text-align: center;">Login</h2>

        <% 
            String success = (String) request.getAttribute("successMessage");
            String err = (String) request.getAttribute("errorMessage");
            if (success != null) { 
        %>
            <p style="color: green; font-size: 14px;"><%= success %></p>
        <% } if (err != null) { %>
            <p style="color: red; font-size: 14px;"><%= err %></p>
        <% } %>

        <form action="login" method="post">
            <input type="email" name="email" placeholder="Email" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <input type="password" name="password" placeholder="Password" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <button type="submit" style="width: 100%; padding: 10px; background: #28a745; color: white; border: none; margin-top: 10px; cursor: pointer;">Login</button>
        </form>
        <p style="font-size: 13px; text-align: center;">New User? <a href="signup.jsp">Register here</a></p>
    </div>
</body>
</html>