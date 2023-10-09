USE [cob_ccontable] 
GO

print '-->cco_error_conaut'
go
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[cco_error_conaut](
	[ec_secuencial] [numeric](8, 0) IDENTITY(1,1) NOT NULL,
	[ec_empresa] [tinyint] NOT NULL,
	[ec_producto] [tinyint] NOT NULL,
	[ec_fecha_conta] [datetime] NOT NULL,
	[ec_numerror] [int] NOT NULL,
	[ec_fecha] [datetime] NOT NULL,
	[ec_tran_modulo] [varchar](20) NOT NULL,
	[ec_asiento] [int] NOT NULL,
	[ec_mensaje] [dbo].[descripcion] NOT NULL,
	[ec_perfil] [varchar](20) NULL,
	[ec_oficina] [smallint] NULL,
	[ec_valor] [money] NULL,
	[ec_comprobante] [int] NULL
) ON [PRIMARY]
GO

SET ANSI_PADDING OFF
GO


print '-->cco_error_conaut_his'
go
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE cco_error_conaut_his 
(
    eh_empresa     tinyint       NOT NULL,
    eh_producto    tinyint       NOT NULL,
    eh_fecha_conta datetime      NOT NULL,
    eh_secuencial  int           NOT NULL,
    eh_fecha       datetime      NOT NULL,
    eh_tran_modulo varchar(20)   NOT NULL,
    eh_asiento     smallint      NOT NULL,
    eh_numerror    int           NULL,
    eh_mensaje     [descripcion] NOT NULL,
    eh_perfil      varchar(20)   NULL,
    eh_oficina     smallint      NULL,
    eh_valor       money         NULL,
    eh_comprobante int           NULL
)
GO
SET ANSI_PADDING OFF
GO

