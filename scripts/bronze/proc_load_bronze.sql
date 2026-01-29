/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/


CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME2, @end_time DATETIME2, @batch_start_time DATETIME2,@batch_end_time DATETIME2
	BEGIN TRY
		SET @batch_start_time= GETDATE()
		SET @start_time= GETDATE()
		print'=========================================='
		PRINT 'Truncating table: [bronze].[crm_cust_info]'
		TRUNCATE TABLE [bronze].[crm_cust_info];
		PRINT 'inserting data into table: [bronze].[crm_cust_info]'
		BULK INSERT [bronze].[crm_cust_info]
		from 'D:\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE()
		PRINT 'Load duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR(50)) + ' Seconds'

		SET @start_time= GETDATE()
		print'=========================================='
		PRINT 'Truncating table: [bronze].[crm_prd_info]'
		TRUNCATE TABLE [bronze].[crm_prd_info];
		BULK INSERT [bronze].[crm_prd_info]
		from 'D:\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE()
		PRINT 'Load duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR(50)) + ' Seconds'


		SET @start_time= GETDATE()
		print'=========================================='
		PRINT 'Truncating table: [bronze].[crm_sales_details]'
		TRUNCATE TABLE [bronze].[crm_sales_details];
		BULK INSERT [bronze].[crm_sales_details]
		from 'D:\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE()
		PRINT 'Load duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR(50)) + ' Seconds'

		SET @start_time= GETDATE()
		PRINT'=========================================='
		PRINT 'Truncating table: [bronze].[erp_CUST_AZ12]'
		TRUNCATE TABLE [bronze].[erp_CUST_AZ12];
		BULK INSERT [bronze].[erp_CUST_AZ12]
		from 'D:\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE()
		PRINT 'Load duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR(50)) + ' Seconds'


		SET @start_time= GETDATE()
		PRINT'=========================================='
		PRINT 'Truncating table: [bronze].[erp_LOC_A101]'
		TRUNCATE TABLE [bronze].[erp_LOC_A101];
		BULK INSERT [bronze].[erp_LOC_A101]
		from 'D:\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE()
		PRINT 'Load duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR(50)) + ' Seconds'

		SET @start_time= GETDATE()
		PRINT'=========================================='
		PRINT 'Truncating table: [bronze].[erp_PX_CAT_G1V2]'
		TRUNCATE TABLE [bronze].[erp_PX_CAT_G1V2];
		BULK INSERT [bronze].[erp_PX_CAT_G1V2]
		from 'D:\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
		SET @end_time=GETDATE()
		PRINT 'Load duration: '+ CAST(DATEDIFF(SECOND,@start_time,@end_time) AS VARCHAR(50)) + ' Seconds'
		PRINT'=========================================='

		SET @batch_end_time= GETDATE()
		PRINT 'Batch load duration: '+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS VARCHAR(50)) + ' Seconds'

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
