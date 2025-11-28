/*One-to-one  с  CONSTRAINT fk_person_passport   Име на външния ключе на Foreign key*/

CREATE DATABASE onetoone_second;
USE onetoone_second;

-- Създаваме таблица с паспорти
CREATE TABLE passports (
    passport_id INT PRIMARY KEY,      -- Уникален номер на паспорта
    passport_number VARCHAR(20) NOT NULL
);

INSERT INTO passports (passport_id, passport_number) VALUES
(101, 'AA123456'),
(102, 'BB654321'),
(103, 'CC987654');

-- Създаваме таблица с хора (вариант 1: ON DELETE SET NULL)
CREATE TABLE persons (
    person_id INT PRIMARY KEY,        -- Уникален идентификатор за човек
    first_name VARCHAR(50) NOT NULL,  -- Име
    salary DECIMAL(10,2),             -- Заплата
    passport_id INT UNIQUE,           -- Външен ключ + UNIQUE -> гарантира One-to-One
    
    CONSTRAINT fk_person_passport    -- Име на външния ключ
        FOREIGN KEY (passport_id) 
        REFERENCES passports(passport_id)
        ON DELETE SET NULL            -- Ако паспорт се изтрие → стойността става NULL
);

INSERT INTO persons (person_id, first_name, salary, passport_id) VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

/*КОМЕНТАР - Защо това е One-To-One?
✔ passport_id в таблица persons е UNIQUE → не може двама души да имат еднакъв паспорт
✔ Всеки паспорт може да е само на един човек
✔ Всичко е свързано чрез външен ключ*/

-- Примери за изтриване
DELETE FROM persons WHERE person_id = 3;
DELETE FROM passports WHERE passport_id = 102;

-- Премахваме таблиците
DROP TABLE persons;
DROP TABLE passports;

-- Създаваме отново таблица с паспорти
CREATE TABLE passports (
    passport_id INT PRIMARY KEY,      -- Уникален номер на паспорта
    passport_number VARCHAR(20) NOT NULL
);

INSERT INTO passports (passport_id, passport_number) VALUES
(101, 'AA123456'),
(102, 'BB654321'),
(103, 'CC987654');

-- Създаваме таблица с хора (вариант 2: ON DELETE CASCADE)
CREATE TABLE persons (
    person_id INT PRIMARY KEY,        -- Уникален идентификатор за човек
    first_name VARCHAR(50) NOT NULL,  -- Име
    salary DECIMAL(10,2),             -- Заплата
    passport_id INT UNIQUE,           -- Външен ключ + UNIQUE -> гарантира One-to-One
    
    CONSTRAINT fk_person_passport_cascade  -- Име на външния ключ
        FOREIGN KEY (passport_id) 
        REFERENCES passports(passport_id)         
        ON DELETE CASCADE              -- Изтриваме паспорт → изтрива се и човека, който го притежава
);

INSERT INTO persons (person_id, first_name, salary, passport_id) VALUES
(1, 'Roberto', 43300.00, 102),
(2, 'Tom', 56100.00, 103),
(3, 'Yana', 60200.00, 101);

SELECT * FROM passports;
SELECT * FROM persons;

-- Пример за каскадно изтриване
DELETE FROM passports WHERE passport_id = 102;
