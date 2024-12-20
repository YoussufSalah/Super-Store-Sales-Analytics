-- Create temporary table for monthly sales:
CREATE TEMP TABLE temp_sales_per_month AS (
    WITH CTE AS (
        SELECT EXTRACT(
                MONTH
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            ) || '-' || EXTRACT(
                YEAR
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            ) AS "Month",
            ROUND(SUM("Sales")::DECIMAL, 2) AS "Total Monthly Sales"
        FROM sales_dim
        GROUP BY EXTRACT(
                YEAR
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            ),
            EXTRACT(
                MONTH
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            )
        ORDER BY EXTRACT(
                YEAR
                FROM TO_DATE("Order Date", 'DD/MM/YYYY')
            ) ASC,
            EXTRACT(
                MONTH
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
            "Total Monthly Sales" - LAG(
                "Total Monthly Sales",
                (
                    SELECT COUNT(*) - 1
                    FROM temp_sales_per_month
                )::INT
            ) OVER (
                ORDER BY TO_DATE("Month", 'MM-YYYY')
            )
        ) / LAG(
            "Total Monthly Sales",
            (
                SELECT COUNT(*) - 1
                FROM temp_sales_per_month
            )::INT
        ) OVER (
            ORDER BY TO_DATE("Month", 'MM-YYYY')
        ) * 100,
        2
    ) AS "Growth Over Months"
FROM temp_sales_per_month AS tsm
ORDER BY "Growth Over Months"
LIMIT 1;
-- Calculate month-on-month growth percentage:
SELECT *,
    ROUND(
        (
            "Total Monthly Sales" - LAG("Total Monthly Sales") OVER (
                ORDER BY TO_DATE("Month", 'MM-YYYY')
            )
        ) / LAG("Total Monthly Sales") OVER (
            ORDER BY TO_DATE("Month", 'MM-YYYY')
        ) * 100,
        2
    ) AS "MoM Growth (%)"
FROM temp_sales_per_month AS tsm;
/*
 *  Insights:
 *      - The MoM Growth isn't consistent
 *      - Overall growth is going up ( around 484.49%)
 */