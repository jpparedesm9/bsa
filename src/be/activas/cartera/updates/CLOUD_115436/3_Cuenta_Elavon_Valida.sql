---Actualizo cuenta openpay
--DROP TABLE #plan_general

USE cob_conta
GO
IF NOt EXISTS(SELECT 1 FROM cob_conta..cb_cuenta 
WHERE cu_cuenta='14019101')
BEGIN
UPDATE cob_conta..cb_cuenta  
SET cu_nombre='ELAVON',
    cu_descripcion='ELAVON',
    cu_cuenta='14019101'
    WHERE cu_cuenta='14910101'
end    
go
--Inserto en el plan general


IF NOT EXISTS(SELECT  *
FROM cob_conta..cb_plan_general  
WHERE pg_cuenta='14019101')
BEGIN
SELECT  *
INTO #plan_general
FROM cob_conta..cb_plan_general  
WHERE pg_cuenta ='11020201'

UPDATE #plan_general SET 
pg_cuenta='14019101', --cuenta DEL banco
pg_clave='14019101'+convert(VARCHAR, pg_oficina)+convert(VARCHAR, pg_area)
INSERT cob_conta..cb_plan_general 
SELECT * FROM #plan_general 
end

GO
---ca_producto
USE cob_cartera

GO
/*SELECT cp_codvalor,cp_producto,*
FROM cob_cartera..ca_producto
WHERE cp_producto='SANTANDER'
GROUP BY cp_producto
ORDER BY cp_codvalor*/




IF NOT EXISTS(SELECT 1 
FROM cob_cartera..ca_producto
WHERE cp_producto='ELAVON')
BEGIN
SELECT * 
INTO #ca_forma_pago
FROM cob_cartera..ca_producto
WHERE cp_producto='SANTANDER'


UPDATE #ca_forma_pago SET 
cp_producto='ELAVON',
cp_descripcion='ELAVON',
cp_codvalor='141',--hacer consulta en prod es el maximo+1 de la ca_producto
cp_producto_reversa='ELAVON'

INSERT cob_cartera..ca_producto
SELECT * FROM #ca_forma_pago 
end

GO
 ---det perfil
 
USE cob_conta
GO

IF NOT EXISTS(SELECT * FROM cob_conta..cb_det_perfil
               WHERE dp_perfil='CCA_RPA'
               AND dp_codval=141)
BEGIN               

SELECT TOP 1 *
INTO #pago_perfil_det_rpa
FROM cob_conta..cb_det_perfil
WHERE dp_perfil='CCA_RPA'
AND  dp_asiento=9

UPDATE #pago_perfil_det_rpa
SET dp_asiento=10,
dp_codval=141

INSERT cob_conta..cb_det_perfil
SELECT * FROM #pago_perfil_det_rpa 

END
go
---parametro


IF NOT EXISTS(SELECT  *
FROM cob_conta..cb_relparam 
WHERE re_clave='ELAVON'
AND   re_substring='14019101')
BEGIN

SELECT  * 
INTO #parametro
FROM cob_conta..cb_relparam 
WHERE re_parametro='F_PAGO'
AND   re_clave='SANTANDER'

UPDATE #parametro
SET re_clave='ELAVON',
re_substring='14019101'--cuenta del banco
INSERT cob_conta..cb_relparam
SELECT * FROM #parametro 
END
go


USE cob_cartera
GO
--ca_corresponsal


IF NOT EXISTS(SELECT 1
from cob_cartera..ca_corresponsal 
where co_nombre='ELAVON')
BEGIN
DECLARE
@w_max INT 

SELECT @w_max=co_id+1 FROM cob_cartera..ca_corresponsal 

SELECT * 
INTO #ca_corresponsal_tmp
from cob_cartera..ca_corresponsal 
where co_nombre = 'SANTANDER'

UPDATE #ca_corresponsal_tmp 
SET
co_id= @w_max,
co_nombre='ELAVON',
co_descripcion='ELAVON',
co_estado='I'

INSERT INTO cob_cartera..ca_corresponsal 
SELECT * FROM #ca_corresponsal_tmp
END
go

USE cob_conta
go

IF NOT EXISTS(SELECT 1 FROM cob_conta..cb_codigo_valor 
              WHERE cv_codval=141 
              AND   cv_descripcion='ELAVON'  )
 BEGIN
     SELECT * 
     INTO #cb_codigo_valor_temp
     FROM  cob_conta..cb_codigo_valor
     WHERE cv_descripcion='BANCO SANTANDER'
     
     UPDATE #cb_codigo_valor_temp SET 
     cv_codval=141,
     cv_descripcion='ELAVON'
     
     INSERT cob_conta..cb_codigo_valor
     SELECT * FROM #cb_codigo_valor_temp 

  END 




