-------------------------------
--CASO 109322 CAMBIO DE NOMBRE
-------------------------------
use cob_cartera
go


PRINT 'Total con diferencias'
SELECT count(1) FROM cob_cartera..ca_operacion, cobis..cl_grupo 
WHERE op_banco IN (SELECT tg_referencia_grupal FROM cob_credito..cr_tramite_grupal where tg_grupo = op_cliente)
AND op_cliente = gr_grupo
AND op_nombre<>gr_nombre


PRINT 'Registros con diferencias'
SELECT gr_nombre, op_nombre,* FROM cob_cartera..ca_operacion, cobis..cl_grupo 
WHERE op_banco IN (SELECT tg_referencia_grupal FROM cob_credito..cr_tramite_grupal where tg_grupo = op_cliente)
AND op_cliente = gr_grupo
AND op_nombre<>gr_nombre


PRINT 'Actualizando'
UPDATE cob_cartera..ca_operacion
SET op_nombre= gr_nombre
FROM  cob_cartera..ca_operacion, cobis..cl_grupo 
WHERE op_banco IN (SELECT tg_referencia_grupal FROM cob_credito..cr_tramite_grupal where tg_grupo = op_cliente)
AND op_cliente = gr_grupo
AND op_nombre<>gr_nombre


PRINT 'Despues, total con diferencias'
SELECT count(1) FROM cob_cartera..ca_operacion, cobis..cl_grupo 
WHERE op_banco IN (SELECT tg_referencia_grupal FROM cob_credito..cr_tramite_grupal where tg_grupo = op_cliente)
AND op_cliente = gr_grupo
AND op_nombre<>gr_nombre

PRINT 'Despues, total sin diferencias'
SELECT count(1) FROM cob_cartera..ca_operacion, cobis..cl_grupo 
WHERE op_banco IN (SELECT tg_referencia_grupal FROM cob_credito..cr_tramite_grupal where tg_grupo = op_cliente)
AND op_cliente = gr_grupo
AND op_nombre=gr_nombre

PRINT 'Despues, Registro sin diferencias'
SELECT gr_nombre, op_nombre,* FROM cob_cartera..ca_operacion, cobis..cl_grupo 
WHERE op_banco IN (SELECT tg_referencia_grupal FROM cob_credito..cr_tramite_grupal where tg_grupo = op_cliente)
AND op_cliente = gr_grupo
AND op_nombre=gr_nombre

go

