-- Database IO analysis.
WITH IOFORDATABASE AS 
(
  SELECT 
    DB_NAME(VFS.database_id) AS DatabaseName
    , CASE WHEN smf.type = 1 
      THEN 'LOG_FILE' ELSE 'DATA_FILE' END
	    AS DatabaseFile_Type
    , SUM(VFS.num_of_bytes_written) AS IO_Write
    , SUM(VFS.num_of_bytes_read) AS IO_Read
    , SUM(VFS.num_of_bytes_read + VFS.num_of_bytes_written) 
        AS Total_IO
    , SUM(VFS.io_stall) AS IO_STALL
  FROM sys.dm_io_virtual_file_stats(NULL, NULL) AS VFS
  JOIN sys.master_files AS smf
  ON VFS.database_id = smf.database_id
  AND VFS.file_id = smf.file_id
  GROUP BY DB_NAME(VFS.database_id), smf.type
)
SELECT
  ROW_NUMBER() OVER (ORDER BY io_stall DESC) AS RowNumber
  , DatabaseName
  , DatabaseFile_Type
  , CAST(1.0 * IO_Read / (1024 * 1024) AS DECIMAL(12,2)) 
      AS IO_Read_MB
  , CAST(1.0 * IO_Write / (1024 * 1024) AS DECIMAL(12,2)) 
      AS IO_Write_MB
  , CAST(1. * Total_IO / (1024 * 1024) AS DECIMAL(12,2)) 
      AS IO_TOTAL_MB
  , CAST(IO_STALL / 1000. AS DECIMAL(12, 2)) 
      AS IO_STALL_Seconds
  , CAST(100. * IO_STALL / SUM(IO_STALL) OVER() AS DECIMAL(10,2))
      AS IO_STALL_Pct
FROM IOFORDATABASE
ORDER BY IO_STALL_Seconds DESC