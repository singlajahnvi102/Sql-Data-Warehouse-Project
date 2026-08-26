/*
========================================================================================
Quality Checks
========================================================================================

Script Purpose:
    This script performs various quality checks for data consistency, accuracy,
    and standardization across the 'silver' schemas. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
========================================================================================
*/

--checking Table silver.crm_cust_info
-- Check for Nulls or Duplicates in Pimary key
--expectation: No Result
SELECT   cst_id,
         count(*)
FROM     silver.crm_cust_info
GROUP BY cst_id
HAVING   count(*) > 1
         OR cst_id IS NULL;

--check for unwanted spaces
--expectation:No Result
SELECT cst_firstname
FROM   silver.crm_cust_info
WHERE  cst_firstname != TRIM(cst_firstname);

--data standardization & consistency
SELECT DISTINCT gndr
FROM   silver.crm_cust_info;

--checking Table silver.crm_prd_info
-- Check for Nulls or Duplicates in Pimary key
--expectation: No Result
SELECT   prd_id,
         count(*)
FROM     silver.crm_prd_info
GROUP BY prd_id
HAVING   count(*) > 1
         OR prd_id IS NULL;

--check for unwanted spaces
--expectation:No Result
SELECT prd_nm
FROM   silver.crm_prd_info
WHERE  prd_nm != TRIM(prd_nm);

--check from nulls or -ve number
SELECT prd_cost
FROM   silver.crm_prd_info
WHERE  prd_cost < 0
       OR prd_cost IS NULL;

--data standardization & consistency
SELECT DISTINCT prd_line
FROM   silver.crm_prd_info;

--check for invalid date
SELECT *
FROM   silver.crm_prd_info
WHERE  prd_end_dt < prd_start_dt;

--Checking Table silver.crm_sales_details
SELECT sls_order_dt
FROM   silver.crm_sales_details
WHERE  sls_order_dt <= 0
       OR len(sls_order_dt) != 8;

--check data consistency : Between Sales,Quantity and Price
-->>sales=Quantity*Price
-->>values must not be null,zero or negative
SELECT sls_sales,
       sls_quantity,
       sls_price
FROM   silver.crm_sales_details
WHERE  sls_sales != sls_quantity * sls_price
       OR sls_sales IS NULL
       OR sls_quantity IS NULL
       OR sls_price IS NULL
       OR sls_quantity <= 0
       OR sls_price <= 0
       OR sls_sales <= 0;

--checking table silver.erp_cust_az12
--identify out of range dates
SELECT DISTINCT bdate
FROM   silver.erp_cust_az12
WHERE  bdate < '1924-01-01'
       OR bdate > GETDATE();

--data standardization & consistency
SELECT DISTINCT gen
FROM   silver.erp_cust_az12;

--Checking Table [silver].[erp_loc_A101]
--data standardization & consistency
SELECT   DISTINCT cntry
FROM     [silver].[erp_loc_A101]
ORDER BY cntry;

-- Checking Table [silver].[erp_PX_CAT_G1V2]
--check for unwanted spaces
--expectation:No Result
SELECT cat
FROM   [silver].[erp_PX_CAT_G1V2]
WHERE  cat != TRIM(cat)
       OR subcat != TRIM(subcat)
       OR Maintenance != TRIM(Maintenance);

--data standardization & consistency
SELECT DISTINCT cat
FROM   [silver].[erp_PX_CAT_G1V2];

SELECT DISTINCT subcat
FROM   [silver].[erp_PX_CAT_G1V2];

SELECT DISTINCT Maintenance
FROM   [silver].[erp_PX_CAT_G1V2];



