use cob_credito
go

declare @w_cliente int

select @w_cliente = 8288

print 'Borrar info de tablas buro'

delete from cr_buro_cuenta
where bc_id_cliente = @w_cliente

delete from cr_buro_resumen_reporte
where br_id_cliente = @w_cliente

delete from cr_interface_buro
where ib_cliente = @w_cliente

print 'Insertar registros del respaldo'

insert into cr_interface_buro
select * from cr_interface_buro_104383
where ib_cliente = @w_cliente

insert into cr_buro_cuenta
select * from cr_buro_cuenta_104383
where bc_id_cliente = @w_cliente

insert into cr_buro_resumen_reporte
select * from cr_buro_resumen_reporte_104383
where br_id_cliente = @w_cliente

go
