use cobis
go
------------------------------********************------------------------------
------------------------------INGRESO DE PARAMETRO
------------------------------********************------------------------------
declare @w_nemonico char(6), @w_producto char(3)

select @w_nemonico = 'AHURO', @w_producto = 'CRE'

select * from cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto

delete cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto
go
------------------------------********************------------------------------
declare @w_nemonico char(6), @w_producto char(3)

select @w_nemonico = 'CLGRRP', @w_producto = 'CRE'

select * from cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto

delete cobis..cl_parametro where pa_nemonico = @w_nemonico and pa_producto = @w_producto
go