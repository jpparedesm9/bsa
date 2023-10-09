--BUEN DIA FAVOR DE APOYARNOS CON LA REASIGNACION DEL SIGUIENTE PROSPECTO:
--
--#8508 MA. DEL CARMEN GARCIA NAVARRETE
--ASESOR ACTUAL: Mirna Ivonne Valdez Ascensión con usuario mivaldez
--ASESOR PARA REASIGNAR: Roció Hernández Galindo con usuario rhernandezg



USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'rhernandezg' -- antes mivaldez
select @w_oficial_cod = 144 -- antes 106

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login--,
       --en_oficina    = @w_oficina
WHERE  en_ente in (8508)
go
