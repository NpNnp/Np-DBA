USE [master]
GO

/****** Object:  LinkedServer [BMJKT-000139]    Script Date: 14/09/2021 13:41:55 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'BMJKT-000139', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'BMJKT-000139',@useself=N'False',@locallogin=NULL,@rmtuser=N'appdev',@rmtpassword='L1nkn3t123'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'collation compatible', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'data access', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'dist', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'pub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'rpc', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'rpc out', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'sub', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'connect timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'collation name', @optvalue=null
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'lazy schema validation', @optvalue=N'false'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'query timeout', @optvalue=N'0'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'use remote collation', @optvalue=N'true'
GO

EXEC master.dbo.sp_serveroption @server=N'BMJKT-000139', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO


