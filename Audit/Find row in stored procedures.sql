select so.name from syscomments sc, sysobjects so where sc.text like '%mysearch%' and sc.id = so.id 



SELECT distinct  sys.schemas.name + '.' + sys.objects.name AS SProcedure, sys.objects.type AS Type
FROM    sys.objects 
INNER JOIN sys.schemas ON sys.objects.schema_id = sys.schemas.schema_id
INNER JOIN sys.syscomments ON sys.syscomments.id = sys.objects.object_id
WHERE sys.syscomments.text LIKE '%SRV-SUNLIGHT%'
ORDER BY SProcedure