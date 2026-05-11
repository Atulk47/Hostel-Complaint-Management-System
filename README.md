# 🏨 Hostel Complaint Management System

A full-stack **Java EE web application** for managing hostel complaints with role-based access for Students, Staff, and Admins. Built using the **MVC architecture pattern** with Servlets, JSP, and MySQL.

---

## 📋 Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Installation & Setup](#installation--setup)
- [Usage](#usage)
- [Default Credentials](#default-credentials)
- [Database Schema](#database-schema)
- [Design Patterns Used](#design-patterns-used)
- [Screenshots](#screenshots)

---

## Overview

The **Hostel Complaint Management System** streamlines the process of raising, tracking, and resolving complaints within a hostel environment. Students can submit complaints, administrators can assign them to maintenance staff, and staff can update the status of repairs — all tracked through a complete timeline system.

### Problem Statement

In traditional hostel management, complaints are handled manually through registers or verbal communication, leading to:
- Lost or forgotten complaints
- No accountability or tracking
- Delayed resolutions
- No performance analytics

This system digitizes the entire complaint lifecycle with full audit trails and analytics.

---

## Features

### 👨‍🎓 Student Portal
- Submit complaints across 6 categories (Electrical, Plumbing, Internet, Cleanliness, Security, Furniture)
- View real-time complaint status updates
- Track complaint history with detailed timeline
- Room-based complaint filing

### 🔧 Staff Portal
- View assigned complaints on a dedicated dashboard
- Update complaint status (In Progress → Resolved)
- Add repair notes and remarks
- Track personal workload

### 🛡️ Admin Portal
- View and manage all complaints system-wide
- Assign complaints to available staff members
- Filter complaints by category and status
- Close resolved complaints
- **Analytics & Reports Dashboard:**
  - Complaint statistics by status and category
  - Staff performance metrics
  - Average resolution time tracking
  - Pending vs. resolved complaint ratios

### 🔐 Security
- Role-based access control via Authentication Filter
- Session-based authentication with 30-minute timeout
- HttpOnly cookies for session security
- SQL injection prevention using PreparedStatements
- Input validation on all forms

---

## Tech Stack

| Layer        | Technology                          |
|:-------------|:------------------------------------|
| **Language** | Java 11                             |
| **Backend**  | Java Servlets (javax.servlet 4.0)   |
| **Frontend** | JSP, Bootstrap 5, Font Awesome 6    |
| **Database** | MySQL 5.7+                          |
| **JDBC**     | MySQL Connector/J 8.0               |
| **Build**    | Apache Maven                        |
| **Server**   | Apache Tomcat 9+ (embedded via Maven plugin) |
| **Logging**  | SLF4J 1.7                           |
| **Testing**  | JUnit 4.13                          |

---

## Architecture

The application follows the **Model-View-Controller (MVC)** design pattern:

```
┌─────────────────────────────────────────────────────┐
│                    Client (Browser)                  │
└─────────────────────┬───────────────────────────────┘
                      │ HTTP Request/Response
┌─────────────────────▼───────────────────────────────┐
│              AuthFilter (Security Layer)             │
│         Role-based access control enforcement        │
└─────────────────────┬───────────────────────────────┘
                      │
┌─────────────────────▼───────────────────────────────┐
│          Controller Layer (13 Servlets)              │
│  LoginServlet · RegisterServlet · LogoutServlet      │
│  StudentDashboardServlet · ComplaintServlet           │
│  StaffDashboardServlet · UpdateStatusServlet          │
│  AdminDashboardServlet · AssignComplaintServlet       │
│  CloseComplaintServlet · FilterComplaintServlet       │
│  TimelineServlet · ReportServlet                     │
└──────────┬──────────────────────────┬───────────────┘
           │                          │
┌──────────▼──────────┐  ┌───────────▼───────────────┐
│  Model Layer        │  │   View Layer (JSP)         │
│  User · Student     │  │   login.jsp · register.jsp │
│  Staff · Admin      │  │   studentDashboard.jsp     │
│  Complaint          │  │   staffDashboard.jsp       │
│  ComplaintTimeline   │  │   adminDashboard.jsp       │
└──────────┬──────────┘  │   reports.jsp + more...    │
           │              └──────────────────────────-─┘
┌──────────▼──────────┐
│  DAO Layer          │
│  UserDAO            │
│  ComplaintDAO        │
│  TimelineDAO         │
│  ReportDAO           │
└──────────┬──────────┘
           │ JDBC
┌──────────▼──────────┐
│  MySQL Database     │
│  hostel_complaint_db │
└─────────────────────┘
```

---

## Project Structure

```
hostel-complaint-management/
│
├── pom.xml                          # Maven build configuration
├── hostel_complaint_db.sql          # Database schema + sample data
│
├── src/main/java/com/hostel/
│   ├── controller/                  # Servlet Controllers (13 files)
│   │   ├── LoginServlet.java
│   │   ├── RegisterServlet.java
│   │   ├── LogoutServlet.java
│   │   ├── StudentDashboardServlet.java
│   │   ├── ComplaintServlet.java
│   │   ├── StaffDashboardServlet.java
│   │   ├── UpdateStatusServlet.java
│   │   ├── AdminDashboardServlet.java
│   │   ├── AssignComplaintServlet.java
│   │   ├── CloseComplaintServlet.java
│   │   ├── FilterComplaintServlet.java
│   │   ├── TimelineServlet.java
│   │   └── ReportServlet.java
│   │
│   ├── dao/                         # Data Access Objects (4 files)
│   │   ├── UserDAO.java
│   │   ├── ComplaintDAO.java
│   │   ├── TimelineDAO.java
│   │   └── ReportDAO.java
│   │
│   ├── model/                       # Entity Models (6 files)
│   │   ├── User.java
│   │   ├── Student.java
│   │   ├── Staff.java
│   │   ├── Admin.java
│   │   ├── Complaint.java
│   │   └── ComplaintTimeline.java
│   │
│   ├── filter/                      # Security Filter
│   │   └── AuthFilter.java
│   │
│   └── util/                        # Utilities
│       └── DBConnection.java
│
├── src/main/webapp/
│   ├── index.jsp                    # Landing page
│   ├── login.jsp                    # Login page
│   ├── register.jsp                 # Registration page
│   ├── WEB-INF/
│   │   └── web.xml                  # Web app configuration
│   ├── error/
│   │   ├── 404.jsp
│   │   ├── 500.jsp
│   │   └── error.jsp
│   └── views/
│       ├── student/                 # Student JSP pages
│       │   ├── studentDashboard.jsp
│       │   ├── submitComplaint.jsp
│       │   ├── complaintHistory.jsp
│       │   └── complaintTimeline.jsp
│       ├── staff/                   # Staff JSP pages
│       │   ├── staffDashboard.jsp
│       │   └── updateComplaint.jsp
│       ├── admin/                   # Admin JSP pages
│       │   ├── adminDashboard.jsp
│       │   ├── assignComplaint.jsp
│       │   └── reports.jsp
│       └── includes/               # Shared components
│           ├── header.jsp
│           └── footer.jsp
│
└── src/test/java/com/hostel/       # Unit tests
    └── util/
        └── DBConnectionTest.java
```

---

## Prerequisites

Before you begin, ensure you have the following installed:

- **Java JDK 11** or higher → [Download](https://adoptium.net/)
- **Apache Maven 3.6+** → [Download](https://maven.apache.org/download.cgi)
- **MySQL 5.7+** → [Download](https://dev.mysql.com/downloads/)
- **Apache Tomcat 9+** (or use the embedded Maven plugin)

---

## Installation & Setup

### 1️⃣ Clone the Repository

```bash
git clone https://github.com/<your-username>/Hostel-Complaint-Management-System.git
cd Hostel-Complaint-Management-System
```

### 2️⃣ Set Up the Database

```bash
# Login to MySQL
mysql -u root -p

# Run the schema script
source hostel_complaint_db.sql;
```

This creates the `hostel_complaint_db` database with 3 tables and inserts sample data.

### 3️⃣ Configure Database Connection

Edit `src/main/java/com/hostel/util/DBConnection.java`:

```java
private static final String DB_URL = "jdbc:mysql://localhost:3306/hostel_complaint_db";
private static final String DB_USER = "root";
private static final String DB_PASSWORD = "your_password_here";  // ← Set your MySQL password
```

### 4️⃣ Build the Project

```bash
mvn clean compile
```

### 5️⃣ Run the Application

**Option A — Using the embedded Tomcat Maven plugin:**
```bash
mvn tomcat7:run
```
Then open: `http://localhost:8080/hostel-complaint-management/`

**Option B — Deploy WAR to standalone Tomcat:**
```bash
mvn clean package
# Copy target/hostel-complaint-management.war to your Tomcat webapps/ folder
```

---

## Usage

### Complaint Lifecycle

```
SUBMITTED  →  ASSIGNED  →  IN_PROGRESS  →  RESOLVED  →  CLOSED
   (Student)    (Admin)       (Staff)        (Staff)     (Admin)
```

1. **Student** logs in and submits a complaint with category, description, and room number
2. **Admin** reviews the complaint and assigns it to a staff member
3. **Staff** marks the complaint as In Progress and begins work
4. **Staff** marks the complaint as Resolved once the issue is fixed
5. **Admin** reviews and closes the complaint

Every status change is recorded in the **Complaint Timeline** for full audit trails.

### Complaint Categories

| Category       | Description                              |
|:---------------|:-----------------------------------------|
| 🔌 Electrical  | Power outlets, wiring, lighting issues   |
| 🔧 Plumbing    | Water leaks, drainage, taps              |
| 🌐 Internet    | WiFi, LAN connectivity issues            |
| 🧹 Cleanliness | Room/common area cleaning requests       |
| 🔒 Security    | Lock issues, safety concerns             |
| 🪑 Furniture   | Broken furniture, replacement requests   |

---

## Default Credentials

The SQL script inserts these sample users for testing:

| Role     | Email              | Password    |
|:---------|:-------------------|:------------|
| Admin    | admin@hostel.com   | admin@123   |
| Staff    | john@hostel.com    | john@123    |
| Staff    | sarah@hostel.com   | sarah@123   |
| Student  | alice@student.com  | alice@123   |
| Student  | bob@student.com    | bob@123     |

---

## Database Schema

The system uses **3 normalized tables** with proper foreign key relationships:

```
┌──────────────────┐      ┌─────────────────────┐      ┌─────────────────────────┐
│      users       │      │     complaints       │      │   complaint_timeline    │
├──────────────────┤      ├─────────────────────┤      ├─────────────────────────┤
│ PK user_id       │◄──┐  │ PK complaint_id      │◄──┐  │ PK timeline_id          │
│    name          │   ├──│ FK student_id         │   └──│ FK complaint_id          │
│    email (UNIQUE)│   │  │    category (ENUM)    │      │    action               │
│    password      │   └──│ FK assigned_staff     │   ┌──│ FK performed_by          │
│    role (ENUM)   │◄─────│    description        │   │  │    remarks              │
│    room_number   │      │    room_number        │   │  │    timestamp            │
│    created_at    │      │    status (ENUM)      │   │  └─────────────────────────┘
│    updated_at    │      │    notes              │   │
└──────────────────┘      │    date_created       │   │
                          │    date_closed        │   │
                          └─────────────────────┘   │
                                                     │
                          ┌──────────────────────────┘
                          │ (users.user_id)
```

**Indexes** are created on `email`, `role`, `student_id`, `assigned_staff`, `status`, `category`, `complaint_id`, and `timestamp` for optimized query performance.

---

## Design Patterns Used

| Pattern              | Where Applied                                         |
|:---------------------|:------------------------------------------------------|
| **MVC**              | Servlets (Controller), Models, JSPs (View)            |
| **DAO**              | `UserDAO`, `ComplaintDAO`, `TimelineDAO`, `ReportDAO`  |
| **Front Controller** | `AuthFilter` intercepts and controls request flow      |
| **Singleton-like**   | `DBConnection` utility for centralized DB access       |
| **Inheritance**      | `Student`, `Staff`, `Admin` extend `User` base class   |

---

</p>
