CREATE DATABASE IF NOT EXISTS manytomany_example;
USE manytomany_example;

-- Създаваме таблица students
CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Вмъкваме данните
INSERT INTO students (name) VALUES
('Mila'),
('Toni'),
('Ron');

-- Създаваме таблица exams
CREATE TABLE exams (
    exam_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

-- Вмъкваме данните
INSERT INTO exams (name) VALUES
('Spring MVC'),
('Neo4j'),
('Oracle 11g');

-- Преглед на създадените ID-та
SELECT * FROM students;
SELECT * FROM exams;

-- Създаваме таблица students_exams (връзка Many-to-Many)
CREATE TABLE students_exams (
    student_id INT,
    exam_id INT,
    
    PRIMARY KEY (student_id, exam_id),   -- Съставен първичен ключ

    CONSTRAINT fk_studentsexams_student
        FOREIGN KEY (student_id)
        REFERENCES students(student_id)
        ON DELETE CASCADE,

    CONSTRAINT fk_studentsexams_exam
        FOREIGN KEY (exam_id)
        REFERENCES exams(exam_id)
        ON DELETE CASCADE
);

-- Вмъкваме данните за студентите и техните изпити
-- Тук използваме реалните AUTO_INCREMENT ID-та
INSERT INTO students_exams (student_id, exam_id) VALUES
(1, 1),  -- Mila -> Spring MVC
(1, 2),  -- Mila -> Neo4j
(2, 1),  -- Toni -> Spring MVC
(3, 3),  -- Ron -> Oracle 11g
(2, 2),  -- Toni -> Neo4j
(2, 3);  -- Toni -> Oracle 11g

-- Преглед на таблиците
SELECT * FROM students;
SELECT * FROM exams;
SELECT * FROM students_exams;
