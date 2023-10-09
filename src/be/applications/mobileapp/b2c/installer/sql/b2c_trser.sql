/******************************************************************************/
/*  Archivo:            b2c_trser.sql                                         */
/*  Base de datos:      cob_bvirtual                                          */
/******************************************************************************/
/*              IMPORTANTE                                                    */
/*  Este programa es parte de los paquetes bancarios propiedad de             */
/*  "Cobiscorp".                                                              */
/*  Su uso no autorizado queda expresamente prohibido asi como                */
/*  cualquier alteracion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la                   */
/*  Presidencia Ejecutiva de Cobiscorp o su representante.                    */
/******************************************************************************/
/*              PROPOSITO                                                     */
/*  Creacion tabla de servicio y Vistas                                       */
/******************************************************************************/
/*              MODIFICACIONES                                                */
/******************************************************************************/
/* FECHA        VERSION       AUTOR              RAZON                        */
/******************************************************************************/
/* 23/Nov/2018   4.1.0.5    Estefania Ramirez  Emision Inicial Instalador B2C */
/******************************************************************************/
use cob_bvirtual
go
print 'Creando tabla de transacciones de servicio y vistas...'
print 'bv_tran_servicio'
if not exists (select * from sysobjects where name = 'bv_tran_servicio')
CREATE TABLE bv_tran_servicio (
        ts_secuencial           int             not null,
        ts_tipo_transaccion     int             not null,
        ts_clase                char(1)         not null,
        ts_cod_alterno          int             null,
        ts_fecha                datetime        null,
        ts_usuario              varchar(14)     null,
        ts_terminal             varchar(64)     null,
        ts_oficina              smallint        null,
        ts_tabla                varchar(30)     null,
        ts_lsrv                 varchar(30)     null,
        ts_srv                  varchar(30)     null,
        ts_hora                 varchar(8)      null,
        ts_int01                int             null,
        ts_int02                int             null,
        ts_int03                int             null,
        ts_int04                int             null,
        ts_int05                int             null,
        ts_int06                int             null,
        ts_int07                int             null,
        ts_smallint01           smallint        null,
        ts_smallint02           smallint        null,
        ts_smallint03           smallint        null,
        ts_smallint04           smallint        null,
        ts_tinyint01            tinyint         null,
        ts_tinyint02            tinyint         null,
        ts_tinyint03            tinyint         null,
        ts_descripcion01        varchar(64)     null,
        ts_descripcion02        varchar(64)     null,
        ts_descripcion03        varchar(64)     null,
        ts_descripcion04        varchar(64)     null,
        ts_fecha01              datetime        null,
        ts_fecha02              datetime        null,
        ts_fecha03              datetime        null,
        ts_fecha04              datetime        null,
        ts_char101              char(1)         null,
        ts_char102              char(1)         null,
        ts_char103              char(1)         null,
        ts_char104     			char(1)     	null,
		ts_char106     			char(1)     	null,
        ts_char201              char(2)         null,
        ts_char301              char(3)         null,
        ts_char501              char(5)         null,
        ts_char601              char(6)         null,
        ts_char6401     		char(64) 		null,
        ts_char6402    			char(64) 		null,
        ts_char6403     		char(64) 		null,
        ts_char6404     		char(64) 		null,
        ts_char6405     		char(64) 		null,
        ts_char6406     		char(64) 		null,
        ts_char6407     		char(64) 		null,
        ts_float01              float           null,
        ts_float02              float           null,
        ts_float03              float           null,
		ts_varchar1501    		varchar(15) 	null,
		ts_varchar1502    		varchar(15) 	null,
		ts_varchar2001    		varchar(20) 	null,
        ts_varchar3001          varchar(30)     null,
        ts_varchar3002          varchar(30)     null,
        ts_varchar3003          varchar(30)     null,
        ts_varchar3004          varchar(30)     null,
        ts_varchar3201          varchar(32)     null,
		ts_varchar10001      	varchar(100)    null,
        ts_varchar25501         varchar(255)    null,
        ts_varchar25502         varchar(255)    null,
        ts_varchar601           varchar(6)      null,
        ts_catalogo01           varchar(14)     null,
        ts_catalogo02           varchar(14)     null,
        ts_catalogo03           varchar(14)     null,
        ts_catalogo04           varchar(14)     null,
        ts_catalogo05           varchar(14)     null,
        ts_money01              money           null,
        ts_money02              money           null,
        ts_money03              money           null,
        ts_money04              money           null,
        ts_grupo                int             null,
        ts_miembro              int             null,
        ts_varchar10002         varchar(100)    null, /*IB0041*/
	    ts_varchar12801         varchar(128)    null, /*PAV Variables CPN*/
		ts_varchar1				varchar(15)		null,
		ts_varchar2				varchar(15)		null,
		ts_varchar3				varchar(15)		null,
		ts_varchar6				varchar(15)		null,	
		ts_varchar9				varchar(15)		null,
)

if not exists (select 1 from sysindexes where name = 'bv_tran_servicio_Key')
CREATE UNIQUE CLUSTERED INDEX [bv_tran_servicio_Key] ON [dbo].[bv_tran_servicio]
(
   [ts_tipo_transaccion] ASC,
   [ts_secuencial] ASC,
   [ts_cod_alterno] ASC,
   [ts_clase] ASC
) WITH  FILLFACTOR = 90

if not exists (select 1 from sysindexes where name = 'idx_tran_alterno')
CREATE NONCLUSTERED INDEX [idx_tran_alterno] ON [dbo].[bv_tran_servicio]
(
   [ts_tipo_transaccion] ASC,
   [ts_cod_alterno] ASC,
   [ts_clase] ASC
) WITH  FILLFACTOR = 90
go

print 'ts_ente'
go
if exists (select * from sysobjects
           where type = 'V' and name = 'ts_ente')
drop view ts_ente
go

CREATE VIEW ts_ente
    ( secuencial,
      cod_alterno,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      ente,
      ente_mis,
      nombre,
      fecha_reg,
      fecha_mod,
      fecha_nac,
      ced_ruc,
      categoria,
      tipo,
      email,
      fax,
      sector,
      lenguaje,
      oficina_ente,
      notificacion,
      oficial,
      autorizado,
      origen_ente,
      uso_convenio,
      segmento,
      linea_negocio,
      apoderado,
      grupo,
	  hora,
	  tipo_autorizacion
 ) AS
  SELECT ts_secuencial,
   ts_cod_alterno,
   ts_tipo_transaccion,
   ts_clase,
   ts_fecha,
   ts_usuario,
   ts_terminal,
   ts_oficina,
   ts_tabla,
   ts_lsrv,
   ts_srv,
   ts_int01,
   ts_int02,
   ts_descripcion01,
   ts_fecha01,
   ts_fecha02,
   ts_fecha03,
   ts_varchar3001,
   ts_catalogo01,
   ts_char101,
   ts_descripcion02,
   ts_varchar3201,
   ts_catalogo02,
   ts_catalogo03,
   ts_smallint01,
   ts_char102,
   ts_smallint02,
   ts_char103,
   ts_char301,
   ts_catalogo04,
   ts_catalogo05,
   ts_varchar1501,
   ts_int03,
   ts_varchar25501,
   ts_fecha04,
   ts_char6407 
 from bv_tran_servicio
   WHERE  ts_tipo_transaccion in(18501, 1800502)
go

print 'ts_servicio'
go
if exists (select * from sysobjects
           where type = 'V' and name = 'ts_servicio')
drop view ts_servicio
go

create view ts_servicio(
      secuencial,
      cod_alterno,
      tipo_transaccion,
      clase,
      fecha,
      usuario,
      terminal,
      oficina,
      tabla,
      lsrv,
      srv,
      servicio,
      nombre,
      descripcion,
      habilitado,
      fecha_reg,
      fecha_mod,
      estado
) as
select
      ts_secuencial,
      ts_cod_alterno,
      ts_tipo_transaccion,
      ts_clase,
      ts_fecha,
      ts_usuario,
      ts_terminal,
      ts_oficina,
      ts_tabla,
      ts_lsrv,
      ts_srv,
      ts_tinyint01,
      ts_varchar3201,
      ts_descripcion01,
      ts_catalogo01,
      ts_fecha01,
      ts_fecha02,
      ts_catalogo02
FROM bv_tran_servicio
WHERE ts_tipo_transaccion = 18509
go


print 'ts_login'
go
if exists (select * from sysobjects
           where type = 'V' and name = 'ts_login')
drop view ts_login
go

CREATE VIEW ts_login
    (
        secuencial, cod_alterno, tipo_transaccion, clase,
        fecha, usuario, terminal, oficina,
        tabla, lsrv, srv, hora,
        --
        ente, servicio, login, clave_temp,
        clave_def, fecha_reg, fecha_mod, fecha_ult_pwd,
        tipo_vigencia, dias_vigencia, parametro, renovable,
        descripcion, estado, autorizado, tipo_autorizacion,
        usar_mimenu, estilo, lenguaje, motivo_reimp,
        num_clave_gen, num_clave_imp,   carga_pagina, fecha_ult_int,
        empresa, sucursal, afiliador,   of_operaciones
    )
AS
    SELECT
        ts_secuencial, ts_cod_alterno, ts_tipo_transaccion, ts_clase,
        ts_fecha, ts_usuario, ts_terminal, ts_oficina,
        ts_tabla, ts_lsrv, ts_srv, ts_hora,
        --
        ts_int01, ts_tinyint01, ts_descripcion01, ts_descripcion02,
        ts_descripcion03, ts_fecha01, ts_fecha02, ts_fecha03,
        ts_catalogo01, ts_smallint01, ts_catalogo02, ts_char101,
        ts_descripcion04, ts_catalogo04, ts_char102, ts_catalogo05,
        ts_char103, ts_catalogo03, ts_varchar601, ts_char201,
        ts_smallint02, ts_smallint03, ts_char104, ts_fecha04,
        ts_int02, ts_smallint04, ts_varchar3001, ts_varchar3002
    FROM bv_tran_servicio
    WHERE ts_tipo_transaccion = 18548
       OR ts_tipo_transaccion = 18761
go



--Internacionalizacion
use cobis
go

/****************************************************************************/
/*  Vista General de Etiquetas                                              */
/****************************************************************************/

PRINT 'ELIMINACION DE VISTA ad_etiqueta_i18n'
IF EXISTS (SELECT 1 FROM sysobjects
           WHERE name = 'ad_etiqueta_i18n')
DROP VIEW ad_etiqueta_i18n
GO

PRINT 'CREACION DE VISTA ad_etiqueta_i18n'
GO
CREATE VIEW ad_etiqueta_i18n
AS
    SELECT pc_id, pc_tipo, pc_identificador, pc_codigo, re_cultura, re_valor
    FROM ad_pseudo_catalogo INNER JOIN ad_recurso
        ON pc_id = re_pc_id
    WHERE pc_tipo = 'L'
GO