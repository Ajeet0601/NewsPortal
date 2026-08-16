package com.newsportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.newsportal.model.User;
import com.newsportal.util.DBConnection;

public class UserDAO {

    // Register User
    public boolean registerUser(User user) {
        boolean status = false;
        String sql = "INSERT INTO users (full_name, email, mobile, password, role, is_verified) VALUES (?, ?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getMobile());
            ps.setString(4, user.getPassword());
            ps.setString(5, user.getRole());
            ps.setBoolean(6, user.isVerified());

            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }

    // Login Validation
    public User loginUser(String email, String password) {
        User user = null;
        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                user = new User();
                user.setUserId(rs.getInt("user_id"));
                user.setFullName(rs.getString("full_name"));
                user.setEmail(rs.getString("email"));
                user.setMobile(rs.getString("mobile"));
                user.setRole(rs.getString("role"));
                user.setProfileImage(rs.getString("profile_image"));
                user.setVerified(rs.getBoolean("is_verified"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }

    // Check if email already exists
    public boolean isEmailExists(String email) {
        boolean exists = false;
        String sql = "SELECT user_id FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                exists = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return exists;
    }
}