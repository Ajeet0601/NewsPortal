<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.newsportal.model.User, com.newsportal.model.News, com.newsportal.dao.NewsDAO, java.util.List" %>
<%
    User currentUser = (User) session.getAttribute("currentUser");
    if (currentUser == null || !"ADMIN".equalsIgnoreCase(currentUser.getRole())) {
        response.sendRedirect("login.jsp");
        return;
    }

    NewsDAO newsDAO = new NewsDAO();
    List<News> newsList = newsDAO.getAllNews();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard - NewsPortal</title>
    <link href="https://fonts.googleapis.com/css2?family=Plus+Jakarta+Sans:wght@400;600;700;800&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Plus Jakarta Sans', sans-serif; }
        body { background: #f8fafc; color: #0f172a; }
        
        .navbar {
            background: #0f172a;
            color: #fff;
            padding: 14px 24px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
        }
        .navbar a { color: #fff; text-decoration: none; font-weight: 600; font-size: 13px; }
        
        .container { max-width: 1100px; margin: 24px auto; padding: 0 16px; }
        
        .header-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 12px;
            margin-bottom: 20px;
        }
        .btn-post {
            background: #2563eb;
            color: #fff !important;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 600;
            font-size: 13px;
        }

        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(160px, 1fr));
            gap: 16px;
            margin-bottom: 24px;
        }
        .stat-card {
            background: #fff;
            padding: 16px;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        .stat-card h4 { color: #64748b; font-size: 12px; text-transform: uppercase; }
        .stat-card p { font-size: 24px; font-weight: 800; color: #2563eb; margin-top: 4px; }

        /* Responsive Table Container */
        .table-responsive {
            width: 100%;
            overflow-x: auto;
            background: #fff;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        table { width: 100%; border-collapse: collapse; min-width: 500px; }
        th, td { padding: 12px 16px; text-align: left; border-bottom: 1px solid #e2e8f0; font-size: 13px; }
        th { background: #f8fafc; font-weight: 700; color: #475569; }
    </style>
</head>
<body>

    <nav class="navbar">
        <h2 style="font-size: 18px;">NewsPortal <span style="font-size:12px; color:#94a3b8;">[Admin]</span></h2>
        <div style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
            <span style="font-size: 13px;">Admin: <b><%= currentUser.getFullName() %></b></span>
            <a href="index.jsp" style="color: #60a5fa;">Live Site</a>
            <a href="logout" style="color: #ef4444;">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="header-bar">
            <h2>Articles Management</h2>
            <a href="add-news.jsp" class="btn-post">+ Post Article</a>
        </div>

        <div class="stats-grid">
            <div class="stat-card">
                <h4>Total Published</h4>
                <p><%= newsList.size() %></p>
            </div>
            <div class="stat-card">
                <h4>Access Level</h4>
                <p style="font-size: 18px; color: #10b981;">Full Admin</p>
            </div>
        </div>

        <div class="table-responsive">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Category</th>
                        <th>Date</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (News n : newsList) { %>
                        <tr>
                            <td><%= n.getNewsId() %></td>
                            <td><b><%= n.getTitle() %></b></td>
                            <td><%= n.getCategoryName() != null ? n.getCategoryName() : "General" %></td>
                            <td><%= n.getCreatedAt() != null ? n.getCreatedAt().toString().substring(0, 10) : "" %></td>
                            <td>
                                <a href="view-news.jsp?id=<%= n.getNewsId() %>" style="color: #2563eb; text-decoration: none; font-weight: 600;">Preview</a>
                            </td>
                        </tr>
                    <% } %>
                </tbody>
            </table>
        </div>
    </div>

</body>
</html>