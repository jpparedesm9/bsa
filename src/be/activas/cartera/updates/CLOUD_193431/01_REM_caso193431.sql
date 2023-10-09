--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go

if OBJECT_ID ('dbo.ca_reporte_cobranza_linea') IS NOT NULL
    drop table dbo.ca_reporte_cobranza_linea
go

create table ca_reporte_cobranza_linea
(
    rc_oficina        varchar(256),
    rc_oficina_id     varchar(256),
    rc_region         varchar(256),
    rc_contrado_grupo varchar(20),
    rc_nombre_grupo_cliente varchar (256), 
    rc_secuencial    varchar(256),
    rc_corresponsal  varchar(16),
    rc_tipo          varchar(256),
    rc_fecha_proceso varchar(256),
    rc_fecha_valor   varchar(256),
    rc_referencia    varchar(256),
    rc_monto         varchar(256),
    rc_estado        varchar(256),
    rc_archivo_ref   varchar(256),
    rc_login         varchar(256),
    rc_fecha_real    varchar(256)
)
go

--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>'
USE cobis
go

select * from cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'RRCBLI'

delete cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'RRCBLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('RUTA REPORTE COBRANZA EN LINEA', 'RRCBLI', 'C', 'D:\WorkFolder\COBRANZAENLINEA\', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')--PRODUCCION
go
--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>'
USE cobis
go

select * from cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'HRCBLI'

delete cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'HRCBLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('HORA REPORTE COBRANZA EN LINEA', 'HRCBLI', 'C', '18:10:00', NULL, NULL, NULL, NULL, NULL, NULL, 'CCA')
go
