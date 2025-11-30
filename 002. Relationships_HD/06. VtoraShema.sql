CREATE DATABASE shema2;
USE shema2;

-- Създаване на таблица за предмети
CREATE TABLE subjects (
    subject_id INT(11) NOT NULL AUTO_INCREMENT, -- уникален идентификатор на предмета
    subject_name VARCHAR(50) NOT NULL,         -- име на предмета
    PRIMARY KEY (subject_id)
);

-- Създаване на таблица за специалности
CREATE TABLE majors (
    major_id INT(11) NOT NULL AUTO_INCREMENT,  -- уникален идентификатор на специалността
    name VARCHAR(50) NOT NULL,                 -- име на специалността
    PRIMARY KEY (major_id)
);

-- Създаване на таблица за студенти
CREATE TABLE students (
    student_id INT(11) NOT NULL AUTO_INCREMENT, -- уникален идентификатор на студента
    student_number VARCHAR(12) NOT NULL,       -- студентски номер
    student_name VARCHAR(50) NOT NULL,         -- име на студента
    major_id INT(11),                          -- външен ключ към таблица majors
    PRIMARY KEY (student_id),
    FOREIGN KEY (major_id) REFERENCES majors(major_id)
);

-- Създаване на таблица agenda (за записване на студенти по предмети)
CREATE TABLE agenda (
    student_id INT(11) NOT NULL,               -- външен ключ към таблица students
    subject_id INT(11) NOT NULL,               -- външен ключ към таблица subjects
    PRIMARY KEY (student_id, subject_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (subject_id) REFERENCES subjects(subject_id)
);

-- Създаване на таблица за плащания
CREATE TABLE payments (
    payment_id INT(11) NOT NULL AUTO_INCREMENT, -- уникален идентификатор на плащането
    payment_date DATE NOT NULL,                 -- дата на плащане
    payment_amount DECIMAL(8,2) NOT NULL,      -- сума на плащане
    student_id INT(11),                         -- външен ключ към таблица students
    PRIMARY KEY (payment_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id)
);
