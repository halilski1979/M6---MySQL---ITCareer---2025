/*One-to-Many*/

CREATE DATABASE IF NOT EXISTS onetomany_example;
USE onetomany_example;

-- Създаваме таблица manufacturers
CREATE TABLE manufacturers (
    manufacturer_id INT AUTO_INCREMENT PRIMARY KEY,  -- Първичен ключ с автоинкремент
    name VARCHAR(50) NOT NULL,
    established_on DATE
);

-- Вмъкваме данните
INSERT INTO manufacturers (name, established_on) VALUES
('BMW', '1916-03-01'),
('Tesla', '2003-01-01'),
('Lada', '1966-05-01');

-- Създаваме таблица models
CREATE TABLE models (
    model_id INT AUTO_INCREMENT PRIMARY KEY,        -- Първичен ключ с автоинкремент
    name VARCHAR(50) NOT NULL,
    manufacturer_id INT,                             -- Външен ключ, производител
    
    CONSTRAINT fk_models_manufacturers             -- Име на външния ключ
        FOREIGN KEY (manufacturer_id)
        REFERENCES manufacturers(manufacturer_id)
        ON DELETE CASCADE                           -- Ако производител се изтрие → изтриват се и моделите му
);

-- Вмъкваме данните
INSERT INTO models (name, manufacturer_id) VALUES
('X1', 1),
('i6', 1),
('Model S', 2),
('Model X', 2),
('Model 3', 2),
('Nova', 3);

-- Преглед на данните
SELECT * FROM manufacturers;
SELECT * FROM models;

-- 1.Изтриваме модела "Model X"
DELETE FROM models 
WHERE name = 'Model X';

-- Проверяваме таблицата models
SELECT * FROM models;
-- ✅ Резултат: Ще изчезне редът за Model X, останалите модели и производителите остават.

-- 2.Изтриваме производител "Tesla", 
/* Тъй като таблицата models е дефинирана с ON DELETE CASCADE,
 ако изтрием производител, всички негови модели също ще се изтрият:*/ 
DELETE FROM manufacturers 
WHERE name = 'Tesla';

-- Проверяваме таблиците
SELECT * FROM manufacturers;
SELECT * FROM models;

/*ИЗТРИВАНЕ НА СЪДЪРЖАНИЕ ОТ ТАБЛИЦИ*/
-- Изтриваме всички модели
DELETE FROM models;
-- Изтриваме всички производители
DELETE FROM manufacturers;


/*ИЗТРИВАНЕ НА ТАБЛИЦИ*/
-- Първо изтриваме таблицата с външния ключ
DROP TABLE IF EXISTS models;
-- После изтриваме таблицата производители
DROP TABLE IF EXISTS manufacturers;


