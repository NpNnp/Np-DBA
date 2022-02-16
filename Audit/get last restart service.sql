

sELECT sqlserver_start_time FROM sys.dm_os_sys_info

use master
go
SELECT login_time as [SQL Server Instance Uptime] FROM sys.sysprocesses where spid=1;

select sqlserver_start_time as  [SQL Server Instance Uptime] from sys.dm_os_sys_info

EXEC xp_ReadErrorLog 0, 1, N'SQL',N'Starting' 