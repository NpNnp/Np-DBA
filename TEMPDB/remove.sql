use tempdb
GO

DBCC DROPCLEANBUFFERS
GO

DBCC FREEPROCCACHE
GO

DBCC FREESESSIONCACHE
GO

DBCC FREESYSTEMCACHE ( 'ALL')
GO

DBCC SHRINKDATABASE (tempdb,8)
GO
-- Step1: First empty the data file
USE tempdb
GO
DBCC SHRINKFILE (temp8, EMPTYFILE); -- to empty “tempdev12” data file
GO
--Step2: Remove that extra data file from the database
ALTER DATABASE tempdb
REMOVE FILE temp8; --to delete “tempdev12” data file
GO

