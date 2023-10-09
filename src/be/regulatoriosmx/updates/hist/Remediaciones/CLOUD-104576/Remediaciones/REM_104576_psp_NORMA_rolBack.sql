--BUEN DIA FAVOR DE APOYARNOS CON LA SIGUIENTE REASIGNACION:
--
--ASESOR ACTUAL: Paula Reséndiz Hernández con usuario presensizhe
--ASESOR PARA REASIGNACION: asesor Karla Arguelles Islas con usuario karguelles
--
--#5120 NORMA PATRICIA RAMOS GUERRA

USE cobis 
go

declare @w_oficial_login varchar(14), @w_oficial_cod int
select @w_oficial_login = 'karguelles' -- antes presensizhe
select @w_oficial_cod = 113 -- antes 85

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login
WHERE  en_ente in (5120)
go
