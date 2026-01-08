use geography;
/* Задача 5.1. Държави с реки */
SELECT 
    `c`.`country_name`,    -- Име на държавата
    `r`.`river_name`       -- Име на реката
FROM `countries_rivers` AS `cr`   -- Таблица за връзка между държави и реки

/* Свързваме с таблицата rivers, за да вземем имената на реките */
LEFT JOIN `rivers` AS `r` 
    ON `r`.`id` = `cr`.`river_id`

/* Свързваме с таблицата countries, за да вземем имената на държавите */
LEFT JOIN `countries` AS `c` 
    ON `c`.`country_code` = `cr`.`country_code`

/* Филтрираме само държавите от Африка */
WHERE `c`.`continent_code` = "AF"

 /* Подреждаме резултатите по име на държавата */
ORDER BY `c`.`country_name`

/* Ограничаваме резултатите до първите 5 записа */
LIMIT 5;



/* 
   Задача 5.2.* Държави без планини
   Цел: Извеждаме списък на всички държави, които нямат нито една планина
   (общо би трябвало да са 231)
*/
SELECT 
    `country_name`           -- Име на държавата
FROM `countries` AS `c`     -- Основна таблица: държави

/* LEFT JOIN с таблицата mountains_countries, за да видим дали страната има планина */
LEFT JOIN `mountains_countries` AS `mc` 
    ON `mc`.`country_code` = `c`.`country_code`

/* Филтър: взимаме само тези държави, за които няма свързана планина (NULL в mountain_id) */
WHERE `mc`.`mountain_id` IS NULL;


/* 
   Задача 5.3. Планините в България 
   Цел: Изброяваме планините в България и за 
   всяка - най-високия ѝ връх и неговата височина.
   Сортиране: по височината на върховете, от 
   най-висок към най-нисък.
*/
SELECT 
    `m`.`mountain_range`,    -- Име на планинската верига
    `p`.`peak_name`,         -- Име на върха
    `p`.`elevation`          -- Височина на върха
FROM `peaks` AS `p`         -- Таблица с върхове

/* Свързваме върховете с планините, към които принадлежат */
LEFT JOIN `mountains` AS `m` 
    ON `m`.`id` = `p`.`mountain_id`

/* Свързваме планините с държавите, в които се намират */
LEFT JOIN `mountains_countries` AS `mc` 
    ON `mc`.`mountain_id` = `m`.`id`

/* Филтрираме само планините, които се намират в България */
WHERE `mc`.`country_code` = "BG"

/* Подреждаме резултатите по височината на върховете, от най-висок към най-нисък */
ORDER BY `p`.`elevation` DESC;


/* 
   Задача 5.4. Служители без проект
   Цел: Извеждаме списък на служителите, които не са назначени на нито един проект.
*/

/* Избираме базата данни soft_uni */
USE `softuni`;
SELECT 
    `e`.`employee_id`,   -- ID на служителя
    `first_name`,        -- Малко име на служителя
    `last_name`          -- Фамилия на служителя
FROM `employees` AS `e`  -- Таблица с всички служители

/* LEFT JOIN с employees_projects, за да видим дали служителят има проект */
LEFT JOIN `employees_projects` AS `ep` 
    ON `ep`.`employee_id` = `e`.`employee_id`

/* Филтър: взимаме само служители, за които няма свързан проект */
WHERE `ep`.`project_id` IS NULL

/* Подреждаме резултатите по малко име и фамилия */
ORDER BY `first_name`, `last_name`

/* Ограничаваме резултатите до първите 3 записа */
LIMIT 3;



