--SOLICITAMOS DE SU APOYO PARA REALIZAR EL CAMBIO DE CUENTA DE LA CLIENTA:
--11198 - ROSA VALDES ZALDIVAR
--CODIGO SANTANDER: 30420603
--CUENTA INCORRECTA: 25000592350-   en la base 025000592350
--CUENTA CORRECTA: 60604904473  --  correcta 060604904473

use cobis
go

print 'Caso 105947 - Cliente: 11198 - '
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int, @w_cuenta_act  varchar(24)
select @w_cliente = 11198
select @w_cuenta = '025000592350'
select @w_buc = '22879374' --antes buc 22879374
select @w_num_operacion = 75756 -- se envia por que tiene estado 1
select @w_cuenta_act = '060604904473'

--select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
update cobis..cl_ente
set    en_banco = @w_buc
where en_ente = @w_cliente

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

update cob_cartera..ca_det_trn
set    dtr_cuenta = @w_cuenta
where  dtr_secuencial in (1,5)
and    dtr_operacion  = @w_num_operacion
and    dtr_cuenta     = @w_cuenta_act

go

