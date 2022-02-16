--CPU Cores Assigned
DECLARE @OnlineCpuCount int
DECLARE @LogicalCpuCount int

SELECT @OnlineCpuCount = COUNT(*) FROM sys.dm_os_schedulers WHERE status = 'VISIBLE ONLINE'
SELECT @LogicalCpuCount = cpu_count FROM sys.dm_os_sys_info 

SELECT @LogicalCpuCount AS 'ASSIGNED ONLINE CPU #', @OnlineCpuCount AS 'VISIBLE ONLINE CPU #',
   CASE 
     WHEN @OnlineCpuCount < @LogicalCpuCount 
     THEN 'You are not using all CPU assigned to O/S! If it is VM, review your VM configuration to make sure you are not maxout Socket'
     ELSE 'You are using all CPUs assigned to O/S. GOOD!' 
   END as 'CPU Usage Desc'

--Physical Memory (depends on SQL version)
select round(cast(physical_memory_kb as float)/1024/1024,0) RAM_GB from sys.dm_os_sys_info
--select round(cast(physical_memory_in_bytes as float)/1024/1024/1024,0) RAM_GB from sys.dm_os_sys_info

select @@VERSION

