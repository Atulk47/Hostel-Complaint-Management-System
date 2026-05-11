package com.hostel.model;

/**
 * Staff Model Class
 * Extends User class - represents a maintenance staff member
 */
public class Staff extends User {

    public Staff() {
        super();
    }

    public Staff(String name, String email, String password) {
        super(name, email, password, "STAFF", null);
    }

    public Staff(int userId, String name, String email, String password) {
        super(userId, name, email, password, "STAFF", null);
    }

    @Override
    public String toString() {
        return "Staff{" +
                "userId=" + getUserId() +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", role='" + getRole() + '\'' +
                '}';
    }
}
