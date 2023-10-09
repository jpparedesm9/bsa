/************************************************************************/
/*      Archivo:                ahmencont.sp                            */
/*      Stored procedure:       sp_ahmensual_contract                   */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Fecha de escritura:     16-Ago-2011                             */
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
/*      Este programa realiza el calculo de intereses para cuentas      */
/*      contractuales aplicando puntos premio.                          */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*  FECHA         AUTOR           RAZON                                 */
/*  02/May/2016   Javier Calderon Migración a CEN                       */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ahmensual_contract')
  drop proc sp_ahmensual_contract
go

create proc sp_ahmensual_contract
(
  @t_show_version  bit = 0,
  @i_ssn           int,
  @i_fecha         datetime,
  @i_cuenta        int,
  @i_ptos_premio   float,
  @i_tipo_atributo char(1),
  @i_numdeci       tinyint,
  @i_min_dispmes   money = 0,
  @i_turno         smallint = 1,
  @i_oficina       smallint,
  @i_categoria     char(1),
  @i_prod_banc     smallint,
  @i_clase_clte    char(1),
  @i_tipocta_super char(1),
  @i_moneda        tinyint,
  @i_cta_banco     cuenta,
  @i_cliente       int,
  @i_tasa_pactada  float,
  @o_ajuste        money = null out
)
as
  declare
    @w_error            int,
    @w_trn_code         int,
    @w_msg              varchar(255),
    @w_sp_name          varchar(30),
    @w_fecha_ini        datetime,
    @w_fecha_fin        datetime,
    @w_fecha            datetime,
    @w_saldo_contable   money,
    @w_saldo_disponible money,
    @w_prom_disponible  money,
    @w_promedio1        money,
    @w_monto            money,
    @w_dias_cap         tinyint,
    @w_tasa_nominal     float,
    @w_ptos_nominal     float,
    @w_factor           float,
    @w_factor1          float,
    @w_factor2          float,
    @w_valor_acreditar  money,
    @w_dias_anio        smallint,
    @w_cliente          int,
    @w_camcat           char(1),
    @w_tasa_recalculo   float,
    @w_valor_total      money,
    @w_debug            char(1),
    @w_tasa             float,
    @w_int_hoy          money

  select
    @w_sp_name = 'sp_ahmensual_contract'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha_ini = dateadd(dd,
                           1 - (datepart(dd,
                                         @i_fecha)),
                           @i_fecha),
    @w_fecha_fin = dateadd(dd,
                           -1,
                           @i_fecha),
    @w_sp_name = 'sp_ahmensual_contract',
    @w_debug = 'N'

  /* Encuentra el dias del anio para provision diaria interes */
  select
    @w_dias_anio = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'DIA'
  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS ANIO'
    goto ERROR
  end

  /* UNIVERSO DE DIAS A RECALCULAR */
  select
    *
  into   #saldo_diario
  from   cob_ahorros_his..ah_saldo_diario with(nolock)
  where  sd_fecha between @w_fecha_ini and @w_fecha_fin
     and sd_cuenta = @i_cuenta
  if @@rowcount = 0
  begin
    select
      @o_ajuste = 0 -- Ajuste en cero porque no hay dias para recalculo
    select
      @w_error = 0,
      @w_msg = 'NO EXISTE CUENTA EN ah_saldo_diario. CUENTA: ' + convert(varchar
               ,
               @i_cta_banco)
    goto ERROR
  end

  select
    @w_valor_total = 0,
    @w_factor1 = 0,
    @w_factor2 = 0,
    @w_factor = 0,
    @w_valor_acreditar = 0

  while 1 = 1
  begin
    select top 1
      @w_fecha = sd_fecha,
      @w_saldo_contable = sd_saldo_contable,
      @w_saldo_disponible = sd_saldo_disponible,
      @w_prom_disponible = sd_prom_disponible,
      @w_promedio1 = sd_promedio1,
      @w_dias_cap = sd_dias,
      @w_tasa_nominal = sd_tasa_disponible,
      @w_int_hoy = sd_int_hoy
    from   #saldo_diario
    order  by sd_fecha asc
    if @@rowcount = 0
      break

    /* MODALIDAD DE CALCULO DEL VALOR BASE SOBRE EL QUE SE PAGARA EL INTERES */

    if @i_tipo_atributo = 'B' /* Saldo promedio */
      select
        @w_monto = @w_promedio1
    else if @i_tipo_atributo = 'C' /* Saldo Contable */
      select
        @w_monto = @w_saldo_contable
    else if @i_tipo_atributo = 'A' /* Saldo Disponible */
      select
        @w_monto = @w_saldo_disponible
    else if @i_tipo_atributo = 'E' /* Promedio Disponible */
      select
        @w_monto = @w_prom_disponible
    else if @i_tipo_atributo = 'D' /* Saldo minimo mensual */
      select
        @w_monto = @i_min_dispmes
    else
      select
        @w_monto = $1

    select
      @w_tasa = (@i_tasa_pactada + (@i_ptos_premio / 100))
    /* RECALCULO CON PUNTOS PREMIO */
    select
      @w_factor1 = 1 + @w_tasa
    select
      @w_factor2 = (convert(float, 1)) / @w_dias_anio
    /*calculo del factor para 1 dia */
    select
      @w_factor = (power (@w_factor1,
                          @w_factor2)) - 1
    select
      @w_ptos_nominal = @w_factor * @w_dias_anio
    select
      @w_tasa_recalculo = (@w_ptos_nominal * 100)
    select
      @w_valor_acreditar = round((@w_monto * @w_factor),
                                 @i_numdeci)
    select
      @w_valor_acreditar = @w_valor_acreditar * @w_dias_cap

    /* ACTUALIZAR SALDOS DIARIOS */
    if @w_debug = 'S'
      print 'CUENTA: ' + cast(@i_cta_banco as varchar) + ' FECHA: ' + cast(
            @w_fecha
                              as
                              varchar)
            + ' PUNTOS: ' + cast(@w_tasa_recalculo as varchar) + ' INTERES: '
            + cast(@w_valor_acreditar as varchar)
    else
    begin
      update cob_ahorros_his..ah_saldo_diario with(rowlock)
      set    sd_tasa_disponible = round(isnull(@w_tasa_recalculo,
                                               0),
                                        2),
             sd_int_hoy = isnull(@w_valor_acreditar,
                                 0)
      where  sd_cuenta = @i_cuenta
         and sd_fecha  = @w_fecha
      if @@error <> 0
      begin
        select
          @w_error = 203022,
          @w_msg = 'ERROR ACTUALIZANDO SALDOS DIARIOS. CUENTA: ' + convert(
                   varchar,
                   @i_cta_banco)
        goto ERROR
      end
    end

    /* ACUMULADOR DE VALORES ACREDITADOS */
    select
      @w_valor_acreditar = (@w_valor_acreditar - @w_int_hoy)
    select
      @w_valor_total = isnull(@w_valor_total, 0) + isnull(@w_valor_acreditar, 0)

    delete from #saldo_diario
    where  sd_fecha = @w_fecha

  end

  /* INSERCION TRANSACCION DE SERVICIO */
  if @w_debug = 'S'
    select
      @i_ssn,
      @i_ssn,
      271,
      @i_fecha,
      'op_batch',
      'consola',
      @i_oficina,
      'N',
      'U',
      @i_cta_banco,
      @w_valor_total,
      @i_moneda,
      @i_oficina,
      @i_prod_banc,
      @i_categoria,
      @i_tipocta_super,
      @i_turno,
      @i_clase_clte,
      @i_cliente,
      @w_valor_total
  else
  begin
    insert into cob_ahorros..ah_tran_servicio with (rowlock)
                (ts_secuencial,ts_ssn_branch,ts_tipo_transaccion,ts_tsfecha,
                 ts_usuario,
                 ts_terminal,ts_oficina,ts_reentry,ts_origen,ts_cta_banco,
                 ts_valor,ts_moneda,ts_oficina_cta,ts_prod_banc,ts_categoria,
                 ts_tipocta_super,ts_turno,ts_clase_clte,ts_cliente,ts_interes,
                 ts_cod_alterno,ts_observacion)
    values      ( @i_ssn,@i_ssn,271,@i_fecha,'op_batch',
                  'consola',@i_oficina,'N','U',@i_cta_banco,
                  @w_valor_total,@i_moneda,@i_oficina,@i_prod_banc,@i_categoria,
                  @i_tipocta_super,@i_turno,@i_clase_clte,@i_cliente,
                  @w_valor_total,
                  (@i_ssn + 1),'AJUSTE X PTOS ADICIONALES CONTRACTUAL')
    if @@error <> 0
    begin
      select
        @w_error = 203005,
        @w_msg =
      'ERROR AL INSERTAR TRANSACCION DE SERVICIO RECALCULO DE INTERES'
      goto ERROR
    end
  end

  select
    @o_ajuste = isnull(@w_valor_total,
                       0)

  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = @w_trn_code,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error

go

