use cobis
go
-- ========= REQ 153833 - Cambios Json biometricos =========
-- \\bsa_153833_V2\src\be\clientes\installer\sql\cl_table.sql
IF OBJECT_ID ('cl_log_error_biometricos') IS NOT NULL
    DROP TABLE cl_log_error_biometricos
go

CREATE TABLE cl_log_error_biometricos (
	eb_fecha_proceso datetime NULL,
	eb_usuario login NULL,
	eb_error_descripcion varchar(255) NULL,
	eb_error_code varchar(64) NULL,
	eb_cliente int NULL,
	eb_tramite int NULL
)
go
create index idx_cl_log_error_biometricos_1
	on dbo.cl_log_error_biometricos (eb_fecha_proceso, eb_cliente, eb_tramite)
GO
create index idx_cl_log_error_biometricos_2
	on dbo.cl_log_error_biometricos (eb_fecha_proceso, eb_usuario)
go

