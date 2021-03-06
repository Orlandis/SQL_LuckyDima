-- Transactional Replication Status Script
use distribution
go

select d.Publication, d.Publisher_db, a.Agent_id, d.Name,
case a.Runstatus
when 1 then 'Start -- Ok'
when 2 then 'Succeed -- Critical'
when 3 then 'In progress -- Ok'
when 4 then 'Idle -- Ok'
when 5 then 'Retry -- Critical'
when 6 then 'Fail -- Critical'
end Replication_Status
, a.Time, a.Comments, isnull(c.error_text,'') Error_Text
from dbo.MSdistribution_History a
join
(
select agent_id, max(time) Max_Time
from dbo.MSdistribution_history
group by agent_id
) b on b.agent_id = a.agent_id and b.max_Time = a.time
left outer join dbo.MSrepl_errors c on c.id = a.error_id
join dbo.MSdistribution_agents d on d.id = a.agent_id
where d.subscriber_db <> 'Virtual'
order by 1 




__________________________
����������� ������:
Error Message : The subscription(s) have been marked inactive and must be reinitialized. NoSync subscriptions will need to be dropped and recreated.



USE distribution
Update [MSsubscriptions]
Set [status] = 2
where publisher_db = 'MarkedExpiredDB'