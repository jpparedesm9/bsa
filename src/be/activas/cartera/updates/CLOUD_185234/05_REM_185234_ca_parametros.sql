-------Req.185234 - Seguros Individual 
use cobis
go

delete cl_parametro where pa_nemonico in ('MVAMSI') and pa_producto='CCA' 

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MESES VIGENCIA ASISTENCIA MEDICA SOLICITUD INDIVIDUAL', 'MVAMSI', 'I', NULL, NULL, NULL, 4, NULL, NULL, NULL, 'CCA')
go