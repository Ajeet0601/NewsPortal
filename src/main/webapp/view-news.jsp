<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.newsportal.model.User, com.newsportal.model.News, com.newsportal.dao.NewsDAO" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>News Details - NewsPortal</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        body { background: #f8fafc; color: #0f172a; line-height: 1.6; }
        
        .navbar {
            background: #ffffff;
            border-bottom: 1px solid #e2e8f0;
            padding: 14px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 10px;
        }
        .navbar a { text-decoration: none; font-weight: 600; font-size: 14px; }
        
        .article-container {
            max-width: 800px;
            margin: 24px auto;
            background: #ffffff;
            padding: clamp(16px, 4vw, 32px);
            border-radius: 12px;
            border: 1px solid #e2e8f0;
            box-shadow: 0 1px 3px rgba(0,0,0,0.05);
        }
        .category-badge {
            display: inline-block;
            background: #2563eb;
            color: #ffffff;
            padding: 4px 10px;
            border-radius: 6px;
            font-size: 11px;
            font-weight: 700;
            text-transform: uppercase;
        }
        .news-heading {
            font-size: clamp(20px, 4vw, 30px);
            line-height: 1.3;
            margin: 12px 0;
            font-weight: 800;
        }
        .meta-info {
            color: #64748b;
            font-size: 13px;
            margin-bottom: 16px;
            border-bottom: 1px solid #e2e8f0;
            padding-bottom: 8px;
        }
        .featured-img {
            width: 100%;
            max-height: 420px;
            object-fit: cover;
            border-radius: 8px;
            margin-bottom: 20px;
        }
        .news-body {
            font-size: 15px;
            line-height: 1.8;
            color: #334155;
            white-space: pre-line;
            word-wrap: break-word;
        }
        .back-btn {
            display: inline-block;
            margin-top: 24px;
            color: #2563eb;
            text-decoration: none;
            font-weight: 700;
            font-size: 14px;
        }
    </style>
</head>
<body>

    <%
        User currentUser = (User) session.getAttribute("currentUser");
        String idParam = request.getParameter("id");
        News news = null;

        if (idParam != null && !idParam.isEmpty()) {
            int newsId = Integer.parseInt(idParam);
            NewsDAO dao = new NewsDAO();
            news = dao.getNewsById(newsId);
        }
        boolean isAdmin = (currentUser != null && "ADMIN".equalsIgnoreCase(currentUser.getRole()));
    %>

    <nav class="navbar">
        <a href="index.jsp" style="font-size: 20px; font-weight: 800; color: #2563eb;">NewsPortal</a>
        <div style="display: flex; gap: 12px; align-items: center;">
            <% if (currentUser != null) { %>
                <span style="font-size: 13px; color: #64748b;">Hi, <b><%= currentUser.getFullName() %></b></span>
                <% if (isAdmin) { %>
                    <a href="admin-dashboard.jsp" style="background:#0f172a; color:#fff; padding:6px 12px; border-radius:6px;">Dashboard</a>
                <% } %>
                <a href="logout" style="color: #ef4444;">Logout</a>
            <% } else { %>
                <a href="login.jsp" style="color: #0f172a;">Login</a>
            <% } %>
        </div>
    </nav>

    <div class="article-container">
        <% if (news != null) { %>
            <span class="category-badge"><%= news.getCategoryName() != null ? news.getCategoryName() : "General" %></span>
            <h1 class="news-heading"><%= news.getTitle() %></h1>
            <div class="meta-info">
                Published on: <%= news.getCreatedAt() %>
            </div>

            <% if (news.getImageUrl() != null && !news.getImageUrl().isEmpty()) { %>
                <img src="<%= news.getImageUrl() %>" alt="Article Banner" class="featured-img">
            <% } %>

            <div class="news-body"><%= news.getContent() %></div>
        <% } else { %>
            <h3>Article not found.</h3>
        <% } %>

        <a href="index.jsp" class="back-btn">&larr; Back to Headlines</a>
    </div>

</body>
</html>