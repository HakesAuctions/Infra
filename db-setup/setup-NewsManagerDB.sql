-- Step 1: Create the database
CREATE DATABASE NewsManagerDB;
GO

-- Step 2: Create the login for the write user
CREATE LOGIN NewsManagerDBWriter WITH PASSWORD = 'StrongWritePassword';
GO

-- Step 3: Create the database user for NewsManagerDBWriter
USE NewsManagerDB;
GO
CREATE USER NewsManagerDBWriter FOR LOGIN NewsManagerDBWriter;
GO

-- Step 4: Grant write (db_datawriter) and read (db_datareader) access to NewsManagerDBWriter
ALTER ROLE db_datawriter ADD MEMBER NewsManagerDBWriter;
ALTER ROLE db_datareader ADD MEMBER NewsManagerDBWriter;
GO

-- Step 5: Create the login for the read-only user
CREATE LOGIN NewsManagerDBReadOnly WITH PASSWORD = 'StrongReadPassword';
GO

-- Step 6: Create the database user for NewsManagerDBReadOnly
USE NewsManagerDB;
GO
CREATE USER NewsManagerDBReadOnly FOR LOGIN NewsManagerDBReadOnly;
GO

-- Step 7: Grant read-only access (db_datareader) to NewsManagerDBReadOnly
ALTER ROLE db_datareader ADD MEMBER NewsManagerDBReadOnly;
GO
