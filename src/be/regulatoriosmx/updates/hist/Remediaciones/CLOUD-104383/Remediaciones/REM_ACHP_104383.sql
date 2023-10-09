use cob_credito
go

declare @w_cliente int

select @w_cliente = 8288
print 'Select de tablas buro'

select * from cr_buro_cuenta
where bc_id_cliente = @w_cliente

select * from cr_buro_resumen_reporte
where br_id_cliente = @w_cliente

select * from cr_interface_buro
where ib_cliente = @w_cliente

print 'insert de tablas buro a respaldo'

select * into cr_buro_cuenta_104383
from cr_buro_cuenta
where bc_id_cliente = @w_cliente

select * into cr_buro_resumen_reporte_104383
from cr_buro_resumen_reporte
where br_id_cliente = @w_cliente

select * into cr_interface_buro_104383
from cr_interface_buro
where ib_cliente = @w_cliente

print 'eliminar registros del cliente en tablas buro'

delete from cr_buro_cuenta
where bc_id_cliente = @w_cliente

delete from cr_buro_resumen_reporte
where br_id_cliente = @w_cliente

delete from cr_interface_buro
where ib_cliente = @w_cliente

print 'Select de tablas buro y respaldo'

select * from cr_buro_cuenta where bc_id_cliente = @w_cliente
select * from cr_buro_resumen_reporte where br_id_cliente = @w_cliente
select * from cr_interface_buro where ib_cliente = @w_cliente
select * from cr_buro_cuenta_104383
select * from cr_buro_resumen_reporte_104383
select * from cr_interface_buro_104383

go
