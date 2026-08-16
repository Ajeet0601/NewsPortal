package com.newsportal.util;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBConnection {
    // TiDB connection URL format
    private static final String URL = "jdbc:mysql://gateway01.ap-southeast-1.prod.aws.tidbcloud.com:4000/sys?sslmode=require";
    private static final String USER = "BKprZ3q3Y4Jtu24.root";
    private static final String PASSWORD = "tWJ1lDDnTFUbZxfD"; // Jo password generate hua

    public static Connection getConnection() {
        Connection con = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }
}