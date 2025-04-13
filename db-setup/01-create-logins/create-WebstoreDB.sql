-- Switch to master db
USE [master];
GO

-- Create the logins for WebstoreDB
CREATE LOGIN WebstoreDBWriter WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
CREATE LOGIN WebstoreDBReadOnly WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
GO
