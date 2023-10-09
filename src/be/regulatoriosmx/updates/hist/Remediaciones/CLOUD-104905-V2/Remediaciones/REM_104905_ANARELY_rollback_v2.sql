--ASESOR ACTUAL: : Rafael Aquino Altamirano con usuario: raquino
--ASESOR PARA REASIGNAR: Raúl Martínez Ríos con usuario: rmartinezrio

--NOTA 12
--Anarely Lugo Lorenzo ID 29262
--
--Nota: el ID anterior se encuentra incorrecto.
--
--Favor de apoyarnos en la correccion.
--

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'raquino' -- antes raquino
select @w_oficial_cod = 262 -- antes 262

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (29262)
go
