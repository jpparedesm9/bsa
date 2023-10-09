use cob_remesas
go
print 'Creando tabla pe_tran_servicio'
go

 CREATE TABLE dbo.pe_tran_servicio
    (
    ts_secuencial       INT NOT NULL,
    ts_tipo_transaccion SMALLINT NOT NULL,
    ts_oficina          SMALLINT NULL,
    ts_usuario          VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_terminal         VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_reentry          CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_cod_alterno      INT NULL,
    ts_servicio_per     SMALLINT NULL,
    ts_categoria        VARCHAR (10) COLLATE Latin1_General_BIN NULL,
    ts_tipo_rango       TINYINT NULL,
    ts_grupo_rango      SMALLINT NULL,
    ts_rango            TINYINT NULL,
    ts_operacion        CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_tipo             CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_minimo           REAL NULL,
    ts_maximo           REAL NULL,
    ts_val_medio        REAL NULL,
    ts_en_linea         CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_tipo_default     CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_rol              CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_producto         TINYINT NULL,
    ts_codigo           INT NULL,
    ts_valor_con        REAL NULL,
    ts_tipo_variacion   CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_cuenta           VARCHAR (24) COLLATE Latin1_General_BIN NULL,
    ts_fecha_cambio     SMALLDATETIME NULL,
    ts_fecha_vigencia   SMALLDATETIME NULL,
    ts_fecha            SMALLDATETIME NULL,
    ts_pro_final        SMALLINT NULL,
    ts_servicio_dis     SMALLINT NULL,
    ts_rubro            VARCHAR (10) COLLATE Latin1_General_BIN NULL,
    ts_hora             DATETIME NULL,
    ts_especie          VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_origen           VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_valor_chq        MONEY NULL,
    ts_valor_chq_otra   MONEY NULL,
    ts_valor_efe        MONEY NULL,
    ts_valor_efe_otra   MONEY NULL,
    ts_plantilla        VARCHAR (20) COLLATE Latin1_General_BIN NULL,
    ts_prod_banc        SMALLINT NULL,
    ts_estado           CHAR (1) COLLATE Latin1_General_BIN NULL,
    ts_descripcion      VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ts_posteo           CHAR (1) COLLATE Latin1_General_BIN NULL
    )
go

--CREATE VIEWS

/* comprobantes */

/* pe_ts_cambio_costo */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go
create view pe_ts_cambio_costo (
        servicio_per,
        categoria,
        tipo_rango,
        grupo_rango,
        rango,
        operacion,
        tipo,
        minimo,
        val_medio,
        maximo,
        fecha_cambio,
        fecha_vigencia,
        en_linea)
as
select ts_servicio_per,
    ts_categoria,
    ts_tipo_rango,
    ts_grupo_rango,
    ts_rango,
    ts_operacion,
    ts_tipo,
    ts_minimo,
    ts_val_medio,
    ts_maximo,
    ts_fecha_cambio,
    ts_fecha_vigencia,
    ts_en_linea
from pe_tran_servicio
where ts_tipo_transaccion in (4049,4050,4051)

go

/* ts_tope_oficina */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go

   create view ts_tope_oficina(
      secuencial,            tipo_transaccion,     fecha,
      usuario,               terminal,             cantidad,
      operacion,             efectivo,             cheque_gere,
      efectivo_otra,         cheque_gere_otra,     producto,
      valor_efe,             valor_chq,            valor_efe_otra,
      valor_chq_otra
   ) as
   select
      ts_secuencial,         ts_tipo_transaccion,  ts_fecha,
      ts_usuario,            ts_terminal,          ts_cod_alterno,
      ts_operacion,          ts_tipo,              ts_en_linea,
      ts_tipo_default,       ts_rol,               ts_producto,
      ts_valor_efe,          ts_valor_chq,         ts_valor_efe_otra,
      ts_valor_chq_otra
   from pe_tran_servicio
   where pe_tran_servicio.ts_tipo_transaccion = 4128


go

/* pe_ts_costo */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go
create view pe_ts_costo (
        servicio_per,
        categoria,
        tipo_rango,
        grupo_rango,
        rango,
        minimo,
        val_medio,
        maximo,
        fecha_vigencia)
as
select ts_servicio_per,
    ts_categoria,
    ts_tipo_rango,
    ts_grupo_rango,
    ts_rango,
    ts_minimo,
    ts_val_medio,
    ts_maximo,
    ts_fecha_vigencia
from pe_tran_servicio
where ts_tipo_transaccion in (4060)

go

/* pe_ts_val_contratado */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go
create view pe_ts_val_contratado (
        tipo_default,
        rol,
        codigo,
        producto,
        servicio_per,
        categoria,
        tipo_rango,
        grupo_rango,
        rango,
        valor_con,
        fecha,
        tipo_variacion)
as
select ts_tipo_default,
    ts_rol,
    ts_codigo,
    ts_producto,
    ts_servicio_per,
    ts_categoria,
    ts_tipo_rango,
    ts_grupo_rango,
    ts_rango,
    ts_valor_con,
    ts_fecha,
    ts_tipo_variacion
from pe_tran_servicio
where ts_tipo_transaccion in (4068,4069)

go

/* pe_ts_personaliza */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go
create view pe_ts_personaliza(
        cuenta,
        producto,
        tipo_default,
        rol_ente,
        codigo_default)
as
select  ts_cuenta,
    ts_producto,
    ts_tipo_default,
    ts_rol,
    ts_codigo
from pe_tran_servicio
where ts_tipo_transaccion in (4071)

go

/* ts_limites_restrictivos */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go

   create view ts_limites_restrictivos(
      secuencial,            tipo_transaccion,     fecha,
      usuario,               terminal,             lr_tipo_tran,
      operacion,             lr_origen,            lr_especie,
      lr_tabla,              lr_nro_transacciones, lr_monto_transacciones
   ) as
   select
      ts_secuencial,         ts_tipo_transaccion,  ts_fecha,
      ts_usuario,            ts_terminal,          ts_en_linea,
      ts_operacion,          ts_tipo,              ts_origen,
      ts_especie,            ts_grupo_rango,       ts_valor_efe
   from pe_tran_servicio
   where pe_tran_servicio.ts_tipo_transaccion = 4149


go

/* ts_causales_restringidas */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go

   create view ts_causales_restringidas(
      secuencial,            tipo_transaccion,     fecha,
      usuario,               terminal,             operacion,
      tipo_tran,             cr_causal,            cr_origen,
      cr_especie
   ) as
   select
      ts_secuencial,         ts_tipo_transaccion,  ts_fecha,
      ts_usuario,            ts_terminal,          ts_operacion,
      ts_tipo,               ts_rubro,             ts_origen,
      ts_especie
   from pe_tran_servicio
   where pe_tran_servicio.ts_tipo_transaccion = 4150
go

--jca
use cob_remesas
go

/* pe_ts_contrato_producto */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER OFF
go

create view pe_ts_contrato_producto (
        fecha, secuencial, tipo_transaccion,oficina,usuario,
        terminal, reentry,operacion, tipo_variacion,producto,
        prod_banc, tipo_persona, titularidad, estado, plantilla, descripcion,hora, es_especial
) as
select 
        ts_fecha,ts_secuencial, ts_tipo_transaccion,ts_oficina, ts_usuario, 
        ts_terminal, ts_reentry,ts_operacion,ts_tipo_variacion,ts_producto,
        ts_prod_banc, ts_tipo, ts_posteo, ts_estado, ts_plantilla, ts_descripcion,ts_hora, ts_rubro
from pe_tran_servicio
where ts_tipo_transaccion = 2946
go

use cobis
go

print 'Insert ==>  cobis..ad_vistas_trnser'
if exists (select 1 from sysobjects where id = object_id('ad_vistas_trnser'))
begin
    
delete from cobis..ad_vistas_trnser
where vt_producto = 17
and vt_base_datos = 'cob_remesas'
and vt_tabla      = 'pe_ts_contrato_producto'

end
go

insert into ad_vistas_trnser values (17,'cob_remesas','pe_ts_contrato_producto','MANTENIMIENTO DE ASOCIACIÓN DE CONTRATOS','V','fecha','secuencial','tipo_variacion','N','P','A','B','usuario','terminal',null,'moneda',null)               
go


use cob_remesas_his
go


print 'Creando tabla pe_his_ts'
IF EXISTS (select 1 from sysobjects where name = 'pe_his_ts')
   DROP TABLE pe_his_ts
go
Create table pe_his_ts (
        hts_secuencial        int         not null,
        hts_tipo_transaccion    smallint     not null,
        hts_oficina        smallint     null,
        hts_usuario        descripcion    null,
        hts_terminal        descripcion    null,
        hts_reentry        char(1)        null,
        hts_cod_alterno        int         null,
        hts_servicio_per    smallint    null,
        hts_categoria        catalogo    null,
        hts_tipo_rango        tinyint        null,
        hts_grupo_rango        smallint    null,
        hts_rango        tinyint        null,
        hts_operacion        char(1)        null,
        hts_tipo        char(1)        null,
        hts_minimo        real        null,
        hts_maximo        real        null,
        hts_val_medio        real        null,
        hts_en_linea        char(1)        null,
        hts_tipo_default    char(1)        null,
        hts_rol            char(1)        null,
        hts_producto        tinyint        null,
        hts_codigo        int        null,
        hts_cuenta        cuenta        null,
        hts_valor_con        real        null,
        hts_tipo_variacion    char(1)        null,
        hts_fecha_cambio    smalldatetime    null,
        hts_fecha_vigencia    smalldatetime    null,
        hts_fecha        smalldatetime    null,
        hts_fecha_batch        smalldatetime    null)
go

print 'Creando tabla re_camara_hist'
IF EXISTS (select 1 from sysobjects where name = 're_camara_hist')
   DROP TABLE re_camara_hist
go

CREATE TABLE re_camara_hist (
    ca_fecha             DATETIME NOT NULL,
    ca_secuencial        INT NOT NULL,
    ca_tipo_cheque       CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ca_cuenta            VARCHAR (24) COLLATE Latin1_General_BIN NOT NULL,
    ca_num_cheque        INT NOT NULL,
    ca_valor             MONEY NOT NULL,
    ca_moneda            TINYINT NOT NULL,
    ca_estado            CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
    ca_oficina           SMALLINT NOT NULL,
    ca_banco             TINYINT NULL,
    ca_mensaje           VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ca_cta_dep           VARCHAR (24) COLLATE Latin1_General_BIN NULL,
    ca_producto          TINYINT NULL,
    ca_tipo_error        VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_causa_dev         VARCHAR (64) COLLATE Latin1_General_BIN NULL,
    ca_tipo_equip        VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_tipo_tran         INT NULL,
    ca_secuencial_unisys INT NULL,
    ca_sec_det           INT NULL,
    ca_sec_cab           INT NULL,
    ca_comision          MONEY NULL,
    ca_portes            MONEY NULL,
    ca_iva               MONEY NULL,
    ca_portes_dev        MONEY NULL,
    ca_iva_dev           MONEY NULL,
    ca_procesado         VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_bcoced            INT NULL,
    ca_tipo_compensa     VARCHAR (1) COLLATE Latin1_General_BIN NULL,
    ca_digito_46         TINYINT NULL,
    ca_oficina_cta       SMALLINT NULL
    )
go


