SELECT TOP 10 * FROM sys.dm_os_wait_stats ORDER BY wait_time_ms DESC;
--DBCC SQLPERF('sys.dm_os_wait_stats', CLEAR); 

SELECT TOP 10 * FROM sys.dm_os_latch_stats ORDER BY wait_time_ms DESC;
--DBCC SQLPERF('sys.dm_os_latch_stats', CLEAR); 

SELECT TOP 10 * FROM sys.dm_os_spinlock_stats ORDER BY spins DESC;