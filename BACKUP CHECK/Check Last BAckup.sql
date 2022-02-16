select *
	from 
	(
		SELECT 
			D.name	
			,CASE 
			   WHEN MAX(B.backup_finish_date) IS NULL 
				THEN 'Backup not taken' 
				ELSE CONVERT(VARCHAR(100),MAX(B.backup_finish_date)) 
			END AS LastBackupDate,
			'Database' as Info
		FROM sys.databases AS D
		LEFT OUTER JOIN msdb.dbo.backupset AS B 
			ON D.name = B.database_name AND B.type = 'D'
		GROUP BY D.name
		--ORDER BY 2 DESC

		union 

		SELECT   d.name
				 ,CASE 
			   WHEN MAX(B.backup_finish_date) IS NULL 
				THEN 'Backup not taken' 
				ELSE CONVERT(VARCHAR(100),MAX(B.backup_finish_date)) 
			END AS LastBackupDate,
			'Log' as Info
		FROM     master.sys.sysdatabases d
				 LEFT OUTER JOIN msdb..backupset b
				 ON       b.database_name = d.name
				 AND      b.type          = 'L'
		GROUP BY d.name
		--ORDER BY backup_finish_date DESC
	)x
order by x.Info asc