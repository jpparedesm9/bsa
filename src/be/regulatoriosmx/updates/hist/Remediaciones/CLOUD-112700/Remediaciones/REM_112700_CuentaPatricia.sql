-- BUEN DIA FAVOR DE APOYARNOS CON EL CAMBIO DE CUENTA DEL CLIENTE EN MENCION , YA QUE LA QUE TIENE ACTUALMENTE ESTA CANCELADA.
-- CLIENTE: PATRICIA DE JESUS SANTIAGO con ID 83662

use cobis
go

print 'Caso 112700 - Cliente: 83662'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 83662
select @w_cuenta = '56718001482' -- antes cuenta 56681727678
--select @w_buc = '' --antes buc 
--select @w_num_operacion =  -- se envia por que tiene estado 1

--select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
--update cobis..cl_ente
--set    en_banco = @w_buc
--where en_ente = @w_cliente

--select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
update cobis..cl_ente_aux 
set    ea_cta_banco = @w_cuenta
where ea_ente = @w_cliente

--select dm_cuenta, * from cob_cartera..ca_desembolso where dm_operacion in (select op_operacion from cob_cartera..ca_operacion where op_cliente = @w_cliente)
--update cob_cartera..ca_desembolso 
--set    dm_cuenta = @w_cuenta
--where  dm_operacion = @w_num_operacion
--
----select op_cuenta, * from cob_cartera..ca_operacion where op_cliente = @w_cliente
--update cob_cartera..ca_operacion 
--set    op_cuenta    = @w_cuenta
--where  op_operacion = @w_num_operacion
--
--update cob_cartera..ca_operacion_his
--set    oph_cuenta    = @w_cuenta
--where  oph_operacion = @w_num_operacion
--
--update cob_cartera_his..ca_operacion
--set    op_cuenta    = @w_cuenta
--where  op_operacion = @w_num_operacion
--
--update cob_cartera_his..ca_operacion_his
--set    oph_cuenta    = @w_cuenta
--where  oph_operacion = @w_num_operacion
go
