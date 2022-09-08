
--查實體Log檔案路徑
SELECT *
FROM sys.traces ;


--藉由該路徑查詢Log中資訊
select *
from
    fn_trace_gettable('D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\log_12.trc',5)
where textdata is not null
ORDER BY StartTime DESC; 



--查詢特定DB的資訊
WITH ObjectTypeMap(Value,ObjectType) AS
(
    SELECT * FROM 
        ( Values ( 8259, 'Check Constraint' ),(8272,'Stored Procedure'),(8277, 'Table'),(8278,'View'),
                 (16964, 'Database'),(17235,'Schema' )
        ) as TypeMap(Value,ObjectType)
)
SELECT e.name,f.DatabaseName,m.ObjectType, f.ObjectName,f.ApplicationName, f.HostName,f.NTUserName,f.StartTime,*
  FROM fn_trace_gettable('D:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\Log\log_12.trc',5) f
  JOIN sys.trace_events e ON f.EventClass = e.trace_event_id AND f.EventClass in (46,47,164) and f.EventSubClass = 0
  JOIN ObjectTypeMap m ON f.ObjectType = m.Value
  WHERE DatabaseName = 'FMS'  
  ORDER BY f.StartTime DESC,f.EventSequence DESC