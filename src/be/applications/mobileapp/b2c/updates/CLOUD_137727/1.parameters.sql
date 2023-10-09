use cobis
go

delete cl_parametro where pa_nemonico ='WPPMOM' and pa_producto = 'CLI'
insert into cl_parametro values ('WEB PAY PLUS MONTO MINIMO', 'WPPMOM', 'F', null, null, null, null, null, null, 1, 'CLI')

go