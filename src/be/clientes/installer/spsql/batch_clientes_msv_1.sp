/************************************************************************/
/*   Archivo:             batch_clientes_msv_1.sp                       */
/*   Stored procedure:    sp_batch_clientes_msv_1                       */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Credito y Cartera                             */
/*   Disenado por:        Ricardo Reyes                                 */
/*   Fecha de escritura:  Feb. 2013                                     */
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
/*   Procedimiento que realiza la creaci¢n masiva clientes              */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA              AUTOR             CAMBIOS                    */
/*    May/02/2016     DFu             Migracion CEN                     */
/************************************************************************/
use cobis
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_batch_clientes_msv_1')
  drop proc sp_batch_clientes_msv_1
go

create proc sp_batch_clientes_msv_1
  @i_param1       varchar(255) = null,
  @i_param2       varchar(255) = null,
  @i_param3       varchar(255) = null,
  @i_param4       varchar(255) = null,
  @i_param5       varchar(255) = null,
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_date         datetime = null,
  @s_ofi          smallint = null,
  @s_user         login = null,
  @s_rol          smallint = null,
  @s_term         varchar(30) = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @t_show_version bit = 0,
  @i_hijo         varchar(2) = null,
  @i_debug        char(1) = 'N',
  @i_bloque       int = null,
  @o_ciclo        char(1) = null out,
  @o_id_carga     int = null out,
  @o_id_Alianza   int = null out,
  @o_cedula       numero = null out
as
  declare
    @w_error           int,
    @w_sp_name         varchar(64),
    @w_commit          char(1),
    @w_cedula          numero,
    @w_detener_proceso char(1),
    @w_est_novigente   tinyint,
    @w_est_vigente     tinyint,
    @w_formato_fecha   int,
    @w_tipo_ced        varchar(24),
    @w_return          int,
    @w_id_carga        int,
    @w_id_Alianza      int,
    @w_descripcion     varchar(255),
    @w_hora_msv        varchar(5),
    @w_hora_fin        tinyint,
    @w_min_fin         tinyint,
    @w_pendientes      int,
    @w_error_ext       int,
    @w_retorno_ext     varchar(255),
    @w_exec            varchar(8),
    @w_hilo_wait       int,
    @w_bandera_seg     varchar(30),
    @w_descrip_seguim  varchar(255)

  select
    @w_sp_name = 'sp_batch_clientes_msv_1'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* CARGADO DE VARIABLES DE TRABAJO */
  select
    @s_user = isnull(@s_user,
                     suser_name()),
    @s_term = isnull(@s_term,
                     'BATCH_CLIENTES_MASIVOS'),
    @w_commit = 'N',
    @w_formato_fecha = 101,
    @w_detener_proceso = 'N',
    @w_return = 0,
    @w_pendientes = 0

  select
    @w_bandera_seg = pa_char
  from   cobis..cl_parametro
  where  pa_nemonico = 'SEGMSV'
     and pa_producto = 'MIS'

  while @w_detener_proceso = 'N'
  begin
    /* Parametro General */
    select
      @w_hora_msv = pa_char
    from   cobis..cl_parametro
    where  pa_nemonico = 'HFINMS'
       and pa_producto = 'MIS'

    select
      @w_hora_fin = convert(tinyint, substring(@w_hora_msv,
                                               1,
                                               2))
    select
      @w_min_fin = convert(tinyint, substring(@w_hora_msv,
                                              4,
                                              2))

    select
      @w_pendientes = count(1)
    from   cobis..cl_universo_msv with (nolock)
    where  ub_estado = @i_hijo
       and ub_cedula <> '9999999999'

    if datepart(hh,
                getdate()) > @w_hora_fin
        or (datepart(hh,
                     getdate()) = @w_hora_fin
            and datepart(mi,
                         getdate()) >= @w_min_fin)
    begin
      --insert into control_msv values('Hora Sys: ' + CONVERT(varchar(2),datepart(hh,getdate())) + ' - Minu Sys: ' + CONVERT(varchar(2),datepart(mi,getdate())))  
      set rowcount 0
      delete cobis..cl_universo_msv
      where  ub_estado = @i_hijo
      select
        @o_ciclo = 'N'
      break
    end
    if @w_pendientes = 0
    begin
      select
        @w_detener_proceso = 'N'

      -- Proceso para esperar un tiempo diferente para que cada hilo genere su universo  
      select
        @w_hilo_wait = convert(int, isnull(@i_hijo,
                                           '1')) - 1
      if @w_hilo_wait < 1
          or @w_hilo_wait > 59
          or @w_hilo_wait is null
        select
          @w_hilo_wait = 1
      if @w_hilo_wait >= 1
         and @w_hilo_wait <= 9
        select
          @w_exec = '00:00:0' + convert(char(1), @w_hilo_wait )
      else
        select
          @w_exec = '00:00:' + convert(char(2), @w_hilo_wait )
      waitfor delay @w_exec

      delete cl_universo_msv
      where  ub_estado = 'P'

      set rowcount @i_bloque

      insert into cl_universo_msv
        select
          mc_cedula,mc_id_carga,mc_id_Alianza,@i_hijo,0,
          mc_tipo_ced
        from   cobis..cl_msv_crear with (nolock)
        where  mc_cedula not in (select
                                   ub_cedula
                                 from   cl_universo_msv with (nolock))
        order  by mc_cedula

      select
        @w_pendientes = @@rowcount,
        @o_ciclo = 'S'

      set rowcount 0

      -- DETIENE EL PROCESO 15 SEGUNDOS DEBIDO A QUE NO HAY PENDIENTES.  
      if @w_pendientes = 0
        break -- waitfor delay '00:00:15'  
    --insert into control_msv values('Pendientes 2 : ' + CONVERT(varchar(3),@w_pendientes))         
    end

    set rowcount 0

    if @w_pendientes > 0
    begin
      --insert into control_msv values('Pendientes 3: ' + CONVERT(varchar(3),@w_pendientes))  
      select
        @o_id_carga = 0,
        @o_id_Alianza = 0,
        @o_cedula = '',
        @w_return = 0

      set rowcount 1
      select
        @w_cedula = ub_cedula,
        @w_id_carga = ub_id_carga,
        @w_id_Alianza = ub_id_Alianza,
        @w_tipo_ced = ub_tipo_ced,
        --                @w_detener_proceso = ub_estado,  
        -- Variables de Salida en caso de error  
        @o_id_carga = ub_id_carga,
        @o_id_Alianza = ub_id_Alianza,
        @o_cedula = ub_cedula
      from   cobis..cl_universo_msv with (nolock)
      where  ub_estado   = @i_hijo
         and ub_intentos < 2
         and ub_cedula   <> '9999999999'
         and ub_estado   <> 'P'

      select
        @w_error = 0,
        @w_error_ext = 0,
        @w_retorno_ext = ''
      set rowcount 0

      update cl_universo_msv with (rowlock)
      set    ub_intentos = ub_intentos + 1,
             ub_estado = 'P'
      where  ub_cedula     = @w_cedula
         and ub_estado     = @i_hijo
         and ub_id_carga   = @w_id_carga
         and ub_id_Alianza = @w_id_Alianza
         and ub_tipo_ced   = @w_tipo_ced

      if @w_bandera_seg = 'S'
      begin
        select
          @w_descrip_seguim = 'Cedula: ' + isnull(@w_cedula, '') + ' Tipo_id: '
                              +
                              isnull
                              (
                                     @w_tipo_ced, '')
        if @w_id_carga is not null
          select
          @w_descripcion = @w_descrip_seguim + ' Carga: ' + convert( varchar(20)
                           ,
                           @w_id_carga
            )
        if @w_id_carga is not null
          select
            @w_descripcion = @w_descrip_seguim + ' Alianza : ' + convert(
                             varchar(
                             30
                             ),
                             @w_id_Alianza
                             )

        select
          @w_descrip_seguim = @w_descrip_seguim + 'ANTES MSV CLIENTES.'

        print '01. segumiento CLI MSV: ' + @w_descrip_seguim

        insert into cobis..cl_error_log
                    (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                     er_descripcion)
        values      ( getdate(),null,'msv_c1',null,null,
                      @w_descrip_seguim )

      end

      exec @w_return = cobis..sp_msv_clientes
        @i_id_carga    = @w_id_carga,
        @i_id_alianza  = @w_id_Alianza,
        @i_tipo_ced    = @w_tipo_ced,
        @i_ced_ruc     = @w_cedula,
        @i_hijo        = @i_hijo,
        @o_error_ext   = @w_error_ext out,
        @o_retorno_ext = @w_retorno_ext out

      if @w_return > 0
          or @@error <> 0
          or @w_error_ext <> 0
      begin
        select
          @w_error = 1
        select
          @w_descripcion = 'Error en generacion masiva de cliente - Id: ' +
                           @w_cedula
        select
          @w_descripcion = @w_descripcion + mensaje
        from   cobis..cl_errores
        where  numero = @w_return
        select
          @w_descripcion = @w_descripcion + ' ' + @w_retorno_ext
        insert into cobis..cl_error_log
                    (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                     er_descripcion)
        values      ( getdate(),null,'msv',null,null,
                      @w_descripcion )

        if @w_bandera_seg = 'S'
        begin
          insert into cobis..cl_error_log
                      (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                       er_descripcion)
          values      ( getdate(),null,'msv_c2',null,null,
                        @w_descrip_seguim )

          print '02. segumiento CLI MSV: ' + @w_descrip_seguim

        end

      --insert into control_msv values('Pendientes 4: Return ' + CONVERT(varchar(8),@w_return))  
      end
      else
      begin
        if @w_bandera_seg = 'S'
        begin
          insert into cobis..cl_error_log
                      (er_fecha_proc,er_error,er_usuario,er_tran,er_cuenta,
                       er_descripcion)
          values      ( getdate(),null,'msv_c3',null,null,
                        @w_descrip_seguim )

          print '03. segumiento CLI MSV: ' + @w_descrip_seguim

        end

        insert into cobis..cl_msv_proc
                    (mp_id_carga,mp_id_Alianza,mp_ofi,mp_nombre,mp_p_apellido,
                     mp_s_apellido,mp_sexo,mp_fecha_nac,mp_tipo_ced,mp_cedula,
                     mp_ciudad_nac,mp_lugar_doc,mp_estado_civil,mp_actividad,
                     mp_fecha_emision,
                     mp_sector,mp_tipo_productor,mp_regimen_fiscal,mp_antiguedad
                     ,
                     mp_estrato,
                     mp_recurso_pub,mp_influencia,mp_persona_pub,mp_victima,
                     mp_descripcion,
                     mp_tipo,mp_principal,mp_ciudad,mp_rural_urb,mp_observacion,
                     mp_valor,mp_tipo_telefono,mp_origen_fondos,
                     mp_mercado_objetivo,
                     mp_subtipo_mo,
                     mp_banca,mp_segmento,mp_subsegmento,mp_fecha_proc,mp_hilo)
          select
            mc_id_carga,mc_id_Alianza,mc_ofi,mc_nombre,mc_p_apellido,
            mc_s_apellido,mc_sexo,mc_fecha_nac,mc_tipo_ced,mc_cedula,
            mc_ciudad_nac,mc_lugar_doc,mc_estado_civil,mc_actividad,
            mc_fecha_emision
            ,
            mc_sector,mc_tipo_productor,mc_regimen_fiscal,mc_antiguedad,
            mc_estrato,
            mc_recurso_pub,mc_influencia,mc_persona_pub,mc_victima,
            mc_descripcion,
            mc_tipo,mc_principal,mc_ciudad,mc_rural_urb,mc_observacion,
            mc_valor,mc_tipo_telefono,mc_origen_fondos,mc_mercado_objetivo,
            mc_subtipo_mo
            ,
            mc_banca,mc_segmento,mc_subsegmento,getdate(),@i_hijo
          from   cobis..cl_msv_crear with (nolock)
          where  mc_cedula     = @w_cedula
             and mc_tipo_ced   = @w_tipo_ced
             and mc_id_Alianza = @w_id_Alianza
             and mc_id_carga   = @w_id_carga

        if @@rowcount > 0
        begin
          if not exists (select
                           1
                         from   cobis..cl_msv_crear with (nolock)
                         where  mc_id_carga = @w_id_carga)
            update cob_externos..ex_msv_clientes
            set    mc_estado = 'F'
            where  mc_id_carga = @w_id_carga
        --insert into control_msv values('Pendientes 5: Carga ' + CONVERT(varchar(8),@w_id_carga))  
        end
        else
        begin
          select
            @w_error = 1
          select
            @w_descripcion = isnull(@w_descripcion, '') +
            '.Error en Insercion en cl_msv_proc de cliente - Id: '
            + '. TipoCed:' + @w_tipo_ced + '. Alianza:' + convert(
            varchar(
                                    20), @w_id_Alianza) +
            '. carga:'
            + cast (isnull(@w_id_carga, 0) as varchar) + '. hijo:'
            +
            isnull
                                    (@i_hijo, '')
        --insert into control_msv values('Pendientes 6: @w_cedula ' + CONVERT(varchar(22),@w_cedula))  
        end
      end

      insert into cl_msv_crear_his
                  (mc_id_carga,mc_id_Alianza,mc_ofi,mc_nombre,mc_p_apellido,
                   mc_s_apellido,mc_sexo,mc_fecha_nac,mc_tipo_ced,mc_cedula,
                   mc_ciudad_nac,mc_lugar_doc,mc_estado_civil,mc_actividad,
                   mc_fecha_emision,
                   mc_sector,mc_tipo_productor,mc_regimen_fiscal,mc_antiguedad,
                   mc_estrato,
                   mc_recurso_pub,mc_influencia,mc_persona_pub,mc_victima,
                   mc_descripcion,
                   mc_tipo,mc_principal,mc_ciudad,mc_rural_urb,mc_observacion,
                   mc_valor,mc_tipo_telefono,mc_origen_fondos,
                   mc_mercado_objetivo,
                   mc_subtipo_mo,
                   mc_banca,mc_segmento,mc_subsegmento,mc_fecha_ingreso)
        select
          mc_id_carga,mc_id_Alianza,mc_ofi,mc_nombre,mc_p_apellido,
          mc_s_apellido,mc_sexo,mc_fecha_nac,mc_tipo_ced,mc_cedula,
          mc_ciudad_nac,mc_lugar_doc,mc_estado_civil,mc_actividad,
          mc_fecha_emision
          ,
          mc_sector,mc_tipo_productor,mc_regimen_fiscal,mc_antiguedad,
          mc_estrato,
          mc_recurso_pub,mc_influencia,mc_persona_pub,mc_victima,mc_descripcion,
          mc_tipo,mc_principal,mc_ciudad,mc_rural_urb,mc_observacion,
          mc_valor,mc_tipo_telefono,mc_origen_fondos,mc_mercado_objetivo,
          mc_subtipo_mo
          ,
          mc_banca,mc_segmento,mc_subsegmento,getdate()
        from   cobis..cl_msv_crear with (nolock)
        where  mc_cedula     = @w_cedula
           and mc_tipo_ced   = @w_tipo_ced
           and mc_id_Alianza = @w_id_Alianza
           and mc_id_carga   = @w_id_carga

      if @@error <> 0
      begin
        select
          @w_error = 1
        select
          @w_descripcion = isnull(@w_descripcion, '')
                           +
          ' Error en copia de seguimiento cl_msv_crear_seg de cliente - Id: ' +
                           @w_cedula
      --insert into control_msv values('001..batch_clientes_msv_1 Pendientes 7: @w_cedula ' + CONVERT(varchar(22),@w_cedula) + ' @i_hijo:'  + @i_hijo)  
      end

      delete cl_msv_crear
      where  mc_cedula     = @w_cedula
         and mc_tipo_ced   = @w_tipo_ced
         and mc_id_Alianza = @w_id_Alianza
         and mc_id_carga   = @w_id_carga

      if @@error <> 0
      begin
        select
          @w_error = 1
        select
          @w_descripcion = isnull(@w_descripcion, '') +
                           ' Error en Borrado de cl_msv_crear de cliente - Id: '
                           + @w_cedula
      --insert into control_msv values('001..batch_clientes_msv_1 Pendientes 7: @w_cedula ' + CONVERT(varchar(22),@w_cedula) + ' @i_hijo:'  + @i_hijo)  
      end

      if @w_error = 1
      begin -- REPORTAR ERRORES  
        select
          @w_cedula = @w_cedula + '-' + @w_tipo_ced
        exec cobis..sp_error_proc_masivos -- sp_helpcode sp_error_proc_masivos  
          @i_id_carga       = @w_id_carga,
          @i_id_alianza     = @w_id_Alianza,
          @i_referencia     = @w_cedula,
          @i_tipo_proceso   = 'C',
          @i_procedimiento  = 'sp_batch_clientes_msv_1',
          @i_codigo_interno = 0,
          @i_codigo_err     = @w_return,
          @i_descripcion    = @w_descripcion
      end
      select
        @w_pendientes = @w_pendientes - 1
      --insert into control_msv values('Pendientes 8: ' + CONVERT(varchar(3),@w_pendientes))  

      if @w_pendientes <= 0
      begin
        select
          @o_ciclo = 'S'
        --insert into control_msv values('Pendientes 9: ' + CONVERT(varchar(3),@w_pendientes))  
        break
      end
    end
  end

  return 0

go

