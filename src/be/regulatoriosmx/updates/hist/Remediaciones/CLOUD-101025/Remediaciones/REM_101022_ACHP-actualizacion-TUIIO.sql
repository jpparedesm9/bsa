--Solicito de su apoyo para asignar los siguientes clientes del 
--usuario Sonia Lovera Pascual (slovera) para asignar al asesor a 
--Jaqueline Galindo Reyes (jgalindo.


USE cobis 
go
--172 OFICIAL - 2404 OFICINA - gRUPO 276


--1.-
--actualizacion en la cl_ente de slovera a jgalindo
UPDATE cobis..cl_ente 
SET en_oficial    = 172,
    c_funcionario = 'jgalindo',
    en_oficina    = 2404
WHERE en_ente in (16972,6977,7000,7007,7014,7196,7323,7416)
                  
update cobis..cl_grupo
set gr_oficial = 172
where gr_grupo = 276

update cobis..cl_cliente_grupo  
set cg_usuario = 'jgalindo'
where cg_grupo = 276

go

--2.-
--actualizacion en la ca_operacion de slovera a jgalindo 

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 172 
WHERE op_cliente in (16972,6977,7000,7007,7014,7196,7323,7416)

go

--3.-
--actualizacion en la cr_tramite de slovera a jgalindo 
UPDATE cob_credito..cr_tramite 
SET tr_usuario    = 'jgalindo',
    tr_usuario_apr= 'jgalindo',
    tr_oficial    = 172
WHERE tr_cliente in (16972,6977,7000,7007,7014,7196,7323,7416)

go
--Grupales

UPDATE cob_cartera..ca_operacion 
SET op_oficial = 172 
WHERE op_cliente = 276



UPDATE cob_credito..cr_tramite
SET tr_usuario    = 'jgalindo',
    tr_usuario_apr= 'jgalindo',
    tr_oficial    = 172
WHERE tr_cliente = 276

go


--3.-
--actualizacion en la ca_operacion_his de slovera a jgalindo 

UPDATE cob_cartera..ca_operacion_his 
SET oph_oficial = 172 
WHERE oph_cliente in (16972,6977,7000,7007,7014,7196,7323,7416)
