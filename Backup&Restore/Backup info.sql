-- �������� ������� ������

WITH full_backups AS
(
SELECT
	ROW_NUMBER() OVER(PARTITION BY database_name ORDER BY database_name ASC, backup_finish_date DESC) AS [Row Number]
	, database_name
	, backup_set_id
	, backup_finish_date
FROM msdb.dbo.[backupset]
WHERE [type] = 'D'
)
 
SELECT
	BS.server_name
	, BS.database_name
	, FB.backup_finish_date
	, BMF.physical_device_name
	, BMF.logical_device_name AS [backup_device_name]
FROM full_backups FB
	INNER JOIN msdb.dbo.[backupset] BS ON FB.backup_set_id = BS.backup_set_id
	INNER JOIN msdb.dbo.backupmediafamily BMF ON BS.media_set_id = BMF.media_set_id
WHERE FB.[Row Number] = 1
ORDER BY FB.database_name;

--�������� ������ ����

WITH log_backups AS
(
SELECT
	ROW_NUMBER() OVER(PARTITION BY database_name ORDER BY database_name ASC, backup_finish_date DESC) AS [Row Number]
	, database_name
	, backup_set_id
	, backup_finish_date
FROM msdb.dbo.[backupset]
WHERE [type] = 'L'
)
 
SELECT
	BS.server_name
	, BS.database_name
	, FB.backup_finish_date
	, BMF.physical_device_name
	, BMF.logical_device_name AS [backup_device_name]
FROM log_backups FB
 INNER JOIN msdb.dbo.[backupset] BS ON FB.backup_set_id = BS.backup_set_id
 INNER JOIN msdb.dbo.backupmediafamily BMF ON BS.media_set_id = BMF.media_set_id
WHERE FB.[Row Number] = 1
ORDER BY FB.database_name;


--���������� � �������, ������ � �.�.

WITH full_backups AS
(
SELECT
	ROW_NUMBER() OVER(PARTITION BY BS.database_name ORDER BY BS.database_name ASC, BS.backup_finish_date DESC) AS [Row Number]
	, BS.database_name
	, BS.backup_set_id
	, BS.backup_size AS uncompressed_size
	, BS.compressed_backup_size AS compressed_size
	, CAST((BS.compressed_backup_size / BS.backup_size) AS decimal(4,1)) AS compression_ratio
	, BS.backup_finish_date
FROM msdb.dbo.[backupset] BS
WHERE BS.[type] = 'D'
)
 
SELECT
	FB.database_name
	, FB.backup_finish_date
	, FB.uncompressed_size
	, FB.compressed_size
	, FB.compression_ratio
FROM full_backups FB
 INNER JOIN msdb.dbo.[backupset] BS ON FB.backup_set_id = BS.backup_set_id
 INNER JOIN msdb.dbo.backupmediafamily BMF ON BS.media_set_id = BMF.media_set_id
WHERE FB.[Row Number] = 1
ORDER BY FB.database_name;