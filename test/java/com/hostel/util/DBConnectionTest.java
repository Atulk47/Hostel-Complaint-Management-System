package com.hostel.util;

import org.junit.Test;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import static org.junit.Assert.*;

public class DBConnectionTest {

    @Test
    public void testConnection() {
        try (Connection conn = DBConnection.getConnection()) {
            assertNotNull("Connection should not be null", conn);
            System.out.println("[DEBUG_LOG] Connection successful!");
            
            try (Statement stmt = conn.createStatement();
                 ResultSet rs = stmt.executeQuery("SELECT count(*) FROM users")) {
                if (rs.next()) {
                    System.out.println("[DEBUG_LOG] User count: " + rs.getInt(1));
                }
            }
        } catch (Exception e) {
            System.err.println("[DEBUG_LOG] Connection failed: " + e.getMessage());
            e.printStackTrace();
            fail("Connection failed: " + e.getMessage());
        }
    }
}
