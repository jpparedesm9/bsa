--ASESOR ASIGNADO: Raúl Martínez Ríos Usuario rmartinezrio-rmartinezrio
--ASESOR A REASIGNAR: Jonathan Trejo Rodríguez Usuario jtrejoro-jtrejoro

--CLIENTES:
--35975 - Laura Isela López Hernández
--36077 -Laiza Meredith Reyes Perez
--35516 - Rosa Isela Billanueva Marin

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'rmartinezrio' -- antes rmartinezrio
select @w_oficial_cod = 260 -- antes 260

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (35975,36077,35516)
go
