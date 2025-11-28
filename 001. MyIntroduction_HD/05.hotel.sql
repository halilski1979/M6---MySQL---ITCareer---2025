CREATE DATABASE hotel;
USE hotel;


CREATE TABLE employees (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    title VARCHAR(50) NOT NULL,
    notes TEXT NULL
);

INSERT INTO employees (first_name, last_name, title, notes)
VALUES
('Alice', 'Johnson', 'Manager', 'Experienced in hotel management.'),
('Bob', 'Smith', 'Receptionist', NULL),
('Carol', 'Williams', 'Housekeeping', 'Specializes in VIP rooms.');



CREATE TABLE customers (
    account_number INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    phone_number VARCHAR(20) NULL,
    emergency_name VARCHAR(100) NULL,
    emergency_number VARCHAR(20) NULL,
    notes TEXT NULL
);
INSERT INTO customers (first_name, last_name, phone_number, emergency_name, emergency_number, notes)
VALUES
('John', 'Doe', '0888123456', 'Jane Doe', '0888765432', NULL),
('Mary', 'Smith', '0899123456', 'Paul Smith', '0899876543', 'VIP guest'),
('Mike', 'Brown', '0877123456', NULL, NULL, NULL);




CREATE TABLE room_status (
    room_status VARCHAR(20) NOT NULL PRIMARY KEY,
    notes TEXT NULL
);
INSERT INTO room_status (room_status, notes)
VALUES
('Available', 'Ready for check-in'),
('Occupied', 'Currently occupied'),
('Maintenance', 'Under maintenance');



CREATE TABLE room_types (
    room_type VARCHAR(50) NOT NULL PRIMARY KEY,
    notes TEXT NULL
);
INSERT INTO room_types (room_type, notes)
VALUES
('Single', 'Single occupancy'),
('Double', 'Double occupancy'),
('Suite', 'Luxury suite');




CREATE TABLE bed_types (
    bed_type VARCHAR(50) NOT NULL PRIMARY KEY,
    notes TEXT NULL
);
INSERT INTO bed_types (bed_type, notes)
VALUES
('King', 'King size bed'),
('Queen', 'Queen size bed'),
('Twin', 'Two single beds');



CREATE TABLE rooms (
    room_number INT NOT NULL PRIMARY KEY,
    room_type VARCHAR(50) NOT NULL,
    bed_type VARCHAR(50) NOT NULL,
    rate DECIMAL(7,2) NOT NULL,
    room_status VARCHAR(20) NOT NULL,
    notes TEXT NULL,
    CONSTRAINT fk_rooms_type FOREIGN KEY (room_type) REFERENCES room_types(room_type),
    CONSTRAINT fk_rooms_bed FOREIGN KEY (bed_type) REFERENCES bed_types(bed_type),
    CONSTRAINT fk_rooms_status FOREIGN KEY (room_status) REFERENCES room_status(room_status)
);
INSERT INTO rooms (room_number, room_type, bed_type, rate, room_status, notes)
VALUES
(101, 'Single', 'King', 100.00, 'Available', NULL),
(102, 'Double', 'Queen', 150.00, 'Occupied', 'Reserved for VIP'),
(201, 'Suite', 'King', 300.00, 'Maintenance', 'Renovation ongoing');



CREATE TABLE payments (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    payment_date DATE NOT NULL,
    account_number INT NOT NULL,
    first_date_occupied DATE NOT NULL,
    last_date_occupied DATE NOT NULL,
    total_days INT NOT NULL,
    amount_charged DECIMAL(7,2) NOT NULL,
    tax_rate DECIMAL(5,2) NOT NULL,
    tax_amount DECIMAL(7,2) NOT NULL,
    payment_total DECIMAL(7,2) NOT NULL,
    notes TEXT NULL,
    CONSTRAINT fk_payment_employee FOREIGN KEY (employee_id) REFERENCES employees(id),
    CONSTRAINT fk_payment_customer FOREIGN KEY (account_number) REFERENCES customers(account_number)
);
INSERT INTO payments (employee_id, payment_date, account_number, first_date_occupied, last_date_occupied, total_days, amount_charged, tax_rate, tax_amount, payment_total, notes)
VALUES
(1, '2025-11-20', 1, '2025-11-18', '2025-11-20', 2, 200.00, 10.00, 20.00, 220.00, NULL),
(2, '2025-11-21', 2, '2025-11-19', '2025-11-21', 2, 300.00, 10.00, 30.00, 330.00, 'VIP payment'),
(3, '2025-11-22', 3, '2025-11-20', '2025-11-22', 2, 150.00, 10.00, 15.00, 165.00, NULL);




CREATE TABLE occupancies (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    employee_id INT NOT NULL,
    date_occupied DATE NOT NULL,
    account_number INT NOT NULL,
    room_number INT NOT NULL,
    rate_applied DECIMAL(7,2) NOT NULL,
    phone_charge DECIMAL(7,2) NULL,
    notes TEXT NULL,
    CONSTRAINT fk_occupancies_employee FOREIGN KEY (employee_id) REFERENCES employees(id),
    CONSTRAINT fk_occupancies_customer FOREIGN KEY (account_number) REFERENCES customers(account_number),
    CONSTRAINT fk_occupancies_room FOREIGN KEY (room_number) REFERENCES rooms(room_number)
);
INSERT INTO occupancies (employee_id, date_occupied, account_number, room_number, rate_applied, phone_charge, notes)
VALUES
(1, '2025-11-18', 1, 101, 100.00, 5.00, NULL),
(2, '2025-11-19', 2, 102, 150.00, 0.00, 'VIP guest'),
(3, '2025-11-20', 3, 201, 300.00, 10.00, 'Suite under renovation');









