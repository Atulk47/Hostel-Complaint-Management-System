package com.hostel.model;

import java.time.LocalDateTime;

/**
 * Complaint Model Class
 * Represents a complaint submitted by a student
 */
public class Complaint {
    private int complaintId;
    private int studentId;
    private String category;
    private String description;
    private String roomNumber;
    private String status;
    private Integer assignedStaff;
    private String notes;
    private LocalDateTime dateCreated;
    private LocalDateTime dateClosed;

    // Constructors
    public Complaint() {}

    public Complaint(int studentId, String category, String description, String roomNumber) {
        this.studentId = studentId;
        this.category = category;
        this.description = description;
        this.roomNumber = roomNumber;
        this.status = "SUBMITTED";
    }

    public Complaint(int complaintId, int studentId, String category, String description,
                     String roomNumber, String status, Integer assignedStaff, String notes,
                     LocalDateTime dateCreated, LocalDateTime dateClosed) {
        this.complaintId = complaintId;
        this.studentId = studentId;
        this.category = category;
        this.description = description;
        this.roomNumber = roomNumber;
        this.status = status;
        this.assignedStaff = assignedStaff;
        this.notes = notes;
        this.dateCreated = dateCreated;
        this.dateClosed = dateClosed;
    }

    // Getters and Setters
    public int getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(int complaintId) {
        this.complaintId = complaintId;
    }

    public int getStudentId() {
        return studentId;
    }

    public void setStudentId(int studentId) {
        this.studentId = studentId;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getRoomNumber() {
        return roomNumber;
    }

    public void setRoomNumber(String roomNumber) {
        this.roomNumber = roomNumber;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Integer getAssignedStaff() {
        return assignedStaff;
    }

    public void setAssignedStaff(Integer assignedStaff) {
        this.assignedStaff = assignedStaff;
    }

    public String getNotes() {
        return notes;
    }

    public void setNotes(String notes) {
        this.notes = notes;
    }

    public LocalDateTime getDateCreated() {
        return dateCreated;
    }

    public void setDateCreated(LocalDateTime dateCreated) {
        this.dateCreated = dateCreated;
    }

    public LocalDateTime getDateClosed() {
        return dateClosed;
    }

    public void setDateClosed(LocalDateTime dateClosed) {
        this.dateClosed = dateClosed;
    }

    @Override
    public String toString() {
        return "Complaint{" +
                "complaintId=" + complaintId +
                ", studentId=" + studentId +
                ", category='" + category + '\'' +
                ", description='" + description + '\'' +
                ", roomNumber='" + roomNumber + '\'' +
                ", status='" + status + '\'' +
                ", assignedStaff=" + assignedStaff +
                ", dateCreated=" + dateCreated +
                '}';
    }
}
