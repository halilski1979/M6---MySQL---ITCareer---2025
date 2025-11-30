/* Many-To-Many*/

CREATE DATABASE STUDENTI;
USE STUDENTI;

-- Създаваме таблица Students (Студенти)
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Създаваме таблица Courses (Курсове)
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL
);

-- Междинна таблица за N:N връзка между Students и Courses
-- Една студент може да посещава много курсове
-- Един курс може да се посещава от много студенти
CREATE TABLE StudentCourses (
    student_id INT,
    course_id INT,
    PRIMARY KEY (student_id, course_id), -- Композитен първичен ключ
    FOREIGN KEY (student_id) 
		REFERENCES Students(student_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE, -- Ако изтрием студент — трият се и записа му в връзката
        
        -- Тук използваме RESTRICT (обратното на CASCADE)
        -- Забраняваме изтриване/обновяване ако има зависими записи
        -- ON UPDATE RESTRICT
        -- ON DELETE RESTRICT
        
        -- Ако изтрием студент или курс → FK се прави NULL
        -- ON UPDATE SET NULL
        -- ON DELETE SET NULL
        
        
        --  NO ACTION  На практика същото като RESTRICT в MySQL
        -- ON UPDATE NO ACTION
        -- ON DELETE NO ACTION
        
    FOREIGN KEY (course_id)
        REFERENCES Courses(course_id)
        ON UPDATE CASCADE
        ON DELETE CASCADE -- Ако изтрием курс — изтриват се и записите му във връзката
);

INSERT INTO Students (name) VALUES ('Ivan'), ('Maria'), ('Georgi');
INSERT INTO Courses (title) VALUES ('Math'), ('Programming'), ('English');

INSERT INTO StudentCourses (student_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 2),
(3, 1),
(3, 3);

-- Изтриваме курс с course_id = 2 → автоматично се трият връзките към него
DELETE FROM Courses WHERE course_id = 2;

-- Преименуваме student_id = 1 → 10 → автоматично се обновяват връзките
UPDATE Students
SET student_id = 10
WHERE student_id = 1;

