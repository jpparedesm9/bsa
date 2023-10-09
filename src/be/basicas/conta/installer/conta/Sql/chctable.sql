----------------- <CREANDO TABLAS> -------------------
 
USE [cob_conta_his]
GO
 
set nocount on
go
 
print '-->Tabla: cb_hist_saldo'

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[cb_hist_saldo](
	[hi_empresa] [tinyint] NOT NULL,
	[hi_cuenta] [char](14) NOT NULL,
	[hi_oficina] [smallint] NOT NULL,
	[hi_area] [smallint] NOT NULL,
	[hi_corte] [int] NOT NULL,
	[hi_periodo] [int] NOT NULL,
	[hi_saldo] [money] NULL,
	[hi_saldo_me] [money] NULL,
	[hi_debito] [money] NULL,
	[hi_credito] [money] NULL,
	[hi_debito_me] [money] NULL,
	[hi_credito_me] [money] NULL
)
GO

SET ANSI_PADDING OFF
GO




