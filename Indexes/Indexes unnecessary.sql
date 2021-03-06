SELECT d.name AS 'database name', t.name AS 'table name', i.name AS 'index name', i.type_desc AS 'index type',
((ius.user_updates + 1)/((ius.user_seeks + ius.user_scans)+1)) AS '���������� �������������'
 FROM sys.dm_db_index_usage_stats ius
 JOIN sys.databases d ON d.database_id = ius.database_id AND ius.database_id=db_id()
 JOIN sys.tables t ON t.object_id = ius.object_id
 JOIN sys.indexes i ON i.object_id = ius.object_id AND i.index_id = ius.index_id
 where 
(ius.user_seeks + ius.user_scans = 0 AND ius.user_seeks + ius.user_scans < ius.user_updates)
AND  i.type_desc <> 'HEAP' 
OR (ius.user_seeks + ius.user_scans <> 0  AND (ius.user_updates + 1)/((ius.user_seeks + ius.user_scans) + 1) > 1)
ORDER BY 5 DESC 
 
