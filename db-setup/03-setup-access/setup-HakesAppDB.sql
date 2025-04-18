-- Grant LOGIN access
USE HakesAppDB;
GO
CREATE USER HakesAppDBWriter FOR LOGIN HakesAppDBWriter;
CREATE USER HakesAppDBReadOnly FOR LOGIN HakesAppDBReadOnly;
GO

-- Grant user permissions via ROLE
ALTER ROLE db_datawriter ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_ddladmin ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBReadOnly;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE TO [HakesAppDBWriter];
GO
