-- Grant LOGIN access
USE PBAutoUpdateDB;
GO
CREATE USER PBAutoUpdateDBWriter FOR LOGIN PBAutoUpdateDBWriter;
CREATE USER PBAutoUpdateDBReadOnly FOR LOGIN PBAutoUpdateDBReadOnly;
GO

-- Grant user permissions via ROLE
ALTER ROLE db_datawriter ADD MEMBER PBAutoUpdateDBWriter;
ALTER ROLE db_datareader ADD MEMBER PBAutoUpdateDBWriter;
ALTER ROLE db_ddladmin ADD MEMBER PBAutoUpdateDBWriter;
ALTER ROLE db_datareader ADD MEMBER PBAutoUpdateDBReadOnly;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE TO [PBAutoUpdateDBWriter];
Go
