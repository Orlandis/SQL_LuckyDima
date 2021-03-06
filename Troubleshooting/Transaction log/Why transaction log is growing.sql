DECLARE @path nVARCHAR(300)
DECLARE @db NVARCHAR(100)
SET @db=N'SubscriptionService'
select 
	@path=CONVERT(NVARCHAR(300),[value]) 
FROM ::fn_trace_getinfo(default) 
WHERE [property]=2

SELECT	top 100
		te.name, 
		t.LoginName,
		t.DatabaseName, 
		t.FileName, 
		t.StartTime, 
		dateadd(ms,t.Duration/1000,t.StartTime) [FinishTime],
		t.ApplicationName ,
		t.ObjectID,
        t.Duration/1000/1000 [Duration (s)]
FROM fn_trace_gettable(@path, NULL) AS t 
INNER JOIN sys.trace_events AS te ON t.EventClass = te.trace_event_id 
WHERE te.name LIKE '%Auto Grow' 
and t.DatabaseName=@db
ORDER BY StartTime DESC