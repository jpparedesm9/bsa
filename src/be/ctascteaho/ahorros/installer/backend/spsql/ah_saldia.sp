/************************************************************************/
/*      Archivo:                ah_saldia.sp                            */
/*      Stored procedure:       sp_ah_saldo_diario                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Disenado por:           J. Loyo                                 */
/*      Fecha de escritura:     07-May-2010                             */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                              PROPOSITO                               */
/*      Este programa realiza la transaccion de:                        */
/*      Generacion de saldos diarios de ahorros                         */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */
/*      07/May/2010     J. Loyo         Emision inicial                 */
/*      02/May/2016     Ignacio Yupa    Migración a CEN                 */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah_saldo_diario')
  drop proc sp_ah_saldo_diario
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah_saldo_diario
(
  @t_show_version bit = 0
)
as
  declare
    @w_ini_prx_mes  datetime,
    @w_dias_mes_act tinyint,
    @w_dias_prx_mes tinyint,
    @i_fecha        datetime,
    @w_fecha        datetime,
    @w_cambia_mes   char(1),
    @w_ciudad       int,
    @w_inimes       char(1),
    @w_fechaux      datetime,
    @w_fechain      datetime,
    @w_num_dias     tinyint,
    @w_mensaje      varchar(32),
    @w_dias_mes     tinyint,
    @w_error        int,
    @w_sp_name      varchar(64)

  select
    @w_sp_name = 'sp_ah_saldo_diario',
    @w_cambia_mes = 'N'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end
  --- Fecha del proceso
  select
    @i_fecha = fp_fecha
  from   cobis..ba_fecha_proceso

  -- Determinar el codigo de la ciudad de feriados nacionales
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE CIUDAD DE FERIADOS NACIONALES'
    return 205031
  end

  -- Determinar el numero de dias de feriados nacionales
  select
    @w_fecha = dateadd(dd,
                       1,
                       @i_fecha)
  while 1 = 1
  begin
    -- Determino si existe cambio de mes entre dias feriados
    if datepart(mm,
                @w_fecha) <> datepart(mm,
                                      @i_fecha)
       and @w_cambia_mes = 'N'
      select
        @w_cambia_mes = 'S',
        @w_ini_prx_mes = @w_fecha

    if exists (select
                 df_fecha
               from   cobis..cl_dias_feriados
               where  df_ciudad = @w_ciudad
                  and df_fecha  = @w_fecha)
      select
        @w_fecha = dateadd(dd,
                           1,
                           @w_fecha)
    else
      break
  end

  select
    @w_inimes = 'N'
  select
    @w_fechaux = convert(varchar(2), datepart(mm, @i_fecha)) + '/01/'
                 + convert(varchar(4), datepart(yy, @i_fecha))

  select
    @w_fechain = @w_fechaux
  while 1 = 1
  begin
    select
      @w_fechaux = df_fecha
    from   cobis..cl_dias_feriados
    where  df_ciudad = @w_ciudad
       and df_fecha  = @w_fechaux

    if @@rowcount = 0
      break
    select
      @w_fechaux = dateadd(dd,
                           1,
                           @w_fechaux)
  end

  if @w_fechaux = @i_fecha
    select
      @w_inimes = 'S'

  -- Numero de dias entre hoy y el inicio del mes
  select
    @w_num_dias = datediff(dd,
                           @w_fechain,
                           @i_fecha)

  -- Numero de dias entre hoy y proxima fecha laborable nacional
  if @w_cambia_mes = 'S'
  begin
    select
      @w_dias_mes_act = datediff(dd,
                                 @i_fecha,
                                 @w_ini_prx_mes),
      @w_dias_prx_mes = datediff(dd,
                                 @w_ini_prx_mes,
                                 @w_fecha)
  end
  else
  begin
    if @w_inimes = 'S'
    begin
      select
        @w_dias_mes_act = 1 -- @w_num_dias + 1  Se cuenta solo hacia adelante.
      select
        @w_dias_mes_act = @w_dias_mes_act + (datediff(dd,
                                                      @w_fechaux,
                                                      @w_fecha) - 1)
    end
    else
      select
        @w_dias_mes_act = datediff(dd,
                                   @i_fecha,
                                   @w_fecha)
    select
      @w_dias_prx_mes = 0
  end

  -- select @w_dias_mes_act 

  /** Borrado de los datos en caso de una reejecucion **/
  delete cob_ahorros_his..ah_saldo_diario
  where  sd_fecha = @i_fecha

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR AL BORRAR TABLA DE SALDOS DIARIOS',
      @w_error = 253006
    print @w_mensaje
    goto ERRORFIN
  end

  insert into cob_ahorros_his..ah_saldo_diario
              (sd_cuenta,sd_fecha,sd_12h,sd_24h,sd_48h,
               sd_remesas,sd_saldo_contable,sd_saldo_disponible,sd_tasa_contable
               ,
               sd_tasa_disponible,
               sd_int_hoy,sd_estado,sd_categoria,sd_prod_banc,sd_dias,
               sd_promedio1,sd_prom_disponible)
    select
      ah_cuenta,@i_fecha,ah_12h,ah_24h,ah_48h,
      ah_remesas,ah_disponible + ah_12h + ah_24h + ah_48h,ah_disponible,0,
      ah_tasa_hoy,
      ah_int_hoy,ah_estado,ah_categoria,ah_prod_banc,@w_dias_mes_act,
      ah_promedio1,ah_prom_disponible
    from   cob_ahorros..ah_cuenta
    where  (ah_estado not in ('C', 'G', 'N')
         or (ah_estado        = 'C'
             and ah_fecha_ult_mov = @i_fecha))
    order  by ah_cuenta

  if @@error <> 0
  begin
    select
      @w_mensaje = 'ERROR EN INSERCION DE SALDO DIARIO',
      @w_error = 203035
    print @w_mensaje
    goto ERRORFIN
  end

  select
    'Registros insertados  :' + cast(count(1) as varchar)
  from   cob_ahorros_his..ah_saldo_diario
  where  sd_fecha = @i_fecha

  return 0

  ERRORFIN:
  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'op_batch',
    @i_tran        = 0,
    @i_descripcion = @w_mensaje,
    @i_programa    = @w_sp_name
  return @w_error

go

