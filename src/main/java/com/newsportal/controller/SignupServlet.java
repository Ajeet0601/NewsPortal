package com.newsportal.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.newsportal.dao.UserDAO;
import com.newsportal.model.User;

@WebServlet("/signup")
public class SignupServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String mobile = request.getParameter("mobile");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");

        if (!password.equals(confirmPassword)) {
            request.setAttribute("errorMessage", "Passwords do not match!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        UserDAO userDAO = new UserDAO();

        if (userDAO.isEmailExists(email)) {
            request.setAttribute("errorMessage", "Email is already registered!");
            request.getRequestDispatcher("signup.jsp").forward(request, response);
            return;
        }

        // 1. Temporary User banayein
        User tempUser = new User(fullName, email, mobile, password);

        // 2. 6-digit random OTP generate karein
        int otp = (int)(Math.random() * 900000) + 100000;

        // 3. Session mein save karein
        HttpSession session = request.getSession();
        session.setAttribute("tempUser", tempUser);
        session.setAttribute("generatedOtp", otp);

        // Eclipse Console par OTP print hoga (Testing ke liye)
        System.out.println("=================================");
        System.out.println("OTP for " + email + " is: " + otp);
        System.out.println("=================================");

        // 4. Verify OTP page par bhejein
        response.sendRedirect("verify-otp.jsp");
    }
}