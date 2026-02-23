CREATE TABLE starbucks_raw (
    Store_ID TEXT,
    City TEXT,
    Monthly_Sales_USD TEXT,
    Num_Customers TEXT,
    Rating TEXT,
    Open_Date TEXT,
    Manager_Name TEXT
);


select * from starbucks_raw;

ALTER TABLE starbucks_raw
RENAME COLUMN Monthly_Sales_USD TO Monthly_Sales;

UPDATE starbucks_raw
SET Monthly_Sales = SUBSTRING(Monthly_Sales FROM 2);

alter table starbucks_raw
ALTER COLUMN Monthly_Sales TYPE NUMERIC(12,1),
alter column Num_Customers TYPE int USING num_customers::integer,
alter column Rating TYPE NUMERIC(2,1) USING rating::numeric(2,1),
alter column Open_Date TYPE date USING open_date::date;

DELETE FROM starbucks_raw a
USING starbucks_raw b
WHERE a.ctid > b.ctid
AND a.store_id = b.store_id;


--normalization

CREATE TABLE cities (
    city_id SERIAL PRIMARY KEY,
    city_name TEXT UNIQUE
);

ALTER TABLE cities
DROP CONSTRAINT cities_city_name_key;

ALTER TABLE cities
ADD CONSTRAINT cities_city_name_key UNIQUE (city_name);

CREATE TABLE managers (
    manager_id SERIAL PRIMARY KEY,
    manager_name TEXT UNIQUE
);

ALTER TABLE managers
DROP CONSTRAINT managers_manager_name_key;

ALTER TABLE managers
ADD CONSTRAINT managers_manager_name_key UNIQUE (manager_name);

CREATE TABLE stores (
    store_id TEXT PRIMARY KEY,
    city_id INT REFERENCES cities(city_id),
    monthly_sales NUMERIC(12),
    num_customers INT,
    rating NUMERIC(2,1),
    open_date DATE,
    manager_id INT REFERENCES managers(manager_id)
);


INSERT INTO cities (city_name)
SELECT DISTINCT city
FROM starbucks_raw;

INSERT INTO managers (manager_name)
SELECT DISTINCT manager_name
FROM starbucks_raw;

INSERT INTO stores (
    store_id, city_id, monthly_sales, num_customers,
    rating, open_date, manager_id
)
SELECT
    sr.store_id,
    c.city_id,
    sr.monthly_sales,
    sr.num_customers,
    sr.rating,
    sr.open_date,
    m.manager_id
FROM starbucks_raw sr
LEFT JOIN cities c
    ON c.city_name = sr.city
LEFT JOIN managers m
    ON m.manager_name = sr.manager_name;

select * from stores;
select * from ci;


--queries

--Underperforming Stores Compared to City Average
WITH city_sales AS (
    SELECT 
        city_id,
        ROUND(AVG(monthly_sales),2) AS avg_city_sales
    FROM stores
    GROUP BY city_id
)
SELECT 
    s.store_id,
    c.city_name,
    s.monthly_sales,
    cs.avg_city_sales,
    (cs.avg_city_sales - s.monthly_sales) AS difference
FROM stores s
JOIN city_sales cs ON s.city_id = cs.city_id
JOIN cities c ON c.city_id = s.city_id
WHERE s.monthly_sales < cs.avg_city_sales
order by monthly_sales;


--High customer footfall but low store ratings
WITH avg_values AS (
    SELECT 
        (SELECT AVG(num_customers) FROM stores) AS avg_cust,
        (SELECT AVG(rating) FROM stores) AS avg_rating
)
SELECT 
    s.store_id,
    c.city_name,
    s.num_customers,
    s.rating
FROM stores s
JOIN cities c ON c.city_id = s.city_id
JOIN avg_values a ON TRUE
WHERE s.num_customers > a.avg_cust
  AND s.rating < a.avg_rating
  order by num_customers desc;


--Older stores might have declining performance
WITH store_age AS (
    SELECT 
        store_id,
        city_id,
        monthly_sales,
        EXTRACT(YEAR FROM AGE(open_date)) AS years_running
    FROM stores
)
SELECT 
    sa.store_id,
    c.city_name,
    sa.years_running,
    sa.monthly_sales
FROM store_age sa
JOIN cities c ON sa.city_id = c.city_id
WHERE years_running > 
    (SELECT AVG(EXTRACT(YEAR FROM AGE(open_date))) FROM stores)
  AND monthly_sales <
    (SELECT AVG(monthly_sales) FROM stores)
	order by monthly_sales;


--Some managers handle too many low-performing stores
WITH m_perf AS (
    SELECT 
        m.manager_id,
        m.manager_name,
        COUNT(s.store_id) AS stores_managed,
        AVG(s.monthly_sales) AS avg_sales
    FROM managers m
    LEFT JOIN stores s ON s.manager_id = m.manager_id
    GROUP BY m.manager_id, m.manager_name
),
avg_managed AS (
    SELECT AVG(store_count) AS avg_stores
    FROM (
        SELECT COUNT(store_id) AS store_count
        FROM stores
        GROUP BY manager_id
    ) t
),
avg_sales_all AS (
    SELECT AVG(monthly_sales) AS overall_avg_sales
    FROM stores
)
SELECT 
    mp.*
FROM m_perf mp
CROSS JOIN avg_managed am
CROSS JOIN avg_sales_all asa
WHERE mp.stores_managed > am.avg_stores
  AND mp.avg_sales < asa.overall_avg_sales;


--Some stores have very low sales despite high ratings (Poor location)
WITH high_rating_low_sales AS (
    SELECT 
        s.store_id,
        s.city_id,
        s.monthly_sales,
        s.rating
    FROM stores s
    WHERE s.rating > (SELECT AVG(rating) FROM stores)
      AND s.monthly_sales < (SELECT AVG(monthly_sales) FROM stores)
)
SELECT
    hr.store_id,
    c.city_name,
    hr.rating,
    hr.monthly_sales
FROM high_rating_low_sales hr
JOIN cities c ON c.city_id = hr.city_id
order by rating desc;


--Some cities have high customers but low ratings (City-level service issues)
WITH city_ratings AS (
    SELECT 
        c.city_name,
        ROUND(AVG(s.rating),1) AS avg_rating,
        ROUND(AVG(s.num_customers),0) AS avg_customers
    FROM stores s
    JOIN cities c ON s.city_id = c.city_id
    GROUP BY c.city_name
)
SELECT *
FROM city_ratings
WHERE avg_customers > 
      (SELECT AVG(num_customers) FROM stores)
  AND avg_rating < 
      (SELECT AVG(rating) FROM stores);


--Detect Seasonal Stores (Open Date Effect on Sales)
SELECT 
    store_id,c.city_name,
    TO_CHAR(open_date, 'Month') AS open_month,
    monthly_sales,
    (SELECT ROUND(AVG(monthly_sales),2) FROM stores) AS overall_avg,
    monthly_sales - (SELECT ROUND(AVG(monthly_sales),2) FROM stores) AS difference
FROM stores s
join cities c
on s.city_id = c.city_id
order by open_month;


--City-Level Revenue Contribution
WITH city_sales AS (
    SELECT 
        c.city_name,
        SUM(s.monthly_sales) AS total_sales
    FROM stores s
    JOIN cities c ON c.city_id = s.city_id
    GROUP BY c.city_name
)
SELECT 
    city_name,
    total_sales,
    ROUND(100 * total_sales / SUM(total_sales) OVER (),2) AS contribution_percentage
FROM city_sales
ORDER BY total_sales DESC;


--Manager Performance Ranking
WITH manager_rank AS (
    SELECT 
        m.manager_name,
        SUM(s.monthly_sales) AS total_sales
    FROM stores s
    JOIN managers m ON m.manager_id = s.manager_id
    GROUP BY m.manager_name
)
SELECT 
    manager_name,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS performance_rank
FROM manager_rank;

