USE [master]
GO

/****** Object:  LinkedServer [BMJKT-000244]    Script Date: 22/11/2021 9:52:08 ******/
EXEC master.dbo.sp_addlinkedserver @server = N'BMJKT-000047', @srvproduct=N'SQL Server'
 /* For security reasons the linked server remote logins password is changed with ######## */
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'BMJKT-000047',@useself=N'False',@locallogin=NULL,@rmtuser=N'DataReport',@rmtpassword='L1nkn3t123'
GO
