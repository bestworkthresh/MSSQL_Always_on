--查詢_所有使用者的_資料庫對應使用權限

/*
作者:Thresh
日期:20220321
作用:把所有user列表出來

*/

/*建立暫存資料表*/
IF EXISTS (select * from tempdb.sys.tables where name= '##DBNAME')
BEGIN
DROP TABLE ##DBNAME
END

CREATE TABLE ##DBNAME 
(DBName NVARCHAR (90)
,DBRole NVARCHAR (90)
,MemberName NVARCHAR (90)
)

/*將結果依序寫入*/
EXECUTE master.sys.sp_MSforeachdb
'USE [?];
insert into ##DBNAME (DBName,DBRole,MemberName)
select ''?'' DBName, DBRole = g.name, MemberName = u.name
From sys.database_principals u, sys.database_principals g, sys.database_role_members m
Where g.principal_id = m.role_principal_id And u.principal_id = m.member_principal_id and u.name in (''##MS_PolicyEventProcessingLogin##'',''READONLY'',''##MS_PolicyTsqlExecutionLogin##'',''AP_FMS'',''CTMAdmin'',''DBCHK'',''ETUAP'',''FMS'',''FMS01'',''FMSAP'',''FRUSER'',''FRusers'',''KeycloakAdmin'',''SMSAP'',''SSISREADER'',''TDCC'',''WTH'',''cmsweb'',''ctmuser'',''dbop0'',''dbop1'',''dbop2'',''dbop3'',''dbop4'',''dbop5'',''dbop6'',''dbop7'',''dbop8'',''dbop9'',''dbuser'',''emuser'',''jsyn'',''qrdv'',''sa'',''x1c'' )
Order by 1, 2, 3'

/*
Where g.principal_id = m.role_principal_id And u.principal_id = m.member_principal_id and u.name in (''##MS_PolicyEventProcessingLogin##'',''READONLY'',''##MS_PolicyTsqlExecutionLogin##'',''AP_FMS'',''CTMAdmin'',''DBCHK'',''ETUAP'',''FMS'',''FMS01'',''FMSAP'',''FRUSER'',''FRusers'',''KeycloakAdmin'',''SMSAP'',''SSISREADER'',''TDCC'',''WTH'',''cmsweb'',''ctmuser'',''dbop0'',''dbop1'',''dbop2'',''dbop3'',''dbop4'',''dbop5'',''dbop6'',''dbop7'',''dbop8'',''dbop9'',''dbuser'',''emuser'',''jsyn'',''qrdv'',''sa'',''x1c'' )
Where g.principal_id = m.role_principal_id And u.principal_id = m.member_principal_id and u.name in (''##MS_PolicyEventProcessingLogin##'' ,''##MS_PolicyTsqlExecutionLogin##'' ,''10657'' ,''10659'' ,''11010'' ,''AgentTest'' ,''FMS'' ,''sa'' ,''SSISREADER'' ,''SSISREADWRITE'' ,''SSISREADWRITE2'' ,''TEST1'' ,''TEST2'' )
*/

/*輸出結果*/
DECLARE @DBName NVARCHAR (50) = 'FRSMETA'
DECLARE @USERName NVARCHAR (50) = 'dbop3'

select MemberName,DBName,DBRole
from ##DBNAME 
where DBName NOT IN ('master','tempdb','model','msdb')
--and DBName = @DBName
--and MemberName = @USERName
order by 1,2

truncate table Reserv20170829..Rolerpert

insert into Reserv20170829..Rolerpert 
select MemberName,DBName,DBRole,
case when DBRole like '%db_owner%' then 'o' 
	 when DBRole like 'db_datareader,' then 'r'
	 when DBRole like 'db_datawriter,' then 'w'
	 when DBRole like 'db_ddladmin,' then 'dl'
	 when DBRole like 'db_EXECUTE,' then 'E'
	 when DBRole like 'db_datawriter,db_datareader,' then 'r,w'
	 when DBRole like 'db_ddladmin,db_datawriter,db_datareader,' then 'dl,r,w'
	 when DBRole like 'db_ddladmin,db_datawriter,db_datareader,db_EXECUTE,' then 'dl,r,w,E'  
	 when DBRole like 'db_datawriter,db_datareader,db_EXECUTE,' then 'r,w,E'
	 when DBRole like 'db_datareader,db_EXECUTE,' then 'r,E'
else '' end   [type]

from
(select distinct MemberName,DBName, 
(select DBRole+',' from ##DBNAME as s1 where s1.DBName=s2.DBName and s1.MemberName=s2.MemberName order by 1 desc   FOR XML PATH('')) as DBRole
from ##DBNAME s2 where DBName NOT IN ('master','tempdb','model','msdb')) as new1 
UNION ALL 
SELECT name,'','',''  FROM sys.sql_logins

--where DBRole <>  'db_owner,'
order by 1,2



--相關快速產欄位語法
select MemberName,DBName,DBRole,type from Reserv20170829..Rolerpert
select distinct '['+DBName+'] as ' +DBName + ','  from Reserv20170829..Rolerpert


select distinct+'['+Name+'] ,' from sys.databases　　order by 1 FOR XML PATH('')


select distinct+' isnull (['+Name+'],'''') as '+ Name +','  from sys.databases　　order by 1   FOR XML PATH('') 

select distinct+''''''+Name+''''' ,'  from sys.sql_logins  FOR XML PATH('')TEST

select * from Reserv20170829..Rolerpert



/****************顯示結果******************/

SELECT  MemberName ,
/*這段欄位會因為每個主機環境不同而有所調整*/
 isnull ([CMS],'') as CMS, isnull ([ECLOG],'') as ECLOG, isnull ([FMSOAuthEC],'') as FMSOAuthEC, isnull ([FMSOAuthTA],'') as FMSOAuthTA, isnull ([FMS],'') as FMS, isnull ([FMS_NEW],'') as FMS_NEW, isnull ([FMS_NNN],'') as FMS_NNN, isnull ([FRSMAIN],'') as FRSMAIN, isnull ([FRSMETA],'') as FRSMETA, isnull ([FRlog],'') as FRlog, isnull ([IDPDB],'') as IDPDB, isnull ([OLD_FMS],'') as OLD_FMS, isnull ([PTPF_OFD],'') as PTPF_OFD, isnull ([QRDV_Gateway],'') as QRDV_Gateway, isnull ([Reserv20170829],'') as Reserv20170829, isnull ([SMS],'') as SMS, isnull ([SWEMail],'') as SWEMail, isnull ([SWEMail_New],'') as SWEMail_New, isnull ([TEST],'') as TEST, isnull ([WEALTH],'') as WEALTH, isnull ([crptw],'') as crptw, isnull ([ctmdb],'') as ctmdb, isnull ([emdb],'') as emdb, isnull ([fund],'') as fund, isnull ([fundms],'') as fundms, isnull ([fundother],'') as fundother, isnull ([fundtw],'') as fundtw, isnull ([global],'') as global, isnull ([jsyn_system_megatime],'') as jsyn_system_megatime, isnull ([master],'') as master, isnull ([model],'') as model, isnull ([msdb],'') as msdb, isnull ([rmat],'') as rmat, isnull ([stockrefertw],'') as stockrefertw, isnull ([stocktw],'') as stocktw, isnull ([tempdb],'') as tempdb, isnull ([x1],'') as x1
FROM 
(
select MemberName,DBName,type from Reserv20170829..Rolerpert 
) as aa
PIVOT (
	MAx([type]) FOR 
	/*這段條件會因為每個主機環境不同而有所調整*/
	DBName IN ([CMS] ,[ECLOG] ,[FMSOAuthEC] ,[FMSOAuthTA] ,[FMS] ,[FMS_NEW] ,[FMS_NNN] ,[FRSMAIN] ,[FRSMETA] ,[FRlog] ,[IDPDB] ,[OLD_FMS] ,[PTPF_OFD] ,[QRDV_Gateway] ,[Reserv20170829] ,[SMS] ,[SWEMail] ,[SWEMail_New] ,[TEST] ,[WEALTH] ,[crptw] ,[ctmdb] ,[emdb] ,[fund] ,[fundms] ,[fundother] ,[fundtw] ,[global] ,[jsyn_system_megatime] ,[master] ,[model] ,[msdb] ,[rmat] ,[stockrefertw] ,[stocktw] ,[tempdb] ,[x1] )
) As PTable
order by 1 

