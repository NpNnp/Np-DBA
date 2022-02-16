--dbcc dbreindex ('dbo.AspNetUsers')

SELECT Sch.name as 'Schema',
Tbls.name as 'Table',
Indx.name as 'Index',
indexstat.avg_fragmentation_in_percent
FROM sys.dm_db_index_physical_stats (DB_ID(), NULL, NULL, NULL, NULL) AS indexstat
INNER JOIN sys.tables Tbls on Tbls.object_id = indexstat.object_id
INNER JOIN sys.schemas Sch on Tbls.schema_id = Sch.schema_id
INNER JOIN sys.indexes Indx ON Indx.object_id = indexstat.object_id
AND indexstat.index_id = Indx.index_id
WHERE indexstat.database_id = DB_ID()
and Indx.name is not null
AND indexstat.avg_fragmentation_in_percent > 30
AND Indx.name not like 'FK%'
ORDER BY indexstat.avg_fragmentation_in_percent desc