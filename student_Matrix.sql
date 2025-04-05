create database student_performance;
use student_performance;

DROP TABLE IF EXISTS Attendance;
DROP TABLE IF EXISTS Marks;
DROP TABLE IF EXISTS Enrollments;
DROP TABLE IF EXISTS Courses;
DROP TABLE IF EXISTS Students;

CREATE TABLE Students (
    student_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    dob DATE,
    gender VARCHAR(10)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(100),
    credits INT
);

CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester VARCHAR(10),
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Attendance (
    attendance_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    date DATE,
    status VARCHAR(10),
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);

CREATE TABLE Marks (
    mark_id INT PRIMARY KEY,
    student_id INT,
    course_id INT,
    marks_obtained INT,
    total_marks INT,
    FOREIGN KEY(student_id) REFERENCES Students(student_id),
    FOREIGN KEY(course_id) REFERENCES Courses(course_id)
);


INSERT INTO Students VALUES
(1, 'Amit Sharma', 'amit@example.com', '2002-04-12', 'Male'),
(2, 'Priya Singh', 'priya@example.com', '2001-09-23', 'Female'),
(3, 'Rahul Mehta', 'rahul@example.com', '2003-01-30', 'Male');

INSERT INTO Courses VALUES
(101, 'Data Science', 4),
(102, 'Database Systems', 3),
(103, 'Statistics', 3);

INSERT INTO Enrollments VALUES
(1, 1, 101, 'Spring2024'),
(2, 1, 102, 'Spring2024'),
(3, 2, 101, 'Spring2024'),
(4, 2, 103, 'Spring2024'),
(5, 3, 102, 'Spring2024');

INSERT INTO Attendance VALUES
(1, 1, 101, '2025-03-01', 'Present'),
(2, 1, 101, '2025-03-02', 'Absent'),
(3, 2, 101, '2025-03-01', 'Present'),
(4, 2, 103, '2025-03-01', 'Present'),
(5, 3, 102, '2025-03-01', 'Absent');

INSERT INTO Marks VALUES
(1, 1, 101, 85, 100),
(2, 1, 102, 78, 100),
(3, 2, 101, 90, 100),
(4, 2, 103, 82, 100),
(5, 3, 102, 60, 100);

 ## List all students with their enrolled courses
SELECT s.name AS student_name, c.course_name
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
JOIN Courses c ON e.course_id = c.course_id;

## Get attendance percentage per student per course
SELECT student_id, course_id,
    SUM(CASE WHEN status = 'Present' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS attendance_percentage
FROM Attendance
GROUP BY student_id, course_id;

## List students who scored more than 80% in any course
SELECT s.name, c.course_name, 
       m.marks_obtained * 100.0 / m.total_marks AS percentage
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
JOIN Courses c ON m.course_id = c.course_id
WHERE m.marks_obtained * 100.0 / m.total_marks > 80;

## Top 3 students in Data Science course
SELECT s.name, m.marks_obtained
FROM Marks m
JOIN Students s ON m.student_id = s.student_id
WHERE m.course_id = 101
ORDER BY m.marks_obtained DESC
LIMIT 3;

## Count of students per course
SELECT c.course_name, COUNT(e.student_id) AS total_students
FROM Courses c
JOIN Enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name;

## Students with full attendance in any course
SELECT a.student_id, c.course_name
FROM Attendance a
JOIN Courses c ON a.course_id = c.course_id
GROUP BY a.student_id, a.course_id
HAVING SUM(CASE WHEN status = 'Absent' THEN 1 ELSE 0 END) = 0;
