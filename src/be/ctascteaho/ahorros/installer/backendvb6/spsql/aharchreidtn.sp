/************************************************************************/
/*      Archivo:                aharchreidtn.sp                         */
/*      Stored procedure:       sp_archivo_reint_dtn_ah                 */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas Ahorros                         */
/*      Creado por:             Mario Algarin                           */
/*      Fecha de escritura:     04-Mayo-2010                            */
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
/*      BATCH: Crea Archivo plano de las Cuentas que fueron o van a ser */
/*             rientegradas a la DTN.                                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*  11/14/2013       DLO                ORS 672                         */
/*  02/May/2016      J. Calderon      MigraciÛn a CEN                   */
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
           where  name = 'sp_archivo_reint_dtn_ah')
  drop proc sp_archivo_reint_dtn_ah
go

create proc sp_archivo_reint_dtn_ah
(
  @t_debug        varchar(1) = null,
  @t_show_version bit = 0,
  @i_param1       char(1),-- P-Parcial, D-Definitivo 
  @i_param2       datetime = null -- Fecha Proceso
)
as
  declare
    @w_sp_name          varchar(64),
    @w_return           int,
    @w_fecha            datetime,
    @w_fecha_crea       varchar(8),
    @w_fecha_envia      datetime,
    @w_saldo_total      money,
    @w_remuneracion     money,
    @w_num_reg          int,
    @w_registro         varchar(255),
    @w_ri_cta_banco     cuenta,
    @w_ri_cedula        char(13),
    @w_ri_tipo_cta      tinyint,
    @w_ri_grupo         char(2),
    @w_ri_fecha_corte   datetime,
    @w_ri_valor         money,
    @w_ri_interes       money,
    @w_ri_fecha_proceso datetime,
    @w_msg              descripcion,
    @w_sec_rei          int,
    @w_archivo          descripcion,
    @w_archivo_bcp      descripcion,
    @w_errores          descripcion,
    @w_tot_reg          int,
    @w_path_s_app       varchar(30),
    @w_path             varchar(250),
    @w_s_app            varchar(250),
    @w_cmd              varchar(250),
    @w_error            int,
    @w_comando          varchar(250),
    @w_fecha_fin        datetime,
    @w_fecha_mm         datetime,
    @w_num_dias         int,
    @w_ciudad           int,
    @w_fecha_tmp        datetime,
    @w_fecha_aux        datetime,
    @w_ejecucion        char(1),
    @w_cont_grupo       int,
    @w_dias_fecenv      int,
    @w_fin_trim_nfs     datetime,
    @w_cod_bmia         char(2),
    @w_reproceso        char(1),
    @w_dias_pry         int,
    @w_periodo_dtn      smallint,
    @w_dias_atras       tinyint,
    @w_fecha_atras      datetime

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_archivo_reint_dtn_ah'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  select
    @w_ejecucion = @i_param1
  select
    @w_fecha = @i_param2
  select
    @w_reproceso = 'N'

  /* Captura de la Fecha Proceso*/
  if @w_fecha is null
    select
      @w_fecha = fp_fecha
    from   cobis..ba_fecha_proceso

  /*Ciudad Matriz de Reintegro*/
  select
    @w_ciudad = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'CTE'
     and pa_nemonico = 'CMA'

  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO PARAMETRO DE CIUDAD MATRIZ DE REINTEGRO'
    goto ERROR
  end

  select
    @w_cod_bmia = convert(char(2), pa_tinyint)
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'BMIASF'

  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO CODIGO DE BANCAMIA ANTE LA SUPERFINANCIERA'
    goto ERROR
  end

  select
    @w_dias_fecenv = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'ENVDTN'
     and pa_producto = 'AHO'

  --Escoge el parametro de periodo para el envio DTN
  select
    @w_periodo_dtn = pa_smallint
  from   cobis..cl_parametro
  where  pa_nemonico = 'PERDTN'
     and pa_producto = 'AHO'

  if @@rowcount <> 1
  begin
    /* Error: no se ha definido ciudad de feriados nacionales */
    exec cobis..sp_cerror
      @i_num = 205031,
      @i_msg = 'ERROR EN PARAMETRO DE NUMERO DE DIAS FESTIVOS ENVIADOS'
    return 205031
  end

  select
    @w_dias_atras = pa_tinyint --DLO ORS 672
  from   cobis..cl_parametro
  where  pa_nemonico = 'RETDTN'
     and pa_producto = 'AHO'

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @i_num = 201196,
      @i_msg = 'ERROR EN PARAMETRO GENERAL NUMERO DE DIAS PARA ENVIO A DTN'
    return 201196
  end

  -- REQ 322 CUENTAS INACTIVAS   
  if @w_ejecucion = 'P' -- Ejecucion Parcial
  begin
    /* Hallar fin de trimestre mas cercano a la fecha dada */
    exec cob_ahorros..sp_fecha_fin_periodo
      @i_fecha     = @w_fecha,
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
  begin
    /*** PROYECCION DIAS REINTEGRO DTN ORS 513***/
    select
      @w_dias_pry = pa_int
    from   cobis..cl_parametro
    where  pa_nemonico = 'RTODTN'
       and pa_producto = 'AHO'

    if @@rowcount <> 1
    begin
      /* Error: parﬂmetro numero de d›as proyectados para reintegro DTN */
      exec cobis..sp_cerror
        @i_num = 150006,
        @i_msg =
      'ERROR EN PARAMETRO NUMERO DE DIAS PROYECTADOS PARA REINTEGRO DTN'
      return 205031
    end

    select
      @w_fecha = dateadd(dd,
                         @w_dias_pry,
                         @i_param2)

    select
      @w_fecha_tmp = @w_fecha
  end

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

  /* Validacion de la periodicidad de ejecucion */
  if (datepart(mm,
               @w_fecha_tmp) % 3) <> 0
      or ((datepart(mm,
                    @w_fecha_tmp) % 3) = 0
          and convert(varchar(2), (datepart(mm,
                                            @w_fecha_aux))) =
              convert(varchar(2),
              (datepart(mm,
                        @w_fecha_tmp))))
  begin
    --select @w_msg = 'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE'
    print 'ESTE PROCESO SE EJECUTA TRIMESTRALMENTE'
    goto FIN
  end

  /* DESMARCACION DE CUENTAS PARA REPROCESO */
  if exists(select
              1
            from   cob_remesas..re_tesoro_nacional,
                   cob_remesas..re_reintegro_dtn
            where  tn_cuenta = ri_cta_banco
               and tn_fecha_act between (dateadd(mm,
                                                 -3,
                                                 @w_fecha_tmp)) and @w_fecha_tmp
               and ri_estado = 'P')
  begin
    update cob_remesas..re_reintegro_dtn
    set    ri_estado = 'N'
    from   cob_remesas..re_tesoro_nacional
    where  tn_cuenta = ri_cta_banco
       and tn_fecha_act between (dateadd(mm,
                                         -3,
                                         @w_fecha_tmp)) and @w_fecha_tmp
       and ri_estado = 'P'
    if @@error <> 0
    begin
      select
        @w_msg = 'NO SE PUDO DESMARCAR LAS CUENTAS PARA REPROCESO'
      goto ERROR
    end

    update cobis..cl_parametro
    set    pa_int = pa_int - 1
    where  pa_nemonico = 'RCDTN'
       and pa_producto = 'AHO'

    if @@error <> 0
    begin
      select
        @w_msg =
      'NO SE PUDO ACTUALIZAR EL CONSECUTIVO DE ENVIO A LA DTN PARA REPROCESO'
      goto ERROR
    end

    select
      @w_reproceso = 'S'
  end

  /*Consecutivo de Reintegro a la DTN*/
  select
    @w_sec_rei = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'RCDTN'
     and pa_producto = 'AHO'

  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO SE ENCONTRO PARAMETRO DE CONSECUTIVO DE REINTEGRO DE LA DTN'
    goto ERROR
  end

  /* Borrado de datos existentes en la Tabla Con datos de reintegrar a la DTN */
  truncate table cob_remesas..re_arch_out_dtn

  /* Hallar fin de trimestre mas cercano a la fecha dada */
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

  /* calculo de proxima laborable */
  exec @w_return = cob_remesas..sp_fecha_habil
    @i_fecha     = @w_fin_trim_nfs,
    @i_oficina   = 1,
    @i_efec_dia  = 'S',
    @i_finsemana = 'S',
    @w_dias_ret  = @w_dias_fecenv,
    @o_fecha_sig = @w_fecha_envia out
  if @w_return <> 0
  begin
    select
      @w_msg = 'ERROR ENCONTRANDO FECHA DE ENVIO'
    goto ERROR
  end

  select
    @w_fecha_atras = dateadd(dd,
                             -1 * @w_dias_atras,
                             @w_fecha_tmp) --DLO ORS 672

  /* UNIVERSO DE CUENTAS REINTEGRO */
  select
    ri_cta_banco,
    ri_cuenta,
    ri_producto,
    ri_cedula,
    ri_tipo_cta,
    ri_grupo,
    ri_fecha_corte,
    ri_valor,
    ri_interes,
    ri_fecha_proceso,
    ri_estado,
    ri_fecha = @w_fecha_tmp
  into   #reintegros_dtn
  from   cob_remesas..re_tesoro_nacional,
         cob_remesas..re_reintegro_dtn
  where  tn_cuenta = ri_cta_banco
     and tn_fecha_act between (dateadd(mm,
                                       -3,
                                       @w_fecha_atras)) and @w_fecha_tmp
     and ri_estado = 'N'

/**************/
/*| CABECERA |*/
  /**************/
  select distinct
    ri_grupo
  from   #reintegros_dtn
  where  ri_estado = 'N'
     and ri_fecha  = @w_fecha_tmp

  select
    @w_cont_grupo = @@rowcount

  select
    @w_saldo_total = isnull(sum(round(ri_valor,
                                      2)),
                            0),
    @w_remuneracion = isnull(sum(round(ri_interes,
                                       2)),
                             0),
    @w_num_reg = count(1)
  from   #reintegros_dtn
  where  ri_estado = 'N'
     and ri_fecha  = @w_fecha_tmp

  select
    @w_registro = ''
  select
    @w_registro = '01' + @w_cod_bmia + convert(varchar(8), @w_fecha_envia, 112)
                  + right('00000000000000000000' + convert(varchar,
                  @w_saldo_total
                  )
                                              , 23)
                  + right('00000000000000000000' + convert(varchar,
                  @w_remuneracion)
                                              , 23)
                  + right('000000000' + convert(varchar, @w_num_reg), 9)
                  + right('00' + convert(varchar, @w_cont_grupo), 2)
                  + right('00' + convert(varchar, @w_sec_rei), 2)

  insert into cob_remesas..re_arch_out_dtn
              (aod_registro)
  values      (@w_registro)

  if @@error <> 0
  begin
    select
      @w_msg =
    'No se pudo crear la Cabecera del archivo plano de Reintegro a la DTN'
    goto ERROR
  end

/*************/
/*| DETALLE |*/
/*************/
  /* Cursor que me permite tomar las cuenta que van a ser reintegradas de la DTN */

  declare cuentas_dtn cursor for
    select
      ri_cta_banco,
      ri_cedula,
      ri_tipo_cta,
      ri_grupo,
      ri_fecha_corte,
      round(ri_valor,
            2),
      round(ri_interes,
            2),
      ri_fecha_proceso
    from   #reintegros_dtn
    where  ri_estado = 'N'
       and ri_fecha  = @w_fecha_tmp

/* Abrir el cursor para reintegrar las cuentas de la DTN */
  /* Ubicar el primer registro para el cursor */

  open cuentas_dtn
  fetch cuentas_dtn into @w_ri_cta_banco,
                         @w_ri_cedula,
                         @w_ri_tipo_cta,
                         @w_ri_grupo,
                         @w_ri_fecha_corte,
                         @w_ri_valor,
                         @w_ri_interes,
                         @w_ri_fecha_proceso

  /* Validacion del estado del cursor */

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
    select
      @w_registro = ''
    select
      @w_registro = right('0000000000000000' + @w_ri_cta_banco, 16)
                    + right('000000000000000' + @w_ri_cedula, 15)
                    + right('0' + convert(varchar, @w_ri_tipo_cta), 1) + right(
                    '00'
                    +
                                                @w_ri_grupo, 2)
                    + convert(varchar(8), @w_ri_fecha_corte, 112)
                    + right('000000000000000' + convert(varchar, @w_ri_valor),
                    15)
                    + right('000000000000000' + convert(varchar, @w_ri_interes),
                    15)

    insert into cob_remesas..re_arch_out_dtn
                (aod_registro)
    values      (@w_registro)

    if @@error <> 0
    begin
      select
        @w_msg =
'No se pudo crear registro de detalle para archivo de Reintegro a la DTN'
goto ERROR
end

goto LEER

/* Localizar el siguiente registro del cursor */
LEER:

fetch cuentas_dtn into @w_ri_cta_banco,
                   @w_ri_cedula,
                   @w_ri_tipo_cta,
                   @w_ri_grupo,
                   @w_ri_fecha_corte,
                   @w_ri_valor,
                   @w_ri_interes,
                   @w_ri_fecha_proceso

if @@fetch_status = -2
begin
close cuentas_dtn
deallocate cuentas_dtn

select
@w_msg = 'HUBO ERROR EN LA LECTURA DE LOS REGISTROS'
goto ERROR
end

end /* Fin del While */

  /* Cerrar y liberar cursor */
  close cuentas_dtn
  deallocate cuentas_dtn

  /* Se valida de que hayan registros para poder generar BCP, del archivo de cuentas a enviar a la DTN */
  select
    @w_tot_reg = count(1)
  from   cob_remesas..re_arch_out_dtn

  if @w_tot_reg > 1
  begin
    select
      @w_path_s_app = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'S_APP'

    if @w_path_s_app is null
    begin
      select
        @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
      goto ERROR
    end

    /* Se Realiza BCP */
    select
      @w_s_app = @w_path_s_app + 's_app'

    select
      @w_path = ba_path_destino
    from   cobis..ba_batch
    where  ba_batch = 4193 --OJO CAMBIAR CUANDO SE GENERE LA SARTA

    select
      @w_archivo = 'RI' + '01' + @w_cod_bmia + right('00' + convert(varchar,
                          @w_sec_rei), 2) +
                          '.prn',
      @w_errores = 'ER_' + 'RI' + '01' + @w_cod_bmia + right('00' + convert(
                   varchar
                   ,
                   @w_sec_rei),
                   2 ) + '.txt'

    select
      @w_archivo_bcp = @w_path + @w_archivo,
      @w_errores = @w_path + @w_errores,
      @w_cmd = @w_s_app + ' bcp -auto -login cob_remesas..re_arch_out_dtn out '

    select
      @w_comando = @w_cmd + @w_archivo_bcp + ' -b5000 -c -e' + @w_errores +
                   ' -config ' + @w_s_app
                   + '.ini'

    exec @w_error = xp_cmdshell
      @w_comando

    if @w_error <> 0
    begin
      select
        @w_msg = 'ERROR AL GENERAR ARCHIVO ' + @w_archivo + ' ' + convert(
                 varchar
                 ,
                        @w_error)
      goto ERROR
    end

  end
  else
  begin
    select
      @w_msg =
  'No Existen datos Para Generar Archivo Plano de Reintegro de Cuentas a la DTN'
    goto ERROR
  end

  if @w_ejecucion = 'D'
      or @w_reproceso = 'S'
  begin
    /* Actualizacion estado de las cuentas procesadas */
    update #reintegros_dtn
    set    ri_estado = 'P'
    where  ri_estado = 'N'
       and ri_fecha  = @w_fecha_tmp

    if @@error <> 0
    begin
      select
        @w_msg = 'NO SE PUDO ACTUALIZAR EL ESTADO DE LAS CUENTAS PROCESADAS'
      goto ERROR
    end

    update cob_remesas..re_reintegro_dtn
    set    ri_estado = B.ri_estado
    from   #reintegros_dtn B,
           cob_remesas..re_reintegro_dtn DTN1
    where  DTN1.ri_cta_banco = B.ri_cta_banco

    if @@error <> 0
    begin
      select
        @w_msg =
        'NO SE PUDO ACTUALIZAR ESTADO DE CUENTAS PROCESADAS EN TABLA DEFINITIVA'
      goto ERROR
    end

    /* Actualizacion de Consecutivo de Reintegro a la DTN*/
    update cobis..cl_parametro
    set    pa_int = pa_int + 1
    where  pa_nemonico = 'RCDTN'
       and pa_producto = 'AHO'

    if @@error <> 0
    begin
      select
        @w_msg = 'NO SE PUDO ACTUALIZAR EL CONSECUTIVO DE REINTEGRO A LA DTN'
      goto ERROR
    end

  end
  FIN:
  return 0

  ERROR:

  exec sp_errorlog
    @i_fecha       = @w_fecha,
    @i_error       = 1,
    @i_usuario     = 'Operador',
    @i_tran        = 0,
    @i_cuenta      = '',
    @i_descripcion = @w_msg

  return 1

go

