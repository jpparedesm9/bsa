use cob_cartera
go

---REQ 166501 TRX SOCIO COMERCIAL - Log de Auditoria
IF OBJECT_ID ('dbo.ca_lcr_socio_comercial_log') IS NOT NULL
    DROP TABLE dbo.ca_lcr_socio_comercial_log
go

CREATE TABLE dbo.ca_lcr_socio_comercial_log
(
    sc_fecha_real       datetime     null,
    sc_fecha_proceso    datetime     null,
    sc_usuario          login        null,
    sc_rol              smallint     null,
    sc_actividad        varchar(255) null,
	sc_operacion        varchar(64)  null,
	sc_cliente          int          null,
	sc_canal            catalogo     null
)
go

CREATE INDEX idx_ca_lcr_socio_comercial_log_1 
  ON ca_lcr_socio_comercial_log(sc_fecha_proceso, sc_cliente)
go


IF OBJECT_ID ('dbo.ca_desembolsos_pendientes') IS NOT NULL
	DROP table dbo.ca_desembolsos_pendientes
go

create table dbo.ca_desembolsos_pendientes
	(
	dp_secuencial          int identity not null,
	dp_banco               cuenta,
	dp_fecha_proceso       datetime,
	dp_estado              char (1),
	dp_login               login,
	dp_monto_aprobado      money,
	dp_monto_compra        money,
	dp_comision            money,
	dp_iva                 money,
	dp_error               int,
	dp_mensaje_error       varchar (255),
	dp_referencia          varchar (100),
	dp_codido_autorizacion varchar (6)
	)
go

create index idx_ca_desembolsos_pendientes_1
	on dbo.ca_desembolsos_pendientes (dp_secuencial)
go

create index idx_ca_desembolsos_pendientes_2
	on dbo.ca_desembolsos_pendientes (dp_banco, dp_fecha_proceso)
go