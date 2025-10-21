-- Задание 1: Процент машин без gasoline_consumption
WITH count_gazoline_null AS (
    SELECT COUNT(*)::numeric AS count_null
    FROM car_shop.cars
    WHERE gasoline_consumption IS NULL
),
all_count AS (
    SELECT COUNT(*)::numeric AS all_count
    FROM car_shop.cars
)
SELECT ROUND(count_null / all_count * 100, 2) AS nulls_percentage_gasoline_consumption
FROM count_gazoline_null
JOIN all_count ON 1=1;

-- Задание 2: Средняя цена по брендам и годам
SELECT
    b.brand_name,
    EXTRACT(YEAR FROM o.order_date) AS year,
    ROUND(AVG(o.price - o.discount), 2) AS price_avg
FROM car_shop.orders AS o
JOIN car_shop.cars AS c USING (car_id)
JOIN car_shop.brands AS b USING (brand_id)
GROUP BY b.brand_name, EXTRACT(YEAR FROM o.order_date)
ORDER BY b.brand_name, year;

-- Задание 3: Средняя цена по месяцам 2022 года
SELECT
    EXTRACT(MONTH FROM order_date) AS month,
    EXTRACT(YEAR FROM order_date) AS year,
    ROUND(AVG(price - discount), 2) AS price_avg
FROM car_shop.orders
WHERE EXTRACT(YEAR FROM order_date) = 2022
GROUP BY EXTRACT(MONTH FROM order_date), EXTRACT(YEAR FROM order_date)
ORDER BY month;

-- Задание 4: Список машин у каждого человека
SELECT
    p.name AS person,
    STRING_AGG(CONCAT_WS(' ', b.brand_name, c.model), ', ') AS cars
FROM car_shop.orders o
JOIN car_shop.persons p USING(person_id)
JOIN car_shop.cars c USING(car_id)
JOIN car_shop.brands b USING(brand_id)
GROUP BY p.name
ORDER BY p.name;

-- Задание 5: Минимальная и максимальная цена по странам брендов
SELECT
    co.country_name AS brand_origin,
    MAX(o.price / (1 - o.discount/100)) AS price_max,
    MIN(o.price / (1 - o.discount / 100)) AS price_min
FROM car_shop.orders o
JOIN car_shop.cars c USING(car_id)
JOIN car_shop.brands b USING(brand_id)
JOIN car_shop.country co USING(country_id)
GROUP BY co.country_name
ORDER BY co.country_name;

-- Задание 6: Количество персон с телефонами из США
SELECT COUNT(person_id) AS persons_from_usa_count
FROM car_shop.persons
WHERE phone LIKE '+1%';