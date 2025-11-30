CREATE DATABASE shema;
USE shema;

-- Таблица за типове артикули
CREATE TABLE item_types (
    item_type_id INT(11) NOT NULL AUTO_INCREMENT, -- Уникален идентификатор за типа на артикула
    name VARCHAR(50) NOT NULL,                   -- Име на типа артикула
    PRIMARY KEY(item_type_id)
);

-- Таблица за артикули
CREATE TABLE items (
    item_id INT(11) NOT NULL AUTO_INCREMENT,     -- Уникален идентификатор на артикула
    name VARCHAR(50) NOT NULL,                   -- Име на артикула
    item_type_id INT(11) NOT NULL,               -- Външен ключ към тип на артикула
    PRIMARY KEY(item_id),
    FOREIGN KEY (item_type_id) REFERENCES item_types(item_type_id)
);

-- Таблица за градове
CREATE TABLE cities (
    city_id INT(11) NOT NULL AUTO_INCREMENT,    -- Уникален идентификатор на града
    name VARCHAR(50) NOT NULL,                  -- Име на града
    PRIMARY KEY(city_id)
);

-- Таблица за клиенти
CREATE TABLE customers (
    customer_id INT(11) NOT NULL AUTO_INCREMENT,-- Уникален идентификатор на клиента
    name VARCHAR(50) NOT NULL,                  -- Име на клиента
    birthday DATE,                              -- Рожденна дата на клиента
    city_id INT(11),                             -- Външен ключ към град
    PRIMARY KEY(customer_id),
    FOREIGN KEY (city_id) REFERENCES cities(city_id)
);

-- Таблица за поръчки
CREATE TABLE orders (
    order_id INT(11) NOT NULL AUTO_INCREMENT,   -- Уникален идентификатор на поръчката
    customer_id INT(11) NOT NULL,               -- Външен ключ към клиента
    PRIMARY KEY(order_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Таблица за артикули в поръчки (много към много)
CREATE TABLE order_items (
    order_id INT(11) NOT NULL,                  -- Външен ключ към поръчка
    item_id INT(11) NOT NULL,                   -- Външен ключ към артикул
    PRIMARY KEY(order_id, item_id),            -- Комбиниран първичен ключ
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (item_id) REFERENCES items(item_id)
);
