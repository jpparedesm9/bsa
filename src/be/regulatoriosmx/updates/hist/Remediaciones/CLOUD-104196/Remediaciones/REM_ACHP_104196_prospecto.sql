--BUEN DIA FAVOR DE REASIGNAR EL PROSPECTO EN MENCION.
--
--CLIENTE: MARIA MAGDALENA SANTANA NUÑEZ 7886
--
--ASESOR ACTUAL: Asesor David Varela Valdés con usuario de COBIS "dvarela"
--ASESOR PARA REASIGNAR: Migue Reyes Garay con el usuario de "mreyesga"

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'mreyesga' -- dvarela
select @w_oficial_cod = 206 -- ante 98
select @w_oficina = 2377 --2377

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (7886)
go
