--Se solicita la reasignación del cliente 25216 ALEJANDRA RUIZ ROJAS
--
--Usuario actual ARTURO ARCOS FLORES (aarcosfl)
--
--Usuario para reasignar JUAN CARLOS ROSALES ROLDAN (jrosalesro) -- NOtaDesarrollador.. el login es jcrosalesro


USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_oficial_login = 'aarcosfl'
select @w_oficial_cod = 157
select @w_oficina = 2403

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (25216)
go
