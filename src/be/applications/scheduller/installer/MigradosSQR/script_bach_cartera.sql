USE cobis
go


INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21056, '(CRE) OPERACIONES QUE NO LLEGARON AL CONSOLIDADOR', 'GENERA EL REPORTE DE OPERACIONES QUE NO LLEGARON AL CONSOLIDADOR', 'SP', '2009-06-03 11:33:15', 21, 'R', 1, 'CR_OPER_CONS', 'cr_opcns.lis', 'cr_opcns.sp', 20, 'lp', 'COBIS1', 'S', 'C:\Cobis\Vbatch\Credito\Objetos\', 'C:\Cobis\Vbatch\Credito\Listados\')
GO



INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (21040, '(CRE) ERRORES DEL PROCESO DIARIO', 'GENERA EL LISTADO DE LOS ERRORES DEL PROCESO DIARIO', 'SP', '2009-06-03 11:33:15', 21, 'R', 4, 'CR_ERRORES_SIB', 'cr_erdia.lis', 'cr_erdia.sp', 20, 'lp', 'COBIS1', 'S', 'C:\Cobis\Vbatch\Credito\Objetos\', 'C:\Cobis\Vbatch\Credito\Listados\')
GO

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion,
            ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado,
            ba_arch_fuente, ba_frec_reg_proc, ba_impresora,ba_reproceso, ba_path_fuente, ba_path_destino, ba_serv_destino)
values (14004,'ANULACION DE OPERACIONES','ANULACION DE OPERACIONES NO INGRESADAS EN CAJA','SP',getdate(),14,'P',1,'PF_OPERACION, PF_SECUEN_TICKET, PF_HIST_SECUEN_TICKET','bt_anula.lis','bt_anula.s',50,'lp','S', 'C:\Cobis\Vbatch\Credito\Objetos\', 'C:\Cobis\Vbatch\Credito\Listados\', 'COBPRUPAS')

use cob_credito
go

IF OBJECT_ID ('cr_oper_cons') IS NOT NULL
	DROP TABLE cr_oper_cons
GO

IF OBJECT_ID ('cr_errorlog') IS NOT NULL
	DROP TABLE cr_errorlog
GO

IF OBJECT_ID ('rpt_cr_opcns') IS NOT NULL
	DROP TABLE rpt_cr_opcns
GO

if exists (select * from systypes where name = 'catalogo')
	drop type catalogo
go
create type catalogo from varchar(10) not null;
go
if exists (select * from systypes where name = 'login')
	drop type login
go
if exists (select * from systypes where name = 'cuenta')
	drop type cuenta
go
create type login from varchar(14) not null;
go
create type cuenta from varchar(14) not null;
go


USE cob_cartera
GO

IF OBJECT_ID('ca_errorlog') IS NOT NULL
	DROP TABLE ca_errorlog
go

IF OBJECT_ID ('rpt_cr_cabc1') IS NOT NULL
	DROP TABLE rpt_cr_cabc1
GO

IF OBJECT_ID ('rpt_cr_cabc2') IS NOT NULL
	DROP TABLE rpt_cr_cabc2
GO

IF OBJECT_ID ('rpt_cr_cabc3') IS NOT NULL
	DROP TABLE rpt_cr_cabc3
GO

IF OBJECT_ID ('rpt_cr_cabc4') IS NOT NULL
	DROP TABLE rpt_cr_cabc4
GO

IF OBJECT_ID ('rpt_cr_opcns') IS NOT NULL
	DROP TABLE rpt_cr_opcns
GO

IF OBJECT_ID('ca_transaccion') IS NOT NULL
	DROP TABLE ca_transaccion
go

IF OBJECT_ID('ca_det_trn') IS NOT NULL
	DROP TABLE ca_det_trn
go

IF OBJECT_ID('ca_concepto') IS NOT NULL
	DROP TABLE ca_concepto
go

IF OBJECT_ID('rpt_ca_seg_reporte_a') IS NOT NULL
	DROP TABLE rpt_ca_seg_reporte_a
go

IF OBJECT_ID('rpt_ca_seg_reporte_b') IS NOT NULL
	DROP TABLE rpt_ca_seg_reporte_b
go

IF OBJECT_ID('rpt_ca_seg_total_a') IS NOT NULL
	DROP TABLE rpt_ca_seg_total_a
go

IF OBJECT_ID('rpt_Seleccion_total_b') IS NOT NULL
	DROP TABLE rpt_Seleccion_total_b
go


use cob_pfijo
go
IF OBJECT_ID ('rpt_cr_opcns') IS NOT NULL
	DROP TABLE rpt_cr_opcns
GO



USE cob_cartera
GO

CREATE TABLE rpt_cr_opcns (cadena VARCHAR (215) COLLATE Latin1_General_BIN NULL
	)
GO

CREATE TABLE rpt_cr_cabc1 (
	cadena varchar(215) NULL
	)
GO

CREATE TABLE rpt_cr_cabc2 (
	cadena varchar(215) NULL
	)
GO

CREATE TABLE rpt_cr_cabc3 (
	cadena varchar(215) NULL
	)
GO

CREATE TABLE rpt_cr_cabc4 (
	cadena varchar(215) NULL
	)
GO

CREATE TABLE [dbo].[ca_transaccion](
	[tr_secuencial] [int] NOT NULL,
	[tr_fecha_mov] [smalldatetime] NOT NULL,
	[tr_toperacion] [char](10) NOT NULL,
	[tr_moneda] [tinyint] NOT NULL,
	[tr_operacion] [int] NOT NULL,
	[tr_tran] [char](10) NOT NULL,
	[tr_en_linea] [char](1) NOT NULL,
	[tr_banco] [char](24) NOT NULL,
	[tr_dias_calc] [int] NOT NULL,
	[tr_ofi_oper] [smallint] NOT NULL,
	[tr_ofi_usu] [smallint] NOT NULL,
	[tr_usuario] [char](14) NOT NULL,
	[tr_terminal] [char](30) NOT NULL,
	[tr_fecha_ref] [smalldatetime] NOT NULL,
	[tr_secuencial_ref] [int] NOT NULL,
	[tr_estado] [char](10) NOT NULL,
	[tr_observacion] [char](62) NOT NULL,
	[tr_gerente] [smallint] NOT NULL,
	[tr_comprobante] [int] NOT NULL,
	[tr_fecha_cont] [datetime] NOT NULL,
	[tr_gar_admisible] [char](1) NOT NULL,
	[tr_reestructuracion] [char](1) NOT NULL,
	[tr_calificacion] [char](1) NOT NULL,
	[tr_fecha_real] [datetime] NULL CONSTRAINT [DF_ca_transaccion_tr_fecha_real]  DEFAULT (getdate())
)
go
CREATE TABLE [dbo].[ca_det_trn](
	[dtr_secuencial] [int] NOT NULL,
	[dtr_operacion] [int] NOT NULL,
	[dtr_dividendo] [int] NOT NULL,
	[dtr_concepto] [dbo].[catalogo] NOT NULL,
	[dtr_estado] [tinyint] NOT NULL,
	[dtr_periodo] [tinyint] NOT NULL,
	[dtr_codvalor] [int] NOT NULL,
	[dtr_monto] [money] NOT NULL,
	[dtr_monto_mn] [money] NOT NULL,
	[dtr_moneda] [tinyint] NOT NULL,
	[dtr_cotizacion] [float] NOT NULL,
	[dtr_tcotizacion] [char](1) NOT NULL,
	[dtr_afectacion] [char](1) NOT NULL,
	[dtr_cuenta] [char](20) NOT NULL,
	[dtr_beneficiario] [char](64) NOT NULL,
	[dtr_monto_cont] [money] NOT NULL
) 
go
CREATE TABLE [dbo].[ca_concepto](
	[co_concepto] [dbo].[catalogo] NOT NULL,
	[co_descripcion] [dbo].[descripcion] NOT NULL,
	[co_codigo] [tinyint] NOT NULL,
	[co_categoria] [dbo].[catalogo] NOT NULL
)
go
CREATE TABLE [dbo].[rpt_ca_seg_reporte_a](
	[tr_ofi_oper_a] [smallint] NULL,
	[dtr_concepto_a] [dbo].[catalogo] NULL,
	[valor_a] [money] NULL
)
go

CREATE TABLE [dbo].[rpt_ca_seg_reporte_b](
	[tr_ofi_oper_b] [smallint] NULL,
	[dtr_concepto_b] [dbo].[catalogo] NULL,
	[valor_b] [money] NULL
)
go

CREATE TABLE [dbo].[rpt_ca_seg_total_a](
	[dtr_concepto_ta] [dbo].[catalogo] NULL,
	[total_ta] [money] NULL
) 

go

CREATE TABLE [dbo].[rpt_Seleccion_total_b](
	[dtr_concepto_tb] [dbo].[catalogo] NULL,
	[total_tb] [money] NULL
)

CREATE TABLE [dbo].[ca_errorlog](
	[er_fecha_proc] [datetime] NOT NULL,
	[er_error] [int] NULL,
	[er_usuario] [dbo].[login] NULL,
	[er_tran] [int] NULL,
	[er_cuenta] [dbo].[cuenta] NULL,
	[er_descripcion] [varchar](255) NULL,
	[er_anexo] [varchar](255) NULL
)

use cob_credito
GO

CREATE TABLE cr_oper_cons (
	os_producto tinyint NOT NULL,
	os_operacion varchar(24) NOT NULL,
	os_cliente int NOT NULL,
	os_toperacion varchar(10) NOT NULL,
	os_moneda tinyint NOT NULL,
	os_estado_contable tinyint NOT NULL,
	os_saldo money NULL,
	os_clase catalogo NOT NULL
	)
GO

CREATE TABLE cr_errorlog (
	er_fecha_proc datetime NOT NULL,
	er_error int NULL,
	er_usuario login NULL,
	er_tran int NULL,
	er_cuenta cuenta NULL,
	er_descripcion varchar(255) NULL
	)
GO


CREATE TABLE rpt_cr_opcns (cadena VARCHAR (215) COLLATE Latin1_General_BIN NULL)
GO


use cob_pfijo
GO
CREATE TABLE rpt_cr_opcns (cadena VARCHAR (215) COLLATE Latin1_General_BIN NULL
	)
GO

