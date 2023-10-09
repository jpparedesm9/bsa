use cobis
go

declare @w_return              int,
        @w_codigo              int,
        @w_descripcion         varchar(100),
        @w_fecha_proceso       datetime

select @w_descripcion = 'AHORRO NORMAL',
       @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_codigo = pb_pro_bancario from cob_remesas..pe_pro_bancario where pb_descripcion like upper('%AHORRO%NORMAL%')
   
-- Producto Bancario CUENTA NORMAL
if exists(select 1 from cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico = 'PCANOR')
begin
	print 'Parámetro ya existe ' + 'AHO' + '-- PCANOR'
end
else
begin
	INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
		VALUES ( @w_descripcion, 'PCANOR', 'I', NULL, NULL, NULL, @w_codigo, NULL, NULL, NULL, 'AHO')

if @@error != 0 
	print 'Error al crear cl_parametro PCANOR'

end
go

