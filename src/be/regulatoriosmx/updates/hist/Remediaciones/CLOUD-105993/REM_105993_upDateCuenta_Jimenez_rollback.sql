--BUEN DIA FAVOR DE CAMBIAR LA CUENTA QUE ACTUALMENTE TIENE EL CLIENTE EN MENCION, YA QUE LA QUE ESTA ACTUALMENTE SE ENCUENTRA CANCELADA Y PARA FUTURA RENOVACION ESTA ES LA CUENTA A LA QUE SE LE VA A DISPERSAR:
--
--BRICIA MARIBEL JIMENEZ RODRIGUEZ
--ID : 1115
--CUENTA EN COBIS: 025000274894
--CUENTA QUE SE SOLICITA VINCULAR: 60-60226567-9--060602265679
--CODIGO DE CLIENTE 44540236

use cobis
go

print 'Caso 105870 - Cliente: 12499 - selec'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 1115
select @w_cuenta = '025000274894' -- antes cuenta 025000274894
select @w_buc = '44540236' --antes buc 44540236
select @w_num_operacion = 79835 -- se envia por que tiene estado 1

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
