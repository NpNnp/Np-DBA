SELECT transaction_id ,
 database_transaction_begin_time ,
 DATEDIFF(SECOND, database_transaction_begin_time, GETDATE()) AS 'Transaction Time(Seconds)',
 CASE database_transaction_type
 WHEN 1 THEN 'Read/write'
 WHEN 2 THEN 'Read-only'
 WHEN 3 THEN 'System'
 END AS 'Type',
 CASE database_transaction_state
 WHEN 1 THEN 'The transaction has not been initialized.'
 WHEN 2 THEN 'The transaction is active.'
 WHEN 3 THEN 'The transaction has been initialized but has not generated any log records.'
 WHEN 4 THEN 'The transaction has generated log records.'
 WHEN 5 THEN 'The transaction has been prepared.'
 WHEN 10 THEN 'The transaction has been committed.'
 WHEN 11 THEN 'The transaction has been rolled back.'
 WHEN 12 THEN 'The transaction is being committed. In this state the log record is being generated, but it has not been materialized or persisted.'
 END AS 'Description',
 database_transaction_log_record_count AS [Number of Log Records],
 database_transaction_begin_lsn,
 database_transaction_last_lsn,
 database_transaction_most_recent_savepoint_lsn,
 database_transaction_commit_lsn
FROM sys.dm_tran_database_transactions
WHERE database_id = 2