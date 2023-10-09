-- origen ucvelasco   ofi 2403-- 122
--destino amgutierrez  ofi 2403 -- 130
USE cobis 
GO
--1
UPDATE cobis..cl_ente  SET en_oficial=130,
c_funcionario='amgutierrez' WHERE 
en_ente IN(7595,7544,7551,7666,7871,7870,7955,7958,8103)
--2
UPDATE cobis..cl_cliente_grupo SET cg_usuario='amgutierrez'
WHERE cg_ente IN(7595,7544,7551,7666,7871,7870,7955,7958,8103)
--3
UPDATE cobis..cl_grupo SET gr_oficial=130
WHERE gr_grupo=306
-------------
--4
--tramite del grupo 2896
UPDATE cob_credito..cr_tramite SET tr_usuario='amgutierrez',tr_usuario_apr='amgutierrez',tr_oficial=130
WHERE tr_tramite=2501 AND tr_oficial=122 
--5
UPDATE cob_cartera..ca_operacion SET op_oficial=130
WHERE op_banco IN ('224030000463','224030000471','224030000489','224030000496','224030000505','224030000513',
'224030000521','224030000539','224030000547','224030000554')

--6


 UPDATE cob_cartera..ca_operacion_his SET oph_oficial=130 
 WHERE oph_banco IN ('224030000463','224030000471','224030000489','224030000496','224030000505','224030000513',
'224030000521','224030000539','224030000547','224030000554')
--7
 
UPDATE cob_cartera_his..ca_operacion SET op_oficial=130
WHERE op_banco IN ('224030000463','224030000471','224030000489','224030000496','224030000505','224030000513',
'224030000521','224030000539','224030000547','224030000554') 
--8
UPDATE cob_cartera_his..ca_operacion_his SET oph_oficial=130 
WHERE oph_banco  IN ('224030000463','224030000471','224030000489','224030000496','224030000505','224030000513',
'224030000521','224030000539','224030000547','224030000554')