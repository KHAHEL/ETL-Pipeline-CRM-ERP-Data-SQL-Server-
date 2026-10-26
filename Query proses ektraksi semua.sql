/*
===============================================================================
Stored Procedure: Load ekstraksi Layer (Source -> ekstraksi)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'ekstraksi' schema from external CSV files. 
    It performs the following actions:
    - Truncates the ekstraksi tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to ekstraksi tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC ekstraksi.load_ekstraksi;
===============================================================================
*/
CREATE OR ALTER PROCEDURE ekstraksi.load_ekstraksi AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME; 
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '================================================';
		PRINT 'Loading ekstraksi Layer';
		PRINT '================================================';

		PRINT '------------------------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ekstraksi.crm_cust_info';
		TRUNCATE TABLE ekstraksi.crm_cust_info;
		PRINT '>> Inserting Data Into: ekstraksi.crm_cust_info';
		BULK INSERT ekstraksi.crm_cust_info
		FROM 'C:\Users\akemi\OneDrive\Documents\Sem 4\ETL & DATAWAREHOUSE\Studi Kasus ETL\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ekstraksi.crm_prd_info';
		TRUNCATE TABLE ekstraksi.crm_prd_info;

		PRINT '>> Inserting Data Into: ekstraksi.crm_prd_info';
		BULK INSERT ekstraksi.crm_prd_info
		FROM 'C:\Users\akemi\OneDrive\Documents\Sem 4\ETL & DATAWAREHOUSE\Studi Kasus ETL\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

        SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ekstraksi.crm_sales_details';
		TRUNCATE TABLE ekstraksi.crm_sales_details;
		PRINT '>> Inserting Data Into: ekstraksi.crm_sales_details';
		BULK INSERT ekstraksi.crm_sales_details
		FROM 'C:\Users\akemi\OneDrive\Documents\Sem 4\ETL & DATAWAREHOUSE\Studi Kasus ETL\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		PRINT '------------------------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '------------------------------------------------';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ekstraksi.erp_loc_a101';
		TRUNCATE TABLE ekstraksi.erp_loc_a101;
		PRINT '>> Inserting Data Into: ekstraksi.erp_loc_a101';
		BULK INSERT ekstraksi.erp_loc_a101
		FROM 'C:\Users\akemi\OneDrive\Documents\Sem 4\ETL & DATAWAREHOUSE\Studi Kasus ETL\source_erp\LOC_A101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ekstraksi.erp_cust_az12';
		TRUNCATE TABLE ekstraksi.erp_cust_az12;
		PRINT '>> Inserting Data Into: ekstraksi.erp_cust_az12';
		BULK INSERT ekstraksi.erp_cust_az12
		FROM 'C:\Users\akemi\OneDrive\Documents\Sem 4\ETL & DATAWAREHOUSE\Studi Kasus ETL\source_erp\CUST_AZ12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ekstraksi.erp_px_cat_g1v2';
		TRUNCATE TABLE ekstraksi.erp_px_cat_g1v2;
		PRINT '>> Inserting Data Into: ekstraksi.erp_px_cat_g1v2';
		BULK INSERT ekstraksi.erp_px_cat_g1v2
		FROM 'C:\Users\akemi\OneDrive\Documents\Sem 4\ETL & DATAWAREHOUSE\Studi Kasus ETL\source_erp\PX_CAT_G1V2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================='
		PRINT 'Loading ekstraksi Layer is Completed';
        PRINT '   - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
	END TRY
	BEGIN CATCH
		PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING ekstraksi LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	END CATCH
END

EXEC ekstraksi.load_ekstraksi;
