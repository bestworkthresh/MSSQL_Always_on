use FRSCUST
go 

CREATE role db_EXECUTE;
GO

exec sp_addrolemember N'db_EXECUTE',N'dbop5';
GO 
GRANT EXECUTE ON SCHEMA::dbo TO db_EXECUTE;
GO 

--exec sp_droprolemember N'db_execproc',N'dbop5';



use FRSMETA
go 

Create role db_EXECUTE;
GO
exec sp_addrolemember N'db_EXECUTE',N'dbop5';
GO 
GRANT EXECUTE ON SCHEMA::dbo TO db_EXECUTE;
GO 

