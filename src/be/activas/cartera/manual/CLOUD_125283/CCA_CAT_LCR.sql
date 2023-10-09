--creacion de indice de la tabla 
use cob_cartera 
go 


if not exists(select 1 from sys.indexes where name = 'ca_cat1' and object_id = object_id('ca_cat'))
   create nonclustered index ca_cat1
   on dbo.ca_cat (ct_tipo_tabla,ct_tasa_interes,ct_tasa_comision,ct_periodicidad)
go



update tasas_periodos set periodo = 52 where tdivi = 7

update tasas_periodos set periodo = 26 where tdivi = 14


delete ca_cat where ct_tipo_tabla = 'ROTATIVA'


insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70, 0	,7	,93.72  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,1.0	,7	,136.2  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,2	,7	,185.8  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,2.5	,7	,214.4  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,3	,7	,245.94 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,3.5	,7	,280.78 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,4	,7	,319.31 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,4.5	,7	,361.97 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,5	,7	,409.27 )


insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	1.0	,14	,112.57 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	2	,14	,134.48 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	2.5	,14	,146.32 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	3	,14	,158.79 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	3.5	,14	,171.95 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	4	,14	,185.84 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	4.5	,14	,200.51 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	70,	5	,14	,216.01 )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values ('ROTATIVA',	49,	4	,14	,113.1 )

insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	1.0	,30	,99.17   )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	2	,30	,109.27  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	2.5	,30	,114.54  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	3	,30	,119.97  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	3.5	,30	,125.56  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	4	,30	,131.32  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	4.5	,30	,137.26  )
insert into ca_cat (ct_tipo_tabla , ct_tasa_interes, ct_tasa_comision,	ct_periodicidad,  ct_cat) values('ROTATIVA',	70,	5	,30	,143.39  )

delete from cobis..cl_parametro 
where pa_producto = 'CCA' and pa_nemonico = 'PPCAT'


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('PORCENTAJE DE PAGO CALCULO CAT', 'PPCAT', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 25, 'CCA')
GO
