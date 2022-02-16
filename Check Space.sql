--Run below script to any database, you will get result for all the database
--DBCC SQLPERF(LOGSPACE)

/*
SELECT DB_NAME(database_id) AS DatabaseName,
SUM((size*8)/1024.0/1024.0) SizeGB
FROM sys.master_files
WHERE DB_NAME(database_id) in (select name from sys.databases where name not in ('tempdb','master','msdb','model'))
group by DB_NAME(database_id)
*/

/*
SELECT DB_NAME() AS DbName,
name AS FileName,
size/128.0 AS CurrentSizeMB,
size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB
FROM sys.database_files;
GO
*/
