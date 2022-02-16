EXEC MASTER..xp_fixeddrives
GO

--====================check aggregate log size
declare @logspace table (DBName nvarchar(100),LogSizeMB float,[LogSpaceUsed%] float,[Status] bit)
insert into @logspace
EXEC('DBCC SQLPERF(LOGSPACE);')
select * from @logspace
order by LogSizeMB desc


/*

ALTER DATABASE Linknet_MSCRM SET RECOVERY SIMPLE 
DBCC SHRINKFILE('MSCRM_Log',2) 
ALTER DATABASE Linknet_MSCRM SET RECOVERY FULL
*/