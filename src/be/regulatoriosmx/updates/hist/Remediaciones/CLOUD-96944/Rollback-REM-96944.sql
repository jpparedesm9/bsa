--rollback
USE cobis 
go
--1.-
--actualizacion en la cl_ente
UPDATE cobis..cl_ente SET en_oficial=34,
c_funcionario='fjgarcialo' WHERE en_ente 
IN
(3927,4154,4244,4239,4153,3925,4280,4282,3940,4504)


UPDATE cobis..cl_grupo SET gr_oficial=34
WHERE gr_grupo=159

UPDATE cobis..cl_cliente_grupo SET cg_usuario='fjgarcialo'
WHERE cg_grupo=159

UPDATE cob_credito..cr_tramite SET tr_usuario='fjgarcialo',tr_usuario_apr='fjgarcialo'
WHERE tr_tramite=1271

UPDATE cob_cartera..ca_operacion SET op_oficial=34
WHERE op_tramite=1271 



SELECT * FROM cobis..cl_ente WHERE en_ente IN (3927,4154,4244,4239,4153,3925,4280,4282,3940,4504)

SELECT * FROM cobis..cl_grupo WHERE gr_grupo=159

SELECT * FROM cobis..cl_cliente_grupo WHERE cg_grupo=159  

SELECT * FROM cob_credito..cr_tramite WHERE tr_tramite=1271

SELECT * FROM cob_cartera..ca_operacion WHERE op_tramite=1271
go