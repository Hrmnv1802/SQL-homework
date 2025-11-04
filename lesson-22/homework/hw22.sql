--1
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS running_total
FROM sales_data
ORDER BY customer_id, order_date;

--2
SELECT 
    product_category,
    COUNT(*) AS order_count
FROM sales_data
GROUP BY product_category;

--3
SELECT 
    product_category,
    MAX(total_amount) AS max_total_amount
FROM sales_data
GROUP BY product_category;

--4
SELECT 
    product_category,
    MIN(unit_price) AS min_unit_price
FROM sales_data
GROUP BY product_category;

--5
SELECT 
    order_date,
    AVG(total_amount) OVER (
        ORDER BY order_date 
        ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
    ) AS moving_avg
FROM sales_data;

--6
SELECT 
    region,
    SUM(total_amount) AS total_sales
FROM sales_data
GROUP BY region;

--7
SELECT 
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spent,
    RANK() OVER (ORDER BY SUM(total_amount) DESC) AS rank_in_all
FROM sales_data
GROUP BY customer_id, customer_name
ORDER BY total_spent DESC;
--8
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    total_amount - LAG(total_amount) OVER (
        PARTITION BY customer_id ORDER BY order_date
    ) AS diff_from_prev
FROM sales_data
ORDER BY customer_id, order_date;
--9
SELECT *
FROM (
    SELECT 
        product_category,
        product_name,
        unit_price,
        RANK() OVER (PARTITION BY product_category ORDER BY unit_price DESC) AS rnk
    FROM sales_data
) ranked
WHERE rnk <= 3;
--10
SELECT 
    region,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY region ORDER BY order_date
    ) AS cumulative_sales
FROM sales_data
ORDER BY region, order_date;
--11
SELECT 
    product_category,
    order_date,
    SUM(total_amount) OVER (
        PARTITION BY product_category ORDER BY order_date
    ) AS cumulative_revenue
FROM sales_data
ORDER BY product_category, order_date;

--12
CREATE TABLE OneColumn (
    Value SMALLINT
);

INSERT INTO OneColumn VALUES (10), (20), (30), (40), (100);

SELECT 
    Value,
    SUM(Value) OVER (ORDER BY Value ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS [Sum of Previous]
FROM OneColumn;
--13
CREATE TABLE Sample (
    ID INT
);
INSERT INTO Sample VALUES (1), (2), (3), (4), (5);

SELECT 
    ID,
    SUM(ID) OVER (ORDER BY ID ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS SumPreValues
FROM Sample;

--14
SELECT 
    customer_id,
    customer_name
FROM sales_data
GROUP BY customer_id, customer_name
HAVING COUNT(DISTINCT product_category) > 1;

--15
WITH RegionalAvg AS (
    SELECT 
        region,
        AVG(total_amount) AS avg_spending
    FROM sales_data
    GROUP BY region
)
SELECT 
    s.customer_id,
    s.customer_name,
    s.region,
    SUM(s.total_amount) AS total_spent,
    ra.avg_spending
FROM sales_data s
JOIN RegionalAvg ra ON s.region = ra.region
GROUP BY s.customer_id, s.customer_name, s.region, ra.avg_spending
HAVING SUM(s.total_amount) > ra.avg_spending
ORDER BY total_spent DESC;

--16
SELECT 
    region,
    customer_id,
    customer_name,
    SUM(total_amount) AS total_spent,
    RANK() OVER (
        PARTITION BY region ORDER BY SUM(total_amount) DESC
    ) AS rank_in_region
FROM sales_data
GROUP BY region, customer_id, customer_name
ORDER BY region, rank_in_region;
--17
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        PARTITION BY customer_id ORDER BY order_date
    ) AS cumulative_sales
FROM sales_data
ORDER BY customer_id, order_date;
--18
SELECT 
    FORMAT(order_date, 'yyyy-MM') AS sale_month,
    SUM(total_amount) AS monthly_sales,
    LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')) AS prev_month_sales,
    (SUM(total_amount) - LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM'))) * 100.0 /
        NULLIF(LAG(SUM(total_amount)) OVER (ORDER BY FORMAT(order_date, 'yyyy-MM')), 0) AS growth_rate
FROM sales_data
GROUP BY FORMAT(order_date, 'yyyy-MM')
ORDER BY sale_month;

--19
SELECT 
    customer_id,
    customer_name,
    order_date,
    total_amount,
    LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date) AS prev_amount
FROM sales_data
WHERE total_amount > LAG(total_amount) OVER (PARTITION BY customer_id ORDER BY order_date)
ORDER BY customer_id, order_date;

--20
SELECT 
    product_name,
    product_category,
    unit_price
FROM sales_data
WHERE unit_price > (
    SELECT AVG(unit_price) FROM sales_data
)
ORDER BY unit_price DESC;

--21



--22
CREATE TABLE TheSumPuzzle (
    ID INT, 
    Cost INT, 
    Quantity INT
);
INSERT INTO TheSumPuzzle VALUES
(1234,12,164),
(1234,13,164),
(1235,100,130),
(1235,100,135),
(1236,12,136);

SELECT 
    ID,
    SUM(Cost) AS Cost,
    SUM(DISTINCT Quantity) AS Quantity
FROM TheSumPuzzle
GROUP BY ID;

--23


