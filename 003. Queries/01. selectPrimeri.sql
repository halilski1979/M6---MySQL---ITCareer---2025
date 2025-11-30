CREATE DATABASE `Select`;
USE `Select`;
-- MySQL SELECT Examples

-- 1. Връща всички записи и всички колони от таблицата employees
SELECT * FROM employees;

-- 2. Връща само имената и фамилиите на служителите
SELECT first_name, last_name FROM employees;

-- 3. Връща служители от отдела 'IT'
SELECT * FROM employees WHERE department = 'IT';

-- 4. Връща служители с заплата над 3000
SELECT * FROM employees WHERE salary > 3000;

-- 5. Връща всички служители, сортирани по фамилия във възходящ ред
SELECT * FROM employees ORDER BY last_name ASC;

-- 6. Връща всички служители, сортирани по заплата от най-високата към най-ниската
SELECT * FROM employees ORDER BY salary DESC;

-- 7. Връща първите 5 служители с най-висока заплата
SELECT * FROM employees ORDER BY salary DESC LIMIT 5;

-- 8. Връща служители с заплата между 2000 и 4000
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 4000;

-- 9. Връща служители, чието първо име започва с 'J'
SELECT * FROM employees WHERE first_name LIKE 'J%';

-- 10. Връща служители от отдела 'IT' с заплата над 3000
SELECT * FROM employees WHERE department = 'IT' AND salary > 3000;

-- 11. Връща уникалните отдели
SELECT DISTINCT department FROM employees;

-- 12. Връща броя на служителите във всеки отдел
SELECT department, COUNT(*) AS num_employees
FROM employees
GROUP BY department;

-- 13. Връща отделите, където средната заплата е над 3000
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 3000;

-- 14. Връща пълното име на служителите
SELECT CONCAT(first_name, ' ', last_name) AS full_name FROM employees;

-- 15. Връща служителите, наети след 1 януари 2020
SELECT * FROM employees WHERE hire_date > '2020-01-01';
