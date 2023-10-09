-- Buen dia favor de apoyarnos con los siguientes cambios de prospectos

-- #38 ANTONIO AMENEYRO GONZALEZ
-- #41 BEATRIZ SALDAÑA IBARRA
-- #39 CELIA VILLEGAS ROJAS
-- #40 DENISSE GARCIA PEREZ
-- #44 DIANA VALERIA ALVARADO PINEDA
-- #45 PATRICIA VILLEGAS PIÑA

-- PERTENECEN
-- ZAIRA TURINCIO PASCUAL
-- USUARIO. ZTURINCIO

-- REASIGNAR A:
-- SERGIO CRUZ GOMEZ
-- USUARIO:SCRUZGO

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
--select @w_grupo = 171
select @w_oficial_login = 'zturincio'
select @w_oficial_cod = 51
select @w_oficina = 3348

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (38,41,39,40,44,45)
go
