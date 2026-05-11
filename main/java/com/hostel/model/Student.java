package com.hostel.model;

/**
 * Student Model Class
 * Extends User class - represents a student user
 */
public class Student extends User {

    public Student() {
        super();
    }

    public Student(String name, String email, String password, String roomNumber) {
        super(name, email, password, "STUDENT", roomNumber);
    }

    public Student(int userId, String name, String email, String password, String roomNumber) {
        super(userId, name, email, password, "STUDENT", roomNumber);
    }

    @Override
    public String toString() {
        return "Student{" +
                "userId=" + getUserId() +
                ", name='" + getName() + '\'' +
                ", email='" + getEmail() + '\'' +
                ", roomNumber='" + getRoomNumber() + '\'' +
                ", role='" + getRole() + '\'' +
                '}';
    }
}
