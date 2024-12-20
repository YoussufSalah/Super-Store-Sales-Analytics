-- Create A Reusable Temporary Table For Category Sales
CREATE TEMP TABLE temp_category_sales AS (
    WITH category_sales AS (
        SELECT RANK() OVER(
                ORDER BY SUM("Sales") DESC
            ) AS "Rank",
            "Category",
            ROUND(SUM("Sales")::DECIMAL, 2) AS "Total Sales"
        FROM sales_dim
        GROUP BY "Category"
    )
    SELECT *
    FROM category_sales
);
-- Ranking Categories By Total Sales
SELECT *
FROM temp_category_sales;
-- Top Sales Category
SELECT "Category" AS "Most Sales Category",
    "Total Sales"
FROM temp_category_sales
ORDER BY "Rank" ASC
LIMIT 1;
-- Worst Sales Category
SELECT "Category" AS "Least Sales Category",
    "Total Sales"
FROM temp_category_sales
ORDER BY "Rank" DESC
LIMIT 1;