--新光銀bcp資料表(匯入)
 SELECT * FROM ifrsrpdb..JH_LOAN_HIST_INFO WHERE PK_SYS = (SELECT MAX(PK_SYS) FROM IFRSRPDB..B_SYS_CONFIG)

 /*
公司環境(DB) 192.168.222.187;databaseName=IFRSRPDB;
DB帳密：sa  JHadmin123
*/
 /******************--(1)放款表內明細 **************************/
 bcp IFRSRPDB..JH_LOAN_HIST_INFO in "E:\TMP\放款表內明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_LOAN_HIST_INFO WHERE PK_SYS = '90'
 --UPDATE JH_LOAN_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
 /****************** --(2)放款表外明細 **************************/
 bcp IFRSRPDB..JH_EXLOAN_HIST_INFO in "E:\TMP\放款表外明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_EXLOAN_HIST_INFO WHERE PK_SYS = '90'
 --UPDATE JH_EXLOAN_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
 /******************(3)信用卡明細 **************************/
 bcp IFRSRPDB..JH_CCARD_HIST_INFO in "E:\TMP\信用卡明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
  SELECT TOP 1000 * FROM JH_CCARD_HIST_INFO WHERE PK_SYS = '90'
--UPDATE JH_CCARD_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
  /******************--(4)債券明細 **************************/
 bcp IFRSRPDB..JH_BOND_HIST_INFO in "E:\TMP\債券明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_BOND_HIST_INFO WHERE PK_SYS = '90'
 --UPDATE JH_BOND_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
 /****************** --(5)人工一般評估明細**************************/
 bcp IFRSRPDB..JH_ARTI_HIST_INFO in "E:\TMP\人工一般評估明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_ARTI_HIST_INFO WHERE PK_SYS = '90'
 --UPDATE JH_ARTI_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
  /******************--(6)人工個案評估明細**************************/
 bcp IFRSRPDB..JH_ARTICASE_HIST_INFO in "E:\TMP\人工個案評估明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_ARTICASE_HIST_INFO WHERE PK_SYS = '90'
 --UPDATE JH_ARTICASE_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
  /******************-  --(7)放款呆帳案件沖銷明細**************************/
 bcp IFRSRPDB..JH_BADDEBIT in "E:\TMP\放款呆帳案件沖銷明細.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_BADDEBIT 
   --DELETE JH_BADDEBIT
 /******************--(8)總帳檔**************************/
 bcp IFRSRPDB..JH_CHK_LEDGER_HIST_INFO in "E:\TMP\總帳檔.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_CHK_LEDGER_HIST_INFO WHERE PK_SYS = '90'
 --UPDATE JH_CHK_LEDGER_HIST_INFO SET PK_SYS = '90' WHERE PK_SYS = '28'
  /******************--(9)擔保品公允價值**************************/
bcp IFRSRPDB..JH_COLLATERAL_FV in "E:\TMP\擔保品公允價值.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
  SELECT TOP 1000 * FROM JH_COLLATERAL_FV 
 -- DELETE JH_COLLATERAL_FV
 --UPDATE JH_CCARD_HIST_INFO SET PK_SYS = '49' WHERE PK_SYS = '26'
 /******************--(10)參數檔**************************/
 bcp IFRSRPDB..JH_LOSS_ESTPARM_MULTI in "E:\TMP\參數檔.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
   SELECT TOP 1000 * FROM JH_LOSS_ESTPARM_MULTI 

 --UPDATE JH_CCARD_HIST_INFO SET PK_SYS = '49' WHERE PK_SYS = '26'
 /******************--(11)會計科目檔**************************/
 bcp IFRSRPDB..JH_CDE_ACCOUNT in "E:\TMP\會計科目檔.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123 
   SELECT TOP 1000 * FROM JH_CDE_ACCOUNT 
  --DELETE JH_CDE_ACCOUNT
 --UPDATE JH_CCARD_HIST_INFO SET PK_SYS = '49' WHERE PK_SYS = '26'
  /******************--(12)新舊帳戶檔**************************/
  bcp IFRSRPDB..JH_NEW_OLDID in "E:\TMP\新舊帳戶檔.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
    SELECT TOP 1000 * FROM JH_NEW_OLDID 
    --DELETE JH_NEW_OLDID
 --UPDATE JH_CCARD_HIST_INFO SET PK_SYS = '49' WHERE PK_SYS = '26'
  /******************--(13)新舊帳號串聯檔**************************/
   bcp IFRSRPDB..JH_NEW_OLDAC in "E:\TMP\新舊帳號串聯檔.TXT"    -t "," -r "\n" -c -S192.168.222.187\  -Usa -PJHadmin123
     SELECT TOP 1000 * FROM JH_NEW_OLDAC
     --DELETE JH_NEW_OLDAC
 --UPDATE JH_CCARD_HIST_INFO SET PK_SYS = '49' WHERE PK_SYS = '26'
   