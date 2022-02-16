BACKUP LOG Linknet_MSCRM TO  DISK = N'D:\SQL.backup\Linknet_MSCRM.trn' WITH NOFORMAT, NOINIT,  
NAME = N'Linknet_MSCRM-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO

