DECLARE @DB_Users TABLE (ServerName SYSNAME, LogInAtServerLevel SYSNAME, UserAtDBLevel SYSNAME, [Database] SYSNAME, DatabaseRoleMembership SYSNAME)
 
INSERT @DB_Users
  EXEC sp_MSforeachdb
 
'
USE [?]
SELECT
    CONVERT(VARCHAR(250), SERVERPROPERTY(''ServerName'')) AS ServerName,
 susers.[name]                                         AS LogInAtServerLevel,
 users.[name]                                          AS UserAtDBLevel,
-- DB_NAME()                                             AS [Database],         
 ''?''                                                 AS [Database],      
 roles.name                                            AS DatabaseRoleMembership
FROM sys.database_principals users
       INNER JOIN sys.database_role_members link ON link.member_principal_id = users.principal_id
       INNER JOIN sys.database_principals roles  ON roles.principal_id       = link.role_principal_id
       INNER JOIN sys.server_principals susers   ON susers.sid               = users.sid
WHERE --users.type_desc IN (''WINDOWS_USER'',''SQL_USER'')
      --AND

susers.[name] NOT IN (''sa'',''NT Service\MSSQLSERVER'',''NT SERVICE\SQLSERVERAGENT'',''NT SERVICE\SQLWriter'',''NT SERVICE\Winmgmt'',''NT AUTHORITY\SYSTEM'',''NT AUTHORITY\NETWORK SERVICE'')
   AND susers.[name] NOT LIKE ''##%''
'
 

SELECT ServerName, LogInAtServerLevel, UserAtDBLevel, [Database], DatabaseRoleMembership
FROM @DB_Users user1
where LogInAtServerLevel in('ddeniyanto')
GROUP BY ServerName,LogInAtServerLevel, UserAtDBLevel, [Database], DatabaseRoleMembership
ORDER BY ServerName,LogInAtServerLevel, UserAtDBLevel, [Database], DatabaseRoleMembership