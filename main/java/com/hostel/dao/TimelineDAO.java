package com.hostel.dao;

import com.hostel.model.ComplaintTimeline;
import com.hostel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * TimelineDAO Class
 * Handles all complaint timeline-related database operations
 */
public class TimelineDAO {

    /**
     * Add a timeline entry for a complaint
     * @param timeline ComplaintTimeline object
     * @return true if successful, false otherwise
     */
    public boolean addTimelineEntry(ComplaintTimeline timeline) {
        String sql = "INSERT INTO complaint_timeline (complaint_id, action, performed_by, remarks) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, timeline.getComplaintId());
            pstmt.setString(2, timeline.getAction());
            pstmt.setInt(3, timeline.getPerformedBy());
            pstmt.setString(4, timeline.getRemarks());

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error adding timeline entry: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Get timeline entries for a complaint
     * @param complaintId Complaint ID
     * @return List of timeline entries
     */
    public List<ComplaintTimeline> getTimelineByComplaintId(int complaintId) {
        List<ComplaintTimeline> timeline = new ArrayList<>();
        String sql = "SELECT * FROM complaint_timeline WHERE complaint_id = ? ORDER BY timestamp ASC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, complaintId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    ComplaintTimeline entry = new ComplaintTimeline(
                        rs.getInt("timeline_id"),
                        rs.getInt("complaint_id"),
                        rs.getString("action"),
                        rs.getInt("performed_by"),
                        rs.getString("remarks"),
                        rs.getTimestamp("timestamp") != null ?
                            rs.getTimestamp("timestamp").toLocalDateTime() : null
                    );
                    timeline.add(entry);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving timeline: " + e.getMessage());
            e.printStackTrace();
        }

        return timeline;
    }

    /**
     * Get latest timeline entry for a complaint
     * @param complaintId Complaint ID
     * @return Latest ComplaintTimeline object
     */
    public ComplaintTimeline getLatestTimelineEntry(int complaintId) {
        String sql = "SELECT * FROM complaint_timeline WHERE complaint_id = ? ORDER BY timestamp DESC LIMIT 1";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, complaintId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new ComplaintTimeline(
                        rs.getInt("timeline_id"),
                        rs.getInt("complaint_id"),
                        rs.getString("action"),
                        rs.getInt("performed_by"),
                        rs.getString("remarks"),
                        rs.getTimestamp("timestamp") != null ?
                            rs.getTimestamp("timestamp").toLocalDateTime() : null
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving latest timeline entry: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Delete timeline entry
     * @param timelineId Timeline ID
     * @return true if successful, false otherwise
     */
    public boolean deleteTimelineEntry(int timelineId) {
        String sql = "DELETE FROM complaint_timeline WHERE timeline_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, timelineId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error deleting timeline entry: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }
}
