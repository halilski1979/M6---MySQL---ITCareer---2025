CREATE DATABASE car_rental;
USE car_rental;

CREATE TABLE categories (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,    -- Първичен ключ
    category VARCHAR(50) NOT NULL,                 -- Име на категорията
    daily_rate DECIMAL(7,2) NOT NULL,             -- Дневна цена
    weekly_rate DECIMAL(7,2) NOT NULL,            -- Седмична цена
    monthly_rate DECIMAL(7,2) NOT NULL,           -- Месечна цена
    weekend_rate DECIMAL(7,2) NULL                -- Цена за уикенд, може да е празно
);

INSERT INTO categories (category, daily_rate, weekly_rate, monthly_rate, weekend_rate)
VALUES
('Economy', 25.00, 150.00, 500.00, 30.00),
('SUV', 50.00, 300.00, 1000.00, 60.00),
('Luxury', 100.00, 600.00, 2000.00, 120.00);

CREATE TABLE cars (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    plate_number VARCHAR(15) NOT NULL UNIQUE,
    make VARCHAR(50) NOT NULL,
    model VARCHAR(50) NOT NULL,
    car_year YEAR NOT NULL,
    category_id INT NOT NULL,
    doors TINYINT NOT NULL,
    picture LONGBLOB NULL,
    car_condition VARCHAR(50) NOT NULL,
    available BOOLEAN DEFAULT TRUE,
    CONSTRAINT fk_cars_category FOREIGN KEY (category_id) REFERENCES categories(id)
);

INSERT INTO cars (plate_number, make, model, car_year, category_id, doors, picture, car_condition, available)
VALUES
('CA1234AB', 'Toyota', 'Corolla', 2020, 1, 4, NULL, 'Excellent', TRUE),
('CB5678CD', 'BMW', 'X5', 2022, 2, 5, NULL, 'Good', TRUE),
('CC9012EF', 'Mercedes', 'S-Class', 2021, 3, 4, NULL, 'Excellent', FALSE);


CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    notes TEXT NULL
);

INSERT INTO employees (first_name, last_name, title, notes)
VALUES
('Alice', 'Johnson', 'Manager', 'Experienced in fleet management.'),
('Bob', 'Smith', 'Sales', NULL),
('Carol', 'Williams', 'Customer Support', 'Handles VIP clients.');


CREATE TABLE customers (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    driver_licence_number VARCHAR(20) NOT NULL UNIQUE,
    full_name VARCHAR(100) NOT NULL,
    address VARCHAR(150) NULL,
    city VARCHAR(50) NULL,
    zip_code VARCHAR(10) NULL,
    notes TEXT NULL
);

INSERT INTO customers (driver_licence_number, full_name, address, city, zip_code, notes)
VALUES
('DL123456', 'John Doe', '123 Main St', 'Sofia', '1000', NULL),
('DL789012', 'Jane Smith', '45 Elm St', 'Plovdiv', '4000', 'VIP customer'),
('DL345678', 'Mike Brown', NULL, 'Varna', '9000', NULL);

CREATE TABLE rental_orders (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    customer_id INT NOT NULL,
    car_id INT NOT NULL,
    car_condition VARCHAR(50) NOT NULL,
    tank_level DECIMAL(4,2) NULL,                  -- Ниво на горивото (литри)
    kilometrage_start INT NOT NULL,
    kilometrage_end INT NULL,
    total_kilometrage INT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_days INT NOT NULL,
    rate_applied DECIMAL(7,2) NOT NULL,
    tax_rate DECIMAL(5,2) NOT NULL,
    order_status ENUM('Pending','Active','Completed','Cancelled') NOT NULL,
    notes TEXT NULL,
    
    CONSTRAINT fk_rental_employee FOREIGN KEY (employee_id) REFERENCES employees(id),
    CONSTRAINT fk_rental_customer FOREIGN KEY (customer_id) REFERENCES customers(id),
    CONSTRAINT fk_rental_car FOREIGN KEY (car_id) REFERENCES cars(id)
);

INSERT INTO rental_orders (employee_id, customer_id, car_id, car_condition, tank_level, kilometrage_start, kilometrage_end, total_kilometrage, start_date, end_date, total_days, rate_applied, tax_rate, order_status, notes)
VALUES
(1, 1, 1, 'Excellent', 50.00, 10000, 10200, 200, '2025-11-20', '2025-11-22', 2, 50.00, 20.00, 'Completed', NULL),
(2, 2, 2, 'Good', 60.00, 5000, 5200, 200, '2025-11-21', '2025-11-24', 3, 150.00, 20.00, 'Active', 'Customer requested GPS'),
(3, 3, 3, 'Excellent', 80.00, 8000, 8300, 300, '2025-11-22', '2025-11-26', 4, 400.00, 20.00, 'Pending', 'Luxury car rental');












