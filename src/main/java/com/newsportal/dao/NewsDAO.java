package com.newsportal.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.newsportal.model.News;
import com.newsportal.util.DBConnection;

public class NewsDAO {

    public List<News> getAllNews() {
        List<News> list = new ArrayList<>();
        String sql = "SELECT n.*, c.category_name FROM news n " +
                     "LEFT JOIN categories c ON n.category_id = c.category_id " +
                     "ORDER BY n.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                News news = new News();
                news.setNewsId(rs.getInt("news_id"));
                news.setTitle(rs.getString("title"));
                news.setContent(rs.getString("content"));
                news.setImageUrl(rs.getString("image_url"));
                news.setCategoryName(rs.getString("category_name"));
                news.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 // Category ke hisaab se news fetch karne ke liye
    public List<News> getNewsByCategory(int categoryId) {
        List<News> list = new ArrayList<>();
        String sql = "SELECT n.*, c.category_name FROM news n " +
                     "LEFT JOIN categories c ON n.category_id = c.category_id " +
                     "WHERE n.category_id = ? " +
                     "ORDER BY n.created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                News news = new News();
                news.setNewsId(rs.getInt("news_id"));
                news.setTitle(rs.getString("title"));
                news.setContent(rs.getString("content"));
                news.setImageUrl(rs.getString("image_url"));
                news.setCategoryName(rs.getString("category_name"));
                news.setCreatedAt(rs.getTimestamp("created_at"));
                list.add(news);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
 // Nayi news add karne ke liye
    public boolean addNews(String title, String content, String imageUrl, int categoryId, int userId) {
        boolean status = false;
        String sql = "INSERT INTO news (title, content, image_url, category_id, user_id) VALUES (?, ?, ?, ?, ?)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, title);
            ps.setString(2, content);
            ps.setString(3, imageUrl);
            ps.setInt(4, categoryId);
            ps.setInt(5, userId);

            int rows = ps.executeUpdate();
            if (rows > 0) {
                status = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return status;
    }
 // News ID se single news article fetch karne ke liye
    public News getNewsById(int newsId) {
        News news = null;
        String sql = "SELECT n.*, c.category_name FROM news n " +
                     "LEFT JOIN categories c ON n.category_id = c.category_id " +
                     "WHERE n.news_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, newsId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                news = new News();
                news.setNewsId(rs.getInt("news_id"));
                news.setTitle(rs.getString("title"));
                news.setContent(rs.getString("content"));
                news.setImageUrl(rs.getString("image_url"));
                news.setCategoryName(rs.getString("category_name"));
                news.setCreatedAt(rs.getTimestamp("created_at"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return news;
    }
}	