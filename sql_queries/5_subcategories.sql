-- Create A Reusable Temporary Table For Sub-Category Sales
CREATE TEMP TABLE temp_sub_category_sales AS (
    WITH sub_category_sales AS (
        SELECT RANK() OVER(
                ORDER BY SUM("Sales") DESC
            ) AS "Rank",
            "Sub - Category",
            ROUND(SUM("Sales")::DECIMAL, 2) AS "Total Sales"
        FROM sales_dim
        GROUP BY "Sub - Category"
    )
    SELECT *
    FROM sub_category_sales
);
-- Ranking Sub-Categories By Total Sales
SELECT *
FROM temp_sub_category_sales;
-- Top 3 Sub-Categories In Sales
SELECT "Sub - Category",
    "Total Sales"
FROM temp_sub_category_sales
ORDER BY "Rank" ASC
LIMIT 3;
-- Worst 3 Sub-Categories In Sales
SELECT "Sub - Category",
    "Total Sales"
FROM temp_sub_category_sales
ORDER BY "Rank" DESC
LIMIT 3;