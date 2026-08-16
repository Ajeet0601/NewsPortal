<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.newsportal.model.User, com.newsportal.model.News, com.newsportal.dao.NewsDAO, java.util.List" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>NewsPortal - Latest News</title>
    
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <style>
        :root {
            --bg-body: #f8fafc;
            --bg-surface: #ffffff;
            --text-main: #0f172a;
            --text-muted: #64748b;
            --primary: #2563eb;
            --primary-hover: #1d4ed8;
            --danger: #ef4444;
            --border-color: #e2e8f0;
            --shadow-sm: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
            --shadow-hover: 0 12px 24px -4px rgba(15, 23, 42, 0.12);
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Plus Jakarta Sans', sans-serif;
        }

        body {
            background-color: var(--bg-body);
            color: var(--text-main);
            line-height: 1.5;
            -webkit-font-smoothing: antialiased;
        }

        /* Responsive Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-bottom: 1px solid var(--border-color);
            position: sticky;
            top: 0;
            z-index: 1000;
            padding: 14px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }

        .navbar .brand {
            font-size: 22px;
            font-weight: 800;
            letter-spacing: -0.5px;
            text-decoration: none;
            color: var(--primary);
        }

        .navbar .brand span {
            color: var(--text-main);
        }

        .nav-right {
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .user-tag {
            font-size: 13px;
            color: var(--text-muted);
        }

        .user-tag b {
            color: var(--text-main);
        }

        .badge-role {
            font-size: 10px;
            background: #dbeafe;
            color: #1e40af;
            padding: 2px 6px;
            border-radius: 4px;
            font-weight: 700;
            margin-left: 4px;
        }

        .btn-panel {
            background: #0f172a;
            color: #ffffff !important;
            padding: 7px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 12px;
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .btn-post {
            background: var(--primary);
            color: #ffffff !important;
            padding: 7px 14px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 12px;
            transition: all 0.2s ease;
            white-space: nowrap;
        }

        .btn-logout {
            color: var(--danger) !important;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            padding: 6px 10px;
            border-radius: 6px;
        }

        .btn-link {
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
            color: var(--text-main);
            padding: 6px 12px;
        }

        /* Container */
        .container {
            max-width: 1200px;
            margin: 24px auto;
            padding: 0 16px;
        }

        .page-header {
            margin-bottom: 24px;
        }

        .page-header h1 {
            font-size: clamp(22px, 4vw, 32px);
            font-weight: 800;
            letter-spacing: -0.5px;
        }

        .page-header p {
            color: var(--text-muted);
            font-size: clamp(13px, 2vw, 15px);
            margin-top: 4px;
        }

        /* Scrollable Category Bar for Mobile */
        .cat-bar {
            display: flex;
            gap: 8px;
            margin-bottom: 24px;
            overflow-x: auto;
            white-space: nowrap;
            padding-bottom: 8px;
            -webkit-overflow-scrolling: touch;
        }

        .cat-bar::-webkit-scrollbar {
            height: 4px;
        }

        .cat-bar::-webkit-scrollbar-thumb {
            background: #cbd5e1;
            border-radius: 4px;
        }

        .cat-btn {
            padding: 6px 14px;
            background: var(--bg-surface);
            border: 1px solid var(--border-color);
            border-radius: 9999px;
            text-decoration: none;
            color: var(--text-muted);
            font-size: 13px;
            font-weight: 600;
            flex-shrink: 0;
        }

        .cat-btn.active {
            background: var(--primary);
            color: #ffffff;
            border-color: var(--primary);
        }

        /* Responsive Grid */
        .grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 20px;
        }

        /* Responsive Cards */
        .card {
            background: var(--bg-surface);
            border-radius: 12px;
            border: 1px solid var(--border-color);
            overflow: hidden;
            display: flex;
            flex-direction: column;
            box-shadow: var(--shadow-sm);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .card:hover {
            transform: translateY(-4px);
            box-shadow: var(--shadow-hover);
        }

        .img-container {
            width: 100%;
            height: 180px;
            overflow: hidden;
            background: #f1f5f9;
            position: relative;
        }

        .img-container img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }

        .category-tag {
            position: absolute;
            top: 10px;
            left: 10px;
            background: rgba(255, 255, 255, 0.95);
            font-size: 10px;
            font-weight: 700;
            color: var(--primary);
            text-transform: uppercase;
            letter-spacing: 0.5px;
            padding: 3px 8px;
            border-radius: 4px;
        }

        .card-body {
            padding: 16px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
        }

        .card-title {
            margin-bottom: 8px;
            font-size: 16px;
            font-weight: 700;
            line-height: 1.4;
        }

        .card-title a {
            text-decoration: none;
            color: var(--text-main);
        }

        .card-text {
            font-size: 13px;
            color: var(--text-muted);
            line-height: 1.5;
            margin-bottom: 14px;
            flex-grow: 1;
        }

        .card-footer {
            padding: 12px 16px;
            font-size: 12px;
            color: var(--text-muted);
            border-top: 1px solid var(--border-color);
            display: flex;
            justify-content: space-between;
            align-items: center;
            background: #fafafa;
        }

        .read-more {
            font-size: 12px;
            color: var(--primary);
            font-weight: 700;
            text-decoration: none;
        }

        @media (max-width: 640px) {
            .navbar {
                flex-direction: column;
                align-items: flex-start;
            }
            .nav-right {
                width: 100%;
                justify-content: space-between;
            }
            .grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

    <%
        User currentUser = (User) session.getAttribute("currentUser");
        NewsDAO newsDAO = new NewsDAO();
        
        String catParam = request.getParameter("category");
        List<News> newsList;
        
        if (catParam != null && !catParam.isEmpty()) {
            int catId = Integer.parseInt(catParam);
            newsList = newsDAO.getNewsByCategory(catId);
        } else {
            newsList = newsDAO.getAllNews();
        }

        boolean isAdmin = (currentUser != null && "ADMIN".equalsIgnoreCase(currentUser.getRole()));
    %>

    <nav class="navbar">
        <a href="index.jsp" class="brand">News<span>Portal</span></a>
        <div class="nav-right">
            <% if (currentUser != null) { %>
                <span class="user-tag">
                    Hi, <b><%= currentUser.getFullName() %></b>
                    <% if (isAdmin) { %><span class="badge-role">ADMIN</span><% } %>
                </span>

                <% if (isAdmin) { %>
                    <a href="admin-dashboard.jsp" class="btn-panel">Dashboard</a>
                    <a href="add-news.jsp" class="btn-post">+ Post News</a>
                <% } %>

                <a href="logout" class="btn-logout">Logout</a>
            <% } else { %>
                <a href="login.jsp" class="btn-link">Login</a>
                <a href="signup.jsp" class="btn-post" style="background:#0f172a;">Register</a>
            <% } %>
        </div>
    </nav>

    <div class="container">
        
        <header class="page-header">
            <h1>Discover Today's Headlines</h1>
            <p>Stay informed with verified reports and in-depth stories across multiple categories.</p>
        </header>

        <div class="cat-bar">
            <a href="index.jsp" class="cat-btn <%= (catParam == null) ? "active" : "" %>">All News</a>
            <a href="index.jsp?category=1" class="cat-btn <%= ("1".equals(catParam)) ? "active" : "" %>">Technology</a>
            <a href="index.jsp?category=2" class="cat-btn <%= ("2".equals(catParam)) ? "active" : "" %>">Sports</a>
            <a href="index.jsp?category=3" class="cat-btn <%= ("3".equals(catParam)) ? "active" : "" %>">Politics</a>
            <a href="index.jsp?category=4" class="cat-btn <%= ("4".equals(catParam)) ? "active" : "" %>">Business</a>
        </div>

        <div class="grid">
            <% if (newsList == null || newsList.isEmpty()) { %>
                <p style="color: var(--text-muted);">No news found for this category.</p>
            <% } else { 
                for (News n : newsList) { 
                    String img = (n.getImageUrl() != null && !n.getImageUrl().trim().isEmpty()) 
                                 ? n.getImageUrl() 
                                 : "https://images.unsplash.com/photo-1585829365295-ab7cd400c167?auto=format&fit=crop&w=800&q=80";
            %>
                    <div class="card">
                        <div class="img-container">
                            <a href="view-news.jsp?id=<%= n.getNewsId() %>">
                                <img src="<%= img %>" alt="News Thumbnail" loading="lazy">
                            </a>
                            <span class="category-tag"><%= n.getCategoryName() != null ? n.getCategoryName() : "General" %></span>
                        </div>
                        <div class="card-body">
                            <h3 class="card-title">
                                <a href="view-news.jsp?id=<%= n.getNewsId() %>"><%= n.getTitle() %></a>
                            </h3>
                            <p class="card-text">
                                <%= (n.getContent() != null && n.getContent().length() > 90) ? n.getContent().substring(0, 90) + "..." : n.getContent() %>
                            </p>
                        </div>
                        <div class="card-footer">
                            <span><%= n.getCreatedAt() != null ? n.getCreatedAt().toString().substring(0, 10) : "" %></span>
                            <a href="view-news.jsp?id=<%= n.getNewsId() %>" class="read-more">Read More &rarr;</a>
                        </div>
                    </div>
            <%  } 
               } %>
        </div>
    </div>

</body>
</html>