use softuni;

/* Задача 5.1. Служител 24 */
SELECT `e`.`employee_id`, `first_name`, 
CASE
    WHEN `p`.`start_date` >= 1/1/2005 THEN NULL
    ELSE `p`.`start_date`
END AS `start_date`

FROM `employees` AS `e`
JOIN `employees_projects` AS `ep` ON `ep`.`employee_id` = `e`.`employee_id`
JOIN `projects` AS `p` ON `p`.`project_id`=`ep`.`project_id`

WHERE `e`.`employee_id` = 24;



/* Задача 5.2. Игра на континенти*/
USE `geography`; 
SELECT `c1`.`continent_name` AS `FROM`,
       `c2`.`continent_name` AS `TO`
FROM `continents` AS `c1`
CROSS JOIN `continents` AS `c2`
ORDER BY `c1`.`continent_name`, `c2`.`continent_name`;



/*Задача 5.3. Европейското по футбол*/
SELECT `c1`.`capital` AS `Place`, 
       `c1`.`country_name` AS `Player 1`,
       NULL AS `Host`,
       NULL AS `Guest`,
       `c2`.`country_name` AS `Player 2`
FROM `countries` AS `c1`
CROSS JOIN `countries` AS `c2`

WHERE `c1`.`continent_code` = "EU" AND
      `c2`.`continent_code` = "EU"
      
ORDER BY RAND();



/*Задача 5.4. Най-висок връх и най-дълга река по държава*/
SELECT	`c`.`country_name`,
		MAX(`p`.`elevation`) AS 'highest_peak_elevation', 
		MAX(`r`.`length`) AS 'longest_river_length' 
 
FROM `countries` AS `c`

LEFT JOIN `mountains_countries` AS `mc` ON `mc`.`country_code` = `c`.`country_code`
LEFT JOIN `peaks` AS `p` ON `p`.`mountain_id` = `mc`.`mountain_id`
LEFT JOIN `countries_rivers` AS `cr` ON `cr`.`country_code` = `c`.`country_code`
LEFT JOIN `rivers` AS `r` ON `r`.`id` = `cr`.`river_id`

GROUP BY `c`.`country_name`
ORDER BY `highest_peak_elevation` DESC, `longest_river_length` DESC, `c`.`country_name` ASC
LIMIT 5;



/* Задача 5.5. *Континенти и валути */
USE `geography`;

SELECT `usages`.`continent_code`, `usages`.`currency_code`, `usages`.`usages` FROM
(
	SELECT `con`.`continent_code`, `cu`.`currency_code`, COUNT(`cu`.`currency_code`) AS `usages` 
	FROM `continents` AS `con`
	INNER JOIN `countries` AS `c` ON `c`.`continent_code` = `con`.`continent_code`
	INNER JOIN `currencies` AS `cu` ON `cu`.`currency_code` = `c`.`currency_code`
	GROUP BY `con`.`continent_code`, `cu`.`currency_code`
) AS `usages`
INNER JOIN
(
	SELECT `usages`.`continent_code`, MAX(`usages`.`usages`) AS `maxUsage`
	FROM 
	(
		SELECT `con`.`continent_code`, `cu`.`currency_code`, COUNT(`cu`.`currency_code`) AS `usages` 
		FROM `continents` AS `con`
		INNER JOIN `countries` AS `c` ON `c`.`continent_code` = `con`.`continent_code`
		INNER JOIN `currencies` AS `cu` ON `cu`.`currency_code` = `c`.`currency_code`
		GROUP BY `con`.`continent_code`, `cu`.`currency_code`
		HAVING COUNT(`cu`.`currency_code`) > 1
	) as `usages`
	GROUP BY `usages`.`continent_code`
) AS `max_usages` 
ON `max_usages`.`continent_code` = `usages`.`continent_code` AND `max_usages`.`maxUsage` = `usages`.`usages`

ORDER BY `usages`.`continent_code`, `usages`.`currency_code`;
