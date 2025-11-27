CREATE DATABASE Minions;
USE Minions;

CREATE TABLE minions (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    age INT
);

CREATE TABLE towns (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL
);

INSERT INTO towns (id, name) VALUES 
(1, 'Sofia'),
(2, 'Plovdiv'),
(3, 'Varna'),
(4, 'Burgas'),
(5, 'Ruse');


-- Begin
ALTER TABLE minions
ADD COLUMN town_id INT;
-- End

/*Добавете ново ограничение, което прави town_id чужд ключ и е препратка към id колоната  на таблицата towns. */
-- Begin
ALTER TABLE minions
ADD CONSTRAINT fk_minions_towns
FOREIGN KEY (town_id) REFERENCES towns(id);
-- End

INSERT INTO minions (id, name, age, town_id)  VALUES
(1, 'Bob', 10, 1),
(2, 'Kevin', 12, 2),
(3, 'Stuart', 9, 1),
(4, 'Mark', 11, 3),
(5, 'Phil', 13, 4);

-- Изтрийте всички данни от таблицата  minions, с помощта на SQL заявка. 
TRUNCATE TABLE minions;

-- Премахнете всички таблици
DROP TABLE minions;
DROP TABLE IF EXISTS towns;





 