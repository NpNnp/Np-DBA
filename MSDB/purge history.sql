EXEC msdb.dbo.sp_purge_jobhistory; ----cleanup all job history
GO
DECLARE @enddate DATETIME = DATEADD(MONTH, -1, GETDATE()); ----cleanup job history that older than 2 month
EXEC msdb.dbo.sp_purge_jobhistory @oldest_date = @enddate;
GO