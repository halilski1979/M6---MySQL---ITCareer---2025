CREATE DATABASE actors_movies;
USE actors_movies;

-- Таблица с актьори
CREATE TABLE Actors (
    actor_id INT AUTO_INCREMENT PRIMARY KEY,
    actor_name VARCHAR(100) NOT NULL
    -- Тук няма ON DELETE/UPDATE правила, защото е родителска таблица
);

-- Таблица с филми
CREATE TABLE Movies (
    movie_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    release_year INT
);

-- Междинна таблица за N:N връзка между филми и актьори
CREATE TABLE MovieActors (
    actor_id INT NOT NULL,
    movie_id INT NOT NULL,

    PRIMARY KEY (actor_id, movie_id), -- Композитен ключ

    -- Тук използваме RESTRICT (обратното на CASCADE)
    -- Забраняваме изтриване/обновяване ако има зависими записи
    FOREIGN KEY (actor_id)
        REFERENCES Actors(actor_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT,

    FOREIGN KEY (movie_id)
        REFERENCES Movies(movie_id)
        ON UPDATE RESTRICT
        ON DELETE RESTRICT
);

-- Въвеждаме примерни данни
INSERT INTO Actors (actor_name) VALUES
('Tom Hanks'), ('Leonardo DiCaprio'), ('Brad Pitt'); -- 1,2,3

INSERT INTO Movies (title, release_year) VALUES
('Inception', 2010),     -- movie_id = 1
('Fight Club', 1999),    -- movie_id = 2
('Forrest Gump', 1994);  -- movie_id = 3

-- Създаваме връзки Недопускащо изтриване/обновяване
INSERT INTO MovieActors (actor_id, movie_id) VALUES
(2, 1), -- DiCaprio → Inception
(3, 2), -- Pitt → Fight Club
(1, 3); -- Hanks → Forrest Gump

-- Грешка: актьорът има връзка в MovieActors, заради RESTRICT
DELETE FROM Actors WHERE actor_id = 1;

-- Грешка: има записи, които го ползват като FK, заради RESTRICT
UPDATE Movies SET movie_id = 10 WHERE movie_id = 1;
