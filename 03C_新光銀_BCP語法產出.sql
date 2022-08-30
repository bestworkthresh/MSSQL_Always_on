--新光銀bcp資料表(產出)
 SELECT * FROM ifrsrpdb..JH_LOAN_HIST_INFO WHERE PK_SYS = (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)
 /*
 定版環境(DB) 10.20.41.211:1433;databaseName=IFRSRPDB;
DB帳密：ifrs_SRV SKbank99
*/
--(1)放款表內明細 
  bcp "  SELECT * FROM ifrsrpdb..JH_LOAN_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\放款表內明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
 --(2)放款表外明細 
  bcp "  SELECT * FROM ifrsrpdb..JH_EXLOAN_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\放款表外明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
 --(3)信用卡明細  
  bcp "  SELECT * FROM ifrsrpdb..JH_CCARD_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\信用卡明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
 --(4)債券明細 
  bcp "  SELECT * FROM ifrsrpdb..JH_BOND_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\債券明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
 --(5)人工一般評估明細
 bcp "  SELECT * FROM ifrsrpdb..JH_ARTI_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\人工一般評估明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(6)人工個案評估明細
 bcp "  SELECT * FROM ifrsrpdb..JH_ARTICASE_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\人工個案評估明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(7)放款呆帳案件沖銷明細
 bcp "  SELECT * FROM ifrsrpdb..JH_BADDEBIT "       queryout "e:\放款呆帳案件沖銷明細.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(8)總帳檔
 bcp "  SELECT * FROM ifrsrpdb..JH_CHK_LEDGER_HIST_INFO WHERE PK_SYS =  (SELECT MAX(PK_SYS) FROM ifrsrpdb..B_SYS_CONFIG)"       queryout "e:\總帳檔.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(9)擔保品公允價值
 bcp "  SELECT * FROM ifrsrpdb..JH_COLLATERAL_FV "       queryout "e:\擔保品公允價值.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(10)參數檔
 bcp "  SELECT * FROM ifrsrpdb..JH_LOSS_ESTPARM_MULTI  WHERE PARM_TYPE = 'DEBT_REC' "       queryout "e:\參數檔.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(11)會計科目檔
 bcp "  SELECT * FROM ifrsrpdb..JH_CDE_ACCOUNT   "       queryout "e:\會計科目檔.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(12)新舊帳戶檔
 bcp "  SELECT * FROM ifrsrpdb..JH_NEW_OLDID   "       queryout "e:\新舊帳戶檔.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99
--(13)新舊帳號串聯檔
 bcp "  SELECT * FROM ifrsrpdb..JH_NEW_OLDAC   "       queryout "e:\新舊帳號串聯檔.TXT"  -t "," -r "\n" -c -S10.20.41.211\  -Uifrs_SRV -PSKbank99