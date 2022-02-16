SELECT TST.session_id AS [Session Id],
 EST.[text] AS [SQL Query Text], [statement] = COALESCE(NULLIF(
 SUBSTRING(
 EST.[text],
 ER.statement_start_offset / 2,
 CASE WHEN ER.statement_end_offset < ER.statement_start_offset
 THEN 0
 ELSE( ER.statement_end_offset - ER.statement_start_offset ) / 2 END
 ), ''
 ), EST.[text]),
 DBT.database_transaction_log_bytes_reserved AS [DB Transaction Log byte reserved]
 , ER.Status
 ,CASE ER.TRANSACTION_ISOLATION_LEVEL
 WHEN 0 THEN 'UNSPECIFIED'
 WHEN 1 THEN 'READUNCOMITTED'
 WHEN 2 THEN 'READCOMMITTED'
 WHEN 3 THEN 'REPEATABLE'
 WHEN 4 THEN 'SERIALIZABLE'
 WHEN 5 THEN 'SNAPSHOT'
 ELSE CAST(ER.TRANSACTION_ISOLATION_LEVEL AS VARCHAR(32))
 END AS [Isolation Level Name],
 QP.QUERY_PLAN AS [XML Query Plan]
FROM
 sys.dm_tran_database_transactions AS DBT
 INNER JOIN sys.dm_tran_session_transactions AS TST
 ON DBT.transaction_id = TST.transaction_id
 LEFT OUTER JOIN sys.dm_exec_requests AS ER
 ON TST.session_id = ER.session_id
 OUTER APPLY sys.dm_exec_sql_text(ER.plan_handle) AS EST
 CROSS APPLY SYS.DM_EXEC_QUERY_PLAN(ER.PLAN_HANDLE) QP
WHERE DBT.database_id = 2;