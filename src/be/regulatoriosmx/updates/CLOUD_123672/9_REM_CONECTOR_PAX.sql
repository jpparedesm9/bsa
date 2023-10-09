-- Creación de tablas para conectores y monitoreo y zipeado de xml

-- tabla conectores
use cob_credito
go

IF OBJECT_ID ('dbo.cr_conector_timbrado') IS NOT NULL
	DROP table dbo.cr_conector_timbrado
go

create table dbo.cr_conector_timbrado
	(
	ct_name_conector     varchar(100),	
	ct_path_salida       varchar (100),
	ct_path_ingreso      varchar(100)  null,
	ct_estado            char(1),
	ct_tipo_conector     char(1)
	)
go

create nonclustered index indx_conector_timb
on cob_credito..cr_conector_timbrado(ct_estado,ct_tipo_conector)

-- tabla de logs
use cob_conta_super
go

if object_id ('sb_factura_paquete') IS NOT NULL
	drop table sb_factura_paquete
go

create table sb_factura_paquete(
fp_fecha_registro datetime,
fp_archivo_zip    varchar(100),
fp_factura        varchar(100)
)

create nonclustered index  sb_factura_paquete_idx on sb_factura_paquete(fp_factura)

if object_id ('sb_complemento_paquete') IS NOT NULL
	drop table sb_complemento_paquete
go

create table sb_complemento_paquete(
cp_fecha_registro datetime,
cp_archivo_zip    varchar(100),
cp_complemento    varchar(100)
)

create nonclustered index  sb_complemento_paquete_idx on sb_complemento_paquete(cp_complemento)



IF object_id ('sb_log_factuacion') IS NOT NULL
	drop table sb_log_factuacion
go

create table sb_log_factuacion(
lf_secuencial     int identity,
ff_fecha          datetime,
lf_archivo        varchar(100),
lf_estado         char(1)
)

create nonclustered index sb_log_factuacion_idx on sb_log_factuacion(ff_fecha)
   

IF object_id ('sb_log_complemento') IS NOT NULL
	drop table sb_log_complemento
go

create table sb_log_complemento(
lc_secuencial     int identity,
lc_fecha          datetime,
lc_archivo        varchar(100),
lc_estado         char(1)
)

create nonclustered index sb_log_complemento_idx on sb_log_complemento(lc_fecha)