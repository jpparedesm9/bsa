--17311 JULIA MONTALVO DE JESUS
--ASESOR ACTUAL: ARTURO ARCOS FLORES (aarcosfl)-157
--ASESOR PARA REASIGNAR: JUAN CARLOS ROSALES ROLDAN (jcrosalesro)-264

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'aarcosfl' -- antes aarcosfl
select @w_oficial_cod = 157 -- antes 157

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (17311)
go
