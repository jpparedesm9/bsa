----------------- <CREANDO TABLAS> -------------------
 
use cob_conta_tercero
go
 
set nocount on
go
 
print '-->Tabla: ct_saldo_tercero'

SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO

CREATE TABLE [dbo].[ct_saldo_tercero](
	[st_empresa] [int] NOT NULL,
	[st_periodo] [int] NOT NULL,
	[st_corte] [int] NOT NULL,
	[st_cuenta] [dbo].[cuenta_contable] NOT NULL,
	[st_oficina] [smallint] NOT NULL,
	[st_area] [smallint] NOT NULL,
	[st_ente] [int] NOT NULL,
	[st_saldo] [money] NOT NULL,
	[st_saldo_me] [money] NOT NULL,
	[st_mov_debito] [money] NOT NULL,
	[st_mov_credito] [money] NOT NULL,
	[st_mov_debito_me] [money] NOT NULL,
	[st_mov_credito_me] [money] NOT NULL
)
GO

