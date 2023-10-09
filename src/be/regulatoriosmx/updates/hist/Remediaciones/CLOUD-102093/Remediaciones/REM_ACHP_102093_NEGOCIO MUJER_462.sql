--ASESOR ACTUAL: mmlanda, Mónica Monserrat Landa Alarcón.
--SE REASIGNA AL ASESOR: yicedillo, Yamidt Itzel Cedillo Sánchez.
--Grupo #462 NEGOCIO MUJER

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 462
select @w_oficial_login = 'yicedillo'
select @w_oficial_cod = 189
select @w_oficina = 2403

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (12282,12295,12305,12395,12403,12405,12408,12413,12431)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (12282,12295,12305,12395,12403,12405,12408,12413,12431)

UPDATE cob_credito..cr_tramite
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (12282,12295,12305,12395,12403,12405,12408,12413,12431)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (12282,12295,12305,12395,12403,12405,12408,12413,12431)

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
