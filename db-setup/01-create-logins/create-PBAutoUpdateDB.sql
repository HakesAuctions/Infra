-- Switch to master db
USE [master];
GO

-- Create the logins for PBAutoUpdateDB
CREATE LOGIN PBAutoUpdateDBWriter WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
CREATE LOGIN PBAutoUpdateDBReadOnly WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
GO
