--Soporte #113074 - CAMBIO DE CUENTA MARTHA ZAVALA
--BUEN DÍA FAVOR DE APOYARNOS CON EL CAMBIO DE CUENTA EN COBIS DEL CLIENTE EN MENCIÓN.
--CLIENTE: Martha Patricia Zavala Mendoza ID: 48343

--PRIMERO
use cobis
go

print 'Caso 105870 - Cliente: 12499 - selec'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 48343
select @w_cuenta = '60605798400' -- antes cuenta 56550712011

--select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
update cobis..cl_ente_aux 
set    ea_cta_banco = @w_cuenta
where  ea_ente = @w_cliente

go

--SEGUNDO
--FAVOR DE REALIZAR LOS SIGUIENTES CAMBIOS DE CUENTA 
--PARA REALIZAR LAS OPERACIONES EN EL MODULO DE REGULARIZACION
--
--MARIA DEL CARMEN CASTILLO BARRERA  --- Codigo 46861
--CUENTA CORRECTA: 25001995644
--CUENTA INCORRECTA: 56530519768

use cobis
go

print 'Cliente: 46861 - selec' --VIENE DEL 111815
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 46861
select @w_cuenta = '25001995644' -- antes cuenta 56530519768
select @w_num_operacion =  225494-- se envia por que tiene estado 1

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


--TERCERO
--FAVOR DE REALIZAR LOS SIGUIENTES CAMBIOS DE CUENTA 
--PARA REALIZAR LAS OPERACIONES EN EL MODULO DE REGULARIZACION

--ANA LUISA GALINDO PENAFLOR   --- Codigo 47560
--CUENTA CORRECTA: 25001996056
--CUENTA INCORRECTA: 56693985817
use cobis
go

print 'Cliente: 47560 - selec' --VIENE DEL 111815
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 47560
select @w_cuenta = '25001996056'-- antes cuenta 56693985817
select @w_num_operacion = 225497-- se envia por que tiene estado 1

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
