
-- 統計資料庫實體檔案空間使用情況
USE master
GO

CREATE table ##DBUSAGE ( 
    [資料庫名稱] sysname, 
    [邏輯名稱] sysname,
    [使用的磁碟空間(MB)] float, 
    [資料實際上使用的空間(MB)] float, 
    [剩餘的可用空間(MB)] float  ,
    [實體檔案位置] sysname
)

EXEC sp_Msforeachdb @command1 = 'use ? insert into ##DBUSAGE
SELECT ''?'' as N''資料庫名稱'' , name N''邏輯名稱'' , size/128.0 N''使用的磁碟空間(MB)'' ,  
 CAST(FILEPROPERTY(name, ''SpaceUsed'') AS int)/128.0 N''資料實際上使用的空間(MB)''  
 ,size/128.0 - CAST(FILEPROPERTY(name, ''SpaceUsed'') AS int)/128.0 N''剩餘的可用空間(MB)''  
 , physical_name N''實體檔案位置''
FROM sys.database_files';
GO

SELECT *
FROM
	##DBUSAGE
ORDER BY
	[資料庫名稱]

DROP TABLE ##DBUSAGE
GO