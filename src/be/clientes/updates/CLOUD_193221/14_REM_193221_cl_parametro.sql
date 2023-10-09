use cobis
go

delete cl_parametro where pa_nemonico in ('VAMAIL','VASMS')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('VALIDACION DE MAIL','VAMAIL','C','S','CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('VALIDACION DE MOVIL SMS','VASMS','C','S','CLI')

delete cl_parametro where pa_nemonico in ('VPMAIL','VPSMS')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('MANT PERSONAS - VALIDACION DE MAIL','VPMAIL','C','N','CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('MANT PERSONAS - VALIDACION DE MOVIL SMS','VPSMS','C','N','CLI')

go
