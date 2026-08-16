<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Verify OTP - NewsPortal</title>
</head>
<body>
    <div style="width: 350px; margin: 50px auto; padding: 20px; border: 1px solid #ccc; text-align: center;">
        <h2>Verify OTP</h2>
        
        <% String error = (String) request.getAttribute("errorMessage");
           if (error != null) { %>
            <p style="color: red;"><%= error %></p>
        <% } %>

        <p>A 6-digit OTP has been sent (Check Eclipse Console for testing).</p>

        <form action="verify-otp" method="post">
            <input type="text" name="enteredOtp" placeholder="Enter 6-digit OTP" maxlength="6" required style="padding: 8px; width: 80%;"><br><br>
            <button type="submit" style="padding: 8px 20px; cursor: pointer;">Verify & Register</button>
        </form>
    </div>
</body>
</html>	