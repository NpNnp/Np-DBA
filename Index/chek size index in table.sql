SELECT
    i.name AS IndexName
    ,SUM(s.used_page_count) * 8 AS IndexSizeInKB
FROM sys.dm_db_partition_stats AS s 
INNER JOIN sys.indexes AS i
	ON s.[object_id] = i.[object_id] AND s.index_id = i.index_id
--WHERE s.[object_id] = object_id('dbo.cust_Sign')
GROUP BY i.name
ORDER BY SUM(s.used_page_count) * 8 desc

/*
ALTER INDEX cndx_Annotation
ON AnnotationBase
REBUILD
WITH (DATA_COMPRESSION = ROW)
*/

--select @@VERSION