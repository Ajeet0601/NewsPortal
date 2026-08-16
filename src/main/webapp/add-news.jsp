<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.newsportal.model.User" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Post New Article - NewsPortal</title>
    <style>
        * { box-sizing: border-box; font-family: 'Segoe UI', sans-serif; }
        body { background: #f4f6f9; margin: 0; padding: 20px; }
        .form-card { max-width: 600px; margin: 30px auto; background: #fff; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; font-weight: 600; }
        input[type="text"], textarea, select { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; }
        button { background: #28a745; color: white; border: none; padding: 12px 20px; border-radius: 4px; cursor: pointer; font-weight: bold; width: 100%; }
        .back-link { display: block; text-align: center; margin-top: 15px; text-decoration: none; color: #007bff; }
    </style>
</head>
<body>

    <%
        User currentUser = (User) session.getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }
    %>

    <div class="form-card">
        <h2>Create News Post</h2>
        
        <% String err = (String) request.getAttribute("errorMessage");
           if (err != null) { %>
            <p style="color: red;"><%= err %></p>
        <% } %>

        <form action="add-news" method="post">
            <div class="form-group">
                <label>Article Title</label>
                <input type="text" name="title" required placeholder="Enter compelling headline">
            </div>

            <div class="form-group">
                <label>Category</label>
                <select name="categoryId" required>
                    <option value="1">Technology</option>
                    <option value="2">Sports</option>
                    <option value="3">Politics</option>
                    <option value="4">Business</option>
                </select>
            </div>

            <div class="form-group">
                <label>Image URL (Unsplash / Web Link)</label>
                <input type="text" name="imageUrl" placeholder="https://example.com/image.jpg">
            </div>

            <div class="form-group">
                <label>Content</label>
                <textarea name="content" rows="6" required placeholder="Write news description here..."></textarea>
            </div>

            <button type="submit">Publish Article</button>
        </form>
        
        <a href="index.jsp" class="back-link">&larr; Back to Home</a>
    </div>

</body>
</html>