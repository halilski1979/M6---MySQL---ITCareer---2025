use softuni;
/* Задача 5.1. Адреси с градове */

/* 
   Извличаме:
   - малко име и фамилия на служителя
   - име на града
   - текст на адреса
*/
SELECT 
    `e`.`first_name`,        -- Малко име на служителя
    `e`.`last_name`,         -- Фамилия на служителя
    `t`.`name` AS `town`,    -- Име на града
    `a`.`address_text`       -- Текст на адреса
FROM `employees` AS `e`

/* Свързваме служителите с адресите им по address_id */
INNER JOIN `addresses` AS `a` 
    ON `a`.`address_id` = `e`.`address_id`

/* Свързваме адресите с градовете по town_id */
INNER JOIN `towns` AS `t` 
    ON `t`.`town_id` = `a`.`town_id`

/* Подреждаме резултатите по малко име и фамилия (възходящо) */
ORDER BY 
    `e`.`first_name`, 
    `e`.`last_name`

/* Ограничаваме резултата до първите 5 записа */
LIMIT 5;


/* ЗАДАЧА 5.2. Служители, наети по-късно */
SELECT 
    `e`.`first_name`,           -- Малко име на служителя
    `e`.`last_name`,            -- Фамилия на служителя
    `e`.`hire_date`,            -- Дата на наемане
    `d`.`name` AS `dept_name`   -- Име на отдела
FROM `employees` AS `e`

/* Свързваме служителите с отделите им по department_id */
INNER JOIN `departments` AS `d` 
    ON `d`.`department_id` = `e`.`department_id`

/* Филтрираме само отделите Sales и Finance и служителите, наети след 1 януари 1999 */
WHERE 
    `d`.`name` IN ("Sales", "Finance") AND
    `e`.`hire_date` >= '1999-01-01'

/* Подреждаме резултатите по дата на наемане (възходящо) */
ORDER BY `e`.`hire_date`;


/* Задача 5.3. Служители с проект */
SELECT 
    `e`.`employee_id`,        -- ID на служителя
    `e`.`first_name`,         -- Малко име на служителя
    `p`.`name` AS `project_name`  -- Име на проекта
FROM `employees` AS `e`

/* Свързваме служителите с техните проекти чрез таблицата за връзка employees_projects */
INNER JOIN `employees_projects` AS `ep` 
    ON `ep`.`employee_id` = `e`.`employee_id`

/* Свързваме проектите и филтрираме по дата на стартиране и завършване */
INNER JOIN `projects` AS `p` 
    ON `p`.`project_id` = `ep`.`project_id`
WHERE 
    `p`.`start_date` > '2002-08-13' AND  -- Проектите започнали след 13 август 2002
    `p`.`end_date` IS NULL              -- Проекти, които все още не са завършени

/* Подреждаме резултатите по малко име на служителя и име на проекта */
ORDER BY 
    `e`.`first_name`, 
    `p`.`name`

/* Ограничаваме резултата до първите 5 записа */
LIMIT 5;

/* Задача 5.4. Резюме на служителите */
SELECT 
    `e`.`employee_id`,                                   -- ID на служителя
    concat(`e`.`first_name`, " ", `e`.`last_name`) AS `employee_name`,  -- Пълно име на служителя
    concat(`m`.`first_name`, " ", `m`.`last_name`) AS `manager_name`,   -- Пълно име на мениджъра
    `d`.`name` AS `department_name`                      -- Име на отдела
FROM `employees` AS `e`

/* Свързваме служителя с неговия мениджър (също служител) по manager_id */
INNER JOIN `employees` AS `m` 
    ON `m`.`employee_id` = `e`.`manager_id`

/* Свързваме служителя с неговия отдел по department_id */
INNER JOIN `departments` AS `d` 
    ON `d`.`department_id` = `e`.`department_id`

/* Подреждаме резултатите по ID на служителя */
ORDER BY `e`.`employee_id`

/* Ограничаваме резултатите до първите 5 записа */
LIMIT 5;


/*БАЗА ДАННИ - ГЕОГРАФИЯ*/
/* Задача 5.5. Най-високи върхове в България */
USE `geography`;
SELECT 
    `mc`.`country_code`,        -- Код на страната (BG)
    `m`.`mountain_range`,       -- Име на планинската верига
    `p`.`peak_name`,            -- Име на върха
    `p`.`elevation`             -- Височина на върха
FROM `peaks` AS `p`

/* Свързваме върховете с планините, към които принадлежат */
INNER JOIN `mountains` AS `m` 
    ON `m`.`id` = `p`.`mountain_id`

/* Свързваме планините с държавите, в които се намират, и филтрираме за България */
INNER JOIN `mountains_countries` AS `mc` 
    ON `mc`.`mountain_id` = `p`.`mountain_id`
    AND `mc`.`country_code` = "BG"  -- Само върхове в България

/* Филтрираме върховете по височина (>= 2835 м) */
WHERE `p`.`elevation` >= 2835

/* Подреждаме резултатите по височина, най-високите първи */
ORDER BY `p`.`elevation` DESC;



/* Задача 5.6. Планински вериги */
SELECT 
    `mc`.`country_code`,       -- Код на страната
    `c`.`country_name`,        -- Име на страната
    `m`.`mountain_range`       -- Име на планинската верига
FROM `mountains_countries` AS `mc`   -- Таблица за връзка между планини и държави

/* Свързваме с таблицата countries за да вземем името на страната */
INNER JOIN `countries` AS `c`  
    ON `mc`.`country_code` = `c`.`country_code`
    AND `mc`.`country_code` IN ("BG", "RU", "US")  -- Филтрираме само България, Русия и САЩ

/* Свързваме с таблицата mountains за да вземем името на планинската верига */
INNER JOIN `mountains` AS `m` 
    ON `mc`.`mountain_id` = `m`.`id`

/* Подреждаме резултатите първо по код на страната, после по име на планинската верига */
ORDER BY 
    `mc`.`country_code`, 
    `m`.`mountain_range`;

