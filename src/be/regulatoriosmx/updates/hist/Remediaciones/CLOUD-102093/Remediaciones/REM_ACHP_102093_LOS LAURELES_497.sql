--ASESOR ACTUAL: ucvelasco, URIEL CALIXTO VELASCO RUIZ.
--SE REASIGNA AL ASESOR: facoria, FIDEL ANTONIO CORIA HERNANDEZ.
--Grupo #497 LOS LAURELES

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 497
select @w_oficial_login = 'facoria'
select @w_oficial_cod = 179
select @w_oficina = 2403

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (12880,12884,12922,12928,12935,13016,13279,13380)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (12880,12884,12922,12928,12935,13016,13279,13380)

UPDATE cob_credito..cr_tramite 
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (12880,12884,12922,12928,12935,13016,13279,13380)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (12880,12884,12922,12928,12935,13016,13279,13380)

--Grupo
update cobis..cl_grupo
set    gr_oficial = @w_oficial_cod
where  gr_grupo   = @w_grupo

update cobis..cl_cliente_grupo  
set    cg_usuario = @w_oficial_login
where  cg_grupo   = @w_grupo

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente = @w_grupo

UPDATE cob_credito..cr_tramite
SET    tr_usuario     = @w_oficial_login,
       tr_usuario_apr = @w_oficial_login,
       tr_oficial     = @w_oficial_cod
WHERE  tr_cliente     = @w_grupo

go
