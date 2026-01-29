USE DataWarehouse;
GO

TRUNCATE TABLE [bronze].[crm_cust_info];
GO 

BULK INSERT [bronze].[crm_cust_info]
from 'D:\datasets\source_crm\cust_info.csv'
WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
);
GO

TRUNCATE TABLE [bronze].[crm_prd_info];
GO 

BULK INSERT [bronze].[crm_prd_info]
from 'D:\datasets\source_crm\prd_info.csv'
WITH(
	FIRSTROW=2,
	FIELDTERMINATOR=',',
	TABLOCK
);
GO
