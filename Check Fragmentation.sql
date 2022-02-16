
-- Get fragmentation info for all indexes above a certain size in the current database  (Query 44) (Index Fragmentation)
-- Note: This query could take some time on a very large database

select * 
	from 
	(
	SELECT DB_NAME(ps.database_id) AS [Database Name], SCHEMA_NAME(o.[schema_id]) AS [Schema Name],'alter index' as text1,
			 i.[name] AS [Index Name],'on' as text2,OBJECT_NAME(ps.OBJECT_ID) AS [Object Name], ps.index_id, 
			ps.index_type_desc, ps.avg_fragmentation_in_percent, 
			ps.fragment_count, ps.page_count, i.fill_factor, i.has_filter, 
			i.filter_definition, i.[allow_page_locks]
	FROM sys.dm_db_index_physical_stats(DB_ID(),NULL, NULL, NULL , N'LIMITED') AS ps
			INNER JOIN sys.indexes AS i WITH (NOLOCK)
			ON ps.[object_id] = i.[object_id] 
			AND ps.index_id = i.index_id
			INNER JOIN sys.objects AS o WITH (NOLOCK)
			ON i.[object_id] = o.[object_id]
	WHERE ps.database_id = DB_ID()
		--AND ps.page_count > 2500
		and index_type_desc<>'heap'
		)x
where [Object Name] not like '%TMP%'
	order by avg_fragmentation_in_percent desc
--where [Object Name]='teleescalateassign'