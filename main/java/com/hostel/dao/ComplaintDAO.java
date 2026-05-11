package com.hostel.dao;

import com.hostel.model.Complaint;
import com.hostel.util.DBConnection;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * ComplaintDAO Class
 * Handles all complaint-related database operations
 */
public class ComplaintDAO {

    /**
     * Submit a new complaint
     * @param complaint Complaint object
     * @return complaint ID if successful, -1 otherwise
     */
    public int submitComplaint(Complaint complaint) {
        String sql = "INSERT INTO complaints (student_id, category, description, room_number, status) VALUES (?, ?, ?, ?, ?)";
        int complaintId = -1;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {

            pstmt.setInt(1, complaint.getStudentId());
            pstmt.setString(2, complaint.getCategory());
            pstmt.setString(3, complaint.getDescription());
            pstmt.setString(4, complaint.getRoomNumber());
            pstmt.setString(5, "SUBMITTED");

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        complaintId = generatedKeys.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            System.err.println("Error submitting complaint: " + e.getMessage());
            e.printStackTrace();
        }

        return complaintId;
    }

    /**
     * Get all complaints for a student
     * @param studentId Student ID
     * @return List of complaints
     */
    public List<Complaint> getComplaintsByStudent(int studentId) {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE student_id = ? ORDER BY date_created DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, studentId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Complaint complaint = new Complaint(
                        rs.getInt("complaint_id"),
                        rs.getInt("student_id"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("room_number"),
                        rs.getString("status"),
                        (Integer) rs.getObject("assigned_staff"),
                        rs.getString("notes"),
                        rs.getTimestamp("date_created") != null ?
                            rs.getTimestamp("date_created").toLocalDateTime() : null,
                        rs.getTimestamp("date_closed") != null ?
                            rs.getTimestamp("date_closed").toLocalDateTime() : null
                    );
                    complaints.add(complaint);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving complaints for student: " + e.getMessage());
            e.printStackTrace();
        }

        return complaints;
    }

    /**
     * Get all complaints
     * @return List of all complaints
     */
    public List<Complaint> getAllComplaints() {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints ORDER BY date_created DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Complaint complaint = new Complaint(
                    rs.getInt("complaint_id"),
                    rs.getInt("student_id"),
                    rs.getString("category"),
                    rs.getString("description"),
                    rs.getString("room_number"),
                    rs.getString("status"),
                    (Integer) rs.getObject("assigned_staff"),
                    rs.getString("notes"),
                    rs.getTimestamp("date_created") != null ?
                        rs.getTimestamp("date_created").toLocalDateTime() : null,
                    rs.getTimestamp("date_closed") != null ?
                        rs.getTimestamp("date_closed").toLocalDateTime() : null
                );
                complaints.add(complaint);
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving all complaints: " + e.getMessage());
            e.printStackTrace();
        }

        return complaints;
    }

    /**
     * Get complaint by ID
     * @param complaintId Complaint ID
     * @return Complaint object if found, null otherwise
     */
    public Complaint getComplaintById(int complaintId) {
        String sql = "SELECT * FROM complaints WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, complaintId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    return new Complaint(
                        rs.getInt("complaint_id"),
                        rs.getInt("student_id"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("room_number"),
                        rs.getString("status"),
                        (Integer) rs.getObject("assigned_staff"),
                        rs.getString("notes"),
                        rs.getTimestamp("date_created") != null ?
                            rs.getTimestamp("date_created").toLocalDateTime() : null,
                        rs.getTimestamp("date_closed") != null ?
                            rs.getTimestamp("date_closed").toLocalDateTime() : null
                    );
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving complaint: " + e.getMessage());
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Assign complaint to staff
     * @param complaintId Complaint ID
     * @param staffId Staff member ID
     * @return true if successful, false otherwise
     */
    public boolean assignComplaintToStaff(int complaintId, int staffId) {
        String sql = "UPDATE complaints SET assigned_staff = ?, status = 'ASSIGNED' WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, staffId);
            pstmt.setInt(2, complaintId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error assigning complaint: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Update complaint status
     * @param complaintId Complaint ID
     * @param status New status
     * @return true if successful, false otherwise
     */
    public boolean updateComplaintStatus(int complaintId, String status) {
        String sql = "UPDATE complaints SET status = ? WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, status);
            pstmt.setInt(2, complaintId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating complaint status: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Update complaint notes
     * @param complaintId Complaint ID
     * @param notes Notes to add
     * @return true if successful, false otherwise
     */
    public boolean updateComplaintNotes(int complaintId, String notes) {
        String sql = "UPDATE complaints SET notes = ? WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, notes);
            pstmt.setInt(2, complaintId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error updating complaint notes: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Close complaint
     * @param complaintId Complaint ID
     * @return true if successful, false otherwise
     */
    public boolean closeComplaint(int complaintId) {
        String sql = "UPDATE complaints SET status = 'CLOSED', date_closed = NOW() WHERE complaint_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, complaintId);

            return pstmt.executeUpdate() > 0;

        } catch (SQLException e) {
            System.err.println("Error closing complaint: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Get complaints assigned to staff
     * @param staffId Staff ID
     * @return List of complaints assigned to staff
     */
    public List<Complaint> getComplaintsByStaff(int staffId) {
        List<Complaint> complaints = new ArrayList<>();
        String sql = "SELECT * FROM complaints WHERE assigned_staff = ? ORDER BY date_created DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setInt(1, staffId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Complaint complaint = new Complaint(
                        rs.getInt("complaint_id"),
                        rs.getInt("student_id"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("room_number"),
                        rs.getString("status"),
                        (Integer) rs.getObject("assigned_staff"),
                        rs.getString("notes"),
                        rs.getTimestamp("date_created") != null ?
                            rs.getTimestamp("date_created").toLocalDateTime() : null,
                        rs.getTimestamp("date_closed") != null ?
                            rs.getTimestamp("date_closed").toLocalDateTime() : null
                    );
                    complaints.add(complaint);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving complaints for staff: " + e.getMessage());
            e.printStackTrace();
        }

        return complaints;
    }

    /**
     * Get complaints filtered by category and status
     * @param category Complaint category
     * @param status Complaint status
     * @return List of filtered complaints
     */
    public List<Complaint> getFilteredComplaints(String category, String status) {
        List<Complaint> complaints = new ArrayList<>();
        StringBuilder sql = new StringBuilder("SELECT * FROM complaints WHERE 1=1");

        if (category != null && !category.isEmpty()) {
            sql.append(" AND category = ?");
        }
        if (status != null && !status.isEmpty()) {
            sql.append(" AND status = ?");
        }
        sql.append(" ORDER BY date_created DESC");

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql.toString())) {

            int paramIndex = 1;
            if (category != null && !category.isEmpty()) {
                pstmt.setString(paramIndex++, category);
            }
            if (status != null && !status.isEmpty()) {
                pstmt.setString(paramIndex++, status);
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Complaint complaint = new Complaint(
                        rs.getInt("complaint_id"),
                        rs.getInt("student_id"),
                        rs.getString("category"),
                        rs.getString("description"),
                        rs.getString("room_number"),
                        rs.getString("status"),
                        (Integer) rs.getObject("assigned_staff"),
                        rs.getString("notes"),
                        rs.getTimestamp("date_created") != null ?
                            rs.getTimestamp("date_created").toLocalDateTime() : null,
                        rs.getTimestamp("date_closed") != null ?
                            rs.getTimestamp("date_closed").toLocalDateTime() : null
                    );
                    complaints.add(complaint);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error retrieving filtered complaints: " + e.getMessage());
            e.printStackTrace();
        }

        return complaints;
    }
}
