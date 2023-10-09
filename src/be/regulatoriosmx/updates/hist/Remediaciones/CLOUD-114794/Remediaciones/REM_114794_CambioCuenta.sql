--BUEN DIA , SE TRATA DE CAMBIAR CUENTA EN LA HERRAMIENTA DE REGULARIZAR DISPERSIONES RECHAZADAS SIN EMBARGO EL SISTEMA ARROJA EL SIGUIENTE ERROR.
--POR FAVOR NECESITAMOS QUE NOS APOYEN CON EL CAMBIO PARA REALIZAR EL REINTENTO, ANEXO EL ESTAADO CUENTA PARA DICHO CAMBIO.
--CLIENTE: MARIANA MENDOZA RODRIGUEZ ID:95030

use cobis
go

print 'Caso 114794 - Cliente: 95030 - selec'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 95030
select @w_cuenta = '60608934106' -- antes cuenta 25002144616
select @w_num_operacion =  267632 -- se envia por que tiene estado 1

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
