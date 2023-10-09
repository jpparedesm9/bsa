--MAITE DIAZ GARCÍA código 29285 
--SANTA SANCHEZ TORRES código 29186
--ASESOR ACTUAL: GUADALUPE SUSANA ROSALES PÉREZ gsrosales-gsrosales
--ASESOR PARA REASIGNAR: DULCE SELENE JERÓNIMO VILLA dsjeronimo-dsjeronimo


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
