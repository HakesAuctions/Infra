-- Switch to master db
USE [master];
GO

-- Create the logins for NewsManagerDB
CREATE LOGIN NewsManagerDBWriter WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
CREATE LOGIN NewsManagerDBReadOnly WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
GO
