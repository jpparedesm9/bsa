use cob_remesas
go

print 'Creando tabla pe_tran_servicio'
go

CREATE TABLE pe_tran_servicio (
    ts_secuencial   int not null,
    ts_tipo_transaccion smallint    not null,
    ts_oficina  smallint    null,
    ts_usuario  varchar(64) null,
    ts_terminal varchar(64) null,
    ts_reentry  char(1) null,
    ts_cod_alterno  int null,
    ts_servicio_per smallint    null,
    ts_categoria    varchar(10) null,
    ts_tipo_rango   tinyint null,
    ts_grupo_rango  smallint    null,
    ts_rango    tinyint null,
    ts_operacion    char(1) null,
    ts_tipo char(1) null,
    ts_minimo   real    null,
    ts_maximo   real    null,
    ts_val_medio    real    null,
    ts_en_linea char(1) null,
    ts_tipo_default char(1) null,
    ts_rol  char(1) null,
    ts_producto tinyint null,
    ts_codigo   int null,
    ts_valor_con    real    null,
    ts_tipo_variacion   char(1) null,
    ts_cuenta   varchar(24) null,
    ts_fecha_cambio smalldatetime   null,
    ts_fecha_vigencia   smalldatetime   null,
    ts_fecha    smalldatetime   null,
    ts_pro_final    smallint    null,
    ts_servicio_dis smallint    null,
    ts_rubro    varchar(10) null,
    ts_hora datetime    null,
    ts_especie  varchar(64) null,
    ts_origen   varchar(64) null,
    ts_valor_chq    money   null,
    ts_valor_chq_otra   money   null,
    ts_valor_efe    money   null,
    ts_valor_efe_otra   money   null
)
go



/* cb_ult_fecha_cotiz_mon */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER ON
go


/* asi_auxiliar */
set ANSI_NULLS ON
go
set QUOTED_IDENTIFIER ON
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

--
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
/* re_ts_causales_impuestos */
set ANSI_NULLS OFF
go
set QUOTED_IDENTIFIER OFF
go

CREATE VIEW re_ts_causales_impuestos (
            secuencial, tipo_transaccion, fecha, causa, referencia,
            usuario, terminal, oficina, producto, hora)
as
select  ts_secuencial,
        ts_tipo_transaccion,
        ts_tsfecha,
        ts_char5,
        ts_varchar7,
        ts_login,
        ts_terminal,
        ts_oficina,
        ts_tinyint1,
        ts_datetime1
  from  re_tran_servicio
  where ts_tipo_transaccion in (698, 699, 701)

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


/* ts_par_perfil */
set ANSI_NULLS OFF
go
set QUOTED_IDENTIFIER OFF
go
create view ts_par_perfil
(
    secuencial,  tipo_transaccion, oficina,   usuario,
    terminal,    nodo,             operacion, clase,
    fecha_proc,  fecha_sis,        sec_reg,   producto,
    transaccion, perfil,           tipo_trn
)
as
select ts_secuencial, ts_tipo_transaccion, ts_oficina, ts_operador,
       ts_terminal,   ts_nodo,             ts_origen,  ts_clase,
       ts_tsfecha,    ts_datetime1,        ts_int1,    ts_tinyint1,
       ts_smallint1,  ts_varchar2,         ts_varchar4
from   re_tran_servicio
where  ts_tipo_transaccion in (720, 721)

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

