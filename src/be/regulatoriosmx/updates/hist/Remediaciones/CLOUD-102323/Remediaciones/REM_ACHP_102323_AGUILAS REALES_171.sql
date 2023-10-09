--BUEN DIA, FAVOR DE APOYARNOS PARA REASIGNAR EL SIGUIENTE GRUPO:

--GRUPO:
--AGUILAS REALES
--ID:9001.18.000154
--GRUPO: 171

--PERTENECEN:
--MIGUEL ANGEL REYES GONZALEZ
--USUARIO: MAREYESGO

--ASIGNACION:
--DANTE VAZQUEZ SAAVEDRA
--USUARIO: DVAZQUEZSA  -- se corrigue a DAVAZQUEZSA


USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 171
select @w_oficial_login = 'davazquezsa'
select @w_oficial_cod = 50
select @w_oficina = 3348

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (4538,4553,4558,4560,4565,4589,4593,4662,4675)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (4538,4553,4558,4560,4565,4589,4593,4662,4675)

UPDATE cob_credito..cr_tramite 
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (4538,4553,4558,4560,4565,4589,4593,4662,4675)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (4538,4553,4558,4560,4565,4589,4593,4662,4675)

--Grupo
update cobis..cl_grupo
set    gr_oficial = @w_oficial_cod
where  gr_grupo   = @w_grupo

update cobis..cl_cliente_grupo  
set    cg_usuario = @w_oficial_login
where  cg_grupo   = @w_grupo
and    cg_ente    in (4538,4553,4558,4560,4565,4589,4593,4662,4675)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente = @w_grupo

UPDATE cob_credito..cr_tramite
SET    tr_usuario     = @w_oficial_login,
       tr_usuario_apr = @w_oficial_login,
       tr_oficial     = @w_oficial_cod
WHERE  tr_cliente     = @w_grupo

go
