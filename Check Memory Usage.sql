
--select * from  sys.dm_os_sys_memory

select
(SELECT (total_physical_memory_kb / 1024)  FROM sys.dm_os_sys_memory) as Server_Physical_MB,
CAST((SELECT [value] FROM sys.configurations WHERE [name] = 'min server memory (MB)') AS BIGINT) as SQL_MinMemory_MB
,(SELECT cntr_value / 1024 FROM sys.dm_os_performance_counters WHERE counter_name = 'Total Server Memory (KB)') as SQL_UsedMemory_MB
,CAST((SELECT [value] FROM sys.configurations WHERE [name] = 'max server memory (MB)') AS BIGINT) as SQL_MaxMemory_MB,
--(physical_memory_in_use_kb/1024)Phy_Memory_usedby_Sqlserver_MB,
--(virtual_address_space_committed_kb/1024 )Total_Memory_UsedBySQLServer_MB,
memory_utilization_percentage ,
(locked_page_allocations_kb/1024 )Locked_pages_used_Sqlserver_MB,
process_physical_memory_low,
process_virtual_memory_low
from sys. dm_os_process_memory

/*
-- Memory used by each database
SELECT DB_NAME(database_id),
COUNT (1) * 8 / 1024 AS MBUsed
FROM sys.dm_os_buffer_descriptors
GROUP BY database_id
ORDER BY COUNT (*) * 8 / 1024 DESC
GO
*/