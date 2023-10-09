/************************************************************************/
/*   Archivo:             batch_negocio_msv.sp                          */
/*   Stored procedure:    sp_batch_negocio_msv                          */
/*   Base de datos:       cob_cartera                                   */
/*   Producto:            Credito y Cartera                             */
/*   Disenado por:        Ricardo Reyes                                 */
/*   Fecha de escritura:  Abr. 2013                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
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
/*                          PROPOSITO                                   */
/*   Procedimiento que realiza la validacion de Negocio                 */
/************************************************************************/
/*                              CAMBIOS                                 */
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
           where  name = 'sp_batch_negocio_msv')
  drop proc sp_batch_negocio_msv
go

create proc sp_batch_negocio_msv
  @i_param1       varchar(255) = null,
  @i_param2       varchar(255) = null,
  @i_param3       varchar(255) = null,
  @i_param4       varchar(255) = null,
  @i_param5       varchar(255) = null,
  @i_param6       varchar(255) = null,
  @s_ssn          int = null,
  @s_sesn         int = null,
  @s_date         datetime = null,
  @s_ofi          smallint = null,
  @s_user         login = null,
  @s_rol          smallint = null,
  @s_term         varchar(30) = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @i_debug        char(1) = 'N',
  @s_org          char(1) = null,
  @t_show_version bit = 0
as
  declare
    @w_sp_name       char(30),
    @w_return        int,
    @w_a_procesar    int,
    @w_cont          int,
    @i_hijo          varchar(2),
    @i_sarta         int,
    @i_batch         int,
    @i_opcion        char(1),
    @i_bloque        int,
    @i_tipo_trn      char(1),
    @w_est_novigente tinyint,
    @w_reg_loop      tinyint,
    @w_ciclo         char(1),
    @w_hora_msv      varchar(5),
    @w_hora_fin      varchar(5),
    @w_min_fin       varchar(5),
    @w_cedula        numero,
    @w_id_carga      int,
    @w_id_Alianza    int,
    @w_descripcion   varchar(255),
    @w_max_sec       int,
    @w_fecha_hoy     datetime

  select
    @w_sp_name = 'sp_batch_negocio_msv'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_param1 is not null
    select
      @i_hijo = convert(varchar(2), rtrim(ltrim(@i_param1))),
      @i_sarta = convert(int, rtrim(ltrim(@i_param2))),
      @i_batch = convert(int, rtrim(ltrim(@i_param3))),
      @i_opcion = convert(char(1), rtrim(ltrim(@i_param4))),
      @i_bloque = convert(int, rtrim(ltrim(@i_param5))),
      @i_tipo_trn = convert(char(1), rtrim(ltrim(@i_param6))),
      @w_ciclo = 'S',
      @w_descripcion = 'Error No controlado Hijo: ' + @i_param1 + ' Sarta: ' +
                       @i_param2 + ' Batch: ' +
                       @i_param3

  select
    @w_fecha_hoy = getdate()

  -- Eliminacion cobis..ba_log 
  delete cobis..ba_log
  where  lo_sarta                                  = @i_sarta
     and lo_batch                                  = @i_batch
     and datediff(dd,
                  lo_fecha_inicio,
                  @w_fecha_hoy) = 0
     and lo_intento                                > 1

  if @i_opcion = 'G'
  begin -- generar universo
    ---------- ELIMINACION DE ARHIVOS DE CARPETA OUTDIR ------------------------------------------------------------------
    if @i_hijo = '0'
    begin -- Se ejecuta solo para el primer hijo
      exec @w_return = cobis..sp_elim_msv_outdir
        @i_sarta       = @i_sarta,
        @i_batch       = @i_batch,
        @o_descripcion = @w_descripcion out

      if @w_return <> 0
      begin
        exec cobis..sp_error_proc_masivos
          @i_id_carga       = @w_id_carga,
          @i_id_alianza     = @w_id_Alianza,
          @i_referencia     = 'No_Id',
          @i_tipo_proceso   = 'C',
          @i_procedimiento  = 'sp_batch_clientes_msv',
          @i_codigo_interno = 0,
          @i_codigo_err     = 999999,
          @i_descripcion    = @w_descripcion

      end
    end

    ---------- GENERAR UNIVERSO ------------------------------------------------------------------------------------------
    delete cl_universo_negocio_msv
    where  ub_tipo_tra = @i_tipo_trn

    select
      @w_max_sec = max(sb_secuencial) + 1
    from   cobis..ba_sarta_batch
    where  sb_sarta = @i_sarta

    select
      @w_reg_loop = 2
    while @w_reg_loop < @w_max_sec
    begin
      insert into cl_universo_negocio_msv
      values      ('Negocio',convert(char(1), @w_reg_loop),0,@i_tipo_trn)
      select
        @w_reg_loop = @w_reg_loop + 1
    end

    delete cobis..ba_ctrl_ciclico
    where  ctc_sarta = @i_sarta

    insert into cobis..ba_ctrl_ciclico
      select
        sb_sarta,sb_batch,sb_secuencial,'S','P'
      from   cobis..ba_sarta_batch with (nolock)
      where  sb_sarta = @i_sarta
         and sb_batch = @i_batch

    return 0

  end

  --- OPCION QUE SE EJECUTARA SOLO SI EL PROCESO ES EL BATCH MASIVO (NO PARA FECHA VALOR)   
  if @i_opcion = 'B'
  begin --procesos batch
    select
      @w_cont = count(*)
    from   cl_universo_negocio_msv with (nolock)
    where  ub_estado   = @i_hijo
       and ub_intentos < 2
       and ub_tipo_tra = @i_tipo_trn

    select
      @w_cont = @i_bloque - @w_cont

    if @w_cont < 0
      select
        @w_cont = @i_bloque

    if @w_cont > 0
    begin
      set rowcount @w_cont

      update cl_universo_negocio_msv with (rowlock)
      set    -- select * from cl_universo_negocio_msv 
      ub_estado = @i_hijo
      where  ub_estado   = 'N'
         and ub_intentos < 2
         -- controlar que un cliente se intente procesar 2 veces
         and ub_negocio  <> 'Negocio'
         and ub_tipo_tra = @i_tipo_trn

      if @@error <> 0
        return 710001

      set rowcount 0

    end

    update cobis..ba_ctrl_ciclico with (rowlock)
    set    ctc_estado = 'P'
    where  ctc_sarta      = @i_sarta
       and ctc_batch      = @i_batch
       and ctc_secuencial = @i_hijo

    --- CONTROL DE TERMINACION DE PROCESO 
    if not exists(select
                    1
                  from   cl_universo_negocio_msv with (nolock)
                  where  ub_estado   = @i_hijo
                     and ub_intentos < 2)
    begin
      update cobis..ba_ctrl_ciclico with (rowlock)
      set    ctc_procesar = 'N'
      where  ctc_sarta      = @i_sarta
         and ctc_batch      = @i_batch
         and ctc_secuencial = @i_hijo

      if @@error <> 0
        return 710002
    end
  end

  --insert into cobis..control_msv values ('00_1. Hora Sys: ' + CONVERT(varchar(50), getdate(), 109) + '-sp_batch_negocio_msv'+@i_tipo_trn )

  --SET TRANSACTION ISOLATION LEVEL SNAPSHOT   

  --- EJECUCION DEL PROCESO BATCH 
  exec @w_return = sp_batch_negocio_msv_1
    @s_ssn        = @s_ssn,
    @s_sesn       = @s_sesn,
    @s_srv        = @s_srv,
    @s_lsrv       = @s_lsrv,
    @s_user       = @s_user,
    @s_date       = @s_date,
    @s_ofi        = @s_ofi,
    @s_rol        = @s_rol,
    @s_term       = @s_term,
    @i_hijo       = @i_hijo,
    @i_debug      = @i_debug,
    @i_bloque     = @i_bloque,
    @i_tipo_trn   = @i_tipo_trn,
    @o_ciclo      = @w_ciclo out,
    @o_id_carga   = @w_id_carga out,
    @o_id_Alianza = @w_id_Alianza out,
    @o_cedula     = @w_cedula out

  if @@error <> 0
      or isnull(@w_return,
                0) <> 0
  begin
    select
      @w_id_carga = isnull(@w_id_carga,
                           0),
      @w_id_Alianza = isnull(@w_id_Alianza,
                             0),
      @w_cedula = isnull(@w_cedula,
                         '')

    if isnull(@w_return,
              0) <> 0
    begin
      select
        @w_descripcion = 'Error: ' + 'Cod.Error:' + cast(isnull( @w_return, 0)
                         as
                                varchar) + ' Hijo:' +
                                @i_param1
                         + ' Sarta: ' + @i_param2 + ' Batch: ' + @i_param3
      select
        @w_descripcion = @w_descripcion + '. - ' + mensaje
      from   cobis..cl_errores
      where  numero = @w_return
    end

    exec cobis..sp_error_proc_masivos
      @i_id_carga       = @w_id_carga,
      @i_id_alianza     = @w_id_Alianza,
      @i_referencia     = @w_cedula,
      @i_tipo_proceso   = 'C',
      @i_procedimiento  = 'sp_batch_negocio_msv_1',
      @i_codigo_interno = 0,
      @i_codigo_err     = 999999,
      @i_descripcion    = @w_descripcion

    select
      @w_hora_fin = case
                      when len(convert(varchar(2), datepart(hh,
                                                            getdate()))) = 1
                    then
                      '0' + convert(varchar(2), datepart(hh, getdate()))
                      else convert(varchar(2), datepart(hh,
                                                        getdate()))
                    end,
      @w_min_fin = case
                     when len(convert(varchar(2), datepart(mi,
                                                           getdate()))) = 1 then
                     '0' + convert(varchar(2), datepart(mi, getdate()))
                     else convert(varchar(2), datepart(mi,
                                                       getdate()))
                   end

    select
      @w_hora_msv = @w_hora_fin + ':' + @w_min_fin

    update cobis..cl_parametro
    set    pa_char = @w_hora_msv
    where  pa_nemonico = 'HFINMS'
       and pa_producto = 'MIS'

    delete cl_universo_negocio_msv
    where  ub_tipo_tra = @i_tipo_trn
       and ub_estado   = @i_hijo
  end

  if @i_opcion = 'B'
  begin -- Validacion para marcacion de todos los hilos como finalizados   
    if @w_ciclo = 'N'
    begin -- Si ha llegado la hora de finalizar los masivos.
      -- insert into cobis..control_msv values ('00_2. Hora Sys: ' + CONVERT(varchar(50), getdate(), 109) + '-sp_batch_negocio_msv'+  'hijo:'+convert( varchar(20), @i_hijo)  )

      delete cl_universo_negocio_msv
      where  ub_estado = @i_hijo

      update cobis..ba_ctrl_ciclico with (rowlock)
      set    ctc_estado = 'F'
      where  ctc_sarta      = @i_sarta
         and ctc_batch      = @i_batch
         and ctc_secuencial = @i_hijo

      if @@error <> 0
        return 710002
    end
  end

  return @w_return

go

