


--�d��Ʈw�Ҧb���D���ӧO�٦��h�֮e�q
DECLARE  @SPACE   AS TABLE  (drive varchar(3), size decimal)
insert into @SPACE EXEC master..xp_fixeddrives 

SELECT 
drive AS 'DISK_NAME',
size/1024.0 AS '�Ѿl�e�q(GB)'
FROM @SPACE



--��Ʈw���ثe�w��
SELECT CONVERT (VARCHAR(50), DATABASEPROPERTYEX('��Ʈw�W��','collation'));


--�d��SQL_Server_������骺���A���w��
/*�ϥ�SERVERPROPERTY �禡*/
SELECT CONVERT(varchar, SERVERPROPERTY('collation'));


--�ק�ƾڮw�w��(�`�N�@�U�A���p�̭��w�g����ƤF�A�o�ʧ@���|�ק������ƪ��w��)
USE [master]
GO
ALTER DATABASE [IFRSRPDB] COLLATE Chinese_Taiwan_Stroke_CI_AS
GO


--�ק�cloumns�w��
ALTER TABLE tb ALTER COLUMN colname nvarchar(100) COLLATE Chinese_PRC_CI_AS


--�B�⦡�h�ũw��
/*
�B�⦡�h�ũw�ǬO�b���泯�z���ɳ]�w���A�ӥB���̷|�v�T�Ǧ^���G�����覡�C �o�˥i�� ORDER BY �N���G�ƧǬ��a�ϳ]�w�S�w�C �Y�n����B�⦡�h�ũw�ǡA�Шϥ� COLLATE �l�y�A�p�U�ҥܡG
*/
SELECT name FROM customer ORDER BY name COLLATE Latin1_General_CS_AI;    




--���o�Ҧ���ƪ���O����
select 'SELECT * FROM ::fn_listextendedproperty(NULL, ''user'', ''dbo'', ''table'', '''+name+''', NULL, NULL)' from sys.tables

--���o�Ҧ���ƪ�Ҧ������O����
select 'SELECT * FROM ::fn_listextendedproperty(NULL, ''user'', ''dbo'', ''table'', '''+name+''', ''column'', NULL)' from sys.tables

--���o��ƪ��������O����
SELECT * FROM ::fn_listextendedproperty(NULL, 'user', 'dbo', 'table', '��ƪ�W��', 'column', '���W��')

--���o��ƪ�Ҧ������O����
SELECT '    ,'+objname, '           --'+convert (varchar(50),value,120),objtype,name
FROM ::fn_listextendedproperty(NULL, 'user', 'dbo', 'table', '��ƪ�W��', 'column', NULL)

--���o��ƪ���O����
SELECT * FROM ::fn_listextendedproperty(NULL, 'user', 'dbo', 'table', '��ƪ�W��', NULL, NULL)



--�s�W��ƪ���컡��
execute sp_ADDextendedproperty 'MS_Description', '��줤��W��', 'user', 'dbo', 'table', '��ƪ�', 'column', '���'

--�ק��ƪ���컡��
execute sp_UPDATEextendedproperty 'MS_Description', '��줤��W��', 'user', 'dbo', 'table', '��ƪ�', 'column', '���'

--�s�W��ƪ�����
execute sp_ADDextendedproperty 'MS_Description','��ƪ�����W��', 'user', 'dbo', 'table', '��ƪ�'

--�ק��ƪ�����
execute sp_UPDATEextendedproperty 'MS_Description','��ƪ�����W��', 'user', 'dbo', 'table', '��ƪ�'


--�s�W�έק���컡��_�P�_
IF not exists(SELECT * FROM ::fn_listextendedproperty (NULL, 'user', 'dbo', 'table', '��ƪ�W��', 'column', '���W��')) 
           BEGIN  
            exec sp_addextendedproperty 'MS_Description', '��컡��', 'user', 'dbo', 'table', '��ƪ�W��', 'column', '���W��' 
           END  
ELSE 
           BEGIN  
            exec sp_updateextendedproperty 'MS_Description', '��컡��', 'user', 'dbo', 'table', '��ƪ�W��', 'column', '���W��' 
           END


		     
--�������v�����y�k���S�w�ϥΪ�
--���
SELECT 'FN' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''FN'')) GRANT EXECUTE ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.objects
WHERE TYPE IN ('FN')
UNION ALL
--�˵�
SELECT 'V' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''V'')) GRANT SELECT ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.objects
WHERE TYPE IN ('V')
UNION ALL
--�{��
SELECT 'SP' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''P'', N''PC'')) GRANT EXECUTE ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.procedures
UNION ALL
--��ƪ�
SELECT 'SP' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''U'')) GRANT SELECT ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.objects
WHERE TYPE IN ('U')


--�T����v���S�w�ϥΪ�
DENY EXECUTE ON userTO user_income CASCADE;

--�R���ӨϥΪ̸Ӫ��󪺩Ҧ��v��
REVOKE DELETE ON user FROM member

--�P�_��ƪ�O�_�s�b_�p�G�s�b
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JH_WS02_SCHDL_UX_LIST_BK]') AND type in (N'U'))
SELECT 'EXISTS'
ELSE SELECT 'NOT EXISTS' 
GO


--�C�X��Ʈw�ɮשҦb�ϺЪŶ���T
SELECT distinct volume_mount_point as '�ϺХN��', total_bytes/1024/1024/1024 as '�Ϻ��`�Ŷ�(���:GB)', available_bytes/1024/1024/1024 '�ϺХi�ΪŶ�(���:GB)'
 ,cast (convert(float, (available_bytes/1024/1024/1024))/(total_bytes/1024/1024/1024) * 100 as int) as '�ϺЪŶ��i�βv(%)'
FROM sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id);



--�d��_SQL_Server_�W��������Ʈw���ɮפj�p_�t�޿���
SELECT 
DB_NAME(database_id) N'��Ʈw',
[name] N'�޿��ɮצW��',
physical_name N'�����ɮ�', 
type_desc N'�ɮ�����', 
state_desc N'�ɮת��A', 
size*8.0/1024 N'�ɮפj�p(MB)',
max_size N'�ɮפW��'
FROM sys.master_files
order by 5 desc 




--�d�ݸ�Ʈw�̫�@���ƥ��O���Ӯɫ�
SELECT D.name ��Ʈw�W��,
	�_��Ҧ� = CASE D.recovery_model_desc
		WHEN 'SIMPLE' THEN '²��'
		WHEN 'FULL' THEN '����'
		ELSE '�j�q�O��'
	END,
	ISNULL(CONVERT(varchar, BS.bdate, 120), '�q���ƥ��L') AS �̫�ƥ����,
	�ƥ����� = CASE BS.type
		WHEN 'D' THEN '��Ʈw'
		WHEN 'I' THEN '�t����Ʈw'
		WHEN 'L' THEN '�O��'
		WHEN 'F' THEN '�ɮש��ɮ׸s��'
		WHEN 'G' THEN '�t���ɮ�'
		WHEN 'P' THEN '����'
		WHEN 'Q' THEN '�t������'
		ELSE ''
	END
FROM sys.databases D LEFT JOIN  
( 
	SELECT database_name, MAX(backup_finish_date) bdate, type
	FROM msdb.dbo.backupset
	GROUP BY database_name, type
) BS ON D.name = BS.database_name 
ORDER BY 1;



--2. SQL Server 2008 �H�W�����A�Q�� sys.dm_os_sys_info 
SELECT @@servername as '��Ʈw�A�ȦW��',sqlserver_start_time as '��Ʈw�A�ȱҰʮɶ�'
FROM [sys].[dm_os_sys_info]






--�s�W�ϥΪ̻P�����n�J��
USE [master]
GO

/*
�P�_�ӵn�J�̦p�G���s�b�A�N�ظm�ӵn�J��
*/
IF NOT EXISTS (select loginname from master.dbo.syslogins where name =  N'ifrs_SRV')
BEGIN
    CREATE LOGIN [ifrs_SRV] WITH PASSWORD=N'SKbank99'
    , DEFAULT_DATABASE=[JH_DB]
    , DEFAULT_LANGUAGE=[�c�餤��]
    , CHECK_EXPIRATION=OFF
    , CHECK_POLICY=OFF
END
ELSE 	ALTER LOGIN [lluser] ENABLE

--�s�W��Ʈw���ϥΪ�
USE [JH_DB]
GO
/****** Object:  User [ifrs_SRV]    Script Date: 2020/5/14 �g�| �W�� 09:23:20 ******/
IF  EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [type] = N'S' AND [name] = N'ifrs_SRV')
BEGIN

	DROP USER [ifrs_SRV] 
--�s�W�ϥΪ̻P�n�J�̳]�w
	CREATE USER [ifrs_SRV] FOR LOGIN [ifrs_SRV]
--����֦��̥����v��
	ALTER ROLE [db_owner] ADD MEMBER [OTBT_ADMIN]
--���Ū��g���v��
	ALTER ROLE [db_datareader] ADD MEMBER [ifrs_SRV]
	ALTER ROLE [db_datawriter] ADD MEMBER [ifrs_SRV]
END
ELSE
	CREATE USER [ifrs_SRV] FOR LOGIN [ifrs_SRV]

--����֦��̥����v��
	ALTER ROLE [db_owner] ADD MEMBER [OTBT_ADMIN]
--���Ū��g���v��
	ALTER ROLE [db_datareader] ADD MEMBER [ifrs_SRV]
	ALTER ROLE [db_datawriter] ADD MEMBER [ifrs_SRV]

--�P�_��ƮwLOGIN�O�_�s�b
USE [master]
GO

IF NOT EXISTS (select loginname from master.dbo.syslogins where name =  N'lluser')
BEGIN
	CREATE LOGIN [lluser] WITH PASSWORD=N'admin1234', DEFAULT_DATABASE=[LLRPDB], DEFAULT_LANGUAGE=[�c�餤��], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
	ALTER LOGIN [lluser] DISABLE
END


--�ֳt���o��ƪ�Ҧ���쪺�W��					
DECLARE @TB_NAME VARCHAR(200)
SET @TB_NAME  = 'LOG_ECLOG'

SELECT '['+C.NAME + '],' 
FROM (SELECT C.NAME FROM sys.tables T
      INNER JOIN sys.columns C ON T.object_id = C.object_id
      WHERE T.NAME = @TB_NAME
     ) C
FOR XML PATH('')



--�ֳt�}�ҲպA�޲z��
�}�l > ���� > ��J"SQLServerManager11.msc" (�w�� SQL Server 2012 ����)





--���Y��ƮwLOG�ɮ�1
USE [IFRSSTG]
GO
DBCC SHRINKDATABASE(N'IFRSSTG' )
GO

--���Y��Ʈw�S�w���ɮ�
USE [IFRSSTG]
GO
        /*��Ʈw�޿�W�١A�o�O�������Y*/
DBCC SHRINKFILE (N'LLSTG' , 0, TRUNCATEONLY)
GO

USE [IFRSSTG]
GO
        /*��Ʈw�޿�W�١A�Ʀr�N�����Y�Ѧh�j�������ɮסA���OMB*/
DBCC SHRINKFILE (N'LLSTG' , 2048)
GO


--���Y��Ʈw�S�w��������
USE [IFRSSTG]
GO
        /*�������޿�W�١A�o�O�������Y*/
DBCC SHRINKFILE (N'LLSTG_log' , 0, TRUNCATEONLY)
GO

USE [IFRSSTG]
GO
        /*�������޿�W�١A�Ʀr�N�����Y�Ѧh�j�������ɮסA���OMB*/
DBCC SHRINKFILE (N'LLSTG' , 2048)
GO

--�MLOG
USE ESUN_FHC_DB
GO
ALTER DATABASE ESUN_FHC_DB SET RECOVERY SIMPLE WITH NO_WAIT
DBCC SHRINKFILE(LLIFRSDB_LOG, 1)
ALTER DATABASE ESUN_FHC_DB SET RECOVERY FULL WITH NO_WAIT
GO



--��Ʈw�d���ɮפj�p
SELECT name N'�޿�W��' 
,(( size*8)/1024.0)/1024.0 N'�ϥΪ��ϺЪŶ�(GB)' 
, ((CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)*8)/1024.0)/1024.0 N'��ƹ�ڤW�ϥΪ��Ŷ�(GB)'
, ((( size*8)/1024.0)/1024.0)-(((CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)*8)/1024.0)/1024.0) N'�Ѿl���i�ΪŶ�(GB)'
FROM sys.database_files;


--�O�����ƪ��`�@���Φh�ְO����
select  sum(allocated_bytes)/(1024*1024) as total_allocated_MB,   
       sum(used_bytes)/(1024*1024) as total_used_MB  
from sys.dm_db_xtp_memory_consumers  		

--�d�ݦU��ƪ���Φh�ְO����
SELECT object_name(object_id) AS Name
,memory_allocated_for_table_kb
,(memory_allocated_for_table_kb/1024) AS 'memory_allocated_for_table_MB'
,memory_used_by_table_kb
,(memory_used_by_table_kb/1024) AS 'memory_used_by_table_MB'
,memory_allocated_for_indexes_kb
,(memory_allocated_for_indexes_kb/1024) AS 'memory_allocated_for_indexes_MB'
,memory_used_by_indexes_kb 
,(memory_used_by_indexes_kb /1024) AS 'memory_used_by_indexes_MB'
FROM sys.dm_db_xtp_table_memory_stats
GO


--�d�߬������������
SELECT RIGHT(LEFT(@@VERSION,25),4) N'���~�����s��' , 
 SERVERPROPERTY('ProductVersion') N'�����s��',
 SERVERPROPERTY('ProductLevel') N'�����h��',
 SERVERPROPERTY('Edition') N'������鲣�~����',
 DATABASEPROPERTYEX('master','Version') N'��Ʈw�������������X',
 @@VERSION N'�����������s���B�B�z���[�c�B�ظm����M�@�~�t��'
 