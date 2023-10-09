/*****************************************************************************/
--No Historia				 : H80491
--Título de la Historia		 : Paso de datos de Ahorros a cob_cuenta_super
--Fecha					     : 08/18/2016
--Descripción del Problema	 : Se requiere de un proceso que realice el paso 
--                             de los datos de transacciones monetarias y de 
--                             servicios hacia la base cob_externos para 
--                             realizar proceso de reportes
--Descripción de la Solución : Creación de tablas: 
--                             sb_carga_archivo_cuentas
--                             sb_relacion_canal
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cbsup_table.sql
/*****************************************************************************/

USE [cob_conta_super]
GO

IF OBJECT_ID ('dbo.sb_carga_archivo_cuentas') IS NOT NULL
	DROP TABLE dbo.sb_carga_archivo_cuentas
GO

CREATE TABLE [sb_carga_archivo_cuentas](
	[ca_tipo_reg] [char](2) NULL,
	[ca_secuencia] [int] NULL,
	[ca_tipo_carga] [char](1) NULL,
	[ca_tipo_ced] [char](2) NULL,
	[ca_ced_ruc] [bigint] NULL,
	[ca_nomb_arch] [varchar](60) NULL,
	[ca_ente] [int] NULL,
	[ca_cta_banco] [char](16) NULL,
	[ca_tipo_prod] [tinyint] NULL,
	[ca_fecha_reg] [datetime] NULL,
	[ca_cant_reg] [int] NULL,
	[ca_valor] [money] NULL,
	[ca_tipo_mov] [char](1) NULL,
	[ca_causal] [char](3) NULL,
	[ca_fecha_proc] [datetime] NULL,
	[ca_tipo_oper] [char](1) NULL,
	[ca_estado] [char](1) NULL,
	[ca_error] [varchar](250) NULL
)
GO

IF OBJECT_ID ('dbo.sb_relacion_canal') IS NOT NULL
	DROP TABLE dbo.sb_relacion_canal
GO

CREATE TABLE [sb_relacion_canal](
	[rc_cuenta] [char](16) NULL,
	[rc_cliente] [int] NULL,
	[rc_tel_celular] [varchar](15) NULL,
	[rc_tarj_debito] [varchar](20) NULL,
	[rc_canal] [varchar](6) NULL,
	[rc_motivo] [varchar](50) NULL,
	[rc_estado] [char](1) NULL,
	[rc_fecha] [datetime] NULL,
	[rc_fecha_mod] [datetime] NULL,
	[rc_usuario] [varchar](14) NULL,
	[rc_subtipo] [char](3) NULL,
	[rc_tipo_operador] [varchar](10) NULL,
	[rc_aplicativo] [int] NULL,
	[rc_fecha_proceso] [datetime] NULL,
	[rc_oficina] [int] NULL
)
GO

CREATE NONCLUSTERED INDEX [i_idx_sb_relacion_canal] ON [sb_relacion_canal]
(
	[rc_cuenta] ASC,
	[rc_canal] ASC,
	[rc_aplicativo] ASC,
	[rc_fecha_proceso] ASC,
	[rc_tel_celular] ASC,
	[rc_tarj_debito] ASC,
	[rc_tipo_operador] ASC,
	[rc_estado] ASC
)
GO
