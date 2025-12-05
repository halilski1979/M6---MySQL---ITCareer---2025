-- БАЗА ДАННИ  geography - ЗАЯВКИ

/*
Задача 3.18. Всички планински върхове
Показване на всички планински върхове в азбучен ред.
*/
SELECT `peak_name`
FROM `peaks`
ORDER BY `peak_name`;


/*
Задача 3.19. Най-големи по население страни
Намерете 30 най-големи по население страни в Европа. 
Покажете  името на страната и населението.
 Сортирайте резултатите по население (от най-големите до най-малката),
 след това по страна по азбучен ред...
*/
SELECT `country_name`,`population`
FROM `countries`
WHERE `continent_code`="EU"
ORDER BY `population` DESC
LIMIT 30;


/*
Задача 3.20. Страни и валута (Euro / Not Euro)
Намерете всички страни заедно с информация за своята валута.
 Покажете  името на страната, код на страната и информация за валутата ѝ: "Euro" или "Not euro".
 Сортирайте резултатите по име на страната по азбучен ред. 
*/
SELECT `country_name`,`country_code`, 
IF(`currency_code` = "EUR", "Euro" , "Not Euro") as "Currency"
FROM `countries`
ORDER BY `country_name`;



