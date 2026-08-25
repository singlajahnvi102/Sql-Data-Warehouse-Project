/*
================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
================================================================================

Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the 'BULK INSERT' command to load data from CSV files to bronze tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
================================================================================
*/

Exec bronze.load_bronze
Create or Alter procedure bronze.load_bronze AS
BEGIN
Print'===========================================';
Print'Loading Bronze Layer';
Print'==========================================';
print'------------------------------------------';
print 'Loading CRM Tables';
print'------------------------------------------';

PRINT '>> Truncating Table: bronze.crm_cust_info';
TRUNCATE TABLE bronze.crm_cust_info;

PRINT '>> Inserting Data into: bronze.crm_cust_info';
BULK INSERT bronze.crm_cust_info
FROM 'C:\Users\singl\Downloads\CSQLDATA\cust_info.csv'
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);



PRINT '>> Truncating Table: bronze.crm_prd_info';
TRUNCATE TABLE bronze.crm_prd_info;

PRINT '>> Inserting Data into:bronze.crm_prd_info ';
BULK INSERT bronze.crm_prd_info
FROM "C:\Users\singl\Downloads\CSQLDATA\prd_info.csv"
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


PRINT '>> Truncating Table: bronze.crm_sales_details';
TRUNCATE TABLE bronze.crm_sales_details;

PRINT '>> Inserting Data into:bronze.crm_sales_details';
BULK INSERT bronze.crm_sales_details
FROM "C:\Users\singl\Downloads\CSQLDATA\sales_details.csv"
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


print'------------------------------------------';
print 'Loading erp Tables';
print'------------------------------------------';

PRINT '>> Truncating Table: bronze.erp_loc_A101';
TRUNCATE TABLE bronze.erp_loc_A101;

PRINT '>> Inserting Data into:bronze.erp_loc_A101';
BULK INSERT bronze.erp_loc_A101
FROM "C:\Users\singl\Downloads\CSQLDATA\LOC_A101.csv"
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


PRINT '>> Truncating Table:bronze.erp_PX_CAT_G1V2 ';
TRUNCATE TABLE bronze.erp_PX_CAT_G1V2;

PRINT '>> Inserting Data into:bronze.erp_PX_CAT_G1V2';
BULK INSERT bronze.erp_PX_CAT_G1V2
FROM "C:\Users\singl\Downloads\CSQLDATA\PX_CAT_G1V2.csv"
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);


PRINT '>> Truncating Table:bronze.erp_CUST_AZ12';
TRUNCATE TABLE bronze.erp_CUST_AZ12;

PRINT '>> Inserting Data into:bronze.erp_CUST_AZ12';
BULK INSERT bronze.erp_CUST_AZ12
FROM "C:\Users\singl\Downloads\CSQLDATA\CUST_AZ12.csv"
WITH
(
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    TABLOCK
);
END
