/*
Задача 03.1. Най-висока заплата по длъжности
Напишете заявка, която показва най-високата заплата, 
давана на служител за всяка длъжност. Списъкът да е 
подреден по заплати в низходящ ред и по длъжност, в азбучен.
*/

/*ВАРИАНТ 1*/
-- 'e' е псевдоним на таблицата employees във външната заявка
SELECT DISTINCT e.`job_title`, e.`salary` 
FROM `employees` AS e 
WHERE e.`salary` = 
(
	-- 'es' е псевдоним на същата таблица employees, но в подзаявката
    SELECT es.`salary` 
    FROM `employees` AS es
    
    -- Защото използваш корелирана подзаявка – вътрешната заявка сравнява данни с външната:
    WHERE es.`job_title` = e.`job_title`
    ORDER BY es.`salary`
    DESC LIMIT 1
)
ORDER BY e.`salary` DESC, e.`job_title`

/*ВАРИАНТ 2*/
SELECT  job_title,                     
    MAX(salary) AS max_salary
FROM employees
GROUP BY job_title  
ORDER BY max_salary DESC, job_title;


/*
Задача 03.2. Най-ниско платени служители по отдели
Напишете заявка, която извежда името и фамилията, 
заплатата и името на отдела на всички служители, 
получаващи най-ниска заплата в своя отдел. 
Резултатът да е сортиран по заплата, име и фамилия, във възходящ ред.
*/
SELECT `first_name`,`last_name`,`salary`,`department_id`
FROM `employees` AS e
WHERE `salary` = 
(
	SELECT `salary`
    FROM `employees` AS em
    WHERE e.`department_id`=em.`department_id`
    ORDER BY `salary` ASC
    LIMIT 1
)
ORDER BY `salary`,`first_name`,`last_name`;

/*
Задача 03.3. Мениджъри с същото презиме 
Изведете името и фамилията на всички мениджъри,
 на които презимето им съвпада с това на някой от техните подчинени.
*/
USE `soft_uni`;
SELECT `manager`.`first_name`, `manager`.`last_name`
FROM `employees` as `manager`
WHERE (`manager`.`employee_id`, `manager`.`middle_name`) IN 
(
	SELECT `manager_id`, `middle_name`
	FROM `employees`
) 
ORDER BY `manager`.`first_name`, `manager`.`last_name`;

Задача 03.4 Мениджъри с по-ниска заплата
Напишете заявка, извеждаща списък на всички
 мениджъри с поне един подчинен, който има по-висока заплата от тяхната.
*/
SELECT `manager`.`first_name`, `manager`.`last_name`
FROM `employees` AS `manager`
WHERE `manager`.`employee_id` IN 
(
	SELECT DISTINCT `manager_id` 
    FROM `employees`
)
AND `manager`.`salary` < ANY 
(
	SELECT `salary` 
    FROM `employees`
    WHERE `manager_id` = `manager`.`employee_id`
);

/*
Задача 3.5. Мениджъри с точно 5 подчинени
Изведете името и фамилията на всички мениджъри с точно 5 подчинени.
*/
SELECT `manager`.`first_name`, `manager`.`last_name`
FROM `employees` AS `manager`
WHERE `manager`.`employee_id` IN 
(
	SELECT DISTINCT `manager_id` 
    FROM `employees`
)
AND EXISTS 
(
	SELECT 1 
	FROM `employees`
	WHERE `manager_id` = `manager`.`employee_id`
	LIMIT 4,1
)
AND NOT EXISTS 
(
	SELECT 1 
	FROM `employees`
	WHERE `manager_id` = `manager`.`employee_id`
	LIMIT 5,1
)
ORDER BY `manager`.`first_name`, `manager`.`last_name`;


-- БАЗА ДАННИ geography
/*
Задача 3.6. Планините в България 
Напишете заявка, която изброява планини в 
България и за всяка - най-високия ѝ връх и неговата 
височина. Заявката да е сортирана по височината на 
планините, от най-високата към най-ниската.
*/
USE `geography`;
SELECT 
	`mountains`.`mountain_range`,
	`peaks`.`peak_name`,
	`peaks`.`elevation` 
    
FROM `peaks`, `mountains`

WHERE `mountains`.`id` = `peaks`.`mountain_id` AND 
`mountains`.`id` IN
(
	SELECT `mountain_id`
	FROM `mountains_countries` 
	WHERE `country_code`="BG"	
) 
ORDER BY `elevation` DESC;


/*
Задача 3.7. Неописаните планини в България 
Напишете заявка, която изброява имената на планините 
в България,  за които в базата данни няма информация
 за върховете им.
*/
USE `geography`;
SELECT  `mountain_range`
FROM `mountains`
WHERE `mountains`.`id` IN (
		SELECT `mountain_id`
		FROM `mountains_countries` 
		WHERE `country_code`="BG"	
) AND `mountains`.`id` NOT IN 
(
    SELECT DISTINCT `mountain_id`
    FROM `peaks`
    WHERE `mountain_id` IN (
		SELECT `mountain_id`
		FROM `mountains_countries` 
		WHERE `country_code`="BG"	
	)
);