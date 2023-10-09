use cobis
go

--BUEN DÍA FAVOR DE APOYARNOS CON EL CAMBIO DE CUENTA DEL CLIENTE EN MENCIÓN.
--EMIGDIO MIGUEL MARTINEZ SALINAS ID: 1431

print 'Caso 111995 - Cliente: 1431'

declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 1431
select @w_cuenta = '60602286339'-- antes cuenta 25000277106
--select @w_buc = '44540236'--antes buc 44540236
select @w_num_operacion = 197516-- se envia por que tiene estado 1

--select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
--update cobis..cl_ente
--set    en_banco = @w_buc
--where en_ente = @w_cliente

--select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
update cobis..cl_ente_aux 
set    ea_cta_banco = @w_cuenta
where ea_ente = @w_cliente

--select dm_cuenta, * from cob_cartera..ca_desembolso where dm_operacion in (select op_operacion from cob_cartera..ca_operacion where op_cliente = @w_cliente)
update cob_cartera..ca_desembolso 
set    dm_cuenta = @w_cuenta
where  dm_operacion = @w_num_operacion

--select op_cuenta, * from cob_cartera..ca_operacion where op_cliente = @w_cliente
update cob_cartera..ca_operacion 
set    op_cuenta    = @w_cuenta
where  op_operacion = @w_num_operacion

update cob_cartera..ca_operacion_his
set    oph_cuenta    = @w_cuenta
where  oph_operacion = @w_num_operacion

update cob_cartera_his..ca_operacion
set    op_cuenta    = @w_cuenta
where  op_operacion = @w_num_operacion

update cob_cartera_his..ca_operacion_his
set    oph_cuenta    = @w_cuenta
where  oph_operacion = @w_num_operacion

go
