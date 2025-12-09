/* Soft_Uni*/

/*
Задача 02.1  Най-ниско платени служители
Напишете заявка, с която да намерите 
имената и заплатите на служителите, които 
получават най-ниски заплати в компанията. 
*/

/* ВАРИАНТ 1   */
SELECT `first_name`, `last_name`, `salary`
FROM `employees`
WHERE `salary` = (
        -- Намираме директно минималната заплата от таблицата
        SELECT MIN(`salary`)
        FROM `employees`);
        
/* ВАРИАНТ 2   */
select `first_name`,`last_name`,`salary`
from `employees`
where `salary` =  
(
	select `salary`
    from `employees`
    order by `salary` asc
	limit 1
);


/*
Задача 02.2  Служители с близки до най-ниските заплати
Напишете заявка, с която да намерите имената и
 заплатите на служителите (общо 35) с заплати до
 10% по-високи от най-ниските в компанията. 
*/
use `soft_uni`;
select `first_name`,`last_name`,`salary`
from `employees`
where `salary` BETWEEN  
(
	select `salary`
    from `employees`
    order by `salary` asc
	limit 1
) 
AND
(
	select (`salary`*1.10) as 'salary'
    from `employees`
    order by `salary` asc
	limit 1
)
order by `salary` asc;



/*Задача 2.3 Всички мениджъри
Напишете заявка, която показва 
името, фамилията и длъжността на всички 
мениджъри в компанията, сортирани по име и фамилия.*/
select `first_name`,`last_name`,`job_title`
from `employees`
where `employee_id` in
(
	select distinct `manager_id`
    from `employees`
    where `manager_id` is not null
)
order by `first_name`,`last_name`;


/*Задача 02.3 Служителите от San Francisco
Напишете заявка, която показва имената 
на всички служители, живеещи в град San Francisco*/
select `employee_id`, concat(`first_name`," ",`last_name`) as 'employee_name'
from `employees`
where `address_id` in
(
	select `address_id`
	from `addresses`
	where `town_id` = 
	(
		select `town_id`
		from `towns`
		where `name` = "San Francisco"
	)
);

