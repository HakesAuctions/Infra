-- Create the logins for NewsManagerDB
CREATE LOGIN NewsManagerDBWriter WITH PASSWORD = 'StrongWritePassword';
CREATE LOGIN NewsManagerDBReadOnly WITH PASSWORD = 'StrongReadPassword';
GO
