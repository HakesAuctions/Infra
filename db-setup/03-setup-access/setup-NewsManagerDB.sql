-- Grant LOGIN access
USE NewsManagerDB;
GO
CREATE USER NewsManagerDBWriter FOR LOGIN NewsManagerDBWriter;
CREATE USER NewsManagerDBReadOnly FOR LOGIN NewsManagerDBReadOnly;
GO

-- Grant user permissions via ROLE
ALTER ROLE db_datawriter ADD MEMBER NewsManagerDBWriter;
ALTER ROLE db_datareader ADD MEMBER NewsManagerDBWriter;
ALTER ROLE db_datareader ADD MEMBER NewsManagerDBReadOnly;
GO

-- Grant EXECUTE permissions
GRANT EXECUTE TO [NewsManagerDBWriter];
Go

-- Update Procedure from db dump NewsManagerDB_Hakes.bak
ALTER Procedure [dbo].[s_InitImageRecord]
    @ArticleID int,
    @ImageBinary varbinary = NULL
AS
BEGIN
    INSERT INTO Images(ArticleID,ImageBinary,IsSplash)
    VALUES (@ArticleID,@ImageBinary,0)
    RETURN (Select @@identity as ImageID)
END
