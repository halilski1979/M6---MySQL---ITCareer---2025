USE `softuni`;

/* 
Задача 3.1. Намерете цялата информация за отделите
Напишете SQL заявка, за да намерите цялата налична информация за отделите. Изпратете вашите заявки като Подготвите БД & изпълните заявките (Prepare DB & run queries.)
*/
SELECT `department_id`,	`name`, `manager_id`
FROM `departments`;

/* 
Задача 3.2. Намерете всички имена на отдели
Напишете SQL заявка, за да намерите всички имена на отдел. Изпратете вашите заявки като Подготвите БД & изпълните заявките (Prepare DB & run queries.)
*/
SELECT DISTINCT `name`
FROM `departments`;

/* 
Задача 3.3. Намерете заплатата на всеки служител
Напишете SQL заявка, която намера собственото име, фамилното име и заплата на всеки служител. 
Изпратете вашите заявки като Подготвите БД & изпълните заявките (Prepare DB & run queries.)
*/
SELECT `first_name`,`last_name`,`salary`
FROM `employees`;


/*
Задача 3.4. Намерете пълното име на всеки служител
Напишете SQL заявка, която намира личното, бащиното и фамилното име на всеки служител.
 Изпратете вашите заявки като Подготвите БД & изпълните заявките (Prepare DB & run queries.)
*/
SELECT `first_name`,`middle_name`,`last_name`
FROM `employees`;

/*
Задача 3.5. Намерете имейл адреса на всеки служител
Напишете SQL заявка, която намира имейл адреса на всеки служител. (от неговото собствено и фамилно име). 
приемете, че имейл домейна е softuni.bg. Имейлите трябва да изглеждат като "John.Doe@softuni.bg". 
Резултатната колона трябва да бъде наречена "full_ email_address". 
Изпратете вашите заявки като Подготвите БД & изпълните заявките (Prepare DB & run queries.)
*/
SELECT concat(`first_name`,".",`last_name`,"@softuni.bg") AS 'full_email_address'
FROM `employees`;

/* 
Задача 3.6. Намерете всички различни работни заплати
Напишете SQL заявка, за да намерите всичките различни работни заплати. 
Покажи само заплатите.
*/
SELECT DISTINCT `salary`
FROM `employees`;

/*
Задача 3.7. Намерете цялата информация за служители
Напишете SQL заявка, за да намерите цялата информация за служителите, 
чиято длъжност е "Търговски представител" ( Sales Representative ). 
*/

SELECT 
	`employee_id` as "id",
	`first_name` as "ИМЕ",
	`last_name` AS "Last Name",
    `middle_name` AS "Middle Name",
	`job_title` AS "Job Title",
	`department_id` AS "DeptID",
	`manager_id` AS "Mngr ID",
    `hire_date` AS "HireDate",
	`salary`,`address_id`
FROM `employees`
WHERE `job_title` = 'Sales Representative';


/*
Задача 3.8. Намерете имената на всички служители със заплата в диапазон
Напишете SQL заявка, която намира личното име, фамилно име и длъжност на всички служители,
 чиято заплата е в диапазона [20000, 30000].  
*/
SELECT `first_name`,`last_name`,`job_title` AS "JobTitle", salary
FROM `employees`
WHERE `salary` BETWEEN 20000 AND 30000;



/*
Задача 3.9. Намерете имената на всички служители
Напишете SQL заявка, която намира пълното име на всички служители, 
чиято заплата е 25000, 14000, 12500 или 23600. Пълното име е комбинация от личното, бащиното и фамилното име 
(разделени с единичен интервал) и те трябва да бъдат в една колона, наречена "Пълно име" “Full Name”.
*/
SELECT concat(`first_name`," ",`middle_name`," ",`last_name`) AS "full_name"
FROM `employees`
WHERE `salary` in (25000, 14000, 12500, 23600);



/*
Задача 3.10. Намерете всички служители без мениджър
Напишете SQL заявка да намери собствено и фамилно име за тези служители, които не са мениджъри.
 Представят отчети вашата заявка като подготвят DB & изпълните заявки. 
*/
SELECT `first_name`,`last_name`
FROM `employees`
WHERE `manager_id` IS NULL;


/*
3.11. Намерете всички служители със заплата повече от 50000
Напишете SQL заявка, която намира собственото име, 
фамилното име и заплатата на тези служители, които имат заплата повече от 50000.
 Подредете ги в намаляващ ред от заплата. 
*/
SELECT `first_name`,`last_name`,`salary`
FROM `employees`
WHERE `salary` >= 50000
ORDER BY `salary` DESC;


/*
Задача 3.12. Намете 5 най-добре платени служителя
Напишете SQL заявка, която намира собственото и фамилното име на 5 най-добре платени служители,
 подредени в низходящ ред по заплата
*/
SELECT `first_name`,`last_name`, salary
FROM `employees`
ORDER BY `salary` DESC
LIMIT 5;


/*
Задача 3.13. Намерете всички служители, които не са от отдел Marketing 
Напишете SQL заявка, която намира собственото и фамилното име на всички служители,
 чиито номер на отдел е различен от 4. 
*/
SELECT `first_name`,`last_name`
FROM `employees`
WHERE `department_id` NOT IN (4);

/*
Задача 3.14. Различни длъжности
Напишете SQL заявка,която  намира всички различни длъжности.
*/
SELECT DISTINCT `job_title`
FROM `employees`
ORDER BY `job_title`;


/* 
Задача 3.15. Намерете първите 10 започнати проекти
Напишете SQL заявка, която намира първите 10 започнати проекти. 
Изберете цялата информация за тях и ги подредете по начална дата, след това по име. 
*/
SELECT *
FROM `projects`
ORDER BY `start_date`,`name`
LIMIT 10;


/*
Задача 3.16. Последните 7 наети служители
Напишете SQL заявка, която намира последните 7 наети служители. 
Изберете техните собствени имена, фамилни имена и датата им на наемане.
*/
SELECT `first_name`,`last_name`,`hire_date`
FROM `employees`
ORDER BY `hire_date` DESC
LIMIT 7;

/*
Задача 3.17. Увеличаване на заплати
Напишете SQL заявка за увеличаване на заплатите на всички служители,
 които са  в отделите Engineering, Tool Design, Marketing или Information Services с 12 %.
 След това изберете колоната със заплатите  от таблицата Emmployees. 
*/
SELECT `department_id` as "id"
FROM `departments`
WHERE `name` IN ("Engineering", "Tool Design", "Marketing",  "Information Services");
/* Result: 1, 2, 4, 11 */

UPDATE `employees`
SET `salary` = `salary` * 1.12
WHERE `department_id` IN (1, 2, 4, 11);
/* Result: 28 affected rows*/



