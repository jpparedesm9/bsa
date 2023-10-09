/************************************************************************/
/*  Archivo:                carga_mov_svb.sp                            */
/*  Stored procedure:       sp_carga_mov_svb                            */
/*  Base de datos:          cob_ahorros                                 */
/*  Producto:               Cuentas de Ahorros                          */
/*  Disenado por:           Migracion CEN                               */
/*  Fecha de escritura:     03/05/2016                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                              PROPOSITO                               */
/*    Este programa realiza la carga de los mivimientos  svb            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA       AUTOR           RAZON                               */
/*    02/May/2016     J. Calderon     Migraci�n a CEN                   */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select 1 from sysobjects where name = 'sp_carga_mov_svb')
    drop proc sp_carga_mov_svb
GO

create proc sp_carga_mov_svb
(
  @t_show_version bit = 0,
  @i_param1       varchar(20) = null,--nombre archivo de SERVIBANCA (YYMMDD.MOV)
  @i_param2       datetime = null
) --Fecha de proceso

as
  declare
    @w_sp_name      varchar(32),
    @w_mensaje      mensaje,
    @w_archivo      varchar(20),
    @w_error        int,
    @w_s_app        varchar(64),
    @w_path         varchar(64),
    @w_comando      varchar(500),
    @w_binbmi       varchar(10),
    @w_total_regis  int,
    @w_contador     int,
    @w_secuencial   int,
    @w_registro     varchar(300),
    @w_sum_tarjetas float,
    @w_starjetas    float,
    @w_sum_total    float,
    @w_stotal       float,
    @w_cont_total   money,
    @w_bulk         varchar(300)

  select
    @w_sp_name = 'sp_carga_mov_svb',
    @w_archivo = @i_param1

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  if convert(datetime, substring(@i_param1,
                                 1,
                                 6), 103) <> convert(datetime, @i_param2, 103)
  begin
    select
      @w_mensaje = 'FECHA DE ARCHIVO NO COINCIDE CON FECHA A PROCESAR',
      @w_error = 4000001
    goto ERRORFIN
  end

  if exists(select
              1
            from   cob_externos..ex_transaccion_red
            where  tr_fecha_concilia = @i_param2
               and tr_canal          = 'ATM'
               and tr_origen         = 'SVB')
  begin
    select
      @w_mensaje =
      'YA FUE EJECUTADO UN PROCESO DE CONCILIACION PARA LA FECHA DADA',
      @w_error = 4000002
    goto ERRORFIN
  end

  if exists (select
               1
             from   sysobjects
             where  name = 'tmp_movimiento_svb')
    drop table tmp_movimiento_svb

  create table tmp_movimiento_svb
  (
    registro varchar(278)
  )

  select
    @w_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'S_APP'

  if @w_s_app is null
  begin
    select
      @w_mensaje = 'ERROR CARGANDO PARAMETRO BCP',
      @w_error = 4000003
    goto ERRORFIN
  end

  select
    @w_path = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'RUTRBM'

  if @w_path is null
  begin
    select
      @w_mensaje =
      'ERROR CARGANDO LA RUTA BATCH DE DESTINO, REVISAR PARAMETRIZACION',
      @w_error = 4000004
    goto ERRORFIN
  end

  select
    @w_comando = @w_s_app + 's_app' +
                 ' bcp -auto -login cob_wservices..tmp_movimiento_svb in '
                 +
                 @w_path
                 + @w_archivo + ' -c -e' + ' posmia_' + convert(varchar(10),
                              @i_param2, 112) + '.err' + ' -t"|" '
                 + '-config ' + @w_s_app + 's_app.ini'

  /* EJECUTAR CON CMDSHELL */
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_mensaje = 'ERROR CARGANDO ARCHIVO POR BCP',
      @w_error = 4000003

    goto ERRORFIN
  end

  select
    @w_binbmi = convert(int, pa_char)
  from   cobis..cl_parametro
  where  pa_nemonico = 'BINMI'
     and pa_producto = 'REM'

  /*VALIDACION DE CARGA*/
  if exists (select
               1
             from   cob_ahorros..tmp_movimiento_svb)
  begin
    if @w_binbmi <> (select
                       substring(registro,
                                 18,
                                 6)
                     from   cob_ahorros..tmp_movimiento_svb
                     where  substring (convert(varchar(2), registro),
                                       1,
                                       2) = '01')
    begin
      select
        @w_mensaje = 'ERROR PARAMETRO BIN NO CORRESPONDE',
        @w_error = 4000006
      goto ERRORFIN
    end
  end

  delete from cob_wservices..ws_movimiento_atm
  where  ma_fecha_carga  = @i_param2
     and ma_nemonico_red = 'SVB'--

  insert into cob_wservices..ws_movimiento_atm
    select
      @i_param2,'SVB',registro
    from   tmp_movimiento_svb

  if @@error <> 0
  begin
    select
      @w_mensaje =
'EXISTIO UN ERROR AL INSERTAR EN LA TABLA cob_wservices..ws_movimiento_atm',
@w_error = 4000008
goto ERRORFIN
end

  if exists (select
               1
             from   sysobjects
             where  name = '#movimiento_atm')
    drop table #movimiento_atm

  create table #movimiento_atm
  (
    secuencial int identity,
    registro   varchar(1000)
  )

  /*TARBAJAR LOS REGISTROS DETALLE (03) Y MARCADOS CON X*/
  insert into #movimiento_atm
              (registro)
    select
      a.ma_registro
    from   cob_wservices..ws_movimiento_atm a
    where  ma_nemonico_red                                      = 'SVB'
       and substring (convert(varchar(135), a.ma_registro),
                      1,
                      2)   = '03'
       and substring (convert(varchar(135), a.ma_registro),
                      134,
                      2) = 'X'
       and convert(int, substring (convert(varchar(135), a.ma_registro),
                                   23,
                                   6)) in
           (select
              convert(int, tt_codigo_red)
            from   cob_wservices..ws_tipo_tran_redes
            where  tt_red    = 'SVB'
               and tt_estado = 'V')

  if @@error <> 0
  begin
    select
      @w_error = 4000008,
      @w_mensaje = 'EXISTIO UN ERROR AL INSERTAR EN LA TABLA movimiento_atm'
    goto ERRORFIN
  end

  select
    @w_total_regis = count(1)
  from   #movimiento_atm

  select
    @w_contador = 0

  select
    @w_secuencial = 0
  while @w_contador < @w_total_regis
  begin
    select top 1
      @w_secuencial = secuencial,
      @w_registro = substring(registro,
                              1,
                              278)
    from   #movimiento_atm
    where  secuencial > @w_secuencial
    order  by secuencial

    insert into cob_externos..ex_transaccion_red
    (tr_origen,              tr_canal,                 tr_estado,     tr_tipo_reg,         tr_terminal, 
     tr_nom_establecimiento, tr_pais,                  tr_referencia, tr_autorizacion,     tr_establecimiento, 
     tr_fecha_tran,          tr_hora_tran,             tr_moneda,     tr_reverso,          tr_respuesta, 
     tr_tarjeta,             tr_tipo_tran,             tr_valor_com,  tr_tasa_intercambio, tr_valor_propina, 
     tr_valor_tran,          tr_vlr_dispensado_rev_par,tr_cta_banco,  tr_tipo_mensaje,     tr_texto_adic, 
     tr_fecha_carga,         tr_fecha_concilia
    )
      select
        tr_origen = 'SVB',tr_canal = 'ATM',tr_estado = 'PEND',tr_tipo_reg =
        substring(@w_registro,
                                1,
                                2),tr_terminal = substring(@w_registro,
                                11,
                                6),
        tr_nom_establecimiento = substring(@w_registro,
                                           165,
                                           22),tr_pais = 'CO',
        tr_referencia = substring(@w_registro,
                                  145,
                                  12),--substring(@w_registro, 145, 18),
        tr_autorizacion = substring(@w_registro,
                                    138,
                                    6),tr_establecimiento =
                                       substring(@w_registro,
                                       275,
                                       3),
        tr_fecha_tran = convert(varchar(8), substring(@w_registro,
                                                      31,
                                                      15), 2),
        --Hacer convert para solo fecha
        tr_hora_tran = convert(varchar(8), substring(@w_registro,
                                                     31,
                                                     15), 108),
        --Hacer conver para solo hora
        tr_moneda = '170',--Moneda colombia
        tr_reverso = substring(@w_registro,
                               210,
                               2),tr_respuesta = substring(@w_registro,
                                 207,
                                 2),
        tr_tarjeta = substring(@w_registro,
                               77,
                               19),tr_tipo_tran = substring(@w_registro,
                                 23,
                                 6),
        -- Validar contra la tabla ws_tipo_tran_redes 
        tr_valor_com = substring(@w_registro,
                                 246,
                                 6),tr_tasa_intercambio = convert(money, 0),
        tr_valor_propina = convert(money, 0),
        tr_valor_tran = convert(money, substring(@w_registro,
                                                 110,
                                                 11)),tr_vlr_rev_par = 0,
        tr_cta_banco
        = null,tr_tipo_mensaje = substring(@w_registro,
                                    210,
                                    2),tr_texto_adic = null,
        tr_fecha_carga = @i_param2,tr_fecha_concilia = null

    if @@error <> 0
    begin
      select
        @w_mensaje = 'ERROR EN EXTRACCION DE INFORMACION ARCHIVO ARCHIVO ATM',
        @w_error = 4000006
      goto ERRORFIN
    end

    select
      @w_contador = @w_contador + 1,
      @w_starjetas = @w_starjetas + round(convert(float, substring(@w_registro,
                     77
                     ,
                     14
                     )), 0),
      @w_stotal = @w_stotal + round(convert(float, substring(@w_registro, 110,
                  11)
                  )
                  ,
                  2 )

    print 'Contador -> ' + cast(@w_contador as varchar) + 'Sum Tar -> '
          + cast(@w_starjetas as varchar) + 'Val Tot -> ' + cast(@w_stotal as
                              varchar)
  end

  --*** Verificaci¾n de totales
  select
    @w_sum_tarjetas = convert(float, substring(ma_registro,
                                               67,
                                               20)),
    --Contador de control que suma los n·meros de tarjeta (03_CARD_NMBR) para un mismo producto.
    @w_sum_total = convert(float, substring(ma_registro,
                                            88,
                                            20)),
    --Contador de control que suma los valores de transacci¾n (03_TRANS_VALUE) para un mismo producto.
    @w_cont_total = convert(float, substring(ma_registro,
                                             58,
                                             8))
  --Contador del numero de registros por producto.
  from   cob_wservices..ws_movimiento_atm
  where  substring (convert(varchar(2), ma_registro),
                    1,
                    2) in ('05')

  if @w_cont_total <> @w_total_regis
  begin
    print 'Total Registros         -> ' + cast(@w_cont_total as varchar)
    print 'Total Registros Archivo -> ' + cast(@w_total_regis as varchar)
    select
      @w_mensaje = 'TOTALES DE ARCHIVO ATM NO COINCIDE CON REGISTROS DETALLE ',
      @w_error = 4000007
    goto ERRORFIN
  end

  if @w_sum_tarjetas <> @w_starjetas
  begin
    select
      @w_mensaje =
'TOTALES DE ARCHIVO ATM NO COINCIDE CON REGISTROS DETALLE (Sumatoria Num Tarj)',
@w_error = 4000007
  goto ERRORFIN
end

  if @w_sum_total <> @w_stotal
  begin
    select
      @w_mensaje =
    'TOTALES DE ARCHIVO ATM NO COINCIDE CON REGISTROS DETALLE (Valor Total)',
    @w_error = 4000007
    goto ERRORFIN
  end

  return 0

  ERRORFIN:
  exec sp_errorlog
    @i_fecha       = @i_param2,
    @i_error       = @w_error,
    @i_usuario     = 'opbatch',
    @i_tran        = 26003,
    @i_cuenta      = null,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_sp_name

  print @w_mensaje

  return @w_error

go

