
--�d�ߩҦ��ϥΪ̵n�J�n�X�ɶ�
SELECT S.SPID, S.LOGINAME, S.LOGIN_TIME, S.LAST_BATCH, C.CLIENT_NET_ADDRESS 
FROM sys.sysprocesses S, sys.dm_exec_connections C 
WHERE S.spid = C.SESSION_ID


