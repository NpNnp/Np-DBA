

--====================step1 check aggregate log size
declare @logspace table (DBName nvarchar(100),LogSizeMB float,[LogSpaceUsed%] float,[Status] bit)
insert into @logspace
EXEC('DBCC SQLPERF(LOGSPACE);')
select * from @logspace
order by [LogSpaceUsed%] desc
--=====================get exactly name log and a
use Linknet_MSCRM
-- method 1, check log file size
SELECT DB_NAME() AS DbName, 
    name AS FileName, 
    type_desc,
    size/128.0 AS CurrentSizeMB,  
	CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 SpaceUsedMB,
    size/128.0 - CAST(FILEPROPERTY(name, 'SpaceUsed') AS INT)/128.0 AS FreeSpaceMB
FROM sys.database_files

--=====================exec
/*
ALTER DATABASE NOVA SET RECOVERY SIMPLE 
DBCC SHRINKFILE('NOVA_log',2) 
ALTER DATABASE NOVA SET RECOVERY FULL
*/