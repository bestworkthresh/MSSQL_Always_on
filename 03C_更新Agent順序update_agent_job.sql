

/*
目的產出所有job語法，並產生出相關語法插入判斷式


*/

use msdb
go 

select 
m.[job_id]
,m.[name]
,d.step_id
,d.step_name
,d.command
--,*
into updataejob_step
from dbo.sysjobs as m 
left join dbo.sysjobsteps as d 
on m.job_id = d.job_id
where enabled = 1
--and (d.command like 'exec%' or d.command like 'EXEC%' or d.command like '%exec%' or d.command like '%EXEC%')
order by m.name


 select * from updataejob_step





select 'USE [msdb]
GO
--job名稱'+convert(Nvarchar (50),[name])+
'
/****** Object:  Step [TEST_1]    Script Date: 2021/7/27 上午 11:35:19 ******/
IF EXISTS (select [job_id]from dbo.sysjobs where [job_id] = N'''+convert(Nvarchar (50),[job_id])+''')
EXEC msdb.dbo.sp_delete_jobstep @job_id=N'''+convert(Nvarchar (50),[job_id])+''', @step_id=1
GO


USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_id=N'''+convert(Nvarchar (50),[job_id])+''', @step_name=N''判斷AG群組'', 
		@step_id=1, 
		@cmdexec_success_code=0, 
		@on_success_action=3, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N''TSQL'', 
		@command=N''USE FMS


'', 
		@database_name=N''master'', 
		@flags=0
GO

USE [msdb]
GO
EXEC msdb.dbo.sp_add_jobstep @job_id=N'''+convert(Nvarchar (50),[job_id])+''', @step_name=N'''+step_name+''', 
		@step_id=2, 
		@cmdexec_success_code=0, 
		@on_success_action=1, 
		@on_fail_action=2, 
		@retry_attempts=0, 
		@retry_interval=0, 
		@os_run_priority=0, @subsystem=N''TSQL'', 
		@command=N''USE FMS

'+command+''', 
		@database_name=N''master'', 
		@flags=0
GO
'

from updataejob_step
where name in 
    (select m.[name] from dbo.sysjobs as m left join dbo.sysjobsteps as d  on m.job_id = d.job_id
        where enabled = 1 
        group by m.[name]
        having COUNT(step_id) =1
    )


    drop table updataejob_step