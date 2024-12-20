# Sales Analytics

## Description

This project analyzes sales data to uncover insights into performance, trends, and anomalies. The analysis includes identifying missing and duplicate data, ranking products, categories, subcategories, and regions, and tracking monthly and yearly sales trends.

## Objectives

-   Address missing and duplicate data.
-   Analyze performance across products, categories, and regions.
-   Monitor monthly and yearly sales trends.
-   Provide actionable insights based on findings.

## Dataset Overview

The project works on the `sales_dim` dataset, which includes fields such as:

-   `Row ID`, `Order ID`, `Order Date`, `Ship Date`, `Customer ID`, `Product ID`, `Category`, `Sub-Category`, `Region`, `Sales`, etc.

## Scripts & Explanations

### 1. Null Check (`1_has_nulls.sql`)

**Objective**: Identify rows with `null` values in key columns.  
**Notes**: Excludes non-critical columns (`Ship Mode`, `Postal Code`, `Sub-Category`) as `null`s here don't significantly affect the analysis.  
**Result**: Found 11 rows with `null`s in the non-critical `Postal Code` column.

---

### 2. Duplicate Check (`2_has_duplicates.sql`)

**Objective**: Identify duplicate entries at various granularities.

-   **Findings**:
    -   Total Orders: 9800
    -   Distinct Orders: 4922
    -   Duplicate Orders: 2423 (likely due to multi-product orders).
    -   Distinct (Order ID + Product ID) pairs: 9792 (8 duplicates).

---

### 3. Product Analysis (`3_products.sql`)

**Objective**: Rank products by total sales.

-   Temporary table created for reusable ranking.
-   **Findings**:
    -   Top 10 and worst 10 products by sales.

---

### 4. Category Analysis (`4_categories.sql`)

**Objective**: Rank categories by total sales.

-   Temporary table ranks categories.
-   **Findings**:
    -   Highest-performing category: `Technology`, Total Sales: `827455.87$`
    -   Lowest-performing category: `Office Supplies`, Total Sales: `705422.33`

---

### 5. Sub-Category Analysis (`5_subcategories.sql`)

**Objective**: Rank sub-categories by total sales.

-   Temporary table ranks sub-categories.
-   **Findings**:
    -   Top 3 sub-categories: `Phones`, `Chairs`, `Storage`
    -   Bottom 3 sub-categories: `Fasteners`, `Labels`, `Envelopes`

---

### 6. Regional Analysis (`6_region.sql`)

**Objective**: Rank regions by total sales.

-   Temporary table ranks regions.
-   **Findings**:
    -   Highest-performing region: `West`, Total Sales: `710219.68$`
    -   Lowest-performing region: `South`, Total Sales: `389151.46$`

---

### 7. Monthly Sales Analysis (`7_monthly_sales.sql`)

**Objective**: Track monthly sales and calculate growth percentages.

-   Organizes data by Month and Year.
-   **Insights**:
    -   Month-on-Month (MoM) growth is inconsistent.
    -   Overall growth rate: ~484.49%.

---

### 8. Yearly Sales Analysis (`8_yearly_sales.sql`)

**Objective**: Track yearly sales and calculate growth percentages.

-   Organizes data by Year.
-   **Insights**:
    -   Consistent yearly growth of ~50.47%.
    -   2016 had lower sales compared to 2015.

## Key Insights

-   Month-on-Month sales growth is inconsistent, with an overall growth rate of ~484.49%.
-   Yearly sales growth is consistent at ~50.47%, but 2016 underperformed compared to 2015.

## Tools Used

-   SQL (for querying and analysis)
