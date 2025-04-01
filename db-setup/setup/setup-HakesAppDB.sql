-- Step 1: Create the database
--CREATE DATABASE HakesAppDB;
GO

-- Step 2: Create the login for the write user
CREATE LOGIN HakesAppDBWriter WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
GO

-- Step 3: Create the database user for HakesAppDBWriter
USE HakesAppDB;
GO
CREATE USER HakesAppDBWriter FOR LOGIN HakesAppDBWriter;
GO

-- Step 4: Grant write (db_datawriter) and read (db_datareader) access to HakesAppDBWriter
ALTER ROLE db_datawriter ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBWriter;
GO

-- Step 5: Create the login for the read-only user
CREATE LOGIN HakesAppDBReadOnly WITH PASSWORD = 'SeedPasswordThatWillBeChangedAfterSetup';
GO

-- Step 6: Create the database user for HakesAppDBReadOnly
USE HakesAppDB;
GO
CREATE USER HakesAppDBReadOnly FOR LOGIN HakesAppDBReadOnly;
GO

-- Step 7: Grant read-only access (db_datareader) to HakesAppDBReadOnly
ALTER ROLE db_datareader ADD MEMBER HakesAppDBReadOnly;
GO
