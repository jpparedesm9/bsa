/************************************************************************/
/*      Archivo:                cl_asocia_actividad.sp                  */
/*      Stored procedure:       sp_asociacion_actividad                 */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           Iván Jiménez                            */
/*      Fecha de escritura:     15/Julio/2005                           */
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
/*      Este programa procesa las operaciones de Creacion, Busqueda,    */
/*      Actualizacion y Seleccion para el mantenimiento de la tabla     */
/*      cl_asociacion_actividad, de los codigos CIIU.                   */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      15/Jul/05       I.Jiménez       Emision Inicial                 */
/*      16/Feb/09       E.Alvarez       Req.001. Separa parametrizacion */
/*                                      Actividades - Banca             */
/*      02/May/16       DFu             Migracion CEN                   */
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
           where  name = 'sp_asociacion_actividad')
  drop proc sp_asociacion_actividad
go

create proc sp_asociacion_actividad
(
  @s_ssn           int = null,
  @s_user          login = null,
  @s_term          varchar(30) = null,
  @s_date          datetime = null,
  @s_srv           varchar(30) = null,
  @s_lsrv          varchar(30) = null,
  @s_ofi           smallint = null,
  @t_debug         char(1) = 'N',
  @t_file          varchar(10) = null,
  @t_from          varchar(32) = null,
  @t_trn           smallint = null,
  @t_show_version  bit = 0,
  @i_modo          tinyint = null,
  @i_operacion     char(1),
  @i_cod_ciiu      catalogo = null,
  @i_tipo_persona  catalogo = null,
  @i_des_ciiu      varchar(255)= null,
  @i_act_general   catalogo = null,
  @i_sector        catalogo = null,
  @i_banca         catalogo = null,
  @i_mercado_ob    catalogo = null,
  @i_subtipo_mo    catalogo = null,
  @i_banca_up      catalogo = null,
  @i_mercado_ob_up catalogo = null,
  @i_subtipo_mo_up catalogo = null,
  @i_tipo          char(1) = 'C',
  @i_asociacion    char(1) = 'A',
  @i_secuencial    int = null
)
as
  declare
    @w_sp_name     varchar(32),
    @w_codigo      int,
    @w_return      int,
    @w_tabla       smallint,
    @w_sector      catalogo,
    @w_banca       catalogo,
    @w_mercado_ob  catalogo,
    @w_subtipo_mo  catalogo,
    @w_des_sector  descripcion,
    @w_des_banca   descripcion,
    @w_des_mercado descripcion,
    @w_des_subtipo descripcion,
    @w_trn         int,
    @w_descripcion varchar(200),
    @w_sec         int

  select
    @w_sp_name = 'sp_asociacion_actividad'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* EAL FEB/2009 REQ.001 */
  if @i_asociacion = 'A'
  begin
    /** Insert **/
    if @i_operacion = 'I'
    begin
      if exists (select
                   aa_actividad
                 from   cl_asociacion_actividad
                 where  aa_actividad   = @i_cod_ciiu
                    and aa_tipo_pers   = @i_tipo_persona
                    and aa_act_general = @i_act_general
                    and aa_banca       = @i_banca
                    and aa_mercado     = @i_mercado_ob)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101186
        /*  'YA existe ese Registro' */
        return 101186
      end
      else
      begin
        /* Inserta datos en cl_asociacion_actividad */
        insert into cl_asociacion_actividad
                    (aa_actividad,aa_tipo_pers,aa_descripcion,aa_act_general,
                     aa_sector
                     ,
                     aa_banca,aa_mercado,aa_subtipo)
        values      ( @i_cod_ciiu,@i_tipo_persona,@i_des_ciiu,@i_act_general,
                      @i_sector
                      ,
                      @i_banca,@i_mercado_ob,@i_subtipo_mo)

        /* Si no se puede Insertar Error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 103016
          /* 'Error en creacion de actividad' */
          return 103016
        end
      end
    end

    /** Update **/
    if @i_operacion = 'U'
    begin
      if not exists (select
                       aa_actividad
                     from   cl_asociacion_actividad
                     where  aa_actividad   = @i_cod_ciiu
                        and aa_tipo_pers   = @i_tipo_persona
                        and aa_act_general = @i_act_general
                        and aa_banca       = @i_banca
                        and aa_mercado     = @i_mercado_ob)
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105506
        /*  'No Existen Registros' */
        return 105506
      end
      else
      begin
        /* Actualiza datos en cl_asociacion_actividad */
        update cl_asociacion_actividad
        set    aa_descripcion = @i_des_ciiu,
               aa_act_general = @i_act_general,
               aa_sector = @i_sector,
               aa_subtipo = @i_subtipo_mo,
               aa_mercado = @i_mercado_ob,
               aa_banca = @i_banca
        from   cl_asociacion_actividad
        where  aa_actividad = @i_cod_ciiu
           and aa_tipo_pers = @i_tipo_persona

        /* Si no se puede Actualizar Error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 105016
          /* 'Error en actualizacion de actividad' */
          return 105016
        end
      end
    end
    /** Delete **/

    if @i_operacion = 'D'
    begin
      if not exists(select
                      1
                    from   cobis..cl_ente
                    where  en_actividad in
                           (select
                              aa_actividad
                            from   cobis..cl_asociacion_actividad)
                           and en_actividad = @i_cod_ciiu
                           and en_subtipo   = @i_tipo_persona)
      begin
        delete from cl_asociacion_actividad
        where  aa_actividad = @i_cod_ciiu
           and aa_tipo_pers = @i_tipo_persona
        /* Si no se puede Eliminar Error */
        if @@error <> 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_msg   = 'ERROR AL ELIMINAR ASOCIACION ACTIVIDAD',
            @i_num   = 107016
          /* 'Error en actualizacion de actividad' */
          return 107016
        end
      end
      else
      begin
        /* Si no se puede Eliminar Error */
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_msg   = 'CLIENTES CON ESTA ACTIVIDAD ASOCIADA',
          @i_num   = 107109
        /* 'Error en actualizacion de actividad' */
        return 107109
      end
    end

    /* transaccion de servicio*/
    if @i_operacion = 'I'
      select
        @w_trn = 1032,
        @w_descripcion = 'CREA ACTIVIDAD'
    else if @i_operacion = 'U'
      select
        @w_trn = 1033,
        @w_descripcion = 'ACTUALIZA ACTIVIDAD'
    else
      select
        @w_trn = 1034,
        @w_descripcion = 'ELIMINA ACTIVIDAD'

    insert into ts_actividad_sector
                (secuencial,tipo_transaccion,fecha,usuario,terminal,
                 srv,lsrv,clase,oficina,actividad,
                 descripcion)
    values      (@s_ssn,@w_trn,@s_date,@s_user,@s_term,
                 @s_srv,@s_lsrv,@i_tipo_persona,@s_ofi,@i_cod_ciiu,
                 @w_descripcion)
    if @@error <> 0
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 103005
      rollback tran
      return 1 /*'Error en creacion de area influencia'*/
    end

  /** Select **/
    /** Select **/
    if @i_operacion = 'S'
    begin
      if @i_tipo = 'C'
      begin
        set rowcount 20
        if @i_modo = 0 /* Primeros 20 Registros */
        begin
          select distinct
            'Actividad' = aa_actividad,
            'Descripcion' = aa_descripcion,
            'Sector' = aa_sector,
            'Descr Sector' = (select
                                C.valor
                              from   cl_catalogo C,
                                     cl_tabla T
                              where  C.tabla  = T.codigo
                                 and T.tabla  = 'cl_sectoreco'
                                 and C.codigo = X.aa_sector),
            'A.General' = aa_act_general,
            'Descr A.General' = (select
                                   C.valor
                                 from   cl_catalogo C,
                                        cl_tabla T
                                 where  C.tabla  = T.codigo
                                    and T.tabla  = 'cl_actividad_general'
                                    and C.codigo = X.aa_act_general)
          from   cl_asociacion_actividad X
          where  (aa_act_general = @i_act_general
                   or @i_act_general is null)
             and (aa_sector      = @i_sector
                   or @i_sector is null)
             and aa_descripcion like '%' + @i_des_ciiu + '%'
             and aa_tipo_pers   = @i_tipo_persona
          order  by aa_actividad

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 101001
          end
        end
        if @i_modo = 1 /* Siguientes 20 Registros */
        begin
          select
            'Actividad' = aa_actividad,
            'Descripcion' = aa_descripcion,
            'Sector' = aa_sector,
            'Descr Sector' = (select
                                C.valor
                              from   cl_catalogo C,
                                     cl_tabla T
                              where  C.tabla  = T.codigo
                                 and T.tabla  = 'cl_sectoreco'
                                 and C.codigo = X.aa_sector),
            'A.General' = aa_act_general,
            'Descr A.General' = (select
                                   C.valor
                                 from   cl_catalogo C,
                                        cl_tabla T
                                 where  C.tabla  = T.codigo
                                    and T.tabla  = 'cl_actividad_general'
                                    and C.codigo = X.aa_act_general)
          from   cl_asociacion_actividad X
          where  (aa_act_general = @i_act_general
                   or @i_act_general is null)
             and (aa_sector      = @i_sector
                   or @i_sector is null)
             and aa_descripcion like '%' + @i_des_ciiu + '%'
             and aa_tipo_pers   = @i_tipo_persona
             and aa_actividad   > @i_cod_ciiu
          order  by aa_actividad

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 101001
          end
        end
        set rowcount 0
      end
      if @i_tipo = 'B'
      begin
        select distinct
          @w_sector = aa_sector,
          @w_banca = aa_banca,
          @w_mercado_ob = aa_mercado,
          @w_subtipo_mo = aa_subtipo
        from   cl_asociacion_actividad
        where  aa_actividad = @i_cod_ciiu
           and aa_tipo_pers = @i_tipo_persona
        group  by aa_actividad,
                  aa_sector,
                  aa_banca,
                  aa_mercado,
                  aa_subtipo

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 101001
        end

        /* Descripcion de Sector - cl_sectoreco */
        select
          @w_tabla = codigo
        from   cl_tabla
        where  tabla = 'cl_sectoreco'

        select
          @w_des_sector = valor
        from   cl_catalogo
        where  tabla  = @w_tabla
           and codigo = @w_sector

        /* Descripcion de Banca - cl_banca_cliente */
        select
          @w_tabla = codigo
        from   cl_tabla
        where  tabla = 'cl_banca_cliente'

        select
          @w_des_banca = valor
        from   cl_catalogo
        where  tabla  = @w_tabla
           and codigo = @w_sector

        /* Descripcion de Mercado - cl_mercado_objetivo */
        select
          @w_tabla = codigo
        from   cl_tabla
        where  tabla = 'cl_mercado_objetivo'

        select
          @w_des_mercado = valor
        from   cl_catalogo
        where  tabla  = @w_tabla
           and codigo = @w_sector

        /* Descripcion de Subtipo - cl_mobj_subtipo */
        select
          @w_des_subtipo = ms_descripcion
        from   cl_mobj_subtipo
        where  ms_codigo = @w_sector

        /* Mapeo de Variables */
        select
          @w_sector,
          @w_des_sector,
          @w_banca,
          @w_des_banca,
          @w_mercado_ob,
          @w_des_mercado,
          @w_subtipo_mo,
          @w_des_subtipo
      end

      if @i_tipo = 'Q'
      begin
        if @i_modo = 0
        begin /* Primeros 10 Registros */
          delete tmp_asociacion_actividad
          insert into tmp_asociacion_actividad
                      (aa_actividad,aa_tipo_pers,aa_descripcion,aa_act_general,
                       aa_sector
                       ,
                       aa_banca,aa_mercado,aa_subtipo,aa_secuencial)
            select
              aa_actividad,aa_tipo_pers,aa_descripcion,aa_act_general,aa_sector,
              aa_banca,aa_mercado,aa_subtipo,0
            from   cobis..cl_asociacion_actividad
            order  by aa_actividad,
                      aa_tipo_pers,
                      aa_descripcion,
                      aa_banca

          select
            @w_sec = 0
          update cobis..tmp_asociacion_actividad
          set    aa_secuencial = @w_sec,
                 @w_sec = @w_sec + 1

          set rowcount 20
          select
            'Actividad' = aa_actividad,
            'Descripcion' = aa_descripcion,
            'A.General' = aa_act_general,
            'Descr A.General' = (select distinct
                                   C.valor
                                 from   cl_catalogo C,
                                        cl_tabla T
                                 where  C.tabla  = T.codigo
                                    and T.tabla  = 'cl_actividad_general'
                                    and C.codigo = X.aa_act_general),
            'Sector' = aa_sector,
            'Descr Sector' = (select distinct
                                C.valor
                              from   cl_catalogo C,
                                     cl_tabla T
                              where  C.tabla  = T.codigo
                                 and T.tabla  = 'cl_sectoreco'
                                 and C.codigo = X.aa_sector),
            'Mercado' = aa_mercado,
            'Descr Mercado' = (select distinct
                                 C.valor
                               from   cl_catalogo C,
                                      cl_tabla T
                               where  C.tabla  = T.codigo
                                  and T.tabla  = 'cl_mercado_objetivo'
                                  and C.codigo = X.aa_mercado),
            'Subtipo' = aa_subtipo,
            'Descr Subtipo' = (select distinct
                                 ms_descripcion
                               from   cl_mobj_subtipo
                               where  ms_codigo = X.aa_subtipo),
            'Banca ' = aa_banca,
            'Descr Banca' = (select distinct
                               C.valor
                             from   cl_catalogo C,
                                    cl_tabla T
                             where  C.tabla  = T.codigo
                                and T.tabla  = 'cl_banca_cliente'
                                and C.codigo = X.aa_banca),
            'Secuencial' = aa_secuencial
          from   cobis..tmp_asociacion_actividad X
          where  X.aa_tipo_pers = @i_tipo_persona
          order  by X.aa_secuencial

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 101001
          end
        end
        if @i_modo = 1 /* Siguientes 10 Registros */
        begin
          select
            'Actividad' = aa_actividad,
            'Descripcion' = aa_descripcion,
            'A.General' = aa_act_general,
            'Descr A.General' = (select distinct
                                   C.valor
                                 from   cl_catalogo C,
                                        cl_tabla T
                                 where  C.tabla  = T.codigo
                                    and T.tabla  = 'cl_actividad_general'
                                    and C.codigo = X.aa_act_general),
            'Sector' = aa_sector,
            'Descr Sector' = (select distinct
                                C.valor
                              from   cl_catalogo C,
                                     cl_tabla T
                              where  C.tabla  = T.codigo
                                 and T.tabla  = 'cl_sectoreco'
                                 and C.codigo = X.aa_sector),
            'Mercado' = aa_mercado,
            'Descr Mercado' = (select distinct
                                 C.valor
                               from   cl_catalogo C,
                                      cl_tabla T
                               where  C.tabla  = T.codigo
                                  and T.tabla  = 'cl_mercado_objetivo'
                                  and C.codigo = X.aa_mercado),
            'Subtipo' = aa_subtipo,
            'Descr Subtipo' = (select distinct
                                 ms_descripcion
                               from   cl_mobj_subtipo
                               where  ms_codigo = X.aa_subtipo),
            'Banca ' = aa_banca,
            'Descr Banca' = (select distinct
                               C.valor
                             from   cl_catalogo C,
                                    cl_tabla T
                             where  C.tabla  = T.codigo
                                and T.tabla  = 'cl_banca_cliente'
                                and C.codigo = X.aa_banca),
            'Secuencial' = aa_secuencial
          from   cobis..tmp_asociacion_actividad X
          where  X.aa_tipo_pers  = @i_tipo_persona
             and X.aa_secuencial > @i_secuencial
          order  by X.aa_secuencial

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 101001
          end
        end
        set rowcount 0
      end

    end
    /** Validacion **/
    if @i_operacion = 'V'
    begin
      select
        aa_descripcion
      from   cl_asociacion_actividad
      where  aa_actividad = @i_cod_ciiu
         and aa_tipo_pers = @i_tipo_persona

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105506
        /*  'No Existen Registros' */
        return 105506
      end
    end
  end

  /* Asociacion = 'B' aplica solo para pantalla de parametrizacion de banca */
  if @i_asociacion = 'B'
  begin
    if @i_operacion = 'I'
    begin
      /* Descripcion de Subtipo - cl_mobj_subtipo */
      select
        @w_des_subtipo = valor
      from   cobis..cl_catalogo
      where  tabla  = (select
                         codigo
                       from   cobis..cl_tabla
                       where  tabla = 'cl_subtipo_mercado')
         and codigo = @i_subtipo_mo

      insert into cl_mobj_subtipo
                  (ms_codigo,ms_descripcion,ms_mobjetivo,ms_banca,ms_estado)
      values      (@i_subtipo_mo,@w_des_subtipo,@i_mercado_ob,@i_banca,'V')

      /* Si no se puede Insertar Error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101186
        /* 'Error en creacion de Banca' */
        return 101186
      end
    end

    if @i_operacion = 'U'
    begin
      if exists(select
                  1
                from   cl_mobj_subtipo
                where  ms_codigo    = @i_subtipo_mo
                   and ms_mobjetivo = @i_mercado_ob
                   and ms_banca     = @i_banca
                   and ms_estado    = 'V')
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101186
        /* 'REGISTRO YA EXISTE' */
        return 101186
      end

      update cl_mobj_subtipo
      set    ms_banca = @i_banca,
             ms_mobjetivo = @i_mercado_ob,
             ms_codigo = @i_subtipo_mo
      where  ms_mobjetivo = @i_mercado_ob_up
         and ms_codigo    = @i_subtipo_mo_up
         and ms_banca     = @i_banca_up
      /* Si no se puede Actualizar Error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 105095
        /* 'Error en actualizacion de Banca' */
        return 105095
      end
    end

    if @i_operacion = 'D'
    begin
      delete from cl_mobj_subtipo
      where  ms_codigo    = @i_subtipo_mo
         and ms_mobjetivo = @i_mercado_ob
         and ms_banca     = @i_banca

      /* Si no se puede Eliminar Error */
      if @@error <> 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 107016
        /* 'Error en eliminacion de actividad' */
        return 107016
      end
    end

    if @i_operacion = 'S'
    begin
      if @i_tipo = 'Q'
      begin
        set rowcount 10
        if @i_modo = 0 /* Primeros 10 Registros */
        begin
          select
            'Mercado' = ms_mobjetivo,
            'Descr Mercado' = (select
                                 C.valor
                               from   cl_catalogo C,
                                      cl_tabla T
                               where  C.tabla  = T.codigo
                                  and T.tabla  = 'cl_mercado_objetivo'
                                  and C.codigo = X.ms_mobjetivo),
            'Subtipo' = ms_codigo,
            'Descr Subtipo' = (select
                                 C.valor
                               from   cl_catalogo C,
                                      cl_tabla T
                               where  C.tabla  = T.codigo
                                  and T.tabla  = 'cl_subtipo_mercado'
                                  and C.codigo = X.ms_codigo),
            'Banca ' = ms_banca,
            'Descr Banca' = (select
                               C.valor
                             from   cl_catalogo C,
                                    cl_tabla T
                             where  C.tabla  = T.codigo
                                and T.tabla  = 'cl_banca_cliente'
                                and C.codigo = X.ms_banca)
          from   cl_mobj_subtipo X
          --order by X.aa_actividad,X.aa_tipo_pers

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 101001
          end
        end
        if @i_modo = 1 /* Siguientes 10 Registros */
        begin
          select
            'Mercado' = ms_mobjetivo,
            'Descr Mercado' = (select
                                 C.valor
                               from   cl_catalogo C,
                                      cl_tabla T
                               where  C.tabla  = T.codigo
                                  and T.tabla  = 'cl_mercado_objetivo'
                                  and C.codigo = X.ms_mobjetivo),
            'Subtipo' = ms_codigo,
            'Descr Subtipo' = (select
                                 C.valor
                               from   cl_catalogo C,
                                      cl_tabla T
                               where  C.tabla  = T.codigo
                                  and T.tabla  = 'cl_subtipo_mercado'
                                  and C.codigo = X.ms_codigo),
            'Banca ' = ms_banca,
            'Descr Banca' = (select
                               C.valor
                             from   cl_catalogo C,
                                    cl_tabla T
                             where  C.tabla  = T.codigo
                                and T.tabla  = 'cl_banca_cliente'
                                and C.codigo = X.ms_banca)
          from   cl_mobj_subtipo X
          --order by X.aa_actividad 

          if @@rowcount = 0
          begin
            exec sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 101001
            /* 'No existe dato solicitado'*/
            return 101001
          end
        end
      end
    end
  end

  return 0

go

