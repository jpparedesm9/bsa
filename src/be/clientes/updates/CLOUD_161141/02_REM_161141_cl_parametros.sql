use cobis
go

------------- PARAMETRO CODIGO POR DEFECTO COLECTIVO
delete from cl_parametro where pa_nemonico = 'CDDFCL' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('CODIGO POR DEFECTO COLECTIVO','CDDFCL','C','I','CLI')
go

------------- PARAMETRO CODIGO POR DEFECTO COLECTIVO
delete from cl_parametro where pa_nemonico = 'CDDFNC' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('CODIGO POR DEFECTO NIVEL COLECTIVO','CDDFNC','C','O','CLI')
go