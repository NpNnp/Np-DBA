/*
alter index IX_SiteID on DumpProfile1	rebuild
alter index IX_CustAcct on DumpProfile1	rebuild
alter index IX_ProfileID_SiteID	on DumpProfile1 rebuild
*/
--EmailBlastLandingPage
--DigitalPlatformAdvertising
EXEC master.sys.xp_delete_files
N'G:\Log_Backup\ProductBank.trn'; 

BACKUP LOG ProductBank TO  DISK = N'G:\Log_Backup\ProductBank.trn' WITH NOFORMAT, NOINIT,  
NAME = N'ProductBank-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
GO
