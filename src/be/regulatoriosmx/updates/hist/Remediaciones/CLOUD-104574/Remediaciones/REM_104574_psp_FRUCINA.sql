--BUEN DIA FAVOR DE APOYARNOS CON LA SIGUIENTE REASIGNACION:
--
--ASESOR ACTUAL: FRANCISCO JAVIER RAMIREZ CHOPIN (fjramirez)
--ASESOR PARA REASIGNACION: JAMMY IVONNE BARRON ZUÑIGA (jibarron)
--
--Prospecto #420 FRUCINA GONZALEZ BARRIENTOS

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'jibarron' -- antes fjramirez
select @w_oficial_cod = 104 -- antes 54

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (420)
go
