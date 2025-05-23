-- Grant LOGIN access
USE NewsManagerDB;
GO
CREATE USER NewsManagerDBWriter FOR LOGIN NewsManagerDBWriter;
CREATE USER NewsManagerDBReadOnly FOR LOGIN NewsManagerDBReadOnly;
GO

-- Grant user permissions via ROLE
ALTER ROLE db_datawriter ADD MEMBER NewsManagerDBWriter;
ALTER ROLE db_datareader ADD MEMBER NewsManagerDBWriter;
ALTER ROLE db_ddladmin ADD MEMBER NewsManagerDBWriter;
ALTER ROLE db_datareader ADD MEMBER NewsManagerDBReadOnly;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE TO [NewsManagerDBWriter];
Go
