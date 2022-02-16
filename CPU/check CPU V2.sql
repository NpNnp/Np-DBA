WITH DB_CPU AS
(SELECT	DatabaseID, 
		DB_Name(DatabaseID)AS [DatabaseName], 
		SUM(total_worker_time)AS [CPU_Time(Ms)] 
FROM	sys.dm_exec_query_stats AS qs 
CROSS APPLY(SELECT	CONVERT(int, value)AS [DatabaseID]  
			FROM	sys.dm_exec_plan_attributes(qs.plan_handle)  
			WHERE	attribute =N'dbid')AS epa GROUP BY DatabaseID) 
SELECT	ROW_NUMBER()OVER(ORDER BY [CPU_Time(Ms)] DESC)AS [SNO], 
	DatabaseName AS [DBName], [CPU_Time(Ms)], 
	CAST([CPU_Time(Ms)] * 1.0 /SUM([CPU_Time(Ms)]) OVER()* 100.0 AS DECIMAL(5, 2))AS [CPUPercent] 
FROM	DB_CPU 
WHERE	DatabaseID > 4 -- system databases 
	AND DatabaseID <> 32767 -- ResourceDB 
ORDER BY SNO OPTION(RECOMPILE); 