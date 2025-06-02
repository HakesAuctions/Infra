-- Grant LOGIN access
USE HakesAppDB;
GO
CREATE USER HakesAppDBWriter FOR LOGIN HakesAppDBWriter;
CREATE USER HakesAppDBReadOnly FOR LOGIN HakesAppDBReadOnly;
CREATE USER HakesAppDBHakesItemService FOR LOGIN HakesAppDBHakesItemService;
GO

-- Grant user permissions via ROLE
ALTER ROLE db_datawriter ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_ddladmin ADD MEMBER HakesAppDBWriter;
ALTER ROLE db_datareader ADD MEMBER HakesAppDBReadOnly;
ALTER ROLE db_datawriter ADD MEMBER HakesAppDBHakesItemService;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE TO [HakesAppDBWriter];
GRANT EXECUTE TO [HakesAppDBHakesItemService];
GO
