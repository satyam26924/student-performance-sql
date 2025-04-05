
-- Database: Student Performance Management System

-- Drop tables if they already exist
DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

-- Creating Students table
CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    dob DATE,
    gender VARCHAR(10)
);

-- Creating Courses table
CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

-- Creating Enrollments table
CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester VARCHAR(10),
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

-- Creating Attendance table
CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

-- Creating Marks table
CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks_obtained INT,
    total_marks INT,
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

-- Inserting sample data into Students
INSERT INTO Students VALUES
(1, 'Amit Sharma', 'amit@example.com', '2002-04-12', 'Male'),
(2, 'Priya Singh', 'priya@example.com', '2001-09-23', 'Female'),
(3, 'Rahul Mehta', 'rahul@example.com', '2003-01-30', 'Male');

-- Inserting sample data into Courses
INSERT INTO Courses VALUES
(101, 'Data Science', 4),
(102, 'Database Systems', 3),
(103, 'Statistics', 3);

-- Inserting sample data into Enrollments
INSERT INTO Enrollments VALUES
(1, 1, 101, 'Spring2024'),
(2, 1, 102, 'Spring2024'),
(3, 2, 101, 'Spring2024'),
(4, 2, 103, 'Spring2024'),
(5, 3, 102, 'Spring2024');

-- Inserting sample data into Attendance
INSERT INTO Attendance VALUES
(1, 1, 101, '2025-03-01', 'Present'),
(2, 1, 101, '2025-03-02', 'Absent'),
(3, 2, 101, '2025-03-01', 'Present'),
(4, 2, 103, '2025-03-01', 'Present'),
(5, 3, 102, '2025-03-01', 'Absent');

-- Inserting sample data into Marks
INSERT INTO Marks VALUES
(1, 1, 101, 85, 100),
(2, 1, 102, 78, 100),
(3, 2, 101, 90, 100),
(4, 2, 103, 82, 100),
(5, 3, 102, 60, 100);
