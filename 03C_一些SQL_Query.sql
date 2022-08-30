


--查資料庫所在的主機個別還有多少容量
DECLARE  @SPACE   AS TABLE  (drive varchar(3), size decimal)
insert into @SPACE EXEC master..xp_fixeddrives 

SELECT 
drive AS 'DISK_NAME',
size/1024.0 AS '剩餘容量(GB)'
FROM @SPACE



--資料庫的目前定序
SELECT CONVERT (VARCHAR(50), DATABASEPROPERTYEX('資料庫名稱','collation'));


--查詢SQL_Server_執行個體的伺服器定序
/*使用SERVERPROPERTY 函式*/
SELECT CONVERT(varchar, SERVERPROPERTY('collation'));


--修改數據庫定序(注意一下，假如裡面已經有資料了，這動作不會修改到原先資料的定序)
USE [master]
GO
ALTER DATABASE [IFRSRPDB] COLLATE Chinese_Taiwan_Stroke_CI_AS
GO


--修改cloumns定序
ALTER TABLE tb ALTER COLUMN colname nvarchar(100) COLLATE Chinese_PRC_CI_AS


--運算式層級定序
/*
運算式層級定序是在執行陳述式時設定的，而且它們會影響傳回結果集的方式。 這樣可讓 ORDER BY 將結果排序為地區設定特定。 若要執行運算式層級定序，請使用 COLLATE 子句，如下所示：
*/
SELECT name FROM customer ORDER BY name COLLATE Latin1_General_CS_AI;    




--取得所有資料表註記說明
select 'SELECT * FROM ::fn_listextendedproperty(NULL, ''user'', ''dbo'', ''table'', '''+name+''', NULL, NULL)' from sys.tables

--取得所有資料表所有欄位註記說明
select 'SELECT * FROM ::fn_listextendedproperty(NULL, ''user'', ''dbo'', ''table'', '''+name+''', ''column'', NULL)' from sys.tables

--取得資料表單個欄位註記說明
SELECT * FROM ::fn_listextendedproperty(NULL, 'user', 'dbo', 'table', '資料表名稱', 'column', '欄位名稱')

--取得資料表所有欄位註記說明
SELECT '    ,'+objname, '           --'+convert (varchar(50),value,120),objtype,name
FROM ::fn_listextendedproperty(NULL, 'user', 'dbo', 'table', '資料表名稱', 'column', NULL)

--取得資料表註記說明
SELECT * FROM ::fn_listextendedproperty(NULL, 'user', 'dbo', 'table', '資料表名稱', NULL, NULL)



--新增資料表欄位說明
execute sp_ADDextendedproperty 'MS_Description', '欄位中文名稱', 'user', 'dbo', 'table', '資料表', 'column', '欄位'

--修改資料表欄位說明
execute sp_UPDATEextendedproperty 'MS_Description', '欄位中文名稱', 'user', 'dbo', 'table', '資料表', 'column', '欄位'

--新增資料表的說明
execute sp_ADDextendedproperty 'MS_Description','資料表的中文名稱', 'user', 'dbo', 'table', '資料表'

--修改資料表的說明
execute sp_UPDATEextendedproperty 'MS_Description','資料表的中文名稱', 'user', 'dbo', 'table', '資料表'


--新增或修改欄位說明_判斷
IF not exists(SELECT * FROM ::fn_listextendedproperty (NULL, 'user', 'dbo', 'table', '資料表名稱', 'column', '欄位名稱')) 
           BEGIN  
            exec sp_addextendedproperty 'MS_Description', '欄位說明', 'user', 'dbo', 'table', '資料表名稱', 'column', '欄位名稱' 
           END  
ELSE 
           BEGIN  
            exec sp_updateextendedproperty 'MS_Description', '欄位說明', 'user', 'dbo', 'table', '資料表名稱', 'column', '欄位名稱' 
           END


		     
--產執行權限的語法給特定使用者
--函數
SELECT 'FN' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''FN'')) GRANT EXECUTE ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.objects
WHERE TYPE IN ('FN')
UNION ALL
--檢視
SELECT 'V' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''V'')) GRANT SELECT ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.objects
WHERE TYPE IN ('V')
UNION ALL
--程序
SELECT 'SP' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''P'', N''PC'')) GRANT EXECUTE ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.procedures
UNION ALL
--資料表
SELECT 'SP' AS 'TYPE',
       'IF  EXISTS (SELECT * FROM SYS.OBJECTS WHERE OBJECT_ID = OBJECT_ID(N''[DBO].['+NAME+']'') AND TYPE IN (N''U'')) GRANT SELECT ON ['+ NAME + '] TO [IFRS9-AP01T]' AS 'SQLCMD'
FROM SYS.objects
WHERE TYPE IN ('U')


--禁止授權給特定使用者
DENY EXECUTE ON userTO user_income CASCADE;

--刪除該使用者該物件的所有權限
REVOKE DELETE ON user FROM member

--判斷資料表是否存在_如果存在
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[JH_WS02_SCHDL_UX_LIST_BK]') AND type in (N'U'))
SELECT 'EXISTS'
ELSE SELECT 'NOT EXISTS' 
GO


--列出資料庫檔案所在磁碟空間資訊
SELECT distinct volume_mount_point as '磁碟代號', total_bytes/1024/1024/1024 as '磁碟總空間(單位:GB)', available_bytes/1024/1024/1024 '磁碟可用空間(單位:GB)'
 ,cast (convert(float, (available_bytes/1024/1024/1024))/(total_bytes/1024/1024/1024) * 100 as int) as '磁碟空間可用率(%)'
FROM sys.master_files AS f
CROSS APPLY sys.dm_os_volume_stats(f.database_id, f.file_id);



--查詢_SQL_Server_上面全部資料庫的檔案大小_含邏輯檔
SELECT 
DB_NAME(database_id) N'資料庫',
[name] N'邏輯檔案名稱',
physical_name N'實體檔案', 
type_desc N'檔案類型', 
state_desc N'檔案狀態', 
size*8.0/1024 N'檔案大小(MB)',
max_size N'檔案上限'
FROM sys.master_files
order by 5 desc 




--查看資料庫最後一次備份是哪個時後
SELECT D.name 資料庫名稱,
	復原模式 = CASE D.recovery_model_desc
		WHEN 'SIMPLE' THEN '簡單'
		WHEN 'FULL' THEN '完整'
		ELSE '大量記錄'
	END,
	ISNULL(CONVERT(varchar, BS.bdate, 120), '從未備份過') AS 最後備份日期,
	備份類型 = CASE BS.type
		WHEN 'D' THEN '資料庫'
		WHEN 'I' THEN '差異資料庫'
		WHEN 'L' THEN '記錄'
		WHEN 'F' THEN '檔案或檔案群組'
		WHEN 'G' THEN '差異檔案'
		WHEN 'P' THEN '部分'
		WHEN 'Q' THEN '差異部分'
		ELSE ''
	END
FROM sys.databases D LEFT JOIN  
( 
	SELECT database_name, MAX(backup_finish_date) bdate, type
	FROM msdb.dbo.backupset
	GROUP BY database_name, type
) BS ON D.name = BS.database_name 
ORDER BY 1;



--2. SQL Server 2008 以上版本，利用 sys.dm_os_sys_info 
SELECT @@servername as '資料庫服務名稱',sqlserver_start_time as '資料庫服務啟動時間'
FROM [sys].[dm_os_sys_info]






--新增使用者與對應登入者
USE [master]
GO

/*
判斷該登入者如果不存在，就建置該登入者
*/
IF NOT EXISTS (select loginname from master.dbo.syslogins where name =  N'ifrs_SRV')
BEGIN
    CREATE LOGIN [ifrs_SRV] WITH PASSWORD=N'SKbank99'
    , DEFAULT_DATABASE=[JH_DB]
    , DEFAULT_LANGUAGE=[繁體中文]
    , CHECK_EXPIRATION=OFF
    , CHECK_POLICY=OFF
END
ELSE 	ALTER LOGIN [lluser] ENABLE

--新增資料庫的使用者
USE [JH_DB]
GO
/****** Object:  User [ifrs_SRV]    Script Date: 2020/5/14 週四 上午 09:23:20 ******/
IF  EXISTS (SELECT [name] FROM [sys].[database_principals] WHERE [type] = N'S' AND [name] = N'ifrs_SRV')
BEGIN

	DROP USER [ifrs_SRV] 
--新增使用者與登入者設定
	CREATE USER [ifrs_SRV] FOR LOGIN [ifrs_SRV]
--獲取擁有者全部權限
	ALTER ROLE [db_owner] ADD MEMBER [OTBT_ADMIN]
--獲取讀跟寫的權限
	ALTER ROLE [db_datareader] ADD MEMBER [ifrs_SRV]
	ALTER ROLE [db_datawriter] ADD MEMBER [ifrs_SRV]
END
ELSE
	CREATE USER [ifrs_SRV] FOR LOGIN [ifrs_SRV]

--獲取擁有者全部權限
	ALTER ROLE [db_owner] ADD MEMBER [OTBT_ADMIN]
--獲取讀跟寫的權限
	ALTER ROLE [db_datareader] ADD MEMBER [ifrs_SRV]
	ALTER ROLE [db_datawriter] ADD MEMBER [ifrs_SRV]

--判斷資料庫LOGIN是否存在
USE [master]
GO

IF NOT EXISTS (select loginname from master.dbo.syslogins where name =  N'lluser')
BEGIN
	CREATE LOGIN [lluser] WITH PASSWORD=N'admin1234', DEFAULT_DATABASE=[LLRPDB], DEFAULT_LANGUAGE=[繁體中文], CHECK_EXPIRATION=OFF, CHECK_POLICY=OFF
	ALTER LOGIN [lluser] DISABLE
END


--快速取得資料表所有欄位的名稱					
DECLARE @TB_NAME VARCHAR(200)
SET @TB_NAME  = 'LOG_ECLOG'

SELECT '['+C.NAME + '],' 
FROM (SELECT C.NAME FROM sys.tables T
      INNER JOIN sys.columns C ON T.object_id = C.object_id
      WHERE T.NAME = @TB_NAME
     ) C
FOR XML PATH('')



--快速開啟組態管理員
開始 > 執行 > 輸入"SQLServerManager11.msc" (針對 SQL Server 2012 版本)





--壓縮資料庫LOG檔案1
USE [IFRSSTG]
GO
DBCC SHRINKDATABASE(N'IFRSSTG' )
GO

--壓縮資料庫特定的檔案
USE [IFRSSTG]
GO
        /*資料庫邏輯名稱，這是直接壓縮*/
DBCC SHRINKFILE (N'LLSTG' , 0, TRUNCATEONLY)
GO

USE [IFRSSTG]
GO
        /*資料庫邏輯名稱，數字代表壓縮剩多大的實體檔案，單位是MB*/
DBCC SHRINKFILE (N'LLSTG' , 2048)
GO


--壓縮資料庫特定的紀錄檔
USE [IFRSSTG]
GO
        /*紀錄檔邏輯名稱，這是直接壓縮*/
DBCC SHRINKFILE (N'LLSTG_log' , 0, TRUNCATEONLY)
GO

USE [IFRSSTG]
GO
        /*紀錄檔邏輯名稱，數字代表壓縮剩多大的實體檔案，單位是MB*/
DBCC SHRINKFILE (N'LLSTG' , 2048)
GO

--清LOG
USE ESUN_FHC_DB
GO
ALTER DATABASE ESUN_FHC_DB SET RECOVERY SIMPLE WITH NO_WAIT
DBCC SHRINKFILE(LLIFRSDB_LOG, 1)
ALTER DATABASE ESUN_FHC_DB SET RECOVERY FULL WITH NO_WAIT
GO



--資料庫查詢檔案大小
SELECT name N'邏輯名稱' 
,(( size*8)/1024.0)/1024.0 N'使用的磁碟空間(GB)' 
, ((CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)*8)/1024.0)/1024.0 N'資料實際上使用的空間(GB)'
, ((( size*8)/1024.0)/1024.0)-(((CAST(FILEPROPERTY(name, 'SpaceUsed') AS int)*8)/1024.0)/1024.0) N'剩餘的可用空間(GB)'
FROM sys.database_files;


--記憶體資料表總共佔用多少記憶體
select  sum(allocated_bytes)/(1024*1024) as total_allocated_MB,   
       sum(used_bytes)/(1024*1024) as total_used_MB  
from sys.dm_db_xtp_memory_consumers  		

--查看各資料表佔用多少記憶體
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


--查詢相關的版本資料
SELECT RIGHT(LEFT(@@VERSION,25),4) N'產品版本編號' , 
 SERVERPROPERTY('ProductVersion') N'版本編號',
 SERVERPROPERTY('ProductLevel') N'版本層級',
 SERVERPROPERTY('Edition') N'執行個體產品版本',
 DATABASEPROPERTYEX('master','Version') N'資料庫的內部版本號碼',
 @@VERSION N'相關的版本編號、處理器架構、建置日期和作業系統'
 