--Se solicita la reasignación del grupo 223 SCARLET.
--
--ASESOR ACTUAL: URBANO CONCHILLOS RAMIREZ (uconchillos)
--ASESOR PARA REASIGNAR: YAMIDT ITZEL CEDILLO SANCHEZ (yicedillo)
--
--5378 Urbano Conchillos Ramirez GAMA VAZQUEZ RICARDO
--5389 Urbano Conchillos Ramirez SANTIAGO SANCHEZ MARIA GUADALUPE
--5679 Urbano Conchillos Ramirez HERNANDEZ ANDRES YANEDITH GUADALUPE
--5901 Urbano Conchillos Ramirez GARCIA MARTINEZ HILARIA MARGARITA
--13857 Urbano Conchillos Ramirez ROJAS GONZALEZ FANY EVELIN
--13861 Urbano Conchillos Ramirez GONZALEZ EUGENIO ALICIA
--22933 Urbano Conchillos Ramirez CASTILLO CABRERA JANETH MARIA
--23451 Urbano Conchillos Ramirez REGALADO TOVAR MARIA DEL ROCIO

USE cobis 
go

declare @w_grupo int, @w_oficial_login varchar(14), @w_oficial_cod int, @w_oficina int
select @w_grupo = 223
select @w_oficial_login = 'uconchillos'
select @w_oficial_cod = 156
select @w_oficina = 2403

--Clientes
UPDATE cobis..cl_ente 
SET    en_oficial    = @w_oficial_cod,
       c_funcionario = @w_oficial_login,
       en_oficina    = @w_oficina
WHERE  en_ente in (5378,5389,5679,5901,13857,13861,22933,23451)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente in (5378,5389,5679,5901,13857,13861,22933,23451)

UPDATE cob_credito..cr_tramite 
SET    tr_usuario    = @w_oficial_login,
       tr_usuario_apr= @w_oficial_login,
       tr_oficial    = @w_oficial_cod
WHERE  tr_cliente in (5378,5389,5679,5901,13857,13861,22933,23451)

UPDATE cob_cartera..ca_operacion_his 
SET    oph_oficial = @w_oficial_cod 
WHERE  oph_cliente in (5378,5389,5679,5901,13857,13861,22933,23451)

--Grupo
update cobis..cl_grupo
set    gr_oficial = @w_oficial_cod
where  gr_grupo   = @w_grupo

update cobis..cl_cliente_grupo  
set    cg_usuario = @w_oficial_login
where  cg_grupo   = @w_grupo
and    cg_ente    in (5378,5389,5679,5901,13857,13861,22933,23451)

UPDATE cob_cartera..ca_operacion 
SET    op_oficial = @w_oficial_cod 
WHERE  op_cliente = @w_grupo

UPDATE cob_credito..cr_tramite
SET    tr_usuario     = @w_oficial_login,
       tr_usuario_apr = @w_oficial_login,
       tr_oficial     = @w_oficial_cod
WHERE  tr_cliente     = @w_grupo

go
