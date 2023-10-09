use cob_ahorros
go

/************************************************************************/
/*      Archivo:                ahvalact.sp                             */
/*      Stored procedure:       sp_valida_tiempo_activa                 */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Andres Diab                             */
/*      Fecha de escritura:     02-Dic-2011                             */
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
/*      Este programa realiza la validacion del tiempo maximo de        */
/*      activacion para las cuentas de ahorro provisionales.            */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      02/Mayo/2016    Walther Toledo  Migración a CEN                 */
/************************************************************************/

set ANSI_NULLS off
go


set QUOTED_IDENTIFIER off
go



if exists (select
             1
           from   sysobjects
           where  name = 'sp_valida_tiempo_activa')
  drop proc sp_valida_tiempo_activa
go

create proc sp_valida_tiempo_activa
(
  @t_show_version bit = 0
)
as
  declare
    @w_error         int,
    @w_msg           varchar(255),
    @w_sev           tinyint,
    @w_sp_name       varchar(64),
    @w_fecha_proceso datetime,
    @w_param_exp     int,
    @w_cta_banco     varchar(20),
    @w_dias_aper     int,
    @w_ssn           int,
    @w_rowcount      int,
    @w_moneda        tinyint,
    @w_oficina       smallint,
    @w_cliente       int,
    @w_producto      tinyint,
    @w_contador      int,
    @w_fecha_aper    datetime,
    @w_ciudad        int,
    @w_prod_banc     smallint

  select
    @w_sp_name = 'sp_valida_tiempo_activa'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=4.0.0.0'
    return 0
  end

  /* FECHA DE PROCESO */
  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  /* PARAMETRO TIEMPO MAX. ACTIVACION CUENTA AHORROS */
  select
    @w_param_exp = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'TMAC'
     and pa_producto = 'AHO'
  if @@error <> 0
  begin
    select
      @w_error = 101077
    goto ERROR
  end

  /* PARAMETRO CIUDAD FERIADOS NACIONALES */
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

  select
    ah_cta_banco,
    ah_fecha_aper,
    ah_moneda,
    ah_oficina,
    ah_cliente,
    ah_producto,
    ah_prod_banc
  into   #ah_cuenta_temporal
  from   cob_ahorros..ah_cuenta
  where  ah_estado = 'G'
  if @@rowcount = 0
  begin
    print 'NO EXISTEN CUENTAS EN ESTADO INGRESADA'
    goto FIN
  end

  select
    @w_rowcount = count(1)
  from   #ah_cuenta_temporal

  update cobis..ba_secuencial
  set    @w_ssn = se_numero,
         se_numero = @w_ssn + @w_rowcount

  while 1 = 1
  begin
    select
      @w_contador = 0

    select top 1
      @w_cta_banco = ah_cta_banco,
      @w_fecha_aper = ah_fecha_aper,
      @w_dias_aper = datediff(dd,
                              ah_fecha_aper,
                              @w_fecha_proceso),
      @w_moneda = ah_moneda,
      @w_oficina = ah_oficina,
      @w_cliente = ah_cliente,
      @w_producto = ah_producto,
      @w_prod_banc = ah_prod_banc
    from   #ah_cuenta_temporal
    order  by ah_cta_banco asc
    if @@rowcount = 0
      break

    while @w_fecha_aper <= @w_fecha_proceso
    begin
      if exists (select
                   df_fecha
                 from   cobis..cl_dias_feriados
                 where  df_ciudad = @w_ciudad
                    and df_fecha  = @w_fecha_aper)
        select
          @w_contador = @w_contador + 1

      select
        @w_fecha_aper = dateadd(dd,
                                1,
                                @w_fecha_aper)
    end

    if @w_dias_aper - @w_contador >= @w_param_exp
    begin
      begin tran

      update cob_ahorros..ah_cuenta with (rowlock)
      set    ah_estado = 'N',
             ah_fecha_ult_proceso = @w_fecha_proceso,
             ah_fecha_ult_upd = @w_fecha_proceso
      where  ah_cta_banco = @w_cta_banco
      if @@error <> 0
      begin
        select
          @w_error = 255001,
          @w_msg = 'ERROR ACTUALIZANDO ESTADO CUENTA INGRESADA ' + @w_cta_banco,
          @w_sev = 1
        goto ERROR
      end

      update cob_ahorros..ah_tran_servicio with (rowlock)
      set    ts_sec_correccion = @w_ssn,
             ts_estado = 'N',
             ts_fecha_ven = null
      where  ts_tipo_transaccion = 201
         and ts_cta_banco        = @w_cta_banco
         and ts_oficina_cta      = @w_oficina
         and ts_moneda           = @w_moneda
      if @@error <> 0
      begin
        select
          @w_error = 253004
        goto ERROR
      end

      /* INSERTAR TRANSACCION DE SERVICIO */
      insert into ah_tran_servicio
                  (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                   ts_usuario,
                   ts_terminal,ts_filial,ts_oficina,ts_oficina_cta,ts_hora,
                   ts_estado,ts_cta_banco,ts_producto,ts_descripcion_ec,
                   ts_cliente
                   ,
                   ts_prod_banc)
      values      ( @w_ssn,0,4146,@w_fecha_proceso,'opbatch',
                    'consola',1,@w_oficina,@w_oficina,getdate(),
                    'N',@w_cta_banco,@w_producto,
                    'ANULACION DE CUENTA SIN DEPOSITO INICIAL',@w_cliente,
                    @w_prod_banc)
      if @@error <> 0
      begin
        select
          @w_error = 253004
        goto ERROR
      end

      commit tran
    end

    delete from #ah_cuenta_temporal
    where  ah_cta_banco = @w_cta_banco

    select
      @w_ssn = @w_ssn + 1
  end

  FIN:

  return 0

  ERROR:
  exec cobis..sp_cerror
    @i_num = @w_error,
    @i_msg = @w_msg,
    @i_sev = @w_sev

  return @w_error

go

