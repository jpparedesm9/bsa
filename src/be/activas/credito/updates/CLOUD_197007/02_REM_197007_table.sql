--Caso197007 - Flujo B2B Grupal Paperless Fase 1
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--ANTES
select * from cob_credito..cr_reporte_on_boarding

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos Tabla Principal
use cob_credito
go

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_est_carga_alfresco')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_est_carga_alfresco char(1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_est_eliminar_doc')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_est_eliminar_doc char (1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_tiempo_vig_doc')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_tiempo_vig_doc int
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_cod_tipo_doc_cstmr')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_cod_tipo_doc_cstmr char (10)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_estado')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_estado char (1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_reporte_on_boarding' and COLUMN_NAME = 'ra_grp_unif')
begin
  alter table cob_credito..cr_reporte_on_boarding add ra_grp_unif char (2)
end
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Actualizacion Registros de Documentos
use cob_credito
go

update cr_reporte_on_boarding 
set ra_est_carga_alfresco = 'N',
    ra_est_eliminar_doc = 'N',
	ra_estado = 'V'
	
update cr_reporte_on_boarding 
set ra_cod_tipo_doc_cstmr = '009'
where ra_cod_documento 
in ('112')

update cr_reporte_on_boarding 
set ra_cod_tipo_doc_cstmr = '006'
where ra_cod_documento 
in ('120')

update cr_reporte_on_boarding 
set ra_estado = 'I'	
where ra_cod_documento 
in ('109', '110', '111', '112')

update cr_reporte_on_boarding 
set ra_grp_unif = '1'
where ra_cod_documento 
in ('113')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Nuevos Registros de Documentos
use cob_credito
go

delete from cr_reporte_on_boarding where ra_cod_documento 
in ('122', '123', '124', '125', '126', '127', '128')

--Grupal
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('122', 'contratoCreditoInclusion.jasper', 'CONTRATO GRUPAL', 'S', 'S', 'GRUPAL', '_gr', 'N', 4, 'Inbox', 2, 'S', 'N', 90, null, 'V', '1')
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('123', 'caratulaCreditoGrupal.jasper', 'CARATULA DE CREDITO GRUPAL', 'S', 'S', 'GRUPAL', '_gr', 'N', 4, 'Inbox', 11, 'S', 'N', 90, null, 'V', '1')
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('124', 'tablaAmortizacion.jasper', 'TABLA DE AMORTIZACION GRUPAL', 'S', 'S', 'GRUPAL', '_gr', 'N', 4, 'Inbox', 10, 'S', 'N', 90, null, 'V', '1')
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('125', 'kYCSimplificado.jasper', 'FORMULARIO KYC', 'S', 'N', 'GRUPAL', '_gr', 'N', 4, null, null, 'N', 'N', 90, null, 'V', null)
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('126', 'ConsentimientoZurich.jasper', 'CERTIFICADO CONSENTIMIENTO', 'S', 'S', 'GRUPAL', '_gr', 'N', 4, null, null, 'N', 'N', 90, null, 'V', '2')
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('127', 'ConsentSecurityBasic.jasper', 'CERTIFICADO ASISTENCIA MEDICA', 'S', 'S', 'GRUPAL', '_gr', 'N', 4, null, null, 'N', 'N', 90, null, 'V', '2')
insert into cr_reporte_on_boarding (ra_cod_documento, ra_nombre_archivo_jasper, ra_nombre_archivo_presentar, ra_est_gen, ra_est_envio, ra_toperacion, ra_nombre_archivo_term, ra_est_des_alfresco, ra_canal, ra_carpeta, ra_codigo_tipo_doc, ra_est_carga_alfresco, ra_est_eliminar_doc, ra_tiempo_vig_doc, ra_cod_tipo_doc_cstmr, ra_estado, ra_grp_unif)
values ('128', 'asistenciaFuneraria.jasper', 'CERTIFICADO ASISTENCIA FUNERARIA', 'S', 'S', 'GRUPAL', '_gr', 'N', 4, null, null, 'N', 'N', 90, null, 'V', '2')
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

--DESPUES
select * from cr_reporte_on_boarding
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Agregado de Campos Tabla Detalle
use cob_credito
go

--ANTES
select * from cob_credito..cr_cli_reporte_on_boarding_det

if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_est_carga_alfresco')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_est_carga_alfresco char(1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_est_eliminar_doc')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_est_eliminar_doc char(1)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_id_inst_act')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_id_inst_act int
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_cod_tipo_doc_cstmr')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_cod_tipo_doc_cstmr char(10)
end
if not exists (select 1 from INFORMATION_SCHEMA.COLUMNS where TABLE_NAME  = 'cr_cli_reporte_on_boarding_det' and COLUMN_NAME = 'cod_grp_unif')
begin
  alter table cob_credito..cr_cli_reporte_on_boarding_det add cod_grp_unif varchar(2)
end

--DESPUES
select * from cr_cli_reporte_on_boarding_det
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
use cob_cartera
go

if object_id ('dbo.ca_rep_info_des') is not null
	drop table dbo.ca_rep_info_des
go

create table dbo.ca_rep_info_des(
    ri_oficina_desemb_id   varchar (1),
	ri_oficina_desemb_desc varchar (1),
	ri_forma_de_desembolso varchar (1),
	ri_referencia          varchar (1),
	ri_moneda              int,
	ri_moneda_desc         varchar (1),
	ri_cotizacion          int,
	ri_monto               money,
	ri_numero_banco        varchar (24),
	ri_nombre_cliente      varchar (129),
	ri_id_cliente          int,
	ri_fecha_proceso       varchar (10),
	ri_direccion           varchar (246),
	ri_fecha_liquid        varchar (10),
	ri_rol                 varchar (10),
	ri_descrip_rol         varchar (64),
	ri_desplazamiento      int,
	ri_monto_adeudo_previo money,
	ri_monto_cap_trabajo   money,
	ri_monto_a_recibir     money
)
-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>

go
