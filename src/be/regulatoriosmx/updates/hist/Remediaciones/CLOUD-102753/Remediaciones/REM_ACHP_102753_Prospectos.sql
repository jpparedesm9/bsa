--BUEN DIA FAVOR DE APOYARNOS CON LOS SIGUIENTES CAMBIOS DE PROSPECTOS
--
--#5200 SUALIANA OROZCO ANZURES
--#63 MANUEL DE JESUS RAMOS VAZQUEZ
--
--PERTENECIAN A
--ZAIRA TURINCIO PASCUAL
--USUARIO: ZTURINCIO
--
--MIGRACION A:
--ERIKA MONTES BAZ
--USUARIO:EMONTESBA

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'emontesba'
select @w_oficial_cod = 229
select @w_oficina = 3348


--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (5200,63)

go
