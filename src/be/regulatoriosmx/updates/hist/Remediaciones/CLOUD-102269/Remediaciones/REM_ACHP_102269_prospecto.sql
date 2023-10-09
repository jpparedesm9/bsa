--Asesor actual: Jorge Alberto Villa Bahena
--Asesor para reasignar: Yeraldin Yurico Ortega Barrios 
--Elvia Vences Valerio 
--Noemi Vences Valerio #16671.

--BUEN DIA FAVOR DE SOLAMENTE CAMBIAR A:
--Noemi Vences Valerio #16671.



USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int

select @w_oficial_login = 'yyortega'
select @w_oficial_cod = 214
select @w_oficina = 1479

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (16671)
go
