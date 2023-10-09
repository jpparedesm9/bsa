--Buen dia se solicita la reasignacion de dos personas actualmente se encuentra 
--con el asesor JESSICA CORONA MARTINEZ USUARIO:ZTURINCIO y el asesor que se va a 
--reasignar es a DANTE ALEJANDRO VAZQUEZ SAAVEDRA USUARIO: JCORONA (no vale este)
--DANTE VAZQUEZ SAAVEDRA ---- USUARIO: DAVAZQUEZSA (cambiar a este)

--3486 Elizabeth Hernandez Ibañez
--3568 Ofelia Ibañez Martinez

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'davazquezsa'
select @w_oficial_cod = 50
select @w_oficina = 3348

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (3486,3568)
go
