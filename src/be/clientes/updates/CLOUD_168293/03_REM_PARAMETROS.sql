use cobis
go

delete cl_parametro where pa_nemonico = 'WSOBOA'

insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('WORKFLOW SOLICITUD ONBOARDING', 'WSOBOA', 'C', 'SOLICITUD ONBOARDING', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

go