-------------------------------------------------------------
select
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
from [bronze].[crm_sales_details]
--------------------------------------------------------------------------
SELECT
	prd_id,
	prd_key,
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
from bronze.[crm_prd_info]
-----------------------------------------------------------------------------------
SELECT
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
from[bronze].[crm_cust_info]
) AS t
where rn=1
----------------------------------------------------------------
select
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
from 
[bronze].[erp_CUST_AZ12]
---------------------------------------------------------------------
select *
from [bronze].[erp_LOC_A101]



select CID,COUNT(*) as c
from [bronze].[erp_CUST_AZ12]
group by CID
having COUNT(*) >1 



select *--MIN(BDATE),MAX(BDATE)
from [bronze].[erp_CUST_AZ12]
where BDATE>GETDATE()

where CID<>TRIM(CID)

select top 100 *
from [bronze].[erp_LOC_A101]

select top 100 *
from [bronze].[erp_CUST_AZ12]



select distinct cst_gndr
from [bronze].[crm_cust_info]


select *
from bronze.[crm_prd_info]
where prd_cost is null or prd_cost<0

select *
from bronze.[crm_prd_info]
where TRIM(REPLACE(substring(prd_key,1,5),'-','_')) not in (select distinct ID from bronze.[erp_PX_CAT_G1V2])


select *,substring(prd_key,7,LEN(prd_key)) -- added column
from bronze.[crm_prd_info]

select prd_key,COUNT(*) conta
from bronze.[crm_prd_info]
group by prd_key
HAVING COUNT(*) > 1


select top 100 *
from [bronze].[erp_PX_CAT_G1V2]
