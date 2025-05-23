-- Grant LOGIN access
USE WebstoreDB;
GO
CREATE USER WebstoreDBWriter FOR LOGIN WebstoreDBWriter;
CREATE USER WebstoreDBReadOnly FOR LOGIN WebstoreDBReadOnly;
GO

-- Grant user permissions via ROLE
ALTER ROLE db_datawriter ADD MEMBER WebstoreDBWriter;
ALTER ROLE db_datareader ADD MEMBER WebstoreDBWriter;
ALTER ROLE db_ddladmin ADD MEMBER WebstoreDBWriter;
ALTER ROLE db_datareader ADD MEMBER WebstoreDBReadOnly;
GO

-- Grant HakesAppDB access to WebstoreDBWriter
USE HakesAppDB;
GO
CREATE USER WebstoreDBWriter FOR LOGIN WebstoreDBWriter;
GO
ALTER ROLE db_datareader ADD MEMBER WebstoreDBWriter;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE TO [HakesAppDBWriter];
GO
