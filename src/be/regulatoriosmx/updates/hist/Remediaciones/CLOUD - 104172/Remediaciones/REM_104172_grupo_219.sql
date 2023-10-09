--En el ticket #103609 se solicito la reasginación de cartera al asesor JUAN CARLOS ROSALES ROLDAN.
--Dentro de esta reasignación se incluian diversos grupos como el 344 - zapatitos y la integrante 8503 - Araceli Luna Nuñez estaba considerada.
--Al consultarla en sistema muestra que este cliente no tiene asesor asignado.
--Adicional se tiene el prospecto 10085 con el mismo error.
--Necesitamos atención urgente para revisar que la cartera del asesor se encuentra bien asignada.
--Se anexa evidencia

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 219
select @w_oficial_login = 'jcrosalesro' -- antes facoria
select @w_oficial_cod = 264 -- 112 antes
select @w_oficina = 2403 -- 2403 antes
-- para rollBack 5872, 5946

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (SELECT cg_ente FROM cobis..cl_cliente_grupo WHERE cg_grupo = @w_grupo)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (SELECT cg_ente FROM cobis..cl_cliente_grupo WHERE cg_grupo = @w_grupo)

UPDATE cob_credito..cr_tramite   -- validar si para todos los tramites
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (SELECT cg_ente FROM cobis..cl_cliente_grupo WHERE cg_grupo = @w_grupo)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (SELECT cg_ente FROM cobis..cl_cliente_grupo WHERE cg_grupo = @w_grupo)

--Grupo
update cobis..cl_grupo
set    gr_oficial = @w_oficial_cod
where  gr_grupo   = @w_grupo

update cobis..cl_cliente_grupo  
set    cg_usuario = @w_oficial_login
where  cg_grupo   = @w_grupo
and    cg_ente  in (SELECT cg_ente FROM cobis..cl_cliente_grupo WHERE cg_grupo = @w_grupo AND cg_estado = 'V')

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente = @w_grupo

UPDATE cob_credito..cr_tramite
SET    tr_usuario     = @w_oficial_login,
       tr_usuario_apr = @w_oficial_login,
       tr_oficial     = @w_oficial_cod
WHERE  tr_cliente     = @w_grupo

--Se añadio preguntar
UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente = @w_grupo

go
