--FAVOR DE REALIZAR LA SIGUIENTE REASIGNACION
--ASESOR ASIGNADO: JUANA JASET FLORES GALINDO  Usuario: jjflores
--ASESOR A REASIGNAR: GUADALUPE SUSANA ROSALES PÉREZ Usuario gsrosales
--PROSPECTO
--REBECA CALDERON ASCENCIO ID 17130

USE cobis 
go

declare 
@w_oficial_login varchar(14),
@w_oficial_cod int


select 
@w_oficial_login = 'gsrosales', -- antes jjflores
@w_oficial_cod   =  171       -- antes 193


--Clientes
update cl_ente set 
en_oficial    = @w_oficial_cod,
c_funcionario = @w_oficial_login
where en_ente in (17130)
go

