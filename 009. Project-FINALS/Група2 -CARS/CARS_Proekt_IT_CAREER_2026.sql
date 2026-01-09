/*ПРОЕКТ IT_Career 2026: АВТОСЕРВИЗ И ПОДДРЪЖКА НА АВТОМОБИЛИ */

/* ---------- 1. СЪЗДАВАНЕ НА БАЗА ДАННИ ---------- */
CREATE DATABASE car_service;
USE car_service;

/* Таблица: Customer Съхранява информация за клиентите */
CREATE TABLE Customer (
    CustomerId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    PhoneNumber NVARCHAR(15),
    Email NVARCHAR(100),
    Address NVARCHAR(255)
);

/* Таблица: Car
   Съхранява автомобилите на клиентите
   Връзка: Customer (1) -> Car (M) */
CREATE TABLE Car (
    CarId INT PRIMARY KEY AUTO_INCREMENT,
    CustomerId INT NOT NULL,
    Brand NVARCHAR(50) NOT NULL,
    Model NVARCHAR(50) NOT NULL,
    Year INT NOT NULL,
    LicensePlate NVARCHAR(20) UNIQUE NOT NULL,
    FOREIGN KEY (CustomerId) REFERENCES Customer(CustomerId)
);

/* Таблица: Mechanic
   Съхранява информация за механиците */
CREATE TABLE Mechanic (
    MechanicId INT PRIMARY KEY AUTO_INCREMENT,
    FirstName NVARCHAR(50) NOT NULL,
    LastName NVARCHAR(50) NOT NULL,
    Specialty NVARCHAR(100),
    PhoneNumber NVARCHAR(15)
);

/* Таблица: ServiceRecord
   Сервизни посещения на автомобилите
   Връзки: Car (1) -> ServiceRecord (M)
           Mechanic (1) -> ServiceRecord (M) */
CREATE TABLE ServiceRecord (
    ServiceId INT PRIMARY KEY AUTO_INCREMENT,
    CarId INT NOT NULL,
    MechanicId INT NOT NULL,
    ProblemDescription NVARCHAR(255),
    ServiceDate DATE NOT NULL,
    NextServiceDate DATE,
    FOREIGN KEY (CarId) REFERENCES Car(CarId),
    FOREIGN KEY (MechanicId) REFERENCES Mechanic(MechanicId)
);

/* Таблица: Repair
   Извършени ремонти и използвани части
   Връзка: ServiceRecord (1) -> Repair (M) */
CREATE TABLE Repair (
    RepairId INT PRIMARY KEY AUTO_INCREMENT,
    ServiceId INT NOT NULL,
    PartName NVARCHAR(100),
    Cost DECIMAL(10,2),
    Notes NVARCHAR(255),
    FOREIGN KEY (ServiceId) REFERENCES ServiceRecord(ServiceId)
);

/* ---------- 3. ДАННИ ---------- */
/* Клиенти */
INSERT INTO Customer (FirstName, LastName, PhoneNumber, Email, Address)
VALUES
('Иван', 'Петров', '0888123456', 'ivan.petrov@email.com', 'София'),
('Мария', 'Иванова', '0899123456', 'maria.ivanova@email.com', 'Пловдив'),
('Георги', 'Николов', '0877123456', 'georgi.nikolov@email.com', 'Варна');

/* Автомобили */
INSERT INTO Car (CustomerId, Brand, Model, Year, LicensePlate)
VALUES
(1, 'BMW', '320d', 2018, 'CA1234AB'),
(2, 'Audi', 'A4', 2020, 'PB5678CD'),
(3, 'Toyota', 'Corolla', 2015, 'B9012EF');

/* Механици */
INSERT INTO Mechanic (FirstName, LastName, Specialty, PhoneNumber)
VALUES
('Петър', 'Стоянов', 'Двигатели', '0888001122'),
('Николай', 'Димитров', 'Окачване', '0888334455'),
('Антон', 'Георгиев', 'Електроника', '0888776655');

/* Сервизни посещения */
INSERT INTO ServiceRecord (CarId, MechanicId, ProblemDescription, ServiceDate, NextServiceDate)
VALUES
(1, 1, 'Проблем с двигателя', '2024-01-10', '2024-06-10'),
(2, 2, 'Смяна на амортисьори', '2024-02-05', '2024-08-05'),
(3, 3, 'Проблем с акумулатора', '2024-03-01', NULL);

/* Ремонти */
INSERT INTO Repair (ServiceId, PartName, Cost, Notes)
VALUES
(1, 'Горивен инжектор', 450.00, 'Подменен'),
(2, 'Амортисьори', 600.00, 'Предни'),
(3, 'Акумулатор', 220.00, 'Нов');

/* ---------- 4. ЗАЯВКИ ---------- */

/* 1. Добавяне на нов клиент */
INSERT INTO Customer (FirstName, LastName, PhoneNumber, Email, Address)
VALUES ('Димитър', 'Колев', '0888998877', 'dimitar.kolev@email.com', 'Бургас');

/* 2. Данни за автомобил, сервиз и ремонт */
SELECT
    c.Brand,
    c.Model,
    s.ProblemDescription,
    s.ServiceDate,
    r.PartName,
    r.Cost
FROM Car c
LEFT JOIN ServiceRecord s ON c.CarId = s.CarId
LEFT JOIN Repair r ON s.ServiceId = r.ServiceId
WHERE c.CarId = 1;

/* 3. Ново сервизно посещение */
INSERT INTO ServiceRecord (CarId, MechanicId, ProblemDescription, ServiceDate, NextServiceDate)
VALUES (1, 2, 'Смяна на масло', '2025-01-15', '2025-07-15');

/* 4. Добавяне на ремонт */
INSERT INTO Repair (ServiceId, PartName, Cost, Notes)
VALUES (1, 'Масло и филтър', 120.00, 'Редовно обслужване');

/* 5. Всички сервизни посещения на автомобил */
SELECT
    ServiceId,
    ProblemDescription,
    ServiceDate,
    NextServiceDate
FROM ServiceRecord
WHERE CarId = 2;

/* 6. Всички ремонти на клиент */
SELECT
    cu.FirstName,
    cu.LastName,
    r.PartName,
    r.Cost
FROM Customer cu
JOIN Car c ON cu.CustomerId = c.CustomerId
JOIN ServiceRecord s ON c.CarId = s.CarId
JOIN Repair r ON s.ServiceId = r.ServiceId
WHERE cu.CustomerId = 1;

/* 7. Предстоящи сервизни дати */
SELECT
    c.LicensePlate,
    s.NextServiceDate
FROM Car c
JOIN ServiceRecord s ON c.CarId = s.CarId
WHERE s.NextServiceDate IS NOT NULL;

/* 8. Търсене на автомобил по номер или марка */
SELECT *
FROM Car
WHERE LicensePlate = 'CA1234AB'
   OR Brand LIKE '%Toyota%';

/* 9. Брой сервизни посещения за автомобил */
SELECT
    c.LicensePlate,
    COUNT(s.ServiceId) AS ServiceCount
FROM Car c
LEFT JOIN ServiceRecord s ON c.CarId = s.CarId
GROUP BY c.CarId
ORDER BY ServiceCount DESC;

/* 10. Пълна справка клиент – автомобил – сервиз – ремонт */
SELECT
    cu.FirstName,
    cu.LastName,
    c.Brand,
    c.Model,
    s.ServiceDate,
    r.PartName,
    r.Cost
FROM Customer cu
LEFT JOIN Car c ON cu.CustomerId = c.CustomerId
LEFT JOIN ServiceRecord s ON c.CarId = s.CarId
LEFT JOIN Repair r ON s.ServiceId = r.ServiceId;
