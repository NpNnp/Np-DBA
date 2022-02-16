SELECT AdHoc_Plan_MB, Total_Cache_MB,
        AdHoc_Plan_MB*100.0 / Total_Cache_MB AS 'AdHoc %'
FROM (
SELECT SUM(CASE
            WHEN objtype = 'adhoc'
            THEN size_in_bytes
            ELSE 0 END) / 1048576.0 AdHoc_Plan_MB,
        SUM(size_in_bytes) / 1048576.0 Total_Cache_MB
FROM sys.dm_exec_cached_plans) T