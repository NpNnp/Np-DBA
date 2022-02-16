
BACKUP LOG BillPayment TO  DISK = N'D:\backup\BillPayment.trn' WITH NOFORMAT, NOINIT,  
NAME = N'BillPayment-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
