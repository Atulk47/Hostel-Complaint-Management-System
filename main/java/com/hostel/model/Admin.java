package com.hostel.model;

/**
 * Admin Model Class
 * Extends User class - represents an admin/warden user
 */
public class Admin extends User {

    public Admin() {
        super();
    }

    public Admin(String name, String email, String password) {
        super(name, email, password, "ADMIN", null);
    }

    public Admin(int userId, String name, String email, String password) {
        super(userId, name, email, password, "ADMIN", null);
    }

    @Override
    public String toString() {
        return "Admin{" +
                "userId=" + getUserId() +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", role='" + getRole() + '\'' +
                '}';
    }
}
