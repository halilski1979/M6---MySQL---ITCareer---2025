/* Създаване на нова база от данни */
CREATE SCHEMA IF NOT EXISTS minions;

USE minions;

/* Създаване на таблица minions */
CREATE TABLE IF NOT EXISTS minions 
(
  id INT NOT NULL,                 -- Уникален идентификатор
  name VARCHAR(50) NOT NULL,       -- Име на миньона
  age INT(3) NULL,                 -- Възраст (може да бъде NULL)
  townid INT NULL,                 -- Препратка към град (външен ключ)
  PRIMARY KEY (id)                 -- Първичен ключ на таблицата
);

/* Вмъкване на данни в таблицата minions */
INSERT INTO minions (id, name, age) VALUES (1, 'Kevin', 15);     -- Добавяне на Kevin
INSERT INTO minions (id, name, age) VALUES (2, 'Bob', 22);       -- Добавяне на Bob
INSERT INTO minions (id, name) VALUES (3, 'Steward');            -- Добавяне на Steward (без възраст)
INSERT INTO minions (id, name, age) VALUES (4, 'Kiko', 17);     -- Добавяне на Kevin

SELECT * FROM minions;

/* Извеждане на записи с ненулева възраст */
SELECT * FROM minions WHERE age IS NOT NULL;

/* Актуализиране на един запис (промяна на възрастта на Steward) */
UPDATE minions SET age = 10 WHERE id = 3;

/* Актуализиране на всички записи (увеличаване на възрастите с 1) */
UPDATE minions SET age = age + 1 WHERE age IS NOT NULL;

/* Изтриване на запис (Bob) */
DELETE FROM minions WHERE id = 2;
/* Изтриване на запис за определени години */
DELETE FROM minions WHERE age = 13;


/* Създаване на таблица towns */
CREATE TABLE IF NOT EXISTS towns
(
   id INT NOT NULL,               -- Уникален идентификатор за град
   name VARCHAR(40) NOT NULL,     -- Име на града
   PRIMARY KEY (id)               -- Първичен ключ
);

/* Добавяне на данни към towns */
INSERT INTO towns (id, name) VALUES (1, 'Burgas');
INSERT INTO towns (id, name) VALUES (2, 'Sofia');
INSERT INTO towns (id, name) VALUES (3, 'Varna');

 /* Създаване на външен ключ между minions.townid и towns.id */
 ALTER TABLE minions                     -- Променяме структурата на таблицата minions
 
 /*С прости думи: това ограничение гарантира, че всяко townid в minions 
  винаги сочи към валиден град от таблицата towns и предотвратява несъответствия в базата.*/
 ADD CONSTRAINT fk_minions_towns         -- Добавяме ново ограничение (constraint) с име fk_minions_towns
 
  FOREIGN KEY (townid)                  -- Определяме, че колоната townid е външен ключ
  REFERENCES towns (id)                 -- Външният ключ сочи към колоната id в таблицата towns
  ON DELETE NO ACTION                   -- Забранява изтриване на град, ако има миньони, които го използват
  ON UPDATE NO ACTION;                  -- Забранява промяна на towns.id, ако има миньони, които сочат към него






