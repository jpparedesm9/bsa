--Solicito de su apoyo para la reasignación
--
--Asesor para reasignar: efabian Erika Fabián García
--Asesor actual: slovera Sonia Lovera Pascual
--
--#7816 Andrea Ruiz Gonzalez

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'efabian' -- antes slovera
select @w_oficial_cod = 283 -- antes 100

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (7816)
go
