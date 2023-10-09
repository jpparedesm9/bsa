--BUEN DIA FAVOR DE APOYARNOS EN CAMBIAR LA CUENTA QUE VINCULO COBIS , YA QUE ES UNA UENTA MANCOMUNADA EN DONDE 
--LA CLIENTA NO CUENTA YA CON ACCESO, ANEXO LOS DATOS DE LA CUENTA .
--
--CLIENTE: CLAUDIA SANTIAGO HERNANDEZ ID: 52777
--CUENTA INCORRECTA: 060594968622
--
--CUENTA CORRECTA: 060606276028-le pongo cero
--BUC: 43475102

use cobis
go

print 'Caso 108890 - Cliente: 52777'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 52777
select @w_cuenta = '060606276028' -- antes cuenta 060594968622
select @w_buc = '43475102' --antes buc 43475102
select @w_num_operacion = 126659 -- se envia por que tiene estado 1

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
