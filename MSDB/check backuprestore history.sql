use msdb
go
SELECT CONVERT(CHAR(100), SERVERPROPERTY('Servername')) AS Server,
  msdb.dbo.backupset.database_name,
  msdb.dbo.backupset.backup_finish_date,
  CASE msdb..backupset.type
    WHEN 'D' THEN 'Database'
    WHEN 'L' THEN 'Log'
  END AS backup_type
FROM msdb.dbo.backupmediafamily
INNER JOIN msdb.dbo.backupset ON msdb.dbo.backupmediafamily.media_set_id = msdb.dbo.backupset.media_set_id
ORDER BY msdb.dbo.backupset.backup_finish_date;