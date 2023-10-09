use cobis
go
------------------------------********************------------------------------
------------------------------INGRESO DE PARAMETRO
------------------------------********************------------------------------
declare @w_nemonico char(6), @w_producto char(3)

select @w_nemonico = 'AHURO', @w_producto = 'CRE'

select * from cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto

delete cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ACTIVAR BURO HISTORICOS', @w_nemonico, 'C', 'N', NULL, NULL, NULL, NULL, NULL, NULL, @w_producto)
go

------------------------------********************------------------------------
declare @w_nemonico char(6), @w_producto char(3)

select @w_nemonico = 'CLGRRP', @w_producto = 'CRE'

select * from cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto

delete cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PARAMETROS GENERAR REPORTE BURO', @w_nemonico, 'C', '101038,1862006235', NULL, NULL, NULL, NULL, NULL, NULL, @w_producto)
go
