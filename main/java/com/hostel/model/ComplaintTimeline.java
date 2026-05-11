package com.hostel.model;

import java.time.LocalDateTime;

/**
 * ComplaintTimeline Model Class
 * Represents timeline events for a complaint
 */
public class ComplaintTimeline {
    private int timelineId;
    private int complaintId;
    private String action;
    private int performedBy;
    private String remarks;
    private LocalDateTime timestamp;

    // Constructors
    public ComplaintTimeline() {}

    public ComplaintTimeline(int complaintId, String action, int performedBy, String remarks) {
        this.complaintId = complaintId;
        this.action = action;
        this.performedBy = performedBy;
        this.remarks = remarks;
    }

    public ComplaintTimeline(int timelineId, int complaintId, String action, int performedBy,
                            String remarks, LocalDateTime timestamp) {
        this.timelineId = timelineId;
        this.complaintId = complaintId;
        this.action = action;
        this.performedBy = performedBy;
        this.remarks = remarks;
        this.timestamp = timestamp;
    }

    // Getters and Setters
    public int getTimelineId() {
        return timelineId;
    }

    public void setTimelineId(int timelineId) {
        this.timelineId = timelineId;
    }

    public int getComplaintId() {
        return complaintId;
    }

    public void setComplaintId(int complaintId) {
        this.complaintId = complaintId;
    }

    public String getAction() {
        return action;
    }

    public void setAction(String action) {
        this.action = action;
    }

    public int getPerformedBy() {
        return performedBy;
    }

    public void setPerformedBy(int performedBy) {
        this.performedBy = performedBy;
    }

    public String getRemarks() {
        return remarks;
    }

    public void setRemarks(String remarks) {
        this.remarks = remarks;
    }

    public LocalDateTime getTimestamp() {
        return timestamp;
    }

    public void setTimestamp(LocalDateTime timestamp) {
        this.timestamp = timestamp;
    }

    @Override
    public String toString() {
        return "ComplaintTimeline{" +
                "timelineId=" + timelineId +
                ", complaintId=" + complaintId +
                ", action='" + action + '\'' +
                ", performedBy=" + performedBy +
                ", timestamp=" + timestamp +
                '}';
    }
}
