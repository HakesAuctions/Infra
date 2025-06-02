-- Switch to master db
USE [master];
GO

-- Create the logins for HakesAppDB
CREATE LOGIN HakesAppDBWriter WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
CREATE LOGIN HakesAppDBReadOnly WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
CREATE LOGIN HakesAppDBHakesItemService WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
GO
