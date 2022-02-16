--Move tempdb files to a different location
declare @sql nvarchar(max) = '';					--initialize because we cannot concatenate NULL with anything
declare @newPath varchar(128) = 'E:\MSSQL\tempdb\';	--ENTER NEW LOCATION
declare @sizeMB int = 22500;						--ENTER INITIAL SIZE IN MB
declare @autogrowthMB int = 64;						--ENTER AUTOGROWTH IN MB

select @sql += N'alter database tempdb modify file (name = [' + f.[name] + '],
	filename = ''' + @newPath + f.[name]
	+ case when f.[type] = 1 then '.ldf' else '.mdf' end + ''''
	+ ', size = ' + cast(@sizeMB as nvarchar) + 'mb'
	+ ', filegrowth = ' + cast(@autogrowthMB as nvarchar) + 'mb'
	+ ');'
	+ char(13) + char(10)
from sys.master_files f 
where f.database_id = DB_ID(N'tempdb');

print @sql;
--exec sp_executesql @sql;