

USE msdb;  
GO  
declare @date as datetime
set @date=getdate()-90 
--select @date
EXEC sp_delete_backuphistory @oldest_date = @date