--MAITE DIAZ GARC�A c�digo 29285 
--SANTA SANCHEZ TORRES c�digo 29186
--ASESOR ACTUAL: GUADALUPE SUSANA ROSALES P�REZ gsrosales-gsrosales
--ASESOR PARA REASIGNAR: DULCE SELENE JER�NIMO VILLA dsjeronimo-dsjeronimo


USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'gsrosales' -- antes gsrosales
select @w_oficial_cod = 171 -- antes 171

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (29186,29285)
go
