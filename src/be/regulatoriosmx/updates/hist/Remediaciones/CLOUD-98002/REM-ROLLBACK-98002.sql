
--108 ivillafranca 
--119 ljimenezp


USE cobis 
GO
--1
UPDATE cobis..cl_ente  SET en_oficial=108,
c_funcionario='ivillafranca' WHERE en_oficial=119

--2
UPDATE cobis..cl_cliente_grupo SET cg_usuario='ivillafranca'
WHERE cg_usuario='ljimenezp'

--3
UPDATE cobis..cl_grupo SET gr_oficial=108
WHERE gr_oficial=119

--4
UPDATE cob_credito..cr_tramite SET tr_usuario='ivillafranca',tr_usuario_apr='ivillafranca',tr_oficial=108
WHERE tr_oficial=119

--5
UPDATE cob_cartera..ca_operacion SET op_oficial=108
WHERE op_oficial=119 

--6
IF EXISTS (SELECT 1 FROM cob_cartera..ca_operacion_his WHERE oph_oficial=119)
BEGIN
 UPDATE cob_cartera..ca_operacion_his SET oph_oficial=108 WHERE oph_oficial=119
END


--7
IF EXISTS (SELECT 1 FROM cob_cartera_his..ca_operacion WHERE op_oficial=119)
BEGIN

 UPDATE cob_cartera_his..ca_operacion SET op_oficial=108 WHERE op_oficial=119
 
END
--8
UPDATE cob_cartera_his..ca_operacion_his SET oph_oficial=108 WHERE oph_oficial=119

--Retorno de valores

--1
SELECT * FROM cobis..cl_ente WHERE en_oficial=108

--2
SELECT * FROM cobis..cl_grupo WHERE  gr_oficial=108

--3
SELECT cg_usuario,* FROM cobis..cl_cliente_grupo WHERE cg_usuario='ivillafranca'

--4
SELECT  tr_oficial,tr_usuario, * FROM cob_credito..cr_tramite WHERE tr_oficial=108

--5
SELECT op_oficial,* FROM cob_cartera..ca_operacion WHERE op_oficial=108 

--6
SELECT oph_oficial,* FROM cob_cartera..ca_operacion_his WHERE oph_oficial=108

--7
SELECT op_oficial,* FROM cob_cartera_his..ca_operacion WHERE op_oficial=108

--8
SELECT  oph_oficial,* FROM cob_cartera_his..ca_operacion_his WHERE oph_oficial=108
go
