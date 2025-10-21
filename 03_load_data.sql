INSERT INTO car_shop.country (country_name)
SELECT DISTINCT brand_origin
FROM raw_data.sales;

-- Бренды
INSERT INTO car_shop.brands (country_id, brand_name)
SELECT DISTINCT
    c.country_id,
    split_part(s.auto, ' ', 1) AS brand_name
FROM raw_data.sales AS s
JOIN car_shop.country AS c 
    ON s.brand_origin = c.country_name;

-- Цвета
INSERT INTO car_shop.colors (color_name)
SELECT DISTINCT
    trim(split_part(auto, ',', 2)) AS color_name
FROM raw_data.sales;

-- Таблица cars
INSERT INTO car_shop.cars (brand_id, model, color_id, gasoline_consumption)
SELECT
    b.brand_id,
    split_part(split_part(s.auto, ',', 1), ' ', 2) AS model, -- упрощено получение модели
    c.color_id,
    s.gazoline_consumption
FROM raw_data.sales AS s
JOIN car_shop.brands AS b
    ON b.brand_name = split_part(s.auto, ' ', 1)
JOIN car_shop.colors AS c
    ON c.color_name = trim(split_part(s.auto, ',', 2));

-- Таблица персон
INSERT INTO car_shop.persons (name, phone)
SELECT DISTINCT
    person,
    phone
FROM raw_data.sales;

-- Таблица заказов
INSERT INTO car_shop.orders (car_id, price, discount, order_date, person_id)
SELECT
    c.car_id,
    s.price,
    s.discount,
    s.date, 
    p.person_id
FROM raw_data.sales AS s
JOIN car_shop.cars AS c
    ON c.model = split_part(split_part(s.auto, ',', 1), ' ', 2)
   AND c.brand_id = (
        SELECT b.brand_id
        FROM car_shop.brands AS b
        WHERE b.brand_name = split_part(s.auto, ' ', 1)
   )
JOIN car_shop.persons AS p
    ON p.name = s.person;