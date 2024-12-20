SELECT *
FROM sales_dim
WHERE "Row ID" IS NULL
    OR "Order ID" IS NULL
    OR "Order Date" IS NULL
    OR "Ship Date" IS NULL
    OR "Ship Mode" IS NULL -- Can be ignored ( Doesn't affect the analysis so much )
    OR "Customer ID" IS NULL
    OR "Customer Name" IS NULL
    OR "Segment" IS NULL
    OR "Country" IS NULL
    OR "City" IS NULL
    OR "State" IS NULL
    OR "Postal Code" IS NULL -- Can be ignored ( Doesn't affect the analysis so much )
    OR "Region" IS NULL
    OR "Product ID" IS NULL
    OR "Category" IS NULL
    OR "Sub - Category" IS NULL -- Can be ignored ( Doesn't affect the analysis so much )
    OR "Product Name" IS NULL
    OR "Sales" IS NULL;
-- Result: 11 Rows ( All of them doesn't have postal code, every other value is available )