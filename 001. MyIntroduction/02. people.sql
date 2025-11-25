/* Създаване на нова база от данни */
CREATE DATABASE IF NOT EXISTS people;    -- Създава база people, ако още не съществува
USE people;                              -- Избира базата, за да работим в нея

/* Създаване на таблица people */
CREATE TABLE IF NOT EXISTS people
(
    id INT AUTO_INCREMENT NOT NULL UNIQUE,  -- Уникален идентификатор, автоматично увеличаващ се
    name VARCHAR(200) NOT NULL,             -- Име на човека
    picture MEDIUMBLOB NULL,                -- Снимка (до ~16MB)
    height NUMERIC(10,2) NULL,              -- Височина с точност до два знака след запетая
    weight NUMERIC(10,2) NULL,              -- Тегло с точност до два знака след запетая
    gender CHAR(1) NULL,                    -- Пол (m/f)
    birthdate DATETIME NOT NULL,            -- Дата на раждане
    biography VARCHAR(10000) NULL,          -- Голям текст с биография
    
    CONSTRAINT pk_people PRIMARY KEY (id)   -- Задаване на първичен ключ
);


/* Вмъкване на записи в people */
INSERT INTO people (name, height, weight, gender, birthdate) 
VALUES ("Dimitar Minchev", "183", "85", "m", "1978-08-23");   -- Добавяне на първи човек

INSERT INTO people (name, height, weight, gender, birthdate) 
VALUES ("Anelia Tzvetanova", "172", "65", "f", "1986-09-11"); -- Добавяне на втори човек

INSERT INTO people (name, height, weight, gender, birthdate) 
VALUES ("Peter Minchev", "106", "15", "m", "2015-06-30");     -- Добавяне на трети човек

select * FROM PEOPLE


/* Създаване на таблица users */
CREATE TABLE IF NOT EXISTS users
(
    id BIGINT AUTO_INCREMENT NOT NULL,     -- Уникален идентификатор (до 2^63-1), автоувеличаване
    username VARCHAR(30) NOT NULL UNIQUE,  -- Потребителско име, максимум 30 знака, уникално
    password VARCHAR(26) NOT NULL,         -- Парола, максимум 26 символа
    profile_picture BLOB,                  -- До 900 KB (BLOB поддържа до 64 KB – достатъчно)
    last_login_time DATETIME,              -- Дата/час на последно влизане
    is_deleted BOOLEAN,                    -- true/false – дали е изтрит профилът
    
    CONSTRAINT pk_users PRIMARY KEY (id)   -- Първичен ключ
);

/*NSERT данни (5 записа)*/
INSERT INTO users (username, password, last_login_time, is_deleted)
VALUES 
("Pesho",   "pass123",   NOW(), 0),
("Geri",    "qwerty12",  NOW(), 0),
("Ivan",    "ivanpass",  NOW(), 1),
("Maria",   "m123456",   NOW(), 0),
("Stoyan",  "st0yanpw",  NOW(), 0);

/*За да изтриеш съществуваща таблица в MySQL, използваш командата:*/
DROP TABLE users;


/*НЕ РАБОТИ*/
/*Задача 8. Сменете първичния ключ =>  Премахване на текущия първичен ключ (pk_users)*/
ALTER TABLE users
DROP PRIMARY KEY;
/*Задача 8. Сменете първичния ключ => Създаване на нов комбиниран първичен ключ (id, username) */
ALTER TABLE users
ADD CONSTRAINT pk_users PRIMARY KEY (id, username);
/*НЕ РАБОТИ*/

