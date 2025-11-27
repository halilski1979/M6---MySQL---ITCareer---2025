CREATE DATABASE People1;
USE people1;

CREATE TABLE People (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,        -- Уникален номер, автоувеличаване
    name NVARCHAR(200) NOT NULL,                       -- Пълно име, не може NULL
    picture LONGBLOB NULL,                             -- Изображение до 2 MB, може да е NULL
    height DECIMAL(5,2) NULL,                          -- В метри, точност 2 цифри след десетичната запетая
    weight DECIMAL(5,2) NULL,                          -- В килограми, точност 2 цифри след десетичната запетая
    gender ENUM('m','f') NOT NULL,                     -- Пол, m или f, не може NULL
    birthdate DATE NOT NULL,                            -- Дата на раждане, не може NULL
    biography LONGTEXT NULL                             -- Подробна биография, може да е NULL
);

INSERT INTO People (name, picture, height, weight, gender, birthdate, biography)
VALUES
('Alice Johnson', NULL, 1.70, 60.50, 'f', '1990-05-12', 'Alice е софтуерен инженер от София.'),
('Bob Smith', NULL, 1.85, 82.00, 'm', '1985-11-23', 'Bob е професионален готвач, обича пътуванията.'),
('Carol Williams', NULL, 1.65, 55.30, 'f', '1992-07-08', 'Carol е художник, специализира в маслена живопис.'),
('David Brown', NULL, 1.78, 75.00, 'm', '1988-02-15', 'David е преподавател по математика.'),
('Eva Green', NULL, 1.68, 58.20, 'f', '1995-09-30', 'Eva е музикант и свири на пиано.');

SELECT * FROM people;

-- Направете таблицата потребители Users
CREATE TABLE Users (
    id BIGINT NOT NULL AUTO_INCREMENT PRIMARY KEY,    -- Уникален номер, автоувеличаване (до 2^63-1)
    name VARCHAR(30) NOT NULL UNIQUE,                 -- Уникален идентификатор на потребителя
    password VARCHAR(26) NOT NULL,                    -- Парола
    profile_picture LONGBLOB NULL,                    -- Изображение до 900 KB, може да е NULL
    last_login_time DATETIME NULL,                     -- Последно влизане
    is_deleted BOOLEAN DEFAULT FALSE                  -- Показва дали потребителят е изтрит
);

INSERT INTO Users (name, password, profile_picture, last_login_time, is_deleted)
VALUES
('alice123', 'passAlice2025', NULL, '2025-11-27 08:30:00', FALSE),
('bob_smith', 'bobSecure12', NULL, '2025-11-26 21:15:00', FALSE),
('carol_w', 'CarolPass!', NULL, '2025-11-25 14:45:00', FALSE),
('david_b', 'david1234', NULL, '2025-11-24 19:00:00', FALSE),
('eva_green', 'EvaPwd2025', NULL, '2025-11-23 10:20:00', TRUE);

SELECT * FROM users;

