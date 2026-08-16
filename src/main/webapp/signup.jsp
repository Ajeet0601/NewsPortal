<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>Signup - NewsPortal</title>
</head>
<body style="font-family: Arial; display: flex; justify-content: center; align-items: center; min-height: 90vh;">
    <div style="width: 320px; padding: 20px; border: 1px solid #ddd; border-radius: 6px;">
        <h2 style="text-align: center;">Register</h2>

        <% String err = (String) request.getAttribute("errorMessage");
           if (err != null) { %>
            <p style="color: red; font-size: 14px;"><%= err %></p>
        <% } %>

        <form action="signup" method="post">
            <input type="text" name="fullName" placeholder="Full Name" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <input type="email" name="email" placeholder="Email" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <input type="text" name="mobile" placeholder="Mobile Number" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <input type="password" name="password" placeholder="Password" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <input type="password" name="confirmPassword" placeholder="Confirm Password" required style="width: 93%; padding: 8px; margin: 6px 0;"><br>
            <button type="submit" style="width: 100%; padding: 10px; background: #007bff; color: white; border: none; margin-top: 10px; cursor: pointer;">Send OTP & Register</button>
        </form>
        <p style="font-size: 13px; text-align: center;">Already have an account? <a href="login.jsp">Login</a></p>
    </div>
</body>
</html>