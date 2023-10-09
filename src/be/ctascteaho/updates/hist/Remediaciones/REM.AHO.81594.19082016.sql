/*****************************************************************************/
--No Historia				 : H80491
--Título de la Historia		 : Paso de datos de Ahorros a cob_cuenta_super
--Fecha					     : 08/19/2016
--Descripción del Problema	 : Se requiere de un proceso que realice el paso 
--                             de los datos de transacciones monetarias y de 
--                             servicios hacia la base cob_externos para 
--                             realizar proceso de reportes
--Descripción de la Solución : Creación de tablas: 
--                             sb_bloqueo_operaciones
--                             sb_ctas_ingresadas
--                             sb_tran_mensual
--                             sb_tran_rechazos
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cbsup_table.sql
/*****************************************************************************/

USE [cob_conta_super]
GO

IF OBJECT_ID ('dbo.sb_bloqueo_operaciones') IS NOT NULL
	DROP TABLE dbo.sb_bloqueo_operaciones
GO

CREATE TABLE [sb_bloqueo_operaciones](
	[bo_fecha] [datetime] NOT NULL,
	[bo_banco] [varchar](24) NOT NULL,
	[bo_aplicativo] [tinyint] NOT NULL,
	[bo_secuencial] [int] NOT NULL,
	[bo_causa_bloqueo] [varchar](10) NOT NULL,
	[bo_fecha_bloqueo] [datetime] NOT NULL,
	[bo_fecha_modif] [datetime] NULL,
	[bo_fecha_desbloqueo] [datetime] NULL,
	[bo_estado] [char](1) NOT NULL
)
GO


IF OBJECT_ID ('dbo.sb_ctas_ingresadas') IS NOT NULL
	DROP TABLE dbo.sb_ctas_ingresadas
GO

CREATE TABLE [sb_ctas_ingresadas](
	[ci_fecha] [datetime] NOT NULL,
	[ci_cuenta] [varchar](24) NOT NULL,
	[ci_aplicativo] [tinyint] NOT NULL,
	[ci_cliente] [int] NOT NULL,
	[ci_cat_producto] [varchar](10) NOT NULL,
	[ci_fecha_apertura] [datetime] NOT NULL,
	[ci_oficina] [smallint] NOT NULL,
	[ci_estado] [char](1) NOT NULL
) ON [PRIMARY]
GO


IF OBJECT_ID ('dbo.sb_tran_mensual') IS NOT NULL
	DROP TABLE dbo.sb_tran_mensual
GO

CREATE TABLE [sb_tran_mensual](
	[tm_ano] [char](4) NOT NULL,
	[tm_mes] [char](2) NOT NULL,
	[tm_cuenta] [varchar](24) NOT NULL,
	[tm_cod_trn] [int] NOT NULL,
	[tm_cantidad] [int] NOT NULL
) ON [PRIMARY]
GO


IF OBJECT_ID ('dbo.sb_tran_rechazos') IS NOT NULL
	DROP TABLE dbo.sb_tran_rechazos
GO

CREATE TABLE [sb_tran_rechazos](
	[tr_fecha] [datetime] NULL,
	[tr_oficina] [smallint] NULL,
	[tr_cod_cliente] [int] NULL,
	[tr_id_cliente] [varchar](30) NULL,
	[tr_nom_cliente] [varchar](255) NULL,
	[tr_cta_banco] [varchar](24) NULL,
	[tr_tipo_tran] [int] NULL,
	[tr_nom_tran] [varchar](64) NULL,
	[tr_vlr_comision] [money] NULL,
	[tr_vlr_iva] [money] NULL,
	[tr_modulo] [char](3) NULL,
	[tr_causal_rech] [int] NULL
)
GO


CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_bloqueo_operaciones]
(
	[bo_secuencial],
	[bo_causa_bloqueo],
	[bo_banco],
	[bo_aplicativo],
	[bo_fecha]
)
GO

CREATE NONCLUSTERED INDEX [idx2] ON [sb_bloqueo_operaciones]
(
	[bo_fecha],
	[bo_banco],
	[bo_aplicativo]
)
GO

CREATE NONCLUSTERED INDEX [sb_ctas_ingresadas_Key] ON [sb_ctas_ingresadas]
(
	[ci_fecha],
	[ci_aplicativo]
)
GO

CREATE UNIQUE NONCLUSTERED INDEX [idx1] ON [sb_tran_mensual]
(
	[tm_ano] ASC,
	[tm_mes] ASC,
	[tm_cuenta] ASC,
	[tm_cod_trn] ASC
)
GO

CREATE NONCLUSTERED INDEX [idx1] ON [sb_tran_rechazos]
(
	[tr_fecha],
	[tr_cod_cliente]
)
GO


/*****************************************************************************/
--No Historia				 : H80491
--Título de la Historia		 : Paso de datos de Ahorros a cob_cuenta_super
--Fecha					     : 08/19/2016
--Descripción del Problema	 : Se requiere de un proceso que realice el paso 
--                             de los datos de transacciones monetarias y de 
--                             servicios hacia la base cob_externos para 
--                             realizar proceso de reportes
--Descripción de la Solución : Creación de tablas: 
--                             sb_bloqueo_operaciones
--                             sb_ctas_ingresadas
--                             sb_tran_mensual
--                             sb_tran_rechazos
--Autor						 : Jorge Salazar Andrade
--Instalador                 : cobex_table.sql
/*****************************************************************************/

USE [cob_externos]
GO

IF OBJECT_ID ('dbo.ex_ctas_ingresadas') IS NOT NULL
	DROP TABLE dbo.ex_ctas_ingresadas
GO

CREATE TABLE [ex_ctas_ingresadas](
	[ci_fecha] [datetime] NOT NULL,
	[ci_cuenta] [varchar](24) NOT NULL,
	[ci_aplicativo] [tinyint] NOT NULL,
	[ci_cliente] [int] NOT NULL,
	[ci_cat_producto] [varchar](10) NOT NULL,
	[ci_fecha_apertura] [datetime] NOT NULL,
	[ci_oficina] [smallint] NOT NULL,
	[ci_estado] [char](1) NOT NULL
)
GO
