use cobis
go


delete from cl_parametro where pa_nemonico  = 'CLNUSG' and pa_producto = 'CRE'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLIENTES NUEVOS EN SOLICITUD GRUPAL', 'CLNUSG', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

GO