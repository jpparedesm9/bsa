use cobis
go

delete cl_parametro  
WHERE  pa_nemonico = 'PPAMCA'
AND pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto) 
values('PORCETAJE PAGO MENSUAL CALIFICACION','PPAMCA','I',75,'CLI')
GO

use cobis
go

delete cl_parametro where pa_nemonico = 'TMBUCO'
AND pa_producto = 'CLI'

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LONGITUD  MAX BUC ONBO ', 'TMBUCO', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CLI')

go