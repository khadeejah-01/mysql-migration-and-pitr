USE UniversityDB;

INSERT INTO Students (FirstName, LastName, Email) VALUES
('Ali', 'Khan', 'ali.khan@university.edu'),
('Sara', 'Ahmed', 'sara.ahmed@university.edu'),
('Ahmed', 'Hassan', 'ahmed.hassan@university.edu'),
('Fatima', 'Malik', 'fatima.malik@university.edu'),
('Zainab', 'Tariq', 'zainab.tariq@university.edu'),
('Bilal', 'Raza', 'bilal.raza@university.edu');

INSERT INTO Courses (CourseName, Credits, Department) VALUES
('Database Systems', 3, 'Computer Science'),
('Web Technologies', 3, 'Computer Science'),
('Data Structures', 4, 'Computer Science'),
('Computer Networks', 3, 'Computer Science'),
('Artificial Intelligence', 3, 'Computer Science');

INSERT INTO Enrollments (StudentID, CourseID) VALUES
(1, 1),
(1, 2),
(2, 1),
(2, 4),
(3, 3),
(4, 2),
(5, 1),
(6, 3);
SELECT COUNT(*) FROM Students;
SELECT COUNT(*) FROM Courses;
SELECT COUNT(*) FROM Enrollments;
