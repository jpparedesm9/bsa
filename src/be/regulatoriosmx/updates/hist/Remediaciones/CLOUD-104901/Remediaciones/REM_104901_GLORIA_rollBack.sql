--Por medio del presente solicito su apoyo para la reasignación del prospecto
--
--Gloria Susana Morales Ríos ID 4360
--
--Asesor Actual
--Francisco Javier Ramírez Chopin Usuario fjramirez
--
--Asesor para Reasignar
--Maximino López Vázquez Usuario malopezva

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'fjramirez' -- antes fjramirez
select @w_oficial_cod = 54 -- antes 54

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (4360)
go
