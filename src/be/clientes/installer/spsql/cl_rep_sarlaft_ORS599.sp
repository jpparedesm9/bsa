/************************************************************************/
/*  Archivo:                cl_reporte_sarlaft_ORS599.sp                */
/*  Stored procedure:       sp_reporte_sarlaft                          */
/*  Base de datos:          cobis                                       */
/*  Disenado por:           Edwin Jimenez                               */
/*  Fecha de escritura:     04-Jul-2013                                 */
/************************************************************************/
/*                            IMPORTANTE                                */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                             PROPOSITO                                */
/*  Este stored procedure genera un archivo plano con la base utilizada */
/*  para la realizacion de las validaciones indicadas por la SFC, con   */
/*  respecto a la calidad de data.                                      */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*  FECHA          AUTOR            RAZON                               */
/*  04-Jul-2013    E.Jimenez      Emision Inicial                       */
/*  02-May-2016    DFu            Migracion CEN                         */
/************************************************************************/
use cobis
go

set ANSI_NULLS on
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_reporte_sarlaft')
  drop proc sp_reporte_sarlaft
go

create proc sp_reporte_sarlaft
(
  @t_show_version bit = 0,
  @i_param1       varchar(10),
  @i_param2       varchar(10),
  @i_fecha        datetime = null
)
as
  declare
    @w_sp_name         varchar(30),
    @w_tipo_ent        varchar(10),
    @w_cod_entidad     varchar(10),
    @w_sp_name_batch   varchar(50),
    @w_path            varchar(255),
    @w_s_app           varchar(255),
    @w_path_plano      varchar(255),
    @w_cmd             varchar(255),
    @w_msg             varchar(100),
    @w_comando         varchar(500),
    @w_errores         varchar(255),
    @w_error           int,
    @w_fecha           datetime,
    @w_fecha_arch      char(8),
    @w_nombre_arch_txt varchar(255),
    @w_nombre_arch_err varchar(255),
    @w_fecha_ini       datetime,
    @w_fecha_fin       datetime

  select
    @w_sp_name = 'sp_reporte_sarlaft'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Obtiene Nombre del Procedimiento */
  select
    @w_sp_name_batch = 'cobis..sp_reporte_sarlaft'

  if exists (select
               1
             from   cob_conta_super..sysobjects
             where  name = 'sb_dato_sarlaft1')
    truncate table cob_conta_super..sb_dato_sarlaft1

  select
    @w_fecha_ini = convert(datetime, @i_param1),
    @w_fecha_fin = convert(datetime, @i_param2),
    @i_fecha = convert(varchar, fp_fecha, 101),
    @w_fecha = convert(varchar, fp_fecha, 101)
  from   cobis..ba_fecha_proceso

  /* Obtiene el path donde se va a generar el informe : VBatch\Clientes\Listados */
  select
    @w_path = ba_path_destino
  from   cobis..ba_batch
  where  ba_arch_fuente = @w_sp_name_batch

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR EN LA BUSQUEDA DEL PATH EN LA TABLA ba_batch'
    goto ERROR_INF
  end

  /* Obtiene el parametro de la ubicacion del kernel\bin en el servidor */
  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @@rowcount = 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR AL OBTENER EL PARAMETRO GENERAL S_APP DE ADM'
    goto ERROR_INF
  end

  --Plazo fijo ingresos
  select
    'producto' = (select
                    pd_descripcion
                  from   cobis..cl_producto
                  where  pd_producto = dd_aplicativo),
    'Actividad' = case
                    when substring(en_actividad,
                                   0,
                                   3) = '' then '00'
                    else substring(en_actividad,
                                   0,
                                   3)
                  end,
    'Canal' = dt_canal,
    'Jurisdiccion' = dt_oficina,
    'Tipo_tran' = 'I',
    'monto' = dd_monto,
    'Concepto' = dd_concepto,
    dt_tipo_trans,
    en_ente,
    dd_secuencial,
    dd_banco
  into   #universo
  from   cob_conta_super.dbo.sb_dato_pasivas with (nolock),
         cob_conta_super.dbo.sb_dato_transaccion with (nolock),
         cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
         cobis.dbo.cl_ente with (nolock)
  where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
     and dd_secuencial = dt_secuencial
     and dt_aplicativo in (14)
     and dd_concepto in ('CHLOCAL', 'EFMN', 'SEBRA', 'CHGEREN')
     and (dt_tipo_trans in('APE')
           or (dt_tipo_trans in('REN')
               and dd_monto      < 0))-- INGRESOS
     and dd_banco      = dp_banco
     and dd_banco      = dt_banco
     and dp_aplicativo = dd_aplicativo
     and dd_aplicativo = dt_aplicativo
     and dp_fecha      = dd_fecha
     and dd_fecha      = dt_fecha
     and en_ente       = dp_cliente

  -----------------------------------------------
  --- palzo fijo EGRESO

  insert into #universo
    select
      'producto' = (select
                      pd_descripcion
                    from   cobis..cl_producto
                    where  pd_producto = dd_aplicativo),'Actividad' = case
                      when substring(en_actividad,
                                     0,
                                     3) = '' then '00'
                      else substring(en_actividad,
                                     0,
                                     3)
                    end,'Canal' = dt_canal,'Jurisdiccion' = dt_oficina,
      'Tipo_tran' = 'E',
      'monto' = dd_monto,'Concepto' = dd_concepto,dt_tipo_trans,en_ente,
      dd_secuencial,
      dd_banco
    from   cob_conta_super.dbo.sb_dato_pasivas with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
           cobis.dbo.cl_ente with (nolock)
    where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
       and dd_aplicativo = dt_aplicativo
       and dd_secuencial = dt_secuencial
       and dd_fecha      = dt_fecha
       and dt_aplicativo in (14)
       and dd_concepto in ('CHGEREN', 'EFMN', 'SEBRA')
       and (dt_tipo_trans in('CAN')
             or (dt_tipo_trans in('REN')
                 and dd_monto      > 0))
       and dd_banco      = dp_banco
       and dp_aplicativo = dd_aplicativo
       and dp_fecha      = dd_fecha
       and dt_banco      = dd_banco
       and en_ente       = dp_cliente

  ---------------------------------------------------
  --CARTERA CAJA EFECTIVO

  insert into #universo
    select
      'producto' = (select
                      pd_descripcion
                    from   cobis..cl_producto
                    where  pd_producto = dd_aplicativo),'Actividad' = case
                      when substring(en_actividad,
                                     0,
                                     3) = '' then '00'
                      else substring(en_actividad,
                                     0,
                                     3)
                    end,'Canal' = dt_canal,'Jurisdiccion' = dt_oficina,
      'Tipo_tran' = 'E',
      'monto' = dd_monto,'Concepto' = dd_concepto,dt_tipo_trans,en_ente,
      dd_secuencial,
      dd_banco
    from   cob_conta_super.dbo.sb_dato_operacion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
           cobis.dbo.cl_ente with (nolock)
    where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
       and dd_aplicativo = dt_aplicativo
       and dd_secuencial = dt_secuencial
       and dd_fecha      = dt_fecha
       and dt_aplicativo in (7)
       and dd_concepto in ('CAJA', 'CHGEREN', 'RENOVACION', 'EFMN', 'TRANSFEREN'
                          )
       and dt_tipo_trans in ('DES') -- EGRESOS
       and dd_banco      = do_banco
       and do_aplicativo = dd_aplicativo
       and do_fecha      = dd_fecha
       and dt_banco      = dd_banco
       and en_ente       = do_codigo_cliente

  --ingresos
  insert into #universo
    select
      'producto' = (select
                      pd_descripcion
                    from   cobis..cl_producto
                    where  pd_producto = dd_aplicativo),'Actividad' = case
                      when substring(en_actividad,
                                     0,
                                     3) = '' then '00'
                      else substring(en_actividad,
                                     0,
                                     3)
                    end,'Canal' = dt_canal,'Jurisdiccion' = dt_oficina,
      'Tipo_tran' = 'I',
      'monto' = dd_monto,'Concepto' = dd_concepto,dt_tipo_trans,en_ente,
      dd_secuencial,
      dd_banco
    from   cob_conta_super.dbo.sb_dato_operacion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
           cobis.dbo.cl_ente with (nolock)
    where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
       and dd_aplicativo = dt_aplicativo
       and dd_secuencial = dt_secuencial
       and dd_fecha      = dt_fecha
       and dt_aplicativo in (7)
       and dd_concepto in ('SEBRA', 'SOBRANTE', 'CHLOCAL', 'EFMN',
                           'PAGCB', 'PAGCREDEMP', 'PAGOBALOTO', 'PAGOBANCOS',
                           'PAGOEDATEL', 'PAGOSINIES', 'PAGOWS01', 'REDESPAG',
                           'RENOVACION'
                              )
       and dt_tipo_trans in('PAG') -- Ing
       and dd_banco      = do_banco
       and do_aplicativo = dd_aplicativo
       and do_fecha      = dd_fecha
       and dt_banco      = dd_banco
       and en_ente       = do_codigo_cliente

  --Ahorros EGRESO
  insert into #universo
    select
      'producto' = (select
                      pd_descripcion
                    from   cobis..cl_producto
                    where  pd_producto = dd_aplicativo),'Actividad' = case
                      when substring(en_actividad,
                                     0,
                                     3) = '' then '00'
                      else substring(en_actividad,
                                     0,
                                     3)
                    end,'Canal' = dt_canal,'Jurisdiccion' = dt_oficina,
      'Tipo_tran' = 'E',
      'monto' = dd_monto,'Concepto' = dd_concepto,dt_tipo_trans,en_ente,
      dd_secuencial,
      dd_banco
    from   cob_conta_super.dbo.sb_dato_pasivas with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
           cobis.dbo.cl_ente with (nolock)
    where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
       and dd_secuencial = dt_secuencial
       and dt_aplicativo in (4)
       and dd_concepto in ('NDEREIDESC', 'EFEMN', 'EFMN', 'NDETRANS')
       and dt_tipo_trans in ('NDE', 'RET', 'TRS')
       and dd_banco      = dp_banco
       and dd_banco      = dt_banco
       and dp_aplicativo = dd_aplicativo
       and dd_aplicativo = dt_aplicativo
       and dp_fecha      = dd_fecha
       and dd_fecha      = dt_fecha
       and en_ente       = dp_cliente

  --Ahorros ingreso
  insert into #universo
    select
      'producto' = (select
                      pd_descripcion
                    from   cobis..cl_producto
                    where  pd_producto = dd_aplicativo),'Actividad' = case
                      when substring(en_actividad,
                                     0,
                                     3) = '' then '00'
                      else substring(en_actividad,
                                     0,
                                     3)
                    end,'Canal' = dt_canal,'Jurisdiccion' = dt_oficina,
      'Tipo_tran' = 'I',
      'monto' = dd_monto,'Concepto' = dd_concepto,dt_tipo_trans,en_ente,
      dd_secuencial,
      dd_banco
    from   cob_conta_super.dbo.sb_dato_pasivas with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
           cobis.dbo.cl_ente with (nolock)
    where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
       and dd_secuencial = dt_secuencial
       and dt_aplicativo in (4)
       and dd_concepto in ('CHLOCAL', 'EFEMN', 'EFMN', 'NCRDESPRE',
                           'NCREINPAGC', 'NCRWU', 'NCRTRANS')
       and dt_tipo_trans in ('DEP', 'NCR', 'TRS')
       and dd_banco      = dp_banco
       and dd_banco      = dt_banco
       and dp_aplicativo = dd_aplicativo
       and dd_aplicativo = dt_aplicativo
       and dp_fecha      = dd_fecha
       and dd_fecha      = dt_fecha
       and en_ente       = dp_cliente

  --Bonos
  insert into #universo
    select
      'producto' = (select
                      pd_descripcion
                    from   cobis..cl_producto
                    where  pd_producto = dd_aplicativo),'Actividad' = case
                      when substring(en_actividad,
                                     0,
                                     3) = '' then '00'
                      else substring(en_actividad,
                                     0,
                                     3)
                    end,'Canal' = dt_canal,'Jurisdiccion' = dt_oficina,
      'Tipo_tran' = 'I',
      'monto' = dd_monto,'Concepto' = dd_concepto,dt_tipo_trans,en_ente,
      dd_secuencial,
      dd_banco
    from   cob_conta_super.dbo.sb_dato_operacion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion with (nolock),
           cob_conta_super.dbo.sb_dato_transaccion_det with (nolock),
           cobis.dbo.cl_ente with (nolock)
    where  dt_fecha_trans between @w_fecha_ini and @w_fecha_fin
       and dd_aplicativo = dt_aplicativo
       and dd_secuencial = dt_secuencial
       and dd_fecha      = dt_fecha
       and dt_aplicativo = 203
       and dd_concepto in ('SEBRA')
       and dd_banco      = do_banco
       and do_aplicativo = dd_aplicativo
       and do_fecha      = dd_fecha
       and dt_banco      = dd_banco
       and en_ente       = do_codigo_cliente

  insert into cob_conta_super..sb_dato_sarlaft1
    select
      *
    from   #universo

  /* Obtiene los nombres de los informes */
  select
    @w_fecha_arch = convert(char(10), @i_fecha, 112)
  print @w_fecha_arch
  select
    @w_fecha_arch = substring(@w_fecha_arch, 7, 2) + substring(@w_fecha_arch, 5,
                    2
                    )
                    + substring(@w_fecha_arch, 1, 4)
  print @w_fecha_arch
  select
    @w_nombre_arch_txt = @w_path + 'FormatoTRN' + @w_fecha_arch
  select
    @w_nombre_arch_err = @w_nombre_arch_txt + '.err'
  select
    @w_errores = @w_path + @w_nombre_arch_err
  select
    @w_cmd =
       @w_s_app +
       's_app bcp -auto -login cob_conta_super..sb_dato_sarlaft1 out '
  select
       @w_comando = @w_cmd + @w_nombre_arch_txt + ' -c -e' + @w_nombre_arch_err
                    +
                    ' -t"|" '
    +
                    '-config '
    + @w_s_app
                 + 's_app.ini'
  print @w_comando
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_error = 2101084,
      @w_msg = 'ERROR GENERANDO ARCHIVO PLANO: '
    print @w_comando
    goto ERROR_INF
  end

  return 0

  ERROR_INF:

  exec cobis..sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = '28010',
    @i_usuario     = 'op-batch',
    @i_tran        = 1,
    @i_tran_name   = 'I',
    @i_descripcion = @w_msg,
    @i_rollback    = 'N'

  print @w_msg

  return @w_error

go

