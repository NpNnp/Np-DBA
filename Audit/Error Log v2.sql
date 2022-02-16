/* 
script name: ErrorLogs.sql 
Runs xp_readerrorlog to query the errorlog for entries for the past x amount of days. 
*/ 
  
SET NOCOUNT ON 
  
-- cleanup temp tables in case they were left behind 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name = '#servername') DROP TABLE #servername 
IF EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE table_name = '#xp_readerrorlog') DROP TABLE #xp_readerrorlog 
  
-- declare and set variables 
DECLARE @NumOfLogDays INT 
DECLARE @startdate DATETIME 
DECLARE @enddate DATETIME 
  
IF (SELECT DATENAME(WEEKDAY, GETDATE())) like 'Monday' SET @NumOfLogDays = 3 ELSE SET @NumOfLogDays = 1 -- if it's Monday get 3 days of jobs 
SET @startdate=GETDATE() - @NumOfLogDays 
SET @enddate=GETDATE() 
  
-- create and populate temp tables 
CREATE TABLE #servername (ServerName VARCHAR(100)) 
INSERT INTO #servername 
SELECT @@servername 
  
CREATE TABLE #xp_readerrorlog(LogDate varchar(30),ProcessInfo varchar(30),Text varchar(max)) 
INSERT INTO #xp_readerrorlog 
EXEC xp_readerrorlog 0,1,NULL,NULL,@startdate,@enddate,'asc' 
  
-- join temp tables 
SELECT a.ServerName, b.LogDate, b.Text as 'Text ' 
FROM #servername a, #xp_readerrorlog b 
  
-- add whitespace 
PRINT ' ' 
  
-- cleanup 
DROP TABLE #servername 
DROP TABLE #xp_readerrorlog 