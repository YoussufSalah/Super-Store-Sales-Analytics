-- Create A Reusable Temporary Table For Region Sales
CREATE TEMP TABLE temp_region_sales AS (
    WITH region_sales AS (
        SELECT RANK() OVER(
                ORDER BY SUM("Sales") DESC
            ) AS "Rank",
            "Region",
            ROUND(SUM("Sales")::DECIMAL, 2) AS "Total Sales"
        FROM sales_dim
        GROUP BY "Region"
    )
    SELECT *
    FROM region_sales
);
-- Ranking Regions By Total Sales
SELECT *
FROM temp_region_sales;
-- Top Sales Region
SELECT "Region" AS "Most Sales Region",
    "Total Sales"
FROM temp_region_sales
ORDER BY "Rank" ASC
LIMIT 1;
-- Worst Sales Region
SELECT "Region" AS "Least Sales Region",
    "Total Sales"
FROM temp_region_sales
ORDER BY "Rank" DESC
LIMIT 1;