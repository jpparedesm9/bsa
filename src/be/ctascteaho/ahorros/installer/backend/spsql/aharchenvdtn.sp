/************************************************************************/
/*      Archivo:                aharchenvdtn.sp                         */
/*      Stored procedure:       sp_archivo_envia_dtn_ah                 */
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
/*      BATCH: Crea Archivo plano de las Cuentas que van a ser          */
/*             Enviadas a la DTN.                                       */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR              RAZON                        */
/*  02/May/2016      J. Calderon     Migración a CEN                    */
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
           where  name = 'sp_archivo_envia_dtn_ah')
  drop proc sp_archivo_envia_dtn_ah
go

create proc sp_archivo_envia_dtn_ah
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
    @w_fecha_envia      varchar(8),
    @w_saldo_total      money,
    @w_remuneracion     money,
    @w_num_reg          int,
    @w_registro         varchar(255),
    @w_tn_cuenta        varchar(24),
    @w_tn_ced_ruc       varchar(13),
    @w_tn_tipo_cta      tinyint,
    @w_tn_grupo         char(2),
    @w_tn_saldo_inicial money,
    @w_tn_remuneracion  money,
    @w_msg              descripcion,
    @w_sec_env          int,
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
    @w_fecha_aux        datetime,
    @w_ejecucion        char(1),
    @w_ciudad           int,
    @w_fecha_tmp        datetime,
    @w_cont_grupo       int,
    @w_fecha_fin        datetime,
    @w_cod_bmia         char(2),
    @w_reproceso        char(1),
    @w_periodo_dtn      smallint

  /* Captura del nombre del Stored Procedure */
  select
    @w_sp_name = 'sp_archivo_envia_dtn_ah'
  select
    @w_ejecucion = @i_param1
  select
    @w_fecha = @i_param2
  select
    @w_reproceso = 'N'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  /* Captura de la Fecha Proceso*/
  if @w_fecha is null
    select
      @w_fecha = fp_fecha
    from   cobis..ba_fecha_proceso

  -- REQ 322 CUENTAS INACTIVAS   
  /*Ciudad Matriz*/
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
    select
      @w_fecha_tmp = @w_fecha
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
    goto FIN
  end

  /* DESMARCACION DE CUENTAS PARA REPROCESO */
  if exists(select
              1
            from   cob_remesas..re_tesoro_nacional
            where  tn_fecha  = @w_fecha_tmp
               and tn_estado = 'P')
  begin
    update cob_remesas..re_tesoro_nacional
    set    tn_estado = 'N'
    where  tn_estado = 'P'
       and tn_fecha  = @w_fecha_tmp
    if @@rowcount = 0
    begin
      select
        @w_msg = 'NO SE PUDO DESMARCAR LAS CUENTAS PARA REPROCESO'
      goto ERROR
    end

    update cobis..cl_parametro
    set    pa_int = pa_int - 1
    where  pa_nemonico = 'ODTN'
       and pa_producto = 'AHO'

    if @@rowcount = 0
    begin
      select
        @w_msg =
      'NO SE PUDO ACTUALIZAR EL CONSECUTIVO DE ENVIO A LA DTN PARA REPROCESO'
      goto ERROR
    end

    select
      @w_reproceso = 'S'
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

  /* Borrado de datos existentes en la Tabla Con datos de enviar a la DTN */
  truncate table cob_remesas..re_arch_in_dtn

  /* Captura de la Fecha de Envio del Archivo de cuentas a la DTN */
  set rowcount 1

  select
    @w_fecha_fin = @w_fecha_tmp
  select
    @w_fecha_fin = dateadd(mm,
                           1,
                           @w_fecha_fin)
  select
    @w_fecha_fin = dateadd(dd,
                           (datepart(dd,
                                     @w_fecha_fin)) * -1,
                           @w_fecha_fin)

  select
    @w_fecha_crea = convert(varchar(8), @w_fecha_fin, 112),
    @w_fecha_envia = convert(varchar(8), tn_fecha_envio, 112)
  from   cob_remesas..re_tesoro_nacional
  where  tn_estado = 'N'
     and tn_fecha  = @w_fecha_tmp

  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO HAY REGISTROS PARA ENVIAR A LA DTN'
    --goto ERROR
    goto FIN
  end

  set rowcount 0

/**************/
/*| CABECERA |*/
  /**************/

  select distinct
    tn_grupo
  from   cob_remesas..re_tesoro_nacional
  where  tn_estado = 'N'
     and tn_fecha  = @w_fecha_tmp

  select
    @w_cont_grupo = @@rowcount

  select
    @w_saldo_total = sum(tn_saldo_inicial),
    @w_remuneracion = isnull(sum(round(tn_remuneracion,
                                       2)),
                             0),
    @w_num_reg = count(1)
  from   cob_remesas..re_tesoro_nacional
  where  tn_estado = 'N'
     and tn_fecha  = @w_fecha_tmp

  select
    @w_registro = ''
  select
    @w_registro = '01' + @w_cod_bmia + @w_fecha_crea + @w_fecha_envia
                  + right('00000000000000000000' + convert(varchar,
                  @w_saldo_total
                  )
                                              , 23)
                  + right('00000000000000000000' + convert(varchar,
                  @w_remuneracion)
                                              , 23)
                  + right('000000000' + convert(varchar, @w_num_reg), 9)
                  + right('00' + convert(varchar, @w_cont_grupo), 2)
                  + right('00' + convert(varchar, @w_sec_env), 2)

  insert into cob_remesas..re_arch_in_dtn
              (aid_registro)
  values      (@w_registro)

  if @@error <> 0
  begin
    select
      @w_msg =
    'No se pudo crear la Cabecera del archivo plano de Envio a la DTN'
    goto ERROR
  end

/*************/
/*| DETALLE |*/
/*************/
  /* Cursor que me permite tomar las cuenta que van para la DTN */

  declare cuentas_dtn cursor for
    select
      tn_cuenta,
      tn_ced_ruc,
      tn_tipo_cta,
      tn_grupo,
      tn_saldo_inicial,
      isnull(round(tn_remuneracion,
                   2),
             0)
    from   cob_remesas..re_tesoro_nacional
    where  tn_estado = 'N'
       and tn_fecha  = @w_fecha_tmp

/* Abrir el cursor para enviar las cuentas a la DTN */
  /* Ubicar el primer registro para el cursor */

  open cuentas_dtn
  fetch cuentas_dtn into @w_tn_cuenta,
                         @w_tn_ced_ruc,
                         @w_tn_tipo_cta,
                         @w_tn_grupo,
                         @w_tn_saldo_inicial,
                         @w_tn_remuneracion

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
      @w_registro = right('0000000000000000' + @w_tn_cuenta, 16)
                    + right('000000000000000' + @w_tn_ced_ruc, 15)
                    + right('0' + convert(varchar, @w_tn_tipo_cta), 1) + right(
                    '00'
                    +
                                                @w_tn_grupo, 2)
                    + right('000000000000000' + convert(varchar,
                    @w_tn_saldo_inicial
                    )
                                                , 15)
                    + right('000000000000000' + convert(varchar,
                    @w_tn_remuneracion)
                    ,
                                                15)

    insert into cob_remesas..re_arch_in_dtn
                (aid_registro)
    values      (@w_registro)

    if @@error <> 0
    begin
      select
        @w_msg =
      'No se pudo crear registro de detalle para archivo de Envio a la DTN'
      goto ERROR
    end

    goto LEER

    /* Localizar el siguiente registro del cursor */
    LEER:

    fetch cuentas_dtn into @w_tn_cuenta,
                           @w_tn_ced_ruc,
                           @w_tn_tipo_cta,
                           @w_tn_grupo,
                           @w_tn_saldo_inicial,
                           @w_tn_remuneracion

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
  from   cob_remesas..re_arch_in_dtn

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
      @w_archivo = 'TC' + '01' + @w_cod_bmia + right('00' + convert(varchar,
                          @w_sec_env), 2) +
                          '.prn',
      @w_errores = 'ER_' + 'TC' + '01' + @w_cod_bmia + right('00' + convert(
                   varchar
                   ,
                   @w_sec_env),
                   2 ) + '.txt'

    select
      @w_archivo_bcp = @w_path + @w_archivo,
      @w_errores = @w_path + @w_errores,
      @w_cmd = @w_s_app + ' bcp -auto -login cob_remesas..re_arch_in_dtn out '

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
      'No Existen datos Para Generar Archivo Plano de Envio de Cuentas a la DTN'
    goto ERROR
  end

  /* Actualizacion estado de las cuentas procesadas */
  if @w_ejecucion = 'D'
      or @w_reproceso = 'S'
  begin
    update cob_remesas..re_tesoro_nacional
    set    tn_estado = 'P'
    where  tn_estado = 'N'
       and tn_fecha  = @w_fecha_tmp

    if @@rowcount = 0
    begin
      select
        @w_msg = 'NO SE PUDO ACTUALIZAR EL ESTADO DE LAS CUENTAS PROCESADAS'
      goto ERROR
    end

    /* Actualizacion de Consecutivo de Envio a la DTN*/
    update cobis..cl_parametro
    set    pa_int = pa_int + 1
    where  pa_nemonico = 'ODTN'
       and pa_producto = 'AHO'

    if @@rowcount = 0
    begin
      select
        @w_msg = 'NO SE PUDO ACTUALIZAR EL CONSECUTIVO DE ENVIO A LA DTN'
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

