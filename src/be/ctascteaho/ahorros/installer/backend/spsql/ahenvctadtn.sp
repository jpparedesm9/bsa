/************************************************************************/
/*      Archivo:                ahenvctadtn.sp                          */
/*      Stored procedure:       sp_envia_cta_dtn_ah                     */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Creado por:             Mario Algarin                           */
/*      Fecha de escritura:     20-abril-2010                           */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP', representantes exclusivos para el Ecuador de la    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      BATCH: Traslado de cuenta al tesoro nacional, que cumplen       */
/*             parametro de inactividad.                                */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*      17-12-2012      Andres Munoz       Envio sin intereses ORS 515  */
/*      04/May/2016     J. Salazar         Migracion COBIS CLOUD MEXICO */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_envia_cta_dtn_ah')
  drop proc sp_envia_cta_dtn_ah
go

/****** Object:  StoredProcedure [dbo].[sp_envia_cta_dtn_ah]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_envia_cta_dtn_ah
(
  @s_srv          varchar(16) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_show_version bit = 0,
  @i_filial       tinyint = 1,
  @i_fecha        datetime = null,
  @i_param1       datetime,-- Fecha Proceso
  @i_param2       char(1),-- P-Parcial, D-Definitivo
  @i_corresponsal char(1) = 'N',--Req. 381 CB Red Posicionada   
  @i_moneda       int = 0,
  @o_procesadas   int = 0 out
)
as
  declare
    @w_sp_name           varchar(64),
    @w_return            int,
    @w_saldo             money,
    @w_clase_clte        char(1),
    @w_prod_banc         int,
    @w_hi_cuenta         cuenta,
    @w_hi_fecha          datetime,
    @w_ced_ruc           char(13),
    @w_ah_moneda         smallint,
    @w_ah_oficina        int,
    @w_ah_nombre         char(50),
    @w_ah_descripcion_ec char(50),
    @w_ah_telefono       char(50),
    @w_ah_estado         char(1),
    @w_oficial           smallint,
    @w_cliente           int,
    @w_tipo_grupo        char(2),
    @w_fecha_mm          datetime,
    @w_num_dias          int,
    @w_fecha_ult_mov     datetime,
    @w_msg               descripcion,
    @w_dias_env          int,
    @w_nro_uvrs          int,
    @w_ciudad            int,
    @w_sec_env           int,
    @w_vr_ref_uvr        money,
    @w_ssn               int,
    @w_monto_canc        money,
    @w_procesadas        int,
    @w_dias              int,
    @w_fecha             datetime,
    @w_numrg             int,
    @w_dias_tmp          int,
    @w_saldo_intereses   money,
    @w_cuenta            int,
    @w_tasa_disp         real,
    @w_fecha_sld_dia     datetime,
    @w_interes           money,
    @w_fecha_envia       datetime,
    @w_diferencia        int,
    @w_fecha_ult_capi    datetime,
    @w_tipocta_super     char(1),
    @w_fecha_aux         datetime,
    @w_dias_anio         smallint,
    @w_usadeci           char(1),
    @w_numdeci           tinyint,
    @w_rowcount          int,
    @w_ejecucion         char(1),
    @w_fecha_tmp         datetime,
    @w_profinal          int,
    @w_categoria         char(1),
    @w_tipocta           varchar(10),
    @w_dias_fecenv       int,
    @w_fin_trim_nfs      datetime,
    @w_periodo_dtn       smallint,
    @w_fecha_fm          datetime,
    @w_ciudad_matriz     int,
    @w_prod_bancario     varchar(50) --Req. 381 CB Red Posicionada

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_envia_cta_dtn_ah'
  select
    @w_procesadas = 0
  select
    @w_ejecucion = @i_param2

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  --Extraer el catalogo re_pro_banc_cb Req. 381 CB Red Posicionada
  select
    @w_prod_bancario = rtrim(cl_catalogo.codigo)
  from   cobis..cl_catalogo,
         cobis..cl_tabla
  where  cl_catalogo.tabla  = cl_tabla.codigo
     and cl_tabla.tabla     = 're_pro_banc_cb'
     and cl_catalogo.estado = 'V'

  if @i_param1 is null
     and @i_fecha is null
  begin
    --Falta parametro obligatorio
    exec cobis..sp_cerror
      @i_num = 101114
    return 101114
  end

  if @i_fecha is null
    select
      @i_fecha = @i_param1

  if @w_ejecucion = 'D'
     and exists(select
                  1
                from   cob_remesas..re_tesoro_nacional
                where  tn_fecha  = @i_fecha
                   and tn_estado = 'P')
  begin
    /* Error: Proceso batch no Reprocesable */
    exec cobis..sp_cerror
      @i_num = 251109,
      @i_msg =
'EL PROCESO BATCH YA FUE EJECUTADO COMO DEFINITIVO Y NO PUEDE REPROCESARSE'
return 251109
end

  -- REQ 322 CUENTAS INACTIVAS
  /* DETERMINAR LA CIUDAD DE LOS FERIADOS NACIONALES */
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount <> 1
  begin
    exec cobis..sp_cerror
      @i_num = 205031
    return 205031
  end

  select
    @w_dias_fecenv = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'ENVDTN'
     and pa_producto = 'AHO'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS FESTIVOS ENVIADOS'
    return 205031
  end

  --Escoge el parametro de periodo para el envio DTN
  select
    @w_periodo_dtn = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'PERDTN'
     and pa_producto = 'AHO'

  if @w_ejecucion = 'P' -- Ejecucion Parcial
  begin
    /* Hallar fin de trimestre mas cercano a la fecha dada */
    exec cob_ahorros..sp_fecha_fin_periodo
      @i_fecha     = @i_fecha,
      @i_periodo   = @w_periodo_dtn,
      @i_finsemana = 'N',
      @o_fecha_fin = @w_fecha_tmp out
    if @@error <> 0
    begin
      select
        @w_msg = 'ERROR ENCONTRANDO FECHA FIN DE TRIMESTRE'
      goto ERROR
    end
  end

  if @w_ejecucion = 'D'
    select
      @w_fecha_tmp = @i_fecha

  -- FIN REQ 322

  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @w_fecha_tmp,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'S',
    @w_dias_ret  = 1,
    @o_fecha_sig = @w_fecha_aux out

  if @w_return <> 0
      or @@error <> 0
  begin
    --Error al determinar ultimo dia habil del mes
    exec cobis..sp_cerror
      @i_num = 201163
    return 201163
  end

  select
    @w_fecha_fm = dateadd(dd,
                          -1,
                          dateadd(dd,
                                  -1 * datepart(dd,
                                                dateadd(mm,
                                                        1,
                                                        @i_fecha) - 1),
                                  dateadd(mm,
                                          1,
                                          @i_fecha)))

  select
    @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CMA'
     and pa_producto = 'CTE'

  while 1 = 1
  begin
    select
      1
    from   cobis..cl_dias_feriados
    where  df_ciudad = @w_ciudad_matriz
       and df_fecha  = @w_fecha_fm

    if @@rowcount > 0
    begin
      select
        @w_fecha_fm = dateadd(dd,
                              -1,
                              @w_fecha_fm)
    end
    else
    begin
      break
    end
  end

  /*Validacion de la periodicidad de ejecucion*/
  if (datepart(mm,
               @w_fecha_tmp) % 3) <> 0
      or ((datepart(mm,
                    @w_fecha_tmp) % 3) = 0
          and (@w_fecha_fm <> @w_fecha_tmp))
  --((datepart(mm,@w_fecha_tmp) % 3) = 0 and convert(varchar(2),(datepart(mm,@w_fecha_aux))) = convert(varchar(2),(datepart(mm,@w_fecha_tmp))))
  begin
    print 'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE'
    goto FIN
  end

  /* REQ 322 - Eliminar datos para reproceso */
  select
    count(1)
  from   cob_remesas..re_tesoro_nacional
  where  tn_fecha = @w_fecha_tmp

  if @@rowcount > 0
  begin
    delete from cob_remesas..re_tesoro_nacional
    where  tn_fecha = @w_fecha_tmp
  end

  ---------------------------
  --| CARGA DE PARAMETROS |--
  ---------------------------

  -- Encuentra dias del anio para provision diaria interes
  select
    @w_dias_anio = pa_smallint
  from   cobis..cl_parametro
  where  pa_producto = 'ADM'
     and pa_nemonico = 'DIA'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS ANIO'
    return 205031
  end

  -- Encuentra parametro de decimales
  select
    @w_usadeci = mo_decimales
  from   cobis..cl_moneda
  where  mo_moneda = @i_moneda

  if @w_usadeci = 'S'
  begin
    select
      @w_numdeci = pa_tinyint
    from   cobis..cl_parametro
    where  pa_nemonico = 'DCI'
       and pa_producto = 'AHO'

    if @w_numdeci is null
      select
        @w_numdeci = 2
  end
  else
    select
      @w_numdeci = 0

  /*Dias para considerar cuentas para envio a la DTN*/

  select
    @w_dias_env = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'DDTN'
     and pa_producto = 'AHO'

  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO PARAMETRO DE DIAS PARA ENVIO A LA DTN'
    goto ERROR
  end

  /*Cantidad de UVR, para calculo de saldo de envio*/

  select
    @w_nro_uvrs = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CUVRT'
     and pa_producto = 'AHO'

  if @@rowcount = 0
  begin
    select
      @w_msg =
  'NO SE ENCONTRO PARAMETRO DE CANTIDAD DE UVR, PARA CALCULO DE SALDO DE ENVIO'
    goto ERROR
  end

  /*Consecutivo de Traslado a la DTN*/

  select
    @w_sec_env = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'ODTN'
     and pa_producto = 'AHO'

  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO PARAMETRO DE CONSECUTIVO DE ENVIO A LA DTN'
    goto ERROR
  end

  /*Captura del valor de la UVR, para el dia de envio*/
  select
    @w_vr_ref_uvr = ct_valor
  from   cob_conta..cb_cotizacion
  where  ct_moneda = 2 -- UVR --
     and ct_fecha  = @w_fecha_tmp

  select
    @w_rowcount = @@rowcount

  if @w_rowcount > 1
  begin
    select
      @w_msg = 'SE ENCONTRO MAS DE UN VALOR DE UVR PARA EL DIA DEL ENVIO'
    goto ERROR
  end

  if @w_rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO VALOR DE UVR, PARA EL DIA DEL ENVIO'
    goto ERROR
  end

  /*Calculo del Monto para envio a la DTN*/
  select
    @w_monto_canc = isnull((@w_nro_uvrs * @w_vr_ref_uvr),
                           0)

  /* Encuentra el SSN inicial para la transaccion de servicio*/
  begin tran
  select
    @w_ssn = se_numero
  from   cobis..ba_secuencial

  if @@rowcount <> 1
  begin
    /* Error en lectura de SSN */
    select
      @w_msg = 'ERROR EN LA LECTURA DE SSN'
    goto ERROR
  end

  update cobis..ba_secuencial
  set    se_numero = @w_ssn + 1000000

  if @@rowcount <> 1
  begin
    /* Error en actualizacion de SSN */
    select
      @w_msg = 'ERROR EN LA ACTUALIZACION DEL SSN'
    goto ERROR
  end

  commit tran

/* CALCULO FECHA DE ENVIO */
  /* Hallar ultimo dia habil del trimestre sin contar fin de semana*/
  exec cob_ahorros..sp_fecha_fin_periodo
    @i_fecha     = @w_fecha_tmp,
    @i_periodo   = @w_periodo_dtn,
    @o_fecha_fin = @w_fin_trim_nfs out
  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR ENCONTRANDO FECHA FIN DE TRIMESTRE SIN FIN DE SEMANA'
    goto ERROR
  end

  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @w_fin_trim_nfs,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'S',
    @w_dias_ret  = @w_dias_fecenv,
    @o_fecha_sig = @w_fecha_envia out

  /* Calculo de dias para traslado a la DTN*/
  select
    @w_dias = isnull(@w_dias_env,
                     0)

  /* Caluclo de Fecha de envio a la DTN */
  select
    @w_fecha = dateadd(dd,
                       -(@w_dias),
                       @w_fecha_tmp)

  /* Cursor Que me Envia las cuentas a la DTN*/
  declare cuentas_dtn cursor for
    select
      hi_cuenta,
      max(hi_fecha)
    from   cob_ahorros..ah_his_inmovilizadas
    where  (@w_monto_canc = 0
             or hi_saldo      <= @w_monto_canc)
       and hi_saldo      > 0
       and hi_cuenta not in (select
                               tn_cuenta
                             from   cob_remesas..re_tesoro_nacional
                             where  tn_tipo_cta in (2, 3))
    group  by hi_cuenta
    having max(hi_fecha) <= @w_fecha

/* Abrir el cursor para enviar las cuentas a la DTN */
  /* Ubicar el primer registro para el cursor */

  open cuentas_dtn
  fetch cuentas_dtn into @w_hi_cuenta, @w_hi_fecha

  /*Validacion del estado del cursor*/

  if @@fetch_status = -2
  begin
    close cuentas_dtn
    deallocate cuentas_dtn

    select
      @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
    goto ERROR
  end

  if @@fetch_status = -1
  begin
    close cuentas_dtn
    deallocate cuentas_dtn
    return 0
  end

  while @@fetch_status = 0
  begin
    /* Se Valida de que la cuenta no este activa ni que se haya cancelado */
    if exists (select
                 1
               from   cob_ahorros..ah_cuenta
               where  ah_cta_banco = @w_hi_cuenta
                  and ah_estado in ('C', 'A'))
      goto LEER

    -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
    if @i_corresponsal = 'N'
    begin
      select
        @w_saldo = ah_disponible,
        @w_ah_estado = ah_estado,
        @w_ah_oficina = ah_oficina,
        @w_prod_banc = ah_prod_banc,
        @w_categoria = ah_categoria,
        @w_clase_clte = ah_clase_clte,
        @w_tipocta = ah_tipocta,
        @w_cliente = ah_cliente,
        @w_oficial = ah_oficial,
        @w_ah_moneda = ah_moneda,
        @w_ah_nombre = ah_nombre,
        @w_ah_descripcion_ec = ah_descripcion_ec,
        @w_ah_telefono = ah_telefono,
        @w_ced_ruc = ah_ced_ruc,
        @w_fecha_ult_mov = ah_fecha_ult_mov,
        @w_saldo_intereses = ah_saldo_interes,
        @w_cuenta = ah_cuenta,
        @w_fecha_ult_capi = ah_fecha_ult_capi,
        @w_tipocta_super = ah_tipocta_super
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_hi_cuenta
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

      if @@rowcount = 0
      begin
        insert cob_cuentas..re_error_batch
        values (@w_hi_cuenta,'REGISTRO NO ESTA EN EL MAESTRO DE CUENTAS')

        if @@error <> 0
        begin
          /* Cerrar y liberar cursor */
          close cuentas_dtn
          deallocate cuentas_dtn

          select
            @w_msg = 'ERROR EN GRABACION DE ARCHIVO DE ERRORES BATCH'
          goto ERROR
        end
        goto LEER
      end
    end
    else
    begin
      select
        @w_saldo = ah_disponible,
        @w_ah_estado = ah_estado,
        @w_ah_oficina = ah_oficina,
        @w_prod_banc = ah_prod_banc,
        @w_categoria = ah_categoria,
        @w_clase_clte = ah_clase_clte,
        @w_tipocta = ah_tipocta,
        @w_cliente = ah_cliente,
        @w_oficial = ah_oficial,
        @w_ah_moneda = ah_moneda,
        @w_ah_nombre = ah_nombre,
        @w_ah_descripcion_ec = ah_descripcion_ec,
        @w_ah_telefono = ah_telefono,
        @w_ced_ruc = ah_ced_ruc,
        @w_fecha_ult_mov = ah_fecha_ult_mov,
        @w_saldo_intereses = ah_saldo_interes,
        @w_cuenta = ah_cuenta,
        @w_fecha_ult_capi = ah_fecha_ult_capi,
        @w_tipocta_super = ah_tipocta_super
      from   cob_ahorros..ah_cuenta
      where  ah_cta_banco = @w_hi_cuenta
         and ah_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

      if @@rowcount = 0
      begin
        insert cob_cuentas..re_error_batch
        values (@w_hi_cuenta,'REGISTRO NO ESTA EN EL MAESTRO DE CUENTAS')

        if @@error <> 0
        begin
          /* Cerrar y liberar cursor */
          close cuentas_dtn
          deallocate cuentas_dtn

          select
            @w_msg = 'ERROR EN GRABACION DE ARCHIVO DE ERRORES BATCH'
          goto ERROR
        end
        goto LEER
      end
    end

    if @w_saldo <= @w_monto_canc
       and @w_saldo > 0
       and @w_fecha_ult_mov <= @w_fecha
    begin
      if exists (select
                   1
                 from   cob_remesas..re_tesoro_nacional
                 where  tn_cuenta = @w_hi_cuenta)
        goto LEER

      /* Captura de seqnos para tabla de la DTN */
      exec @w_return = cobis..sp_cseqnos
        @i_tabla     = 're_tesoro_nacional',
        @o_siguiente = @w_numrg out

      if @w_return <> 0
      begin
        select
          @w_msg = 'ERROR EN CAPTURA DE SECUENCIAL PARA ENVIO TABLA DTN'
        goto ERROR
      end

      if @w_prod_banc in (2, 4)
        select
          @w_tipo_grupo = '01'
      else
        select
          @w_tipo_grupo = '01'

      /* buscar los interes pagaderos a la cuenta hasta el proximo dia laborable que se reporta*/
      select
        @w_interes = 0,
        @w_diferencia = 0

      -- Req. 381 CB Red Posicionada - Si no es corresponsal no debe presentar las cuentas de corresponsales
      if @i_corresponsal = 'N'
      begin
        select
          @w_fecha_sld_dia = max(sd_fecha)
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta    = @w_cuenta
           and sd_fecha between @w_fecha_ult_capi and @i_fecha
           and sd_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada

        if @w_fecha_sld_dia is not null
          select
            @w_tasa_disp = sd_tasa_disponible
          from   cob_ahorros_his..ah_saldo_diario
          where  sd_cuenta    = @w_cuenta
             and sd_fecha     = @w_fecha_sld_dia
             and sd_prod_banc <> @w_prod_bancario -- Req. 381 CB Red Posicionada
        else
          select
            @w_tasa_disp = 0

        if @w_tasa_disp > 0
        begin
          select
            @w_diferencia = datediff(dd,
                                     @i_fecha,
                                     @w_fecha_envia)
          if @w_diferencia > 0
          begin
            select
              @w_diferencia = @w_diferencia - 1
          --select @w_interes     = round((@w_tasa_disp/@w_dias_anio),@w_numdeci)  * @w_diferencia * @w_saldo               
          end
        end
      end
      else
      begin
        select
          @w_fecha_sld_dia = max(sd_fecha)
        from   cob_ahorros_his..ah_saldo_diario
        where  sd_cuenta = @w_cuenta
           and sd_fecha between @w_fecha_ult_capi and @i_fecha

        if @w_fecha_sld_dia is not null
          select
            @w_tasa_disp = sd_tasa_disponible
          from   cob_ahorros_his..ah_saldo_diario
          where  sd_cuenta = @w_cuenta
             and sd_fecha  = @w_fecha_sld_dia
        else
          select
            @w_tasa_disp = 0

        if @w_tasa_disp > 0
        begin
          select
            @w_diferencia = datediff(dd,
                                     @i_fecha,
                                     @w_fecha_envia)
          if @w_diferencia > 0
          begin
            select
              @w_diferencia = @w_diferencia - 1
          --select @w_interes     = round((@w_tasa_disp/@w_dias_anio),@w_numdeci)  * @w_diferencia * @w_saldo               
          end
        end
      end

      /* REQ 322 Obtener codigo DTN */
      exec @w_return = cob_ahorros..sp_ahcoddtn
        @i_cuenta     = @w_hi_cuenta,
        @i_oficina    = @w_ah_oficina,
        @i_prod_banc  = @w_prod_banc,
        @i_categoria  = @w_categoria,
        @i_tipocta    = @w_tipocta,
        @o_codigo_dtn = @w_tipo_grupo out,
        @o_profinal   = @w_profinal out
      if @w_return <> 0
      begin
        /* Cerrar y liberar cursor */
        close cuentas_dtn
        deallocate cuentas_dtn

        /* Error en consulta de codigo para dtn */
        select
          @w_msg = 'ERROR CONSULTA DE CODIGO PARA DTN'
        goto ERROR
      end

      /* Insercion de Cuentas a la DTN*/
      insert into cob_remesas..re_tesoro_nacional
                  (tn_cuenta,tn_ced_ruc,tn_tipo_cta,tn_grupo,tn_saldo_inicial,
                   tn_remuneracion,tn_fecha,tn_estado,tn_autorizante,tn_oficina,
                   tn_causa,tn_secuencial,tn_fecha_proceso,tn_valor_rv,
                   tn_fecha_envio)
      values      ( @w_hi_cuenta,@w_ced_ruc,3,@w_tipo_grupo,@w_saldo,
                    @w_interes,@w_fecha_tmp,'N','AHO',@w_ah_oficina,
                    '6',@w_numrg,@i_fecha,0,@w_fecha_envia)

      if @@error <> 0
      begin
        /* Cerrar y liberar cursor */
        close cuentas_dtn
        deallocate cuentas_dtn

        /* Error en grabacion de archivo de errores */
        select
          @w_msg = 'ERROR EN GRABACION DE ARCHIVO DE ERRORES BATCH'
        goto ERROR
      end
      if @w_ejecucion = 'D'
      begin
        /* Creacion de la transacicon de servicio para el traslado*/
        insert into ah_tran_servicio
                    (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                     ts_terminal,
                     ts_ctacte,ts_filial,ts_valor,ts_interes,ts_oficina,
                     ts_oficina_cta,ts_prod_banc,ts_causa,ts_cod_alterno,
                     ts_cliente,
                     ts_moneda,ts_clase_clte,ts_tipocta_super,ts_cta_banco)
        values      (@w_ssn,375,@i_fecha,'op_batch','consola',
                     @w_cuenta,@i_filial,@w_saldo,@w_interes,@w_ah_oficina,
                     @w_ah_oficina,@w_prod_banc,'I',1,@w_cliente,
                     @w_ah_moneda,@w_clase_clte,@w_tipocta_super,@w_hi_cuenta)

        if @@error <> 0
        begin
          rollback tran

          /* Cerrar y liberar cursor */
          close cuentas_dtn
          deallocate cuentas_dtn

          /* Error en grabacion en la transaccion de servicio */
          select
            @w_msg = 'ERROR EN GRABACION TS1'
          goto ERROR
        end

        insert into ah_tran_servicio
                    (ts_secuencial,ts_tipo_transaccion,ts_tsfecha,ts_usuario,
                     ts_terminal,
                     ts_ctacte,ts_filial,ts_valor,ts_interes,ts_oficina,
                     ts_oficina_cta,ts_prod_banc,ts_causa,ts_cod_alterno,
                     ts_cliente,
                     ts_moneda,ts_clase_clte,ts_tipocta_super,ts_cta_banco)
        values      (@w_ssn,375,@i_fecha,'op_batch','consola',
                     @w_cuenta,@i_filial,@w_saldo * -1,@w_interes * -1,
                     @w_ah_oficina
                     ,
                     @w_ah_oficina,@w_prod_banc,'T',2,@w_cliente,
                     @w_ah_moneda,@w_clase_clte,@w_tipocta_super,@w_hi_cuenta)

        if @@error <> 0
        begin
          rollback tran

          /* Cerrar y liberar cursor */
          close cuentas_dtn
          deallocate cuentas_dtn

          /* Error en grabacion en la transaccion de servicio */
          select
            @w_msg = 'ERROR EN GRABACION TS2'
          goto ERROR
        end
      end
      goto LEER
    end

    /* Localizar el siguiente registro del cursor */
    LEER:

    fetch cuentas_dtn into @w_hi_cuenta, @w_hi_fecha

    if @@fetch_status = -2
    begin
      close cuentas_dtn
      deallocate cuentas_dtn

      select
        @w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
      goto ERROR
    end
    select
      @w_ssn = @w_ssn + 1
    select
      @w_procesadas = @w_procesadas + 1
  end /* Fin del While */

  /* Cerrar y liberar cursor */
  close cuentas_dtn
  deallocate cuentas_dtn

  select
    @o_procesadas = @w_procesadas

  FIN:
  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @i_fecha,
    @i_error       = 1,
    @i_usuario     = 'Operador',
    @i_tran        = 375,
    @i_cuenta      = @w_hi_cuenta,
    @i_descripcion = @w_msg

  return 1

go

