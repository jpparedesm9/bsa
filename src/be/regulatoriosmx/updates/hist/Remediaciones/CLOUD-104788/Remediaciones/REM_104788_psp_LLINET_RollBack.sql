--Asesor acutual: Prudencio Hern�ndez Hern�ndez 
--Usuario COBIS: Phernandezhe
--
--Asesor para reasignar: Mar�a Guadalupe Hern�ndez Barrios
--Usuario Cobis: mghernandezba
--
--LLINET BERENICE GARCIA GALAN
--C�digo cliente: 10983


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
