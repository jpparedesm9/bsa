--Por medio del presente solicito su apoyo para la reasignaci�n del prospecto
--
--Gloria Susana Morales R�os ID 4360
--
--Asesor Actual
--Francisco Javier Ram�rez Chopin Usuario fjramirez
--
--Asesor para Reasignar
--Maximino L�pez V�zquez Usuario malopezva

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'malopezva' -- antes fjramirez
select @w_oficial_cod = 72 -- antes 54

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (4360)
go
