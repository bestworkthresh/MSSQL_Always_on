use Reserv20170829
go 



SELECT DISTINCT o.name, c.* FROM syscomments c
INNER JOIN sysobjects o ON c.id=o.id
WHERE o.xtype = 'P' And c.text LIKE '%Leah.liu@fundrich.com.tw%'  


SELECT DISTINCT o.name, c.* FROM syscomments c
INNER JOIN sysobjects o ON c.id=o.id
WHERE (o.xtype = 'P') And (c.text LIKE '%11001@fundrich.com.tw%')  

SELECT DISTINCT o.name, c.* FROM sys.sql_modules c
INNER JOIN sys.objects o ON c.object_id=o.object_id
WHERE (o.type = 'P')         And c.definition LIKE '%Leah.liu@fundrich.com.tw%'  



SELECT DISTINCT o.name, c.* FROM sys.sql_modules c
INNER JOIN sys.objects o ON c.object_id=o.object_id
WHERE (o.type = 'P')         And c.definition LIKE '%11001%'   


SELECT DISTINCT o.name, c.* FROM sys.sql_modules c
INNER JOIN sys.objects o ON c.object_id=o.object_id
WHERE (o.type = 'P')         And c.definition LIKE '%Leah%'  


