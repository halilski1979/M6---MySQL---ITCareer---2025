CREATE DATABASE Movies;
USE Movies;

CREATE TABLE directors (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   -- Уникален идентификатор
    director_name VARCHAR(100) NOT NULL,          -- Име на режисьора
    notes TEXT NULL                               -- Бележки, може да е празно
);

INSERT INTO directors (director_name, notes)
VALUES
('Steven Spielberg', 'director1.'),
('Christopher Nolan', 'director2.'),
('Quentin Tarantino', 'director3.'),
('Martin Scorsese', 'director4.'),
('Greta Gerwig', 'director5.');


CREATE TABLE genres (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,  -- Уникален идентификатор
    genre_name VARCHAR(50) NOT NULL,             -- Име на жанра
    notes TEXT NULL                               -- Бележки, може да е празно
);

INSERT INTO genres (genre_name, notes)
VALUES
('Action', 'High-energy films with stunts and fights.'),
('Drama', 'Serious storytelling, character-driven.'),
('Comedy', 'Films designed to make the audience laugh.'),
('Horror', 'Intended to scare and thrill viewers.'),
('Sci-Fi', 'Science fiction, futuristic or speculative settings.');


CREATE TABLE categories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,   -- Уникален идентификатор
    category_name VARCHAR(50) NOT NULL,           -- Име на категорията
    notes TEXT NULL                               -- Бележки, може да е празно
);

INSERT INTO categories (category_name, notes)
VALUES
('Blockbuster', 'Big-budget popular films.'),
('Indie', 'Independent films with smaller budgets.'),
('Classic', 'Films that have stood the test of time.'),
('Animated', 'Films using animation techniques.'),
('Documentary', 'Non-fiction films documenting reality.');


CREATE TABLE movies (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,          -- Първичен ключ
    title VARCHAR(200) NOT NULL,                         -- Заглавие
    director_id INT NOT NULL,                             -- Чужд ключ към directors
    copyright_year YEAR NOT NULL,                         -- Година
    length TIME NOT NULL,                                 -- Продължителност
    genre_id INT NOT NULL,                                -- Чужд ключ към genres
    category_id INT NOT NULL,                             -- Чужд ключ към categories
    rating DECIMAL(3,1) NULL CHECK (rating >= 0 AND rating <= 10),  -- Ограничение за валиден рейтинг
    notes TEXT NULL,                                      -- Бележки
    
    CONSTRAINT fk_director FOREIGN KEY (director_id) REFERENCES directors(id),
    CONSTRAINT fk_genre FOREIGN KEY (genre_id) REFERENCES genres(id),
    CONSTRAINT fk_category FOREIGN KEY (category_id) REFERENCES categories(id)
);

/*Обяснение на добавените Constraints
PRIMARY KEY (id) → всеки филм има уникален идентификатор
FOREIGN KEY (director_id) → гарантира, че всеки филм сочи към реален режисьор
FOREIGN KEY (genre_id) → гарантира, че жанрът съществува в genres
FOREIGN KEY (category_id) → гарантира, че категорията съществува в categories*/

INSERT INTO movies (title, director_id, copyright_year, length, genre_id, category_id, rating, notes)
VALUES
('Jurassic Park', 1, 1993, '02:07:00', 1, 1, 8.1, 'Iconic dinosaur action film.'),
('Inception', 2, 2010, '02:28:00', 5, 1, 8.8, 'Mind-bending heist thriller.'),
('Pulp Fiction', 3, 1994, '02:34:00', 2, 3, 8.9, 'Cult classic with nonlinear storytelling.'),
('The Wolf of Wall Street', 4, 2013, '03:00:00', 2, 1, 8.2, 'Based on real-life events of stockbroker Jordan Belfort.'),
('Little Women', 5, 2019, '02:15:00', 2, 2, 7.8, 'Adaptation of Louisa May Alcott novel.');


