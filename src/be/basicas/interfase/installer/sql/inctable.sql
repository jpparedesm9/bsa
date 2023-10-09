USE [cob_interfase] 
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


print '-->ct_scomprobante'
go
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ct_scomprobante](
       [sc_producto] [tinyint] NOT NULL,
       [sc_comprobante] [int] NOT NULL,
       [sc_empresa] [tinyint] NOT NULL,
       [sc_fecha_tran] [datetime] NOT NULL,
       [sc_oficina_orig] [smallint] NOT NULL,
       [sc_area_orig] [smallint] NOT NULL,
       [sc_fecha_gra] [datetime] NOT NULL,
       [sc_digitador] [varchar](160) NOT NULL,
       [sc_descripcion] [varchar](160) NOT NULL,
       [sc_perfil] [varchar](20) NOT NULL,
       [sc_detalles] [int] NOT NULL,
       [sc_tot_debito] [money] NOT NULL,
       [sc_tot_credito] [money] NOT NULL,
       [sc_tot_debito_me] [money] NOT NULL,
       [sc_tot_credito_me] [money] NOT NULL,
       [sc_automatico] [int] NULL,
       [sc_reversado] [char](1) NOT NULL,
       [sc_estado] [char](1) NOT NULL,
       [sc_mayorizado] [char](1) NOT NULL,
       [sc_observaciones] [varchar](160) NULL,
       [sc_comp_definit] [int] NULL,
       [sc_usuario_modulo] [varchar](160) NOT NULL,
       [sc_causa_error] [char](30) NULL,
       [sc_comp_origen] [int] NULL,
       [sc_tran_modulo] [varchar](20) NULL,
       [sc_error] [char](1) NULL
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO

print '-->ct_sasiento'
go
SET ANSI_NULLS OFF
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[ct_sasiento](
       [sa_producto] [tinyint] NOT NULL,
       [sa_comprobante] [int] NOT NULL,
       [sa_empresa] [tinyint] NOT NULL,
       [sa_fecha_tran] [datetime] NOT NULL,
       [sa_asiento] [int] NOT NULL,
       [sa_cuenta] [char](14) NOT NULL,
       [sa_oficina_dest] [smallint] NOT NULL,
       [sa_area_dest] [smallint] NOT NULL,
       [sa_credito] [money] NULL,
       [sa_debito] [money] NULL,
       [sa_concepto] [varchar](160) NOT NULL,
       [sa_credito_me] [money] NULL,
       [sa_debito_me] [money] NULL,
       [sa_cotizacion] [money] NULL,
       [sa_tipo_doc] [char](1) NOT NULL,
       [sa_tipo_tran] [char](1) NOT NULL,
       [sa_moneda] [tinyint] NULL,
       [sa_opcion] [tinyint] NULL,
       [sa_ente] [int] NULL,
       [sa_con_rete] [char](4) NULL,
       [sa_base] [money] NULL,
       [sa_valret] [money] NULL,
       [sa_con_iva] [char](4) NULL,
       [sa_valor_iva] [money] NULL,
       [sa_iva_retenido] [money] NULL,
       [sa_con_ica] [char](4) NULL,
       [sa_valor_ica] [money] NULL,
       [sa_con_timbre] [char](4) NULL,
       [sa_valor_timbre] [money] NULL,
       [sa_con_iva_reten] [char](4) NULL,
       [sa_con_ivapagado] [char](4) NULL,
       [sa_valor_ivapagado] [money] NULL,
       [sa_documento] [char](24) NULL,
       [sa_mayorizado] [char](1) NOT NULL,
       [sa_origen_mvto] [varchar](20) NULL,
       [sa_con_dptales] [char](4) NULL,
       [sa_valor_dptales] [money] NULL,
       [sa_posicion] [char](1) NULL,
       [sa_debcred] [char](1) NULL,
       [sa_oper_banco] [char](4) NULL,
       [sa_cheque] [varchar](64) NULL,
       [sa_doc_banco] [char](20) NULL,
       [sa_fecha_est] [datetime] NULL,
       [sa_detalle] [smallint] NULL,
       [sa_error] [char](1) NULL,
       [sa_fecha_fin_difer] [datetime] NULL,
       [sa_plazo_difer] [int] NULL,
       [sa_desc_difer] [varchar](160) NULL,
       [sa_fecha_fin_difer_fiscal] [datetime] NULL,
       [sa_plazo_difer_fiscal] [int] NULL
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
