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

@WebServlet("/verify-otp")
public class VerifyOtpServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String enteredOtpStr = request.getParameter("enteredOtp");
        HttpSession session = request.getSession();
        
        Integer generatedOtp = (Integer) session.getAttribute("generatedOtp");
        User tempUser = (User) session.getAttribute("tempUser");

        if (generatedOtp != null && tempUser != null && enteredOtpStr != null) {
            try {
                int enteredOtp = Integer.parseInt(enteredOtpStr.trim());

                if (enteredOtp == generatedOtp) {
                    // YEH LINE DATABASE MEIN AUTOMATICALLY 1 (TRUE) BHEJEGI:
                    tempUser.setVerified(true);

                    // Ab database mein record insert hoga with is_verified = 1
                    UserDAO userDAO = new UserDAO();
                    boolean isSaved = userDAO.registerUser(tempUser);

                    if (isSaved) {
                        // Session clear karein
                        session.removeAttribute("tempUser");
                        session.removeAttribute("generatedOtp");

                        request.setAttribute("successMessage", "Account verified & registered successfully! Please login.");
                        request.getRequestDispatcher("login.jsp").forward(request, response);
                    } else {
                        request.setAttribute("errorMessage", "Database error! Please try again.");
                        request.getRequestDispatcher("signup.jsp").forward(request, response);
                    }
                } else {
                    request.setAttribute("errorMessage", "Invalid OTP. Please try again!");
                    request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "Please enter a valid numeric OTP.");
                request.getRequestDispatcher("verify-otp.jsp").forward(request, response);
            }
        } else {
            response.sendRedirect("signup.jsp");
        }
    }
}