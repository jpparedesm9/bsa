
--Favor de asignar los siguientes clientes del usuario Sonia Lovera 
--Pascual (slovera) para asignar a Jaqueline Galindo Reyes (jgalindo.

--172 OFICIAL - 2404 OFICINA - gRUPO 333

USE cobis 
go
--1.-
--actualizacion en la cl_ente de slovera a jgalindo 
--*8
UPDATE cobis..cl_ente 
SET en_oficial    = 172,
    c_funcionario = 'jgalindo',
    en_oficina    = 2404
WHERE en_ente in (8311,8313,8477,8934,8936,8941,8959,9002)

--*1                  
update cobis..cl_grupo
set gr_oficial = 172
where gr_grupo = 333

--*8
update cobis..cl_cliente_grupo  
set cg_usuario = 'jgalindo'
where cg_grupo = 333

go

--2.-
--actualizacion en la ca_operacion de slovera a jgalindo  
--*8

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 172 
WHERE op_cliente in (8311,8313,8477,8934,8936,8941,8959,9002)

go

--3.-
--actualizacion en la cr_tramite de slovera a jgalindo 
--*8
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'jgalindo',
    tr_usuario_apr= 'jgalindo',
    tr_oficial    = 172
WHERE tr_cliente in (8311,8313,8477,8934,8936,8941,8959,9002)

go
--Grupales
--*1
UPDATE cob_cartera..ca_operacion 
SET op_oficial = 172 
WHERE op_cliente = 333

--*1
UPDATE cob_credito..cr_tramite
SET tr_usuario    = 'jgalindo',
    tr_usuario_apr= 'jgalindo',
    tr_oficial    = 172
WHERE tr_cliente = 333

go


--3.-
--actualizacion en la ca_operacion_his de de slovera a jgalindo 
--*8
UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 172 
WHERE oph_cliente in (8311,8313,8477,8934,8936,8941,8959,9002)
                 
GO




