use cob_cartera
go

IF OBJECT_ID ('dbo.ca_datos_simulacion') is not null
	drop table dbo.ca_datos_simulacion
go

create table ca_datos_simulacion(
    ds_ente          int,
    ds_fecha         datetime,
    ds_canal         int,
	ds_monto_sol     money,
	ds_tplazo        catalogo, --frecuencia
	ds_plazo         smallint, --plazo
	ds_cuota         money,
	ds_moneda        int,
    ds_tasa          float,--84
    ds_toperacion    catalogo,
	ds_fecha_simul   datetime,
	ds_login         login
)
go

create index idx_1 on ca_datos_simulacion(ds_ente)
go

------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
use cobis
go

select * from cl_errores where numero = 70076
delete cl_errores where numero = 70076

insert into cl_errores (numero, severidad, mensaje) values (70076, 0, 'Error al registrar información de la simulación')
go

------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>------->>>>>>>
use cobis
go

delete from cl_parametro 
where pa_producto = 'CCA' and pa_nemonico in ('VTSPRO', 'VTNPRO')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALOR DE TASA PROMO', 'VTSPRO', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 80, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VALOR DE TASA NO PROMO', 'VTNPRO', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 88, 'CCA')
go