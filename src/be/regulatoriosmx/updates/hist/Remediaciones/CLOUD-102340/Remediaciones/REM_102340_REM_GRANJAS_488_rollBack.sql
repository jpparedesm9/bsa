--                                              Asesor actual                          Reasignacion asesor
--GRUPO: GRANJAS ID 488           Liliana Libertad Medina Figueroa llfigueroa     Oscar Fuentes Luna  ofuenteslu

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 488
select @w_oficial_login = 'llfigueroa'
select @w_oficial_cod = 147
select @w_oficina = 1032

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (11572,11573,11587,12019,12904,12905,13001,13199)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (11572,11573,11587,12019,12904,12905,13001,13199)

UPDATE cob_credito..cr_tramite 
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (11572,11573,11587,12019,12904,12905,13001,13199)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (11572,11573,11587,12019,12904,12905,13001,13199)

--Grupo
update cobis..cl_grupo
set    gr_oficial = @w_oficial_cod
where  gr_grupo   = @w_grupo

update cobis..cl_cliente_grupo  
set    cg_usuario = @w_oficial_login
where  cg_grupo   = @w_grupo
and    cg_ente    in (11572,11573,11587,12019,12904,12905,13001,13199)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente = @w_grupo

UPDATE cob_credito..cr_tramite
SET    tr_usuario     = @w_oficial_login,
       tr_usuario_apr = @w_oficial_login,
       tr_oficial     = @w_oficial_cod
WHERE  tr_cliente     = @w_grupo

go
