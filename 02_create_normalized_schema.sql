CREATE SCHEMA IF NOT EXISTS car_shop;

-- Таблица стран
CREATE TABLE car_shop.country (
    country_id SERIAL PRIMARY KEY,      
    country_name VARCHAR(50)            
);

-- Таблица брендов
CREATE TABLE car_shop.brands (
    brand_id SERIAL PRIMARY KEY,        
    brand_name VARCHAR(50),            
    country_id INT REFERENCES car_shop.country(country_id) 
);

-- Таблица цветов
CREATE TABLE car_shop.colors (
    color_id SERIAL PRIMARY KEY,
    color_name VARCHAR(50)             
);

-- Таблица машин
CREATE TABLE car_shop.cars (
    car_id SERIAL PRIMARY KEY,
    brand_id INT REFERENCES car_shop.brands(brand_id),
    model VARCHAR(50),
    color_id INT REFERENCES car_shop.colors(color_id),
    gasoline_consumption REAL CHECK (gasoline_consumption > 0)
);

-- Таблица персон
CREATE TABLE car_shop.persons (
    person_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(100)
);

-- Таблица заказов
CREATE TABLE car_shop.orders (
    order_id SERIAL PRIMARY KEY,
    car_id INT REFERENCES car_shop.cars(car_id),
    price NUMERIC(9, 2),
    discount SMALLINT,
    order_date DATE,
    person_id INT REFERENCES car_shop.persons(person_id)
);
