-- Count total rows:
SELECT COUNT(*)
FROM sales_dim;
-- Count distinct rows:
SELECT COUNT(*)
FROM (
        SELECT DISTINCT *
        FROM sales_dim
    );
-- Count total orders:
SELECT COUNT(*) AS "Total Orders"
FROM sales_dim;
-- Count total distinct orders:
SELECT COUNT(DISTINCT("Order ID")) AS "Total Distinct Orders"
FROM sales_dim;
-- Count duplicated orders:
SELECT COUNT(*) AS "Duplicated Orders"
FROM (
        SELECT COUNT(*) AS "Orders Count"
        FROM sales_dim
        GROUP BY "Order ID"
        HAVING COUNT(*) > 1
    );
-- Count duplicates for ("Order ID", "Product ID"):
SELECT COUNT(*) AS "Duplicated Orders"
FROM (
        SELECT "Order ID",
            "Product ID",
            COUNT(*) AS "Orders Count"
        FROM sales_dim
        GROUP BY "Order ID",
            "Product ID"
        HAVING COUNT(*) > 1
        ORDER BY "Order ID",
            "Product ID"
    );
-- Count distinct pairs ("Order ID", "Product ID"):
SELECT COUNT(*)
FROM (
        SELECT DISTINCT "Order ID",
            "Product ID"
        FROM sales_dim
    );
/*
 * Result:
 *      - Total rows = 9800 Row
 *      - Total distinct rows = 9800 Row
 *      - Total orders = 9800 Order
 *      - Total distinct orders = 4922 Orders
 *      - Total Duplacited orders = 2423 Orders
 * Insights:
 *      - The duplications in the "Order ID" column might be because of an order have multiple different products
 *      - After further checking we found that:
 *          1 - Distinct products: 1861
 *          2 - Distinct orders: 4922
 *          3 - Distinct pairs (orders, products): 9792
 *          4 - Duplicated pairs (orders, products): 8
 *      - There's 8 duplicated pairs (orders, products) and the reason for that might be that the customer ordered more than one of piece of the product in the same order
 */