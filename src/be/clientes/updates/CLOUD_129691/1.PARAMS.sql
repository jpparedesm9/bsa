use cobis
go

delete from cl_parametro where pa_nemonico = 'RMCRF' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
values ('ROL MODIFICA DATOS PARA CURP Y RFC','RMCRF','I',29,'CLI')

go
