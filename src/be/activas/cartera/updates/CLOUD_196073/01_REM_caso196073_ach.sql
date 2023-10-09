use cob_cartera
go

IF OBJECT_ID ('dbo.ca_gen_ficha_pago_det') IS NOT NULL
	DROP TABLE dbo.ca_gen_ficha_pago_det
GO

IF OBJECT_ID ('ca_gen_ficha_pago') IS NOT NULL
	DROP TABLE ca_gen_ficha_pago
go

create table ca_gen_ficha_pago
(
    gfp_cliente_id      INT NOT NULL,
	gfp_fecha_proceso DATETIME NOT NULL,
	gfp_nombre        VARCHAR (64) NULL,
	gfp_tramite       INT NULL,
	gfp_op_fecha_liq  DATETIME NOT NULL,
	gfp_op_moneda     TINYINT NOT NULL,
	gfp_op_oficina    SMALLINT NOT NULL,
	gfp_di_fecha_vig  DATETIME NOT NULL,
	gfp_di_dividendo  INT NOT NULL,
	gfp_di_monto      MONEY NOT NULL,
	gfp_banco         VARCHAR (255) NOT NULL,
	gfp_operacion     int NOT NULL	
	CONSTRAINT PK_ca_gen_ficha_pago PRIMARY KEY(gfp_cliente_id, gfp_banco)
)
go

CREATE TABLE dbo.ca_gen_ficha_pago_det(
   gfpd_cliente_id              int not null,
   gfpd_fecha_proceso         DATETIME NOT NULL,
   gfpd_corresponsal          varchar(10) not null,
   gfpd_institucion           varchar(20) not null,
   gfpd_referencia            varchar(40) not null,
   gfpd_convenio              varchar(30) null,
   gfpd_banco                 VARCHAR (255) NOT NULL,
   gfpd_operacion             int NOT NULL, 
   FOREIGN KEY (gfpd_cliente_id, gfpd_banco) REFERENCES ca_gen_ficha_pago(gfp_cliente_id, gfp_banco),
   CONSTRAINT pk_ca_gen_ficha_pago_det PRIMARY KEY (gfpd_referencia, gfpd_corresponsal)
   )
go

-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>
IF OBJECT_ID ('dbo.ca_notificacion_reporte') IS NOT NULL
	DROP TABLE dbo.ca_notificacion_reporte
GO

CREATE TABLE dbo.ca_notificacion_reporte(
    nr_tproducto        varchar (20) not null,
	nr_job              varchar (20) not null,	
	nr_tproducto_descp  varchar (256) null,
	nr_subjet_doc       varchar (256) null,
	nr_subjet_pass      varchar (256) null,
)
go

insert into ca_notificacion_reporte values ('GRUPAL', 'GRAOB', 'CRÉDITO GRUPAL', 'Documentos', 'Contraseña de Documentos')
insert into ca_notificacion_reporte values ('INDIVIDUAL', 'GRAOB', 'CRÉDITO INDIVIDUAL', 'Documentos', 'Contraseña de Documentos')
insert into ca_notificacion_reporte values ('REVOLVENTE', 'GRAOB', 'CRÉDITO LCR', 'Documentos', 'Contraseña de Documentos')
insert into ca_notificacion_reporte values ('ONBOARDING', 'GRAOB', '(CRÉDITO INDIVIDUAL EN CUENTA CORRIENTE/ CRÉDITO SIMPLE TU CREDIITO + NEGOCIO)', 'Documentos Onboarding', 'Contraseña de Documentos Onboarding')
go

-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>-------------->>>>>>>>>>>>>>
------------->>>>>>templates
use cobis
go

declare @w_codigo int

delete from cobis..ns_template where te_nombre = 'NotifGeneracionReportesPassword.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
insert into cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
values(@w_codigo,'XSLT','NEUTRAL','NotifGeneracionReportePassword.xslt','A','1.0.0')

delete from cobis..ns_template where te_nombre = 'NotifGeneracionReportesDocumento.xslt'
select @w_codigo = max(te_id) + 1 from cobis..ns_template
insert into cobis..ns_template (te_id,te_tipo,te_cultura,te_nombre,te_estado,te_version) 
values(@w_codigo,'XSLT','NEUTRAL','NotifGeneracionReporteDocumento.xslt','A','1.0.0')

go