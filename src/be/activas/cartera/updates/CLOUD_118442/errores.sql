use cobis
go

delete from cl_errores where numero = 710610 and mensaje = 'ESTA FORMA DE PAGO NO APLICA PARA PAGOS GRUPALES'
delete from cl_errores where numero = 710611 and mensaje = 'ERROR AL APLICAR EL PAGO'

insert into cl_errores values(710610,1,'ESTA FORMA DE PAGO NO APLICA PARA PAGOS GRUPALES')
insert into cl_errores values(710611,1,'ERROR AL APLICAR EL PAGO')

go
