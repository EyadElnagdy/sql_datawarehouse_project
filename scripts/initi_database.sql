/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'DataWarehouse' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas 
    within the database: 'bronze', 'silver', and 'gold'.
	
WARNING:
    Running this script will drop the entire 'DataWarehouse' database if it exists. 
    All data in the database will be permanently deleted. Proceed with caution 
    and ensure you have proper backups before running this script.
*/

USE master;
GO

DROP DATABASE IF EXISTS DataWarehouse;
GO

CREATE DATABASE DataWarehouse;
GO

USE Datawarehouse;
GO

DROP SCHEMA IF EXISTS bronze;
GO
CREATE SCHEMA bronze;
GO

DROP SCHEMA IF EXISTS silver;
GO
CREATE SCHEMA silver;
GO

DROP SCHEMA IF EXISTS gold;
GO
CREATE SCHEMA gold;
GO
