/* Задача 5.1. Адрес на служител */
USE `soft_uni`;
/* v1 – JOIN синтаксис   */
SELECT 
    `employee_id`,        -- Уникален идентификатор на служителя
    `job_title`,          -- Длъжността на служителя
    `e`.`address_id`,     -- ID на адреса (от таблицата employees)
    `address_text`        -- Текстово описание на адреса
FROM `employees` AS `e`   -- Основна таблица employees с псевдоним e
JOIN `addresses` AS `a`   -- Свързваме с таблицата addresses (псевдоним a)
    ON `a`.`address_id` = `e`.`address_id` -- Условие за връзка между таблиците
ORDER BY 
    `e`.`address_id` ASC  -- Сортиране по address_id във възходящ ред
LIMIT 5;                  -- Показваме само първите 5 резултата

/* v2 – Стар (implicit) JOIN синтаксис */
SELECT 
    `employee_id`,        -- Уникален идентификатор на служителя
    `job_title`,          -- Длъжността на служителя
    `e`.`address_id`,     -- ID на адреса
    `address_text`        -- Текстово описание на адреса
FROM 
    `employees` AS `e`,   -- Декларираме двете таблици в FROM
    `addresses` AS `a`
WHERE 
    `a`.`address_id` = `e`.`address_id` -- Условие за връзка между таблиците
ORDER BY 
    `e`.`address_id` ASC  -- Сортиране по address_id във възходящ ред
LIMIT 5;                  -- Ограничаваме резултата до 5 реда



/* Задача 5.2. Служител по продажбите */
SELECT 
    `employee_id`,                 -- Уникален идентификатор на служителя
    `first_name`,                  -- Собствено име на служителя
    `last_name`,                   -- Фамилно име на служителя
    `departments`.`name` AS `deparment_name`  
                                   -- Име на отдела, преименувано с псевдоним
FROM `employees`                   -- Основна таблица employees
JOIN `departments`                 -- Свързваме с таблицата departments
    ON `departments`.`department_id` = `employees`.`department_id`
                                   -- Условие за връзка между служител и отдел
WHERE 
    `departments`.`name` = "Sales" -- Филтрираме само служители от отдел „Sales“
ORDER BY 
    `employees`.`employee_id` DESC;
                                   -- Сортиране по employee_id в низходящ ред
                                   
/* Задача 5.3. Служебни отдели */
SELECT 
    `employee_id`,                 -- Уникален идентификатор на служителя
    `first_name`,                  -- Собствено име на служителя
    `salary`,                      -- Заплата на служителя
    `departments`.`name` AS `deparment_name`
                                   -- Име на отдела (с псевдоним)
FROM `employees`                   -- Основна таблица със служители
JOIN `departments`                 -- Свързваме с таблицата departments
    ON `departments`.`department_id` = `employees`.`department_id`
                                   -- Условие за връзка служител ↔ отдел
WHERE 
    `salary` >= 15000               -- Филтрираме служители със заплата ≥ 15000
ORDER BY 
    `departments`.`department_id` DESC
                                   -- Сортиране по department_id в низходящ ред
LIMIT 5;                            -- Показваме само първите 5 записа


/* Задача 5.4. Служители без проект */
SELECT 
    `employees`.`employee_id`,   -- Уникален идентификатор на служителя
    `first_name`                 -- Собствено име на служителя
FROM `employees`                -- Основна таблица със служители
LEFT JOIN `employees_projects`  -- LEFT JOIN, за да вземем и служители без проект
    ON `employees_projects`.`employee_id` = `employees`.`employee_id`
                                -- Условие за връзка служител ↔ проект
WHERE 
    `employees_projects`.`project_id` IS NULL
                                -- Филтрираме само служители без свързан проект
ORDER BY 
    `employees`.`employee_id` DESC
                                -- Сортиране по employee_id в низходящ ред
LIMIT 3;                         -- Показваме само първите 3 резултата

/* Задача 5.5. Мениджър на служителите */
SELECT 
    `e`.`employee_id`,            -- Уникален идентификатор на служителя
    `e`.`first_name`,             -- Собствено име на служителя
    `e`.`manager_id`,             -- ID на мениджъра на служителя
    CONCAT(`m`.`first_name`, " ", `m`.`last_name`) AS `manager_name`
                                  -- Пълно име на мениджъра (име + фамилия)
FROM `employees` AS `e`           -- Таблица employees (служители) с псевдоним e
LEFT JOIN `employees` AS `m`      -- Самосвързване (self JOIN) към employees
    ON `e`.`manager_id` = `m`.`employee_id`
                                  -- Свързваме служителя с неговия мениджър
WHERE 
    `e`.`manager_id` IN (3, 7)    -- Филтрираме служители с мениджъри ID 3 или 7
ORDER BY 
    `e`.`first_name` ASC;         -- Сортиране по собствено име във възходящ ред

/* 
Задача 5.6. Минимална заплата
Заявката връща най-ниската заплата и името на отдела,
в който се изплаща тази заплата.
*/

/* Избираме базата данни */
SELECT 
    `employees`.`salary`,        -- Заплатата на служителя
    `departments`.`name`         -- Име на отдела
FROM `employees`, `departments` -- Използваме двете таблици
WHERE 
    `employees`.`department_id` = `departments`.`department_id`
                                 -- Свързваме служителите с отделите
    AND `employees`.`department_id` =
    (
        SELECT `department_id`   -- Вземаме отдела,
        FROM `employees`         -- в който има най-ниска заплата
        ORDER BY `salary` ASC    -- Сортиране по заплата във възходящ ред
        LIMIT 1                  -- Взимаме само първия (най-ниската заплата)
    )
LIMIT 1;                         -- Ограничаваме резултата до един ред


/*ГЕОГРАФИЯ - база данни*/
/* 
Задача 5.7. Държави без планини
Цел: да се изведат всички държави, които нямат нито една планина.
Очакван резултат: 231 държави
*/

/* v1 – LEFT JOIN подход */
USE geography;
SELECT DISTINCT 
 country_name
 FROM countries AS c
 LEFT JOIN mountains_countries AS mc
 ON c.country_code=mc.country_code
WHERE mc.mountain_id IS NULL;	
    
/* =============================== */
/* v2 – Препоръчителен и по-ясен   */
/* =============================== */

SELECT 
    `country_name`                     -- Име на държавата
FROM `countries`
WHERE 
    `country_code` NOT IN
    (
        SELECT DISTINCT `country_code`
        FROM `mountains_countries`
                                        -- Вземаме всички държави,
                                        -- които имат поне една планина
    );