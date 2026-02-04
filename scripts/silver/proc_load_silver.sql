/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
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
===============================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	BEGIN TRY
		-------------------------------------------------------------
		TRUNCATE TABLE [silver].[crm_sales_details];

		INSERT INTO [silver].[crm_sales_details]
		SELECT
			sls_ord_num,
			sls_prd_key,
			sls_cust_id,
			CASE 
				WHEN sls_order_dt = 0 OR LEN(sls_order_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
			END AS sls_order_dt,
			CASE 
				WHEN sls_ship_dt = 0 OR LEN(sls_ship_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
			END AS sls_ship_dt,
			CASE 
				WHEN sls_due_dt = 0 OR LEN(sls_due_dt) != 8 THEN NULL
				ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
			END AS sls_due_dt,
			CASE 
				WHEN sls_sales IS NULL OR sls_sales <= 0 OR sls_sales != sls_quantity * ABS(sls_price) 
					THEN sls_quantity * ABS(sls_price)
				ELSE sls_sales
			END AS sls_sales, -- Recalculate sales if original value is missing or incorrect
			sls_quantity,
			CASE 
				WHEN sls_price IS NULL OR sls_price <= 0 
					THEN CAST(sls_sales / NULLIF(sls_quantity, 0) AS DECIMAL(10,2))
			ELSE ROUND(sls_price,2)  -- Derive price if original value is invalid
			END AS sls_price
		FROM [bronze].[crm_sales_details];
		--------------------------------------------------------------------------
		TRUNCATE TABLE [silver].[crm_prd_info];		

		INSERT INTO  [silver].[crm_prd_info]
		SELECT
			prd_id,
			substring(prd_key,7,LEN(prd_key)) prd_key,
			REPLACE(substring(prd_key,1,5),'-','_') cat_id,
			prd_nm,
			prd_cost,
			CASE 
				WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
				WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
				WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
				WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
				ELSE 'n/a'
			END AS prd_line,
			prd_start_dt,
			DATEADD(day,-1,LEAD(prd_start_dt,1) OVER(PARTITION BY prd_key ORDER BY prd_start_dt)) AS pd_end_dt
		FROM bronze.[crm_prd_info];
		-----------------------------------------------------------------------------------
		TRUNCATE TABLE [silver].[crm_cust_info];
		
		INSERT INTO  [silver].[crm_cust_info]
		SELECT
			cst_id,
			cst_key,
			TRIM(cst_firstname) cst_firstname,
			TRIM(cst_lastname) cst_lastname,
			CASE
				WHEN UPPER(TRIM(cst_marital_status))='M' THEN 'Married'
				WHEN UPPER(TRIM(cst_marital_status))='S' THEN 'Single'
				ELSE 'n/a'
			END AS cst_marital_status,
			CASE
				WHEN UPPER(TRIM(cst_gndr))='M' THEN 'Male'
				WHEN UPPER(TRIM(cst_gndr))='F' THEN 'Female'
				ELSE 'n/a'
			END AS cst_gndr,
			cst_create_date
		FROM
		(
		select *,
			ROW_NUMBER() OVER(PARTITION BY cst_id ORDER BY cst_create_date desc) as rn
		FROM [bronze].[crm_cust_info]
		) AS t
		where rn=1;
		----------------------------------------------------------------
		TRUNCATE TABLE [silver].[erp_CUST_AZ12];
		
		INSERT INTO  [silver].[erp_CUST_AZ12]
		SELECT
			REPLACE(CID,'NAS','') AS CID,
			CASE
				WHEN BDATE> GETDATE() THEN NULL
				ELSE BDATE
			END AS BDATE,
			CASE
				WHEN UPPER(TRIM(GEN)) IN ('Male','M') THEN 'Male'
				WHEN UPPER(TRIM(GEN)) IN ('Female','F') THEN 'Female'
				ELSE 'n/a'
			END GEN
		FROM [bronze].[erp_CUST_AZ12];
		---------------------------------------------------------------------
		TRUNCATE TABLE [silver].[erp_LOC_A101];
		
		INSERT INTO  [silver].[erp_LOC_A101]
		SELECT 
			REPLACE(CID,'-','') AS CID,
			CASE 
				WHEN TRIM(CNTRY) ='DE' THEN 'Germany'
				WHEN TRIM(CNTRY) ='USA' THEN 'United States'
				WHEN TRIM(CNTRY) ='US' THEN 'United States'
				WHEN TRIM(CNTRY) ='' OR TRIM(CNTRY) is NULL THEN 'n/a'
			ELSE TRIM(CNTRY) END as CNTRY
		FROM [bronze].[erp_LOC_A101];
		--------------------------------------------------------
		TRUNCATE TABLE [silver].[erp_PX_CAT_G1V2];

		INSERT INTO  [silver].[erp_PX_CAT_G1V2]
		SELECT
			ID,
			CAT,
			SUBCAT,
			MAINTENANCE
		FROM [bronze].[erp_PX_CAT_G1V2];
	END TRY

	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END
