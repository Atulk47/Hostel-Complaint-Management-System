package com.hostel.dao;

import com.hostel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.HashMap;
import java.util.Map;

/**
 * ReportDAO Class
 * Handles report generation and statistics
 */
public class ReportDAO {

    /**
     * Get complaint count by status
     * @return Map with status as key and count as value
     */
    public Map<String, Integer> getComplaintCountByStatus() {
        Map<String, Integer> statusMap = new HashMap<>();
        String sql = "SELECT status, COUNT(*) as count FROM complaints GROUP BY status";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                statusMap.put(rs.getString("status"), rs.getInt("count"));
            }

        } catch (SQLException e) {
            System.err.println("Error getting complaint count by status: " + e.getMessage());
            e.printStackTrace();
        }

        return statusMap;
    }

    /**
     * Get complaint count by category
     * @return Map with category as key and count as value
     */
    public Map<String, Integer> getComplaintCountByCategory() {
        Map<String, Integer> categoryMap = new HashMap<>();
        String sql = "SELECT category, COUNT(*) as count FROM complaints GROUP BY category";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                categoryMap.put(rs.getString("category"), rs.getInt("count"));
            }

        } catch (SQLException e) {
            System.err.println("Error getting complaint count by category: " + e.getMessage());
            e.printStackTrace();
        }

        return categoryMap;
    }

    /**
     * Get total complaints count
     * @return Total number of complaints
     */
    public int getTotalComplaintsCount() {
        String sql = "SELECT COUNT(*) as total FROM complaints";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            System.err.println("Error getting total complaints count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Get total closed complaints count
     * @return Total number of closed complaints
     */
    public int getClosedComplaintsCount() {
        String sql = "SELECT COUNT(*) as total FROM complaints WHERE status = 'CLOSED'";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            System.err.println("Error getting closed complaints count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Get pending complaints count
     * @return Number of pending complaints
     */
    public int getPendingComplaintsCount() {
        String sql = "SELECT COUNT(*) as total FROM complaints WHERE status IN ('SUBMITTED', 'ASSIGNED', 'IN_PROGRESS')";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getInt("total");
            }

        } catch (SQLException e) {
            System.err.println("Error getting pending complaints count: " + e.getMessage());
            e.printStackTrace();
        }

        return 0;
    }

    /**
     * Get staff performance statistics
     * @return Map with staff ID and complaints count
     */
    public Map<Integer, Integer> getStaffPerformance() {
        Map<Integer, Integer> performanceMap = new HashMap<>();
        String sql = "SELECT assigned_staff, COUNT(*) as complaint_count FROM complaints " +
                     "WHERE assigned_staff IS NOT NULL GROUP BY assigned_staff";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                performanceMap.put(rs.getInt("assigned_staff"), rs.getInt("complaint_count"));
            }

        } catch (SQLException e) {
            System.err.println("Error getting staff performance: " + e.getMessage());
            e.printStackTrace();
        }

        return performanceMap;
    }

    /**
     * Get average resolution time (in hours)
     * @return Average resolution time
     */
    public double getAverageResolutionTime() {
        String sql = "SELECT AVG(TIMESTAMPDIFF(HOUR, date_created, date_closed)) as avg_time " +
                     "FROM complaints WHERE date_closed IS NOT NULL";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            if (rs.next()) {
                return rs.getDouble("avg_time");
            }

        } catch (SQLException e) {
            System.err.println("Error getting average resolution time: " + e.getMessage());
            e.printStackTrace();
        }

        return 0.0;
    }
}
