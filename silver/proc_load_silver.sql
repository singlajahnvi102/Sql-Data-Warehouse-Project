/*
========================================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
========================================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to
    populate the 'silver' schema tables from the 'bronze' schema.
Actions Performed:
    - Truncates Silver tables.
    - Inserts transformed and cleansed data from Bronze into Silver tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
================================================================================
*/

Create or Alter Procedure silver.load_silver AS
Begin
PRINT '>> Truncating Table:silver.crm_cust_info';

TRUNCATE TABLE silver.crm_cust_info;

PRINT '>>Inserting Data Into:silver.crm_cust_info';

INSERT INTO silver.crm_cust_info (cst_id, cst_key, cst_firstname, cst_last_name, cst_marital_status, cst_gndr, cst_create_date)
SELECT cst_id,
       cst_key,
       TRIM(cst_firstname) AS cst_firstname,
       TRIM(cst_last_name) AS cst_last_name,
       CASE WHEN UPPER(TRIM(cst_marital_status)) = 'M' THEN 'Married' WHEN UPPER(TRIM(cst_marital_status)) = 'S' THEN 'Single' ELSE 'n/a' END AS cst_marital_status,
       CASE WHEN UPPER(TRIM(cst_gndr)) = 'F' THEN 'Female' WHEN UPPER(TRIM(cst_gndr)) = 'M' THEN 'Male' ELSE 'n/a' END AS cst_gndr,
       cst_create_date
FROM   (SELECT *,
               ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
        FROM   bronze.crm_cust_info
        WHERE  cst_id IS NOT NULL) AS t
WHERE  flag_last = 1;

PRINT '>> Truncating Table:silver.crm_prd_info';

TRUNCATE TABLE silver.crm_prd_info;

PRINT '>>Inserting Data Into:silver.crm_prd_info';

INSERT INTO silver.crm_prd_info (prd_id, cat_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
SELECT prd_id,
       Replace(substring(prd_key, 1, 5), '-', '_') AS cat_id,
       substring(prd_key, 7, lEN(prd_key)) AS prd_key,
       prd_nm,
       ISNULL(prd_cost, 0) AS prd_cost,
       CASE WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain' WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road' WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales' WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring' ELSE 'n/a' END AS prd_line,
       CAST (prd_start_dt AS DATE) AS prd_start_dt,
       CAST (lead(prd_start_dt) OVER (PARTITION BY prd_key ORDER BY prd_start_dt) - 1 AS DATE) AS prd_end_dt
FROM   bronze.crm_prd_info;

PRINT '>> Truncating Table:silver.sales_details';

TRUNCATE TABLE silver.crm_sales_details;

PRINT '>>Inserting Data Into:silver.crm_sales_details';

INSERT INTO silver.crm_sales_details (sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price)
SELECT sls_ord_num,
       sls_prd_key,
       sls_cust_id,
       CASE WHEN sls_order_dt = 0
                 OR len(sls_order_dt) != 8 THEN NULL ELSE CAST (CAST (sls_order_dt AS VARCHAR) AS DATE) END AS sls_order_dt,
       CASE WHEN sls_ship_dt = 0
                 OR len(sls_ship_dt) != 8 THEN NULL ELSE CAST (CAST (sls_ship_dt AS VARCHAR) AS DATE) END AS sls_ship_dt,
       CASE WHEN sls_due_dt = 0
                 OR len(sls_due_dt) != 8 THEN NULL ELSE CAST (CAST (sls_due_dt AS VARCHAR) AS DATE) END AS sls_due_dt,
       CASE WHEN sls_sales IS NULL
                 OR sls_sales <= 0
                 OR sls_sales != sls_quantity * ABS(sls_price) THEN sls_quantity * ABS(sls_price) ELSE sls_sales END AS sal_sales,
       sls_quantity,
       CASE WHEN sls_price IS NULL
                 OR sls_price <= 0 THEN sls_sales / NULLIF (sls_quantity, 0) ELSE sls_price END AS sls_price
FROM   bronze.crm_sales_details;

PRINT '>> Truncating Table:silver.erp_CUST_AZ12';

TRUNCATE TABLE silver.erp_CUST_AZ12;

PRINT '>>Inserting Data Into:silver.erp_CUST_AZ12';

INSERT INTO [silver].[erp_CUST_AZ12] (cid, bdate, gen)
SELECT CASE WHEN cid LIKE 'NAS%' THEN substring(cid, 4, len(cid)) ELSE cid END AS cid,
       CASE WHEN bdate > getdate() THEN NULL ELSE bdate END AS bdate,
       CASE WHEN UPPER(TRIM(GEN)) IN ('F', 'Female') THEN 'Female' WHEN UPPER(TRIM(GEN)) IN ('M', 'Male') THEN 'Male' ELSE 'n/a' END AS gen
FROM   [bronze].[erp_CUST_AZ12];

PRINT '>> Truncating Table:silver.erp_loc_A101';

TRUNCATE TABLE silver.erp_loc_A101;

PRINT '>>Inserting Data Into:silver.erp_loc_A101';

INSERT INTO [silver].[erp_loc_A101] (cid, cntry)
SELECT replace(cid, '-', '') AS cid,
       CASE WHEN TRIM(cntry) = 'DE' THEN 'Germany' WHEN TRIM(cntry) IN ('USA', 'US') THEN 'UnitedStates' WHEN TRIM(cntry) = ''
                                                                                                              OR cntry IS NULL THEN 'n/a' ELSE cntry END AS cntry
FROM   [bronze].[erp_loc_A101];
PRINT '>> Truncating Table:silver.erp_PX_CAT_G1V2';

TRUNCATE TABLE silver.erp_PX_CAT_G1V2;

PRINT '>>Inserting Data Into:silver.erp_PX_CAT_G1V2';

INSERT INTO [silver].[erp_PX_CAT_G1V2] (ID, CAT, SUBCAT, MAINTENANCE)
SELECT ID,
       CAT,
       SUBCAT,
       MAINTENANCE
FROM   [bronze].[erp_PX_CAT_G1V2]; 
END
