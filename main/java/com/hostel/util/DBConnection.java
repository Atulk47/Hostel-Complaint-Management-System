package com.hostel.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * DBConnection Utility Class
 * Manages JDBC database connections
 */
public class DBConnection {
    private static final String DB_URL = "jdbc:mysql://localhost:3306/hostel_complaint_db";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "chintu";
    private static final String DB_DRIVER = "com.mysql.cj.jdbc.Driver";

    // Static block to load the JDBC driver
    static {
        try {
            Class.forName(DB_DRIVER);
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
            System.err.println("MySQL JDBC Driver not found!");
        }
    }

    /**
     * Get a database connection
     * @return Connection object
     * @throws SQLException if connection fails
     */
    public static Connection getConnection() throws SQLException {
        try {
            return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.err.println("Failed to connect to database: " + e.getMessage());
            throw e;
        }
    }

    /**
     * Close a database connection
     * @param conn Connection to close
     */
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("Error closing connection: " + e.getMessage());
            }
        }
    }
}
