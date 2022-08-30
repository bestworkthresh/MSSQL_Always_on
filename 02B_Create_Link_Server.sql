USE [master]
GO

/****** Object:  LinkedServer [DB3]    Script Date: 2022/2/14 ¤W¤È 11:02:49 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'DB3', @srvproduct=N'MS SQL', @provider=N'SQLNCLI', @datasrc=N'172.18.22.123'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'DB3',@useself=N'False',@locallogin=NULL,@rmtuser=N'FMS',@rmtpassword='########'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'rpc', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'rpc out', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'DB3', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


