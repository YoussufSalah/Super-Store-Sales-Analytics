CREATE TEMP TABLE temp_sales_per_year AS (
    WITH CTE AS (
        SELECT EXTRACT(
                YEAR
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            ) AS "Year",
            ROUND(SUM("Sales"), 2) AS "Total Yearly Sales"
        FROM sales_dim
        GROUP BY EXTRACT(
                YEAR
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            )
        ORDER BY EXTRACT(
                YEAR
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            ) ASC
    )
    SELECT *
    FROM CTE
);
-- Calculate overall growth percentage:
SELECT *,
    ROUND(
        (
            "Total Yearly Sales" - LAG(
                "Total Yearly Sales",
                (
                    SELECT COUNT(*) - 1
                    FROM temp_sales_per_year
                )::INT
            ) OVER (
                ORDER BY "Year"
            )
        ) / LAG(
            "Total Yearly Sales",
            (
                SELECT COUNT(*) - 1
                FROM temp_sales_per_year
            )::INT
        ) OVER (
            ORDER BY "Year"
        ) * 100,
        2
    ) AS "Growth Over Years"
FROM temp_sales_per_year AS tsy
ORDER BY "Growth Over Years"
LIMIT 1;
-- Calculate the year-on-year (YoY) growth percentage:
SELECT *,
    ROUND(
        (
            "Total Yearly Sales" - LAG("Total Yearly Sales") OVER (
                ORDER BY "Year"
            )
        ) / LAG("Total Yearly Sales") OVER (
            ORDER BY "Year"
        ) * 100,
        2
    ) AS "YoY Growth (%)"
FROM temp_sales_per_year;
/*
 *  Insights:
 *      - The overall yearly growth is going up ( about 50.47% from the 2015 to 2018).
 *      - The only year that had less sales than the previous one is 2016 with total sales of 459436.01$ ( 2015's total sales: 479856.21$ higher than 2016's by about 4.26%)
 */