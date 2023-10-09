--BUEN DIA , FAVOR DE APOYARNOS CON EL CAMBIO DE CUENTA DEL CLIENTE EN ENCION 
--YA QUE COBIS VINCULO UNA CUENTA QUE NO CORRESPONDE AL DEL CLIENTE, 
--SE ANEXA LOS DATOS CORRECTOS EN EL FICHERO.
--CLIENTE: EMMA LAURA RODRIGUEZ ADON 12499
--Número de cuenta: 060577662747
--Cliente santander: 29212460

use cobis
go

print 'Caso 105870 - Cliente: 12499 - selec'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 12499
select @w_cuenta = '060577662747' -- antes cuenta 056632906305
select @w_buc = '29212460' --antes buc 22879374
select @w_num_operacion = 77564 -- se envia por que tiene estado 1

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

go
