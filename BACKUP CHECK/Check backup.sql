with backup_information as
(
    select
        database_name,
        backup_type =
            case type
                when 'D' then 'Full backup'
                when 'I' then 'Differential backup'
                    when 'L' then 'Log backup'
                else 'Other or copy only backup'
            end ,
            backup_start_date ,
        backup_finish_date ,
        user_name  ,
        server_name ,
        compressed_backup_size ,
        rownum = 
            row_number() over
            (
                partition by database_name, type 
                order by backup_finish_date desc
            )
    from msdb.dbo.backupset
)

select
    database_name [Database Name],
    backup_type [Backup Type],
    backup_start_date [Backup start date],
    backup_finish_date [Backup finish date],
	datediff(minute,backup_start_date,backup_finish_date) as interval,
    server_name [Server Name],
    Convert(varchar,convert(numeric(10,2),compressed_backup_size/ 1024/1024)) [Backup size in MB],
    user_name [Backup taken by]
from backup_information
where rownum = 1
order by database_name,interval desc;

