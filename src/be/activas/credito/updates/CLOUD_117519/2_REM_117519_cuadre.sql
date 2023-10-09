USE cob_conta
go

SELECT  * FROM cob_conta..cb_plan_general  
WHERE pg_cuenta='14019101'

DELETE FROM cob_conta..cb_plan_general  
WHERE pg_cuenta='14019101'

SELECT  *
INTO #plan_general
FROM cob_conta..cb_plan_general  
WHERE pg_cuenta ='11020201'

UPDATE #plan_general SET 
pg_cuenta='14019101', --cuenta DEL banco
pg_clave='14019101'+convert(VARCHAR, pg_oficina)+convert(VARCHAR, pg_area)

INSERT cob_conta..cb_plan_general 
SELECT * FROM #plan_general 

SELECT * FROM #plan_general
go
