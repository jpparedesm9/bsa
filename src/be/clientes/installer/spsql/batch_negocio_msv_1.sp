/************************************************************************/
/*   Archivo:             batch_negocio_msv_1.sp                        */
/*   Stored procedure:    sp_batch_negocio_msv_1                        */
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
/*   Procedimiento que realiza la a validacion de Negocio               */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA              AUTOR           CAMBIOS                      */
/*    May/02/2016          DFu             Migracion CEN                */
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
           where  name = 'sp_batch_negocio_msv_1')
  drop proc sp_batch_negocio_msv_1
go

create proc sp_batch_negocio_msv_1
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
  @i_hijo         varchar(2) = null,
  @i_debug        char(1) = 'N',
  @i_bloque       int = 0,
  @i_tipo_trn     char(1) = null,
  @t_show_version bit = 0,
  @o_ciclo        char(1) = null out,
  @o_id_carga     int = null out,
  @o_id_Alianza   int = null out,
  @o_cedula       numero = null out
as
  declare
    @w_error           int,
    @w_sp_name         varchar(64),
    @w_commit          char(1),
    @w_detener_proceso char(1),
    @w_formato_fecha   int,
    @w_return          int,
    @w_descripcion     varchar(255),
    @w_hora_msv        varchar(5),
    @w_hora_fin        tinyint,
    @w_min_fin         tinyint,
    @w_pendientes      int,
    @w_negocio         varchar(24),
    @w_exec            varchar(8),
    @w_hilo_wait       int,
    @w_error_sist      int

  select
    @w_sp_name = 'sp_batch_negocio_msv_1'

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

  --insert into control_msv values('00_1. Hora Sys: ' + CONVERT(varchar(50), getdate(), 109) + ' ciclo='+ @o_ciclo )

  while @w_detener_proceso = 'N'
  begin
    /* Parametro General */
    select
      @w_hora_msv = pa_char
    from   cobis..cl_parametro with (nolock)
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
    from   cl_universo_negocio_msv with (nolock)
    where  ub_estado  = @i_hijo
       and ub_negocio <> 'Negocio'

    if datepart(hh,
                getdate()) > @w_hora_fin
        or (datepart(hh,
                     getdate()) = @w_hora_fin
            and datepart(mi,
                         getdate()) >= @w_min_fin)
    begin
      --insert into control_msv values('02. Hora Sys: ' + CONVERT(varchar(50), getdate(), 109) + ' ciclo='+ @o_ciclo )
      set rowcount 0
      delete cobis..cl_universo_negocio_msv
      where  ub_estado   = @i_hijo
         and ub_tipo_tra = @i_tipo_trn
      select
        @o_ciclo = 'N'
      break
    end

    if @w_pendientes = 0
    begin
      select
        @w_detener_proceso = 'N'

      -- WAIT PARA QUE LOS HILOS NO SE EJECUTEN AL MISMO TIEMPO
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

      delete cobis..cl_universo_negocio_msv
      where  ub_estado   = 'P'
         and ub_tipo_tra = @i_tipo_trn

      set rowcount @i_bloque

      select
        @i_tipo_trn = 'C'
      ----> Clientes
      if exists (select
                   1
                 from   cob_externos..ex_msv_clientes with (nolock)
                 where  mc_estado = 'E')
      begin
        select
          @i_tipo_trn = 'C'
        insert into cobis..cl_universo_negocio_msv
        values      ('Negocio',@i_hijo,0,@i_tipo_trn)
        select
          @w_pendientes = @@rowcount
      end

      ----> Tramites Unificaciones / Utilizaciones
      if @w_pendientes = 0
      begin
        if exists (select
                     1
                   from   cob_externos..ex_msv_tramites_u with (nolock)
                   where  mtu_estado = 'E')
        begin
          select
            @i_tipo_trn = 'U'
          insert into cobis..cl_universo_negocio_msv
          values      ('Negocio',@i_hijo,0,@i_tipo_trn)
          select
            @w_pendientes = @@rowcount
        end
      end

      ----> Tramites Cupos
      if @w_pendientes = 0
      begin
        if exists (select
                     1
                   from   cob_externos..ex_msv_tramites_cupo with (nolock)
                   where  mtc_estado = 'E')
        begin
          select
            @i_tipo_trn = 'P'
          insert into cobis..cl_universo_negocio_msv
          values      ('Negocio',@i_hijo,0,@i_tipo_trn)
          select
            @w_pendientes = @@rowcount
        end
      end

      ----> Tramites Originales
      if @w_pendientes = 0
      begin
        if exists (select
                     1
                   from   cob_externos..ex_msv_tramites_orig with (nolock)
                   where  mto_estado = 'E')
        begin
          select
            @i_tipo_trn = 'O'
          insert into cobis..cl_universo_negocio_msv
          values      ('Negocio',@i_hijo,0,@i_tipo_trn)
          select
            @w_pendientes = @@rowcount
        end
      end

      -- SI NO HAY PENDIENTES, SE ESPERA 15 SEGUNDOS PARA NO HACER CONSULTAS A LA BD
      if @w_pendientes = 0
        break -- waitfor delay "00:00:15"

      select
        @o_ciclo = 'S'
    end

    if @w_pendientes > 0
    begin
      set rowcount 1
      select
        @w_negocio = ub_negocio,
        @w_detener_proceso = ub_estado
      from   cobis..cl_universo_negocio_msv with (nolock)
      where  ub_estado   = @i_hijo
         and ub_intentos < 2
         and ub_negocio  <> 'Negocio'
         and ub_estado   <> 'P'
         and ub_tipo_tra = @i_tipo_trn

      select
        @w_pendientes = @@rowcount,
        @w_error = 0
      set rowcount 0

      update cobis..cl_universo_negocio_msv with (rowlock)
      set    ub_intentos = ub_intentos + 1,
             ub_estado = 'P'
      where  ub_negocio  <> 'Negocio'
         and ub_estado   = @i_hijo
         and ub_tipo_tra = @i_tipo_trn

      select
        @w_error_sist = 0

      if @i_tipo_trn = 'C'
      begin -- Clientes
        exec @w_return = cobis..sp_msv_valida_neg
          @i_bloque = @i_bloque
        select
          @w_error_sist = @@error
      end

      if @i_tipo_trn = 'U'
      begin -- Tramites Unificaciones / Utilizaciones
        exec @w_return = cob_credito..sp_cr_msv_u
          @i_bloque = @i_bloque
        select
          @w_error_sist = @@error
      end

      if @i_tipo_trn = 'P'
      begin -- Tramites Cupos
        exec @w_return = cob_credito..sp_valida_cupo_masivo
          @i_bloque = @i_bloque
        select
          @w_error_sist = @@error
      end

      if @i_tipo_trn = 'O'
      begin -- Tramites Originales
        exec @w_return = cob_credito..sp_msv_orig
          @i_bloque = @i_bloque
        select
          @w_error_sist = @@error
      end

      if @w_return > 0
          or @w_error_sist <> 0
      begin
        select
          @w_descripcion =
          ' Error en ejecucion de validacion de negocio masiva de '
          +
          (
                 case
                 when
                                  @i_tipo_trn = 'C' then 'Clientes'
                 when
                                  @i_tipo_trn = 'U' then
                 'Tramites Utilizaciones / Unificaciones'
                                 when @i_tipo_trn = 'P' then
                                 'Tramites Cupos'
                                 when @i_tipo_trn = 'O' then
                                 'Tramites Originales '
                                 else ''
                               end)
        select
          @w_descripcion = @w_descripcion + isnull(mensaje, '')
        from   cobis..cl_errores with (nolock)
        where  numero = @w_return
        exec cobis..sp_error_proc_masivos
          @i_id_carga       = 0,
          @i_id_alianza     = 0,
          @i_referencia     = 'Negocio',
          @i_tipo_proceso   = ub_tipo_tra,
          @i_procedimiento  = 'sp_batch_negocio_msv_1',
          @i_codigo_interno = 0,
          @i_codigo_err     = @w_return,
          @i_descripcion    = @w_descripcion
      end
      select
        @w_pendientes = @w_pendientes - 1

      if @w_pendientes <= 0
      begin
        select
          @o_ciclo = 'S'
        break
      end
    end -- if @w_pendientes > 0 

  end -- while 

  return 0

go

