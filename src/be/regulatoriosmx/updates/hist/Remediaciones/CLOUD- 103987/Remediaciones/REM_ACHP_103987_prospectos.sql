--BUEN DIA FAVOR DE APOYARNOS CON LA SIGUIENTE REASIGNACION:
--
--21355 GUADALUPE HERNANDEZ REYES 
--ASESOR ACTUAL: fibarral FRANCISCO IBARRA LEINES  - fibarral
--ASESOR PARA REASIGNAR: aramosm ALICIA RAMOS MEJIA - aramosm
--

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'aramosm'
select @w_oficial_cod = 150
select @w_oficina = 1053

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (21355)
go
