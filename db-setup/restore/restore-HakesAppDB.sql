-- Switch to master db
USE [master];
GO

-- Delete existing db
exec msdb.dbo.rds_drop_database @db_name='HakesAppDB';
go

-- https://aws.amazon.com/blogs/database/migrating-sql-server-to-amazon-rds-using-native-backup-and-restore/
exec msdb.dbo.rds_restore_database
	@restore_db_name='HakesAppDB',
	@s3_arn_to_restore_from='arn:aws:s3:::hakes-prd-appdb-backup/Hakes_Test_20250315.bak',
	@with_norecovery=0,
    @type='FULL';
go

EXEC msdb.dbo.rds_task_status;
