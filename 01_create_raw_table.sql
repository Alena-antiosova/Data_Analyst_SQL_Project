CREATE TABLE raw_data.sales(
    id SERIAL PRIMARY KEY,
    auto VARCHAR(100),
    gazoline_consumption REAL,      
    price NUMERIC(9,2),             
    date DATE,
    person VARCHAR(100),
    phone VARCHAR(100),             
    discount SMALLINT,
    brand_origin VARCHAR(100)
);

COPY raw_data.sales
FROM 'C:\\cars.csv'
WITH (FORMAT CSV, HEADER TRUE, DELIMITER ',', NULL 'null');

SELECT * FROM raw_data.sales LIMIT 10;