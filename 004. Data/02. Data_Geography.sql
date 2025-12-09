/*използвайте базата данни  "geography". */

/*
Задача 4.6. Всички планински върхове
Покажете всички планински върхове, подредени по азбучен ред. 
*/
use `geography`;
select `peak_name`
from `peaks`
order by `peak_name`;


/*
Задача 4.7. Най-големи държави по население
Намерете 30 най-големи държави по население в Европа.
 Покажете името на държавата и населението. 
 Сортирайте резултатите по население (от най-голямо към най-малко), после по държава по азбучен ред. 
*/
use `geography`;
select `country_name`,`population`
from `countries`
where `continent_code` = "EU"
order by `population` desc
limit 30;

/*
Задача 4.8. Държави и валути (Евро / Не евро)
Намерете всички държави заедно с информация за 
тяхната валута. Покажете името на държавата, 
нейният код и информация за нейната валута: или 
"Евро", или "Не евро". Сортирайте резултатите по
 име на страната по азбучен ред. 
*/
use `geography`;
select `country_name`,`country_code`,
if(`currency_code`="EUR","Euro","Not Euro") as 'currency'
from `countries`
order by `country_name` asc;


