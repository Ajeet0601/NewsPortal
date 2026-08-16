package com.newsportal.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.newsportal.dao.NewsDAO;
import com.newsportal.model.User;

@WebServlet("/add-news")
public class AddNewsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        User currentUser = (session != null) ? (User) session.getAttribute("currentUser") : null;

        // Login check
        if (currentUser == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");
        String imageUrl = request.getParameter("imageUrl");
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));

        NewsDAO newsDAO = new NewsDAO();
        boolean isAdded = newsDAO.addNews(title, content, imageUrl, categoryId, currentUser.getUserId());

        if (isAdded) {
            response.sendRedirect("index.jsp");
        } else {
            request.setAttribute("errorMessage", "Failed to publish news!");
            request.getRequestDispatcher("add-news.jsp").forward(request, response);
        }
    }
}