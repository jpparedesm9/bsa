
--SOLICITAMOS DE SU APOYO PARA QURE SE ASIGNE EL GRUPO LAS SUPER PECASA AL ASESOR:JESSICA CORONA MARTINEZ
--USUARIO: JCORONA DE LA SUCURSAL DE CHALCO, YA QUE EL GRUPO NO ESTA ASIGNADO A NINGUN ASESOR.

USE cobis 
go
-- 1.-
-- actualización en la cl_ente de jcorona 
-- *8
UPDATE cobis..cl_ente 
SET en_oficial    = 43,
    c_funcionario = 'jcorona',
    en_oficina    = 3348
WHERE en_ente in (3487,3491,3494,3562,3573,3674,3675,3934)

--*1                  
update cobis..cl_grupo
set gr_oficial = 43
where gr_grupo = 128

--*8
update cobis..cl_cliente_grupo  
set cg_usuario = 'jcorona'
where cg_grupo = 128

go

--2.-
--actualizacion en la ca_operacion a jcorona  
--*8

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 43 
WHERE op_cliente in (3487,3491,3494,3562,3573,3674,3675,3934)

go

--3.-
--actualizacion en la cr_tramite a jcorona 
--*8
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'jcorona',
    tr_usuario_apr= 'jcorona',
    tr_oficial    = 43
WHERE tr_cliente in (3487,3491,3494,3562,3573,3674,3675,3934)

go
--Grupales
--*1
UPDATE cob_cartera..ca_operacion 
SET op_oficial = 43 
WHERE op_cliente = 128

--*1
UPDATE cob_credito..cr_tramite
SET tr_usuario    = 'jcorona',
    tr_usuario_apr= 'jcorona',
    tr_oficial    = 43
WHERE tr_cliente = 128

go


--3.-
--actualizacion en la ca_operacion_his a jcorona 
--*8
UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 43 
WHERE oph_cliente in (3487,3491,3494,3562,3573,3674,3675,3934)
                 
GO




