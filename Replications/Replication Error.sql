use distribution
go

select * from MSpublisher_databases /*View replication DB*/
go

select * from MSrepl_commands
where command_id = 91 /* from replication monitor*/
go



sp_browsereplcmds @xact_seqno_start = '0x003B942C00016D4C0001'
,@xact_seqno_end = '0x003B942C00016D4C0001'
,@publisher_database_id = 1
,@article_id = 1980
,@command_id= 91
go


delete from msrepl_commands where xact_seqno=0x003B942C00016D4C0001 /*Delete error command*/
go


