--#5636 MARLENE HERNANDEZ MIRANDA 
--PERTENECE: JOEL OROCIO LOPEZ USUARIO: jororcio 
--REASIGNAR A : URBANO CONCHILLOS RAMIREZ USUARIO: uconchillos


USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'uconchillos'
select @w_oficial_cod = 156
select @w_oficina = 2403

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (5636)

go
