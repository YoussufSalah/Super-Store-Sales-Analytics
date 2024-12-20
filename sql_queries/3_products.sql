-- Create A Reusable Temporary Table For Product Sales
CREATE TEMP TABLE temp_products_sales AS (
    WITH products_sales AS (
        SELECT RANK() OVER(
                ORDER BY SUM("Sales") DESC
            ) AS "Rank",
            "Product ID",
            "Category",
            "Sub - Category",
            SUM("Sales") AS "Total Sales"
        FROM sales_dim
        GROUP BY "Product ID",
            "Category",
            "Sub - Category"
    )
    SELECT *
    FROM products_sales
);
-- Ranking Products By Sales
SELECT *
FROM temp_products_sales;
-- Top 10 In Sales
SELECT *
FROM temp_products_sales
ORDER BY "Rank" ASC
LIMIT 10;
-- Worst 10 In Sales
SELECT *
FROM temp_products_sales
ORDER BY "Rank" DESC
LIMIT 10;