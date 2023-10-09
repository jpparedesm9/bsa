-- ========= REQ 193221- B2B Grupal Digital =========
--Tabla de Registro de Verificacion Correo y Telefono
use cobis
go

if object_id ('dbo.cl_verif_co_tel') is not null
  drop table dbo.cl_verif_co_tel
go

create table cl_verif_co_tel(
  ct_ente          int, 
  ct_direccion     int,
  ct_valor         varchar(254), 
  ct_tipo          varchar(10),
  ct_verificacion  char(1),
  ct_canal         int,        
  ct_fecha_proc    datetime,
  ct_fecha         datetime
)
go


--Tabla Log de Aceptacion
use cobis
go

if object_id ('dbo.cl_log_aceptacion') is not null
  drop table dbo.cl_log_aceptacion
go

create table cl_log_aceptacion(
  ta_fecha_registro     datetime,
  ta_tipo_aceptacion    varchar(10),
  ta_resultado          char(1), 
  ta_fecha_aceptacion   datetime,
  ta_canal              int,
  ta_ente               int, 
  ta_login_asesor       varchar(14),
  ta_oficina_asesor     int
)
go


-- Agregando columnas 193221 - Fase 3
-- Tabla: cl_ente.p_otro_profesion
-- \src\be\clientes\installer\sql\cl_table.sql
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE Name = 'p_otro_profesion'
			   AND Object_ID = Object_ID('cl_ente'))
BEGIN
	ALTER TABLE cl_ente ADD p_otro_profesion varchar(30) null
	-- ALTER TABLE cl_ente DROP COLUMN p_otro_profesion;
END

-- cl_tran_servicio.ts_otro_profesion
-- \src\be\clientes\installer\sql\cl_trser.sql
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE Name = 'ts_otro_profesion' 
			   AND Object_ID = Object_ID('cl_tran_servicio'))
BEGIN
	ALTER TABLE cl_tran_servicio ADD ts_otro_profesion varchar(30)
	-- ALTER TABLE cl_tran_servicio DROP COLUMN ts_otro_profesion;
END


-- Tabla: cl_ente_aux.ea_act_profesional
-- \src\be\clientes\installer\sql\cl_table.sql
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE Name = 'ea_act_profesional'
			   AND Object_ID = Object_ID('cl_ente_aux'))
BEGIN
	ALTER TABLE cl_ente_aux ADD ea_act_profesional varchar(10) null
	-- ALTER TABLE cl_ente_aux DROP COLUMN ea_act_profesional;
END

-- Tabla: cl_ente_aux.ea_usa_crypto
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE Name = 'ea_usa_crypto'
			   AND Object_ID = Object_ID('cl_ente_aux'))
BEGIN
	ALTER TABLE cl_ente_aux ADD ea_usa_crypto varchar(10) null
	-- ALTER TABLE cl_ente_aux DROP COLUMN ea_usa_crypto;
END



-- Tabla: cl_negocio_cliente.nc_otro_recurso varchar(30)
IF NOT EXISTS (SELECT * FROM sys.columns 
               WHERE Name = 'nc_otro_recurso'
			   AND Object_ID = Object_ID('cl_negocio_cliente'))
BEGIN
	ALTER TABLE cl_negocio_cliente ADD nc_otro_recurso varchar(30) null
	-- ALTER TABLE cl_negocio_cliente DROP COLUMN nc_otro_recurso;
END

go

