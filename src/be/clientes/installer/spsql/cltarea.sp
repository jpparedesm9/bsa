/************************************************************************/
/*  Archivo:            cltarea.sp                                      */
/*  Stored procedure:   sp_tarea                                        */
/*  Base de datos:      cobis                                           */
/*  Producto:           MIS                                             */
/*  Disenado por:       Gabriel Alvis                                   */
/*  Fecha de escritura: 28/Mar/2011                                     */
/************************************************************************/
/*                           IMPORTANTE                                 */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de 'COBISCorp'.                                                     */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                           PROPOSITO                                  */
/*  Administración (Ingreso / Actualización / Consulta) de tareas       */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*  FECHA         AUTOR             RAZON                               */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN                */
/************************************************************************/

use cobis
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

if object_id('sp_tarea') is not null
  drop proc sp_tarea
go

create proc sp_tarea
  @s_date           datetime = null,
  @t_debug          char(1) = null,
  @t_file           varchar(10) = null,
  @t_show_version   bit = 0,
  @i_operacion      char(1),
  @i_user           login = null,
  @i_tipo           catalogo = null,
  @i_ente           int = null,
  @i_fecha_proc     datetime = null,
  @i_secuencial_prd int = null,
  @i_codigo_prd     varchar(30) = null,
  @i_producto       tinyint = null,
  @i_modo           tinyint = null,
  @i_tarea          int = null,
  @i_creador        login = null,
  @i_resultado      catalogo = null,
  @i_motivo_cierre  catalogo = null,
  @i_canal          catalogo = null,
  @i_formato_fecha  tinyint = 101,
  @o_tarea          int = null out
as
  declare
    @w_sp_name            varchar(32),
    @w_error              int,
    @w_tabla_destino      int,
    @w_tabla_ttarea       int,
    @w_tabla_canal        int,
    @w_msg                varchar(255),
    @w_tipo_tarea         catalogo,
    @w_ente               int,
    @w_ced_ruc            numero,
    @w_nomlar             varchar(255),
    @w_sec_prod           int,
    @w_fecha_reg          datetime,
    @w_horas_proceso      int,
    @w_fecha_reg_fmt      varchar(10),
    @w_fecha_real         datetime,
    @w_fecha_hora_proceso datetime,
    @w_toperacion         catalogo,
    @w_monto              money,
    @w_destino            descripcion,
    @w_etapa_desc         descripcion,
    @w_estacion_desc      descripcion,
    @w_secuencial         int,
    @w_tarea              int,
    @w_producto           tinyint,
    @w_viable             char(1)
  declare @wt_tarea_detalle table
  (
     campo varchar(64) null,
     valor varchar(255) null
  )

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_sp_name = 'sp_tarea',
    @w_fecha_real = getdate()

  -- INGRESO
  if @i_operacion = 'I'
  begin
    if @i_modo = 0
    begin
      if @i_tipo is null
          or @i_user is null
          or @i_fecha_proc is null
          or @i_creador is null
      begin
        select
          @w_error = 101114
        goto ERROR
      end

      begin tran

      save tran crea_tarea
      -- DETERMINAR EL CODIGO DE LA TAREA
      exec @w_error = sp_cseqnos
        @t_debug     = @t_debug,
        @t_file      = @t_file,
        @t_from      = @w_sp_name,
        @i_tabla     = 'cl_tarea',
        @o_siguiente = @w_secuencial out

      if @w_secuencial is null
      begin
        rollback tran crea_tarea
        commit tran
        goto ERROR
      end

      insert into cl_tarea
                  (ta_tarea,ta_tipo,ta_login,ta_ente,ta_fecha_reg,
                   ta_fecha_real_reg,ta_creador,ta_secuencial_prd,ta_codigo_prd,
                   ta_producto,
                   ta_canal)
      values      ( @w_secuencial,@i_tipo,@i_user,@i_ente,@i_fecha_proc,
                    @w_fecha_real,@i_creador,@i_secuencial_prd,@i_codigo_prd,
                    @i_producto,
                    @i_canal )

      if @@error <> 0
      begin
        rollback tran crea_tarea
        commit tran
        select
          @w_error = 103094
        goto ERROR
      end

      commit tran

      select
        @o_tarea = @w_secuencial
    end

    if @i_modo = 1
    begin
      if @i_tarea is null
      begin
        select
          @w_error = 101114
        goto ERROR
      end

      insert into cl_tarea_detalle
                  (td_tarea,td_cod_campo,td_valor)
        select
          @i_tarea,campo,valor
        from   #detalle_tarea

      if @@error <> 0
      begin
        select
          @w_error = 103095
        goto ERROR
      end
    end
  end

  -- MODIFICACION
  if @i_operacion = 'M'
  begin
    if @i_fecha_proc is null
    begin
      select
        @w_error = 101114
      goto ERROR
    end

    select
      @w_tarea = max(ta_tarea)
    from   cl_tarea
    where  ta_ente     = @i_ente
       and ta_tipo     = @i_tipo
       and ta_producto = @i_producto

    update cl_tarea
    set    ta_resultado = @i_resultado,
           ta_motivo_cierre = @i_motivo_cierre,
           ta_fecha_ejec = @i_fecha_proc,
           ta_fecha_real_ejec = @w_fecha_real,
           ta_secuencial_prd = @i_secuencial_prd
    where  ta_tarea = @w_tarea

    if @@error <> 0
    begin
      select
        @w_error = 103099
      goto ERROR
    end
  end

  -- CONSULTA
  if @i_operacion = 'C'
  begin
    select
      @w_tabla_ttarea = codigo
    from   cl_tabla
    where  tabla = 'cl_tipo_tarea'

    if @i_modo = 0
    begin
      select
        @w_tabla_canal = codigo
      from   cl_tabla
      where  tabla = 'cl_canal'

      select
        @i_tarea = isnull(@i_tarea,
                          0)

      select top(10)
        'Cod Tarea' = ta_tarea,
        'Tipo Tarea' = (select
                          valor
                        from   cl_catalogo
                        where  tabla  = @w_tabla_ttarea
                           and codigo = T.ta_tipo),
        'Cod Cliente' = ta_ente,
        'Ident Cliente' = en_ced_ruc,
        'Nombre Cliente' = en_nomlar,
        'Producto' = (select
                        pd_descripcion
                      from   cl_producto
                      where  pd_producto = T.ta_producto),
        'Fecha Reg' = convert(varchar(10), ta_fecha_reg, @i_formato_fecha),
        'Canal' = (select
                     valor
                   from   cl_catalogo
                   where  tabla  = @w_tabla_canal
                      and codigo = T.ta_canal)
      from   cl_tarea T,
             cl_ente
      where  ta_login = @i_user
         and ta_tipo  = isnull(@i_tipo,
                               ta_tipo)
         and ta_tarea > @i_tarea
         and ta_fecha_ejec is null
         and en_ente  = ta_ente
      order  by ta_tarea

      if @@rowcount = 0
         and @i_tarea = 0
        print 'No existen tareas por realizar para los criterios ingresados'
    end

    if @i_modo = 1
    begin
      select
        @w_tabla_destino = codigo
      from   cl_tabla
      where  tabla = 'cr_destino'

      select
        @w_tipo_tarea = ta_tipo,
        @w_ente = ta_ente,
        @w_ced_ruc = en_ced_ruc,
        @w_nomlar = en_nomlar,
        @w_sec_prod = ta_secuencial_prd,
        @w_fecha_reg = ta_fecha_real_reg
      from   cl_tarea,
             cl_ente
      where  ta_tarea = @i_tarea
         and en_ente  = ta_ente

      -- REFERENCIACION
      if @w_tipo_tarea = 'R'
      begin
        select
          @w_horas_proceso = datediff(hh,
                                      @w_fecha_reg,
                                      @w_fecha_real),
          @w_fecha_reg_fmt = convert(varchar(10), @w_fecha_reg, @i_formato_fecha
                             )

        select
          @w_toperacion = tr_toperacion,
          @w_monto = tr_monto,
          @w_destino = (select
                          valor
                        from   cl_catalogo
                        where  tabla  = @w_tabla_destino
                           and codigo = tr_destino),
          @w_etapa_desc = et_descripcion,
          @w_estacion_desc = es_descripcion
        from   cob_credito..cr_tramite,
               cob_credito..cr_ruta_tramite,
               cob_credito..cr_etapa,
               cob_credito..cr_estacion
        where  tr_tramite  = @w_sec_prod
           and tr_estado in ('N', 'D')
           and rt_tramite  = tr_tramite
           and rt_salida is null
           and et_etapa    = rt_etapa
           and es_estacion = isnull(rt_estacion_sus,
                                    rt_estacion)

        insert into @wt_tarea_detalle
          select
            'Tipo Tarea',valor
          from   cl_catalogo
          where  tabla  = @w_tabla_ttarea
             and codigo = @w_tipo_tarea
        insert into @wt_tarea_detalle
        values      ('Cod Cliente',@w_ente)
        insert into @wt_tarea_detalle
        values      ('Ident Cliente',@w_ced_ruc)
        insert into @wt_tarea_detalle
        values      ('Nombre Cliente',@w_nomlar)
        insert into @wt_tarea_detalle
        values      ('Tramite',convert(varchar(10), @w_sec_prod))
        insert into @wt_tarea_detalle
        values      ('Etapa',@w_etapa_desc)
        insert into @wt_tarea_detalle
        values      ('Estacion',@w_estacion_desc)
        insert into @wt_tarea_detalle
        values      ('Tiempo(h)',@w_horas_proceso)
        insert into @wt_tarea_detalle
        values      ('Fecha Reg',@w_fecha_reg_fmt)
        insert into @wt_tarea_detalle
        values      ('Linea',@w_toperacion)
        insert into @wt_tarea_detalle
        values      ('Monto',@w_monto)
        insert into @wt_tarea_detalle
        values      ('Destino',@w_destino)

        select
          'Campo' = campo,
          'Valor' = valor
        from   @wt_tarea_detalle
      end

      -- CREACION DE TRAMITE
      if @w_tipo_tarea = 'T'
      begin
        insert into @wt_tarea_detalle
          select
            'Tipo Tarea',valor
          from   cl_catalogo
          where  tabla  = @w_tabla_ttarea
             and codigo = @w_tipo_tarea
        insert into @wt_tarea_detalle
        values      ('Cod Cliente',@w_ente)
        insert into @wt_tarea_detalle
        values      ('Ident Cliente',@w_ced_ruc)
        insert into @wt_tarea_detalle
        values      ('Nombre Cliente',@w_nomlar)
        insert into @wt_tarea_detalle
          select
            tc_desc_campo,td_valor
          from   cl_tarea_detalle,
                 cl_tarea_campo
          where  td_tarea     = @i_tarea
             and tc_tipo      = @w_tipo_tarea
             and tc_cod_campo = td_cod_campo

        select
          'Campo' = campo,
          'Valor' = valor
        from   @wt_tarea_detalle
      end
    end
  end

  -- VALIDACION
  if @i_operacion = 'V'
  begin
    select
      @w_producto = 0

    select
      @s_date = isnull(@s_date,
                       fp_fecha)
    from   ba_fecha_proceso

    while 1 = 1
    begin
      select top(1)
        @w_producto = ta_producto
      from   cl_tarea
      where  ta_ente     = @i_ente
         and ta_tipo     = 'R'
         and ta_producto > @w_producto
      order  by ta_producto

      if @@rowcount = 0
        break

      exec @w_error = sp_serv_referenciacion
        @i_ente     = @i_ente,
        @i_producto = @w_producto,
        @o_viable   = @w_viable out

      if @w_error <> 0
        goto ERROR

      if @w_viable in ('N', 'S')
      begin
        exec @w_error = sp_tarea
          @i_operacion     = 'M',
          @i_ente          = @i_ente,
          @i_tipo          = 'R',
          @i_resultado     = @w_viable,
          @i_motivo_cierre = 'R',
          @i_producto      = @w_producto,
          @i_fecha_proc    = @s_date

        if @w_error <> 0
          return @w_error
      end
    end
  end

  return 0

  ERROR:

  if @i_canal <> 'PALM'
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = @w_error,
      @i_msg   = @w_msg
  end

  return @w_error

go

