


--BCP OUT (將資料匯入)
  bcp "  SELECT * FROM DatabaseName..TableName WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM DatabaseName..TableName)"       queryout "e:\放款表內明細.TXT"  -t "," -r "\n" -c -S192.168.111.123\  -USERNAME -PPASSWORD



--	BCP IN (將資料打包)
 bcp DatabaseName..TableName in "E:\TMP\放款表內明細.TXT"    -t "," -r "\n" -c -S192.168.111.123\  -USERNAME -PPASSWORD
   SELECT TOP 1000 * FROM TableName WHERE PK_SYS = '90'





