--Asesor acutual: Prudencio Hernández Hernández 
--Usuario COBIS: Phernandezhe
--
--Asesor para reasignar: María Guadalupe Hernández Barrios
--Usuario Cobis: mghernandezba
--
--LLINET BERENICE GARCIA GALAN
--Código cliente: 10983


USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'phernandezhe' -- antes phernandezhe
select @w_oficial_cod = 107 -- antes 107

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (10983)
go
