/************************************************************************/
/*      Archivo:                ahmtoplan.sp                            */
/*      Stored procedure:       sp_mto_ahorro_plan                      */
/*      Base de datos:          cob_ahorros                             */
/*      Producto:               Cuentas de Ahorros                      */
/*      Disenado por:           Saira Molano                            */
/*      Fecha de escritura:     18-Jul-2011                             */
/************************************************************************/
/*                             IMPORTANTE                               */
/*      Esta aplicacion es parte de los paquetes bancarios propiedad    */
/*      de COBISCorp.                                                   */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno  de sus        */
/*      usuarios sin el debido consentimiento por escrito de COBISCorp. */
/*      Este programa esta protegido por la ley de derechos de autor    */
/*      y por las convenciones  internacionales de propiedad inte-      */
/*      lectual. Su uso no  autorizado dara  derecho a COBISCorp para   */
/*      obtener ordenes  de secuestro o  retencion y para  perseguir    */
/*      penalmente a los autores de cualquier infraccion.               */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Este programa procesa Realiza:                                  */
/*      Evalua cuentas Progresivo con vencimiento en la fecha de proceso*/
/*      Marca Cuentas cumplidas 'C' y cuentas No cumplidas 'D'          */
/*                                    descubiertas                      */
/*      Genera informacion para archivos planos cuentas incumplidas y   */
/*      cuentas con vencimiento siguiente dia habil                     */
/*      Genera Archivos planos cuentas incumplidas y vencidas dia Sig.  */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR          RAZON                            */
/*      18/Jul/2011     S.Molano       Emision Inicial                  */
/*      04/May/2016     J.Salazar      Migracion COBIS CLOUD MEXICO     */
/************************************************************************/
use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_mto_ahorro_plan')
  drop proc sp_mto_ahorro_plan
go

/****** Object:  StoredProcedure [dbo].[sp_mto_ahorro_plan]    Script Date: 03/05/2016 9:52:01 ******/
set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_mto_ahorro_plan
(
  --@i_param1    varchar(255)  -- Fecha Fin 
  @t_show_version bit = 0,
  @i_mon          tinyint = null
)
as
  declare
    @w_return           int,
    @w_sp_name          varchar(30),
    @w_oficina          smallint,
    @w_cuenta           int,
    @w_fecha_aper       smalldatetime,
    @w_producto         tinyint,
    @w_prod_banc        smallint,
    @w_desc_prod_banc   varchar(64),
    @w_nombre_titulares varchar (255),
    @w_maximo_titulares smallint,
    @w_fecha_sig        datetime,
    @w_saldo_esp        money,
    @w_fecha_batch      datetime,
    @w_estado_cta       char(1),
    @w_ciudad_matriz    int,
    @w_valor_cuota      money,
    @w_cta_banco        cuenta,
    @w_fecha_desde      datetime,
    @w_fecha_hasta      datetime,
    @w_num_cuota        int,
    @w_saldo_desde      money,
    @w_saldo_hasta      money,
    @w_fecha_proceso    datetime,
    @w_valor_mto        money,
    @w_error            int,
    @w_msg              varchar(250),
    @w_fecha_hoy        varchar(12),
    @w_path_destino     varchar(100),
    @w_cmd              varchar(255),
    @w_comando          varchar(255),
    @w_path_s_app       varchar(100),
    @w_s_app            varchar(250),
    @w_sqr              varchar(100),
    @w_path             varchar(250),
    @w_anio             int,
    @w_mes              int,
    @w_dia              int,
    @w_fecha_reporte    varchar(10),
    @w_nom_archivo      varchar(100),
    @w_archivo          varchar(255),
    @w_fecha_aprox      datetime,
    @w_cabecera         varchar(500),
    @w_nombre_plano     varchar(500),
    @w_nombre_cab       varchar(26),
    @w_tot_con          int,
    @w_tot_seg          int

  -- Captura nombre de Stored Procedure
  select
    @w_sp_name = 'sp_mto_ahorro_plan'

  -- Versionamiento del Programa --
  if @t_show_version = 1
  begin
    print 'Stored Procedure=' + @w_sp_name + ' Version=' + '4.0.0.0'
    return 0
  end

  truncate table ah_seg_plan --Almacena cuentas vencen hoy

  --Maximo de filas de la cabecera del titular
  select
    @w_maximo_titulares = 4

  select
    @w_fecha_batch = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @w_ciudad_matriz = pa_int
  from   cobis..cl_parametro
  where  pa_nemonico = 'CMA'
     and pa_producto = 'CTE'
  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO CIUDAD MATRIZ'
    goto ERRORFIN
  end

  select
    @w_producto = pa_int
  from   cobis..cl_parametro
  where  pa_producto = 'AHO'
     and pa_nemonico = 'PAHPR'
  if @@rowcount <> 1
  begin
    select
      @w_error = 205031,
      @w_msg = 'ERROR EN PARAMETRO AHORRO PROGRESIVO'
    goto ERRORFIN
  end

  select
    @w_fecha_sig = dateadd(dd,
                           1,
                           @w_fecha_batch)

  --Busca dia habil siguiente
  exec @w_return = cob_remesas..sp_fecha_habil
    @i_val_dif       = 'N',
    @i_efec_dia      = 'S',
    @i_fecha         = @w_fecha_batch,
    @i_oficina       = 1,
    @i_dif           = 'N',--Horario Normal
    @w_dias_ret      = 1,--Dia siguiente habil 
    @i_finsemana     = 'N',--No tiene en cuenta el sabado como festivo 
    @o_ciudad_matriz = @w_ciudad_matriz out,
    @o_fecha_sig     = @w_fecha_sig out

  if @w_return <> 0
    print @w_return

  print 'fecha siguiente mto ' + convert(varchar(25), @w_fecha_sig)

  select
    @w_tot_seg = 0,
    @w_tot_con = 0

  -- CREAR INDICE A LA TABLA DE	ah_imprime_plan    

  select
    @w_tot_con = count(1)
  from   ah_imprime_plan
  where  im_fecha_aprox between @w_fecha_batch and @w_fecha_sig
     and im_estado = 'P'

  -- Cuentas a evaluar - Correponden a las cuentas que se vencen el dia de hoy
  insert into ah_seg_plan
    select
      im_cuenta,im_numero,im_cuota,im_sldo_esp,im_estado,
      im_fecha_aprox
    from   ah_imprime_plan
    where  im_fecha_aprox between @w_fecha_batch and @w_fecha_sig
       and im_estado = 'P'
    group  by im_cuenta,
              im_numero,
              im_cuota,
              im_sldo_esp,
              im_estado,
              im_fecha_aprox

  if @@rowcount = 0
  begin
    print
'PROGRAMA AHMTOPLAN.SP NO EXISTEN REGISTROS PARA PROCESAR PARA LA FECHA'
+ ' '
+ @w_fecha_hoy
    return 0
  end

  select
    @w_tot_seg = count(1)
  from   ah_seg_plan
  where  im_fecha_aprox between @w_fecha_batch and @w_fecha_sig
     and im_estado = 'P'

  print 'Total_Cont ' + convert(varchar(10), @w_tot_con)
  print 'Total_Segu ' + convert(varchar(10), @w_tot_seg)

  if @w_tot_seg <> @w_tot_con
  begin
    print
'Verificar la cantidad de registos,la cantidad insertada es diferente a la consultada'
end

  select
    ah_cuenta,
    ah_cta_banco,
    ah_prod_banc,
    ah_oficina,
    ah_fecha_aper,
    ah_estado,
    im_numero,
    im_cuota,
    im_sldo_esp,
    im_fecha_aprox
  into   #cuentas_seg_plan
  from   cob_ahorros..ah_cuenta,
         ah_seg_plan
  where  ah_cuenta    = im_cuenta
     and ah_estado    = 'A'
     and ah_prod_banc = @w_producto
     and ah_categoria <> 'N'
  if @@rowcount = 0
  begin
    select
      @w_msg = 'NO EXISTEN CUENTAS ACTIVAS PARA PROCESAR',
      @w_error = 0
    print @w_msg
    goto ERRORFIN
  end

  --Evalua incumplimientos y cumplimientos a la fecha
  declare cuentas cursor for
    select
      ah_cuenta,
      ah_cta_banco,
      ah_prod_banc,
      ah_oficina,
      ah_fecha_aper,
      ah_estado,
      im_numero,
      im_cuota,
      im_sldo_esp,
      im_fecha_aprox
    from   #cuentas_seg_plan
    for update

  open cuentas
  fetch cuentas into @w_cuenta,
                     @w_cta_banco,
                     @w_prod_banc,
                     @w_oficina,
                     @w_fecha_aper,
                     @w_estado_cta,
                     @w_num_cuota,
                     @w_valor_cuota,
                     @w_saldo_esp,
                     @w_fecha_aprox

  if @@fetch_status = -1
  begin
    close cuentas
    deallocate cuentas
    select
      @w_error = 201157,
      @w_msg = 'ERROR ABRIENDO CURSOR CUENTAS'
    goto ERRORFIN
  end

  if @@fetch_status = -2
  begin
    close cuentas
    deallocate cuentas
    return 0
  end

  while @@fetch_status = 0
  begin
    print 'CUENTA :' + @w_cta_banco + ' ' + convert(varchar(14), @w_fecha_aper)
          +
          ' numero '
          + convert(varchar(4), @w_num_cuota)

    select
      @w_fecha_desde = dateadd(mm,
                               @w_num_cuota - 1,
                               @w_fecha_aper)

    select
      @w_saldo_desde = 0
    select
      @w_saldo_hasta = 0
    select
      @w_valor_mto = 0

    select top 1
      @w_saldo_desde = isnull(sd_saldo_disponible,
                              0)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  <= @w_fecha_desde
    order  by sd_fecha desc

    select top 1
      @w_saldo_hasta = isnull(sd_saldo_disponible,
                              0)
    from   cob_ahorros_his..ah_saldo_diario
    where  sd_cuenta = @w_cuenta
       and sd_fecha  = @w_fecha_batch
    order  by sd_fecha desc

    if @w_num_cuota = 1
      select
        @w_valor_mto = isnull((@w_saldo_hasta),
                              0)
    else
      select
        @w_valor_mto = isnull((@w_saldo_hasta - @w_saldo_desde),
                              0)

    if @w_valor_mto < '0.00'
      select
        @w_valor_mto = '0.00'
    --else
    --  select @w_valor_mto = isnull((@w_saldo_hasta - @w_saldo_desde),0)

    print 'FECHA DESDE :' + convert(varchar(15), @w_fecha_desde) + '  MES '
          + convert(varchar(5), @w_mes)
    print 'FECHA HAST :' + convert(varchar(50), @w_fecha_batch) + ' ' +
          ' VALOR MTO:'
          + convert(varchar(20), @w_valor_mto)
    print 'SALDO  DESDE :' + convert(varchar(20), @w_saldo_desde) + ' ' +
          'SALDO  HASTA :'
          + convert(varchar(20), @w_saldo_hasta)
    print 'VALOR CUOTA :' + convert(varchar(20), @w_valor_cuota)
    print 'FECHA SIGUE ' + convert(varchar(25), @w_fecha_aprox)
    print 'FECHA PROCE ' + convert(varchar(25), @w_fecha_batch)

    if (@w_valor_mto >= @w_valor_cuota)
       and @w_saldo_hasta >= @w_saldo_esp
    begin
      update cob_ahorros..ah_imprime_plan
      set    im_estado = 'C',
             im_mto_mes = @w_valor_mto,
             im_saldo_hoy = @w_saldo_hasta
      where  im_cuenta = @w_cuenta
         and im_numero = @w_num_cuota

      if @@rowcount <> 1
      begin
        select
          @w_error = 203035,
          @w_msg =
        'PROGRAMA AHMTOPLAN.SP ERROR INTERNO, REGISTRO NO ACTUALIZADO'
        goto ERROR
      end
    end
    else
    begin
      --print 'FECHA APROX ' + CONVERT(varchar(15), @w_fecha_aprox) + 'FECHA PROCE ' + CONVERT(varchar(15), @w_fecha_proceso)
      if @w_fecha_aprox = @w_fecha_batch
      begin
        print 'FECHA APROX ' + convert(varchar(15), @w_fecha_aprox) +
              'FECHA PROCE '
              + convert(varchar(15), @w_fecha_proceso)
        update cob_ahorros..ah_imprime_plan
        set    im_estado = 'D',
               im_mto_mes = @w_valor_mto,
               im_saldo_hoy = @w_saldo_hasta
        where  im_cuenta = @w_cuenta
           and im_numero = @w_num_cuota

        if @@rowcount <> 1
        begin
          select
            @w_error = 203035,
            @w_msg =
          'PROGRAMA AHMTOPLAN.SP ERROR INTERNO, REGISTRO NO ACTUALIZADO'
          goto ERROR
        end
      end
    end
    goto SIGUIENTE

    ERROR:

    insert into cob_remesas..re_error_batch
    values      (@w_cuenta,@w_msg)

    if @@error <> 0
    begin
      -- Error en grabacion de archivo de errores	    
      exec cob_ahorros..sp_errorlog
        @i_fecha       = @w_fecha_batch,
        @i_error       = @w_error,
        @i_usuario     = 'batch',
        @i_tran        = 4256,
        @i_descripcion = @w_msg,
        @i_programa    = @w_sp_name

      --Cerrar y liberar cursor 
      close cuentas
      deallocate cuentas
      return @w_error
    end

    SIGUIENTE:

    fetch cuentas into @w_cuenta,
                       @w_cta_banco,
                       @w_prod_banc,
                       @w_oficina,
                       @w_fecha_aper,
                       @w_estado_cta,
                       @w_num_cuota,
                       @w_valor_cuota,
                       @w_saldo_esp,
                       @w_fecha_aprox
  end
  close cuentas
  deallocate cuentas

  --********************* **********************--
  ---> GENERAR BCP 
  --*******************************************--
  select
    @w_path_s_app = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'S_APP'

  if @w_path_s_app is null
  begin
    select
      @w_error = 999999,
      @w_msg = 'NO EXISTE PARAMETRO GENERAL S_APP'
    goto ERRORFIN
  end

  select
    @w_path = pp_path_destino
  from   cobis..ba_path_pro
  where  pp_producto = 4

  if @@rowcount = 0
  begin
    select
      @w_msg =
'ERROR 1: NO EXISTE RUTA DE LISTADOS PARA EL BATCH sp_nc_remesa_automatica'
print @w_msg
goto ERRORFIN
end

  exec cobis..sp_datepart
    @i_fecha = @w_fecha_batch,
    @o_dia   = @w_dia out,
    @o_mes   = @w_mes out,
    @o_anio  = @w_anio out
  if @@error <> 0
  begin
    select
      @w_msg = 'ERROR 3: ERROR EN EL SP_DATEPART'
    print @w_msg
    goto ERRORFIN
  end

  --Genera informacion para archivo plano consolidado con Incumplimiento 
  exec sp_consulta_ahorro_plan
    @i_opcion        = 'D',
    @i_fecha_proceso = @w_fecha_batch

  --Genera informacion para archivo plano consolidado con Vencimiento siguiente dia habil 
  exec sp_consulta_ahorro_plan
    @i_opcion        = 'P',
    @i_fecha_proceso = @w_fecha_batch

  select
    @w_fecha_reporte =
       convert(varchar, @w_anio) + right((replicate('0', 2) +
       convert(varchar, @w_mes))
       , 2)
                       + right((replicate('0', 2) + convert(varchar, @w_dia)), 2
       )

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_cabecera = '',
    @w_nombre_cab = 'Incumple_'

  select
    @w_nombre_plano = @w_path + @w_nombre_cab + convert(varchar(2), datepart(dd,
                                                             @w_fecha_reporte))
                      +
                                                             '_'
                      + convert(varchar(2), datepart(mm, @w_fecha_reporte)) +
                      '_'
                      + convert(varchar(4), datepart(yyyy, @w_fecha_reporte)) +
                                                             '.txt'

  select
       @w_cabecera = 'Oficina' + '^|' + 'Total Cuentas' + '^|' + 'Total Dispon.'
                     +
                     '^|'
                     +
                     'Total Esperado'
    + '^|'
                  + 'Producto'

  --Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + convert(varchar, @w_error) + ' ERROR GENERANDO BCP '
               +
                      @w_comando
    print @w_msg
    goto ERRORFIN
  end

  --GENERA Archivo plano con Incumplimiento fecha proceso
  select
    @w_nom_archivo = 'Incumplimiento.txt'
  select
    @w_archivo = @w_path + @w_nom_archivo

  select
    @w_cmd = @w_path_s_app +
    's_app bcp -auto -login cob_ahorros..ah_reporte_plan_incump out '

  select
       @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e' + @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_path_s_app
                 + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  --print 'Comando XYZ' + ' ' + @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + convert(varchar, @w_error) + ' ERROR GENERANDO BCP '
               +
                      @w_comando
    print @w_msg
    goto ERRORFIN
  end

  ----------------------------------------
  --Union de archivo @w_nombre_plano con archivo ca_rep_usaid.txt
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                 'Incumplimiento.txt'
                        + ' ' +
                        @w_nombre_plano

  select
    @w_comando

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + convert(varchar, @w_error) + ' ERROR GENERANDO BCP '
               +
                      @w_comando
    print @w_msg
    goto ERRORFIN
  end

  ----------------------------------------
  --Generar Archivo de Cabeceras
  ----------------------------------------
  select
    @w_cabecera = '',
    @w_nombre_cab = 'Vence_'

  select
    @w_nombre_plano = @w_path + @w_nombre_cab + convert(varchar(2), datepart(dd,
                                                          @w_fecha_reporte)) +
                                                          '_'
                      + convert(varchar(2), datepart(mm, @w_fecha_reporte)) +
                      '_'
                      + convert(varchar(4), datepart(yyyy, @w_fecha_reporte)) +
                                                          '.txt'

  select
       @w_cabecera = 'Oficina' + '^|' + 'Total Cuentas' + '^|' + 'Total Dispon.'
                     +
                     '^|'
                     +
                     'Total Esperado'
    + '^|'
                  + 'Producto'

  --Escribir Cabecera
  select
    @w_comando = 'echo ' + @w_cabecera + ' > ' + @w_nombre_plano

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + convert(varchar, @w_error) + ' ERROR GENERANDO BCP '
               +
                      @w_comando
    print @w_msg
    goto ERRORFIN
  end

  --GENERA Archivo Plano con  Vencimiento dia siguiente
  select
    @w_nom_archivo = 'Vencimientos.txt'
  select
    @w_archivo = @w_path + @w_nom_archivo

  select
    @w_cmd = @w_path_s_app +
    's_app bcp -auto -login cob_ahorros..ah_reporte_plan_venc out '

  select
       @w_comando = @w_cmd + @w_archivo + ' -b5000 -c -e' + @w_archivo + '.err'
                    +
                    ' -t"|" -config '
                    + @w_path_s_app
                 + 's_app.ini'
  exec @w_error = xp_cmdshell
    @w_comando

  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + convert(varchar, @w_error) + ' ERROR GENERANDO BCP '
               +
                      @w_comando
    print @w_msg
    goto ERRORFIN
  end

  ----------------------------------------
  --Union de archivo @w_nombre_plano con archivo ca_rep_usaid.txt
  ----------------------------------------

  select
    @w_comando = 'copy ' + @w_nombre_plano + ' + ' + @w_path +
                 'Vencimientos.txt'
                 +
                        ' ' +
                        @w_nombre_plano

  select
    @w_comando

  exec @w_error = xp_cmdshell
    @w_comando
  if @w_error <> 0
  begin
    select
      @w_msg = 'ERROR: ' + convert(varchar, @w_error) + ' ERROR GENERANDO BCP '
               +
                      @w_comando
    print @w_msg
    goto ERRORFIN
  end

  return 0

  ERRORFIN:

  exec cob_ahorros..sp_errorlog
    @i_fecha       = @w_fecha_batch,
    @i_error       = @w_error,
    @i_usuario     = 'batch',
    @i_tran        = 4256,
    @i_descripcion = @w_msg,
    @i_programa    = @w_sp_name

  return @w_error

go

