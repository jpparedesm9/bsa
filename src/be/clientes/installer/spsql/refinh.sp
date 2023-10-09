/************************************************************************/
/*  Archivo:            refinh.sp                                       */
/*  Stored procedure:   sp_refinh_con                                   */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Octavio Hoyos F.                                */
/*  Fecha de escritura: 26-Jun-1996                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                              PROPOSITO                               */
/*  Este stored procedure procesa:                                      */
/*  Query de datos de referencias inhibitorias                          */
/*                              MODIFICACIONES                          */
/*  FECHA       AUTOR       RAZON                                       */
/* 26-Jun-1996  O. Hoyos    Emision Inicial Proyecto Latincorp          */
/* 05/May/2016  T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_refinh_con')
    drop proc sp_refinh_con
go

create proc sp_refinh_con
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_ofi          smallint = null,
  @s_rol          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = 'N',
  @i_ced_ruc      char(13) = '1',
  @i_nombre       varchar(37) = '%',
  @i_nombre2      varchar(37) = null,
  @i_codigo       int = null,
  @i_nomlar       varchar(64) = null
)
as
  declare
    @w_today       datetime,
    @w_sp_name     varchar(32),
    @w_return      int,
    @w_ced_ruc     char(13),
    @w_nombre      varchar(37),
    @w_descripcion varchar(37),
    @w_fila        int,
    @w_codigo      smallint,
    @o_ced_ruc     char(13),
    @o_nombre      varchar(37),
    @o_codigo      int

  select
    @w_sp_name = 'sp_refinh_con'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @i_ced_ruc = ''
  begin
    select
      @w_ced_ruc = '1'
  end
  else
  begin
    select
      @w_ced_ruc = @i_ced_ruc
  end

  if @i_nombre = ''
  begin
    select
      @w_nombre = 'A'
  end
  else
  begin
    select
      @w_nombre = @i_nombre
  end

  select
    @w_codigo = codigo
  from   cl_tabla
  where  tabla = 'cl_refinh'
  select
    @w_today = getdate()
  select
    @w_fila = 20

  /* Search */
  if @i_operacion = 'S'
  begin
    if @t_trn != 1278
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    set rowcount 20
    if @i_tipo = 'C'
    begin /*BUSQUEDA POR NUMERO DE DOCUMENTO*/
      if @i_modo = 0
      begin
        select --top (@w_fila)
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert (varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar (10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_codigo)
        from   cl_refinh a -- , cobis..cl_tabla x, cobis..cl_catalogo y
        where  in_ced_ruc >= @w_ced_ruc
        /*          and   x.tabla = 'cl_refinh'
                    and   x.codigo = y.tabla
                    and   a.in_origen = y.codigo
                    and   y.estado = 'V'                  Se coloca en comentarios porque no se esta haciendo
                                                          nada con este join y si esta generando time out       */
        order  by in_ced_ruc
      end
      else
      begin
        if @i_modo = 1
          select --top (@w_fila)
            'Tipo Doc. ' = in_tipo_ced,
            'No. Documento ID/NIT' = in_ced_ruc,
            'Nombre o Razon Social' = substring(in_nombre,
                                                1,
                                                25),
            'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                               1,
                                               25),
            'S.Apellido' = substring(in_p_s_apellido,
                                     1,
                                     25),
            'Fecha Ref' = convert(char(10), in_fecha_ref, 101),
            'Origen' = in_origen,
            'Fecha Mod' = convert(char(10), in_fecha_mod, 101),
            'Observacion' = in_observacion,
            'Codigo' = in_codigo,
            'Descripcion Origen' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.in_origen
                                       and tabla  = @w_codigo)
          from   cl_refinh a -- , cobis..cl_tabla x, cobis..cl_catalogo y
          where  in_ced_ruc > @i_ced_ruc
          /*          and   x.tabla = 'cl_refinh'
                      and   x.codigo = y.tabla
                      and   a.in_origen = y.codigo
                      and   y.estado = 'V'                   Se coloca en comentarios porque no se esta haciendo
                                                            nada con este join y si esta generando time out       */
          order  by in_ced_ruc
        else
          select --top (@w_fila)
            'Tipo Doc. ' = in_tipo_ced,
            'No. Documento ID/NIT' = in_ced_ruc,
            'Nombre o Razon Social' = substring(in_nombre,
                                                1,
                                                25),
            'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                               1,
                                               25),
            'S.Apellido' = substring(in_p_s_apellido,
                                     1,
                                     25),
            'Fecha Ref' = convert (varchar(10), in_fecha_ref, 101),
            'Origen' = in_origen,
            'Fecha Mod' = convert(varchar (10), in_fecha_mod, 101),
            'Observacion' = in_observacion,
            'Codigo' = in_codigo,
            'Descripcion Origen' = (select
                                      valor
                                    from   cl_catalogo
                                    where  codigo = a.in_origen
                                       and tabla  = @w_codigo)
          from   cl_refinh a -- , cobis..cl_tabla x, cobis..cl_catalogo y
          where  in_ced_ruc = @i_ced_ruc
          /*            and x.tabla = 'cl_refinh'
                        and x.codigo = y.tabla
                        and y.estado = 'V'
                        and a.in_origen = y.codigo            Se coloca en comentarios porque no se esta haciendo
                                                            nada con este join y si esta generando time out       */
          order  by in_ced_ruc

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
    end

    if @i_tipo = 'N'
    begin --tipo N /*BUSQUEDA POR NOMBRE */
      if @i_modo = 0
      begin
        select --top (@w_fila)
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_codigo)
        from   cl_refinh a-- , cobis..cl_tabla x, cobis..cl_catalogo y
        where  in_nomlar like (@i_nombre) + '%'
        /*             and   x.tabla = 'cl_refinh'
                     and   x.codigo = y.tabla
                     and   y.estado = 'V'
                     and   a.in_origen = y.codigo             Se coloca en comentarios porque no se esta haciendo
                                                          nada con este join y si esta generando time out       */
        order  by in_nomlar
      end
      else if @i_modo = 1
      begin
        select --top (@w_fila)
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_codigo)
        from   cl_refinh a-- , cobis..cl_tabla x, cobis..cl_catalogo y
        where  in_nomlar > @i_nombre
        /*             and   x.tabla = 'cl_refinh'
                       and   x.codigo = y.tabla
                       and   y.estado = 'V'
                       and   a.in_origen = y.codigo          Se coloca en comentarios porque no se esta haciendo
                                                          nada con este join y si esta generando time out       */
        order  by in_nomlar
      end
      else
      begin
        select --top (@w_fila)
          'Tipo Doc. ' = in_tipo_ced,
          'No. Documento ID/NIT' = in_ced_ruc,
          'Nombre o Razon Social' = substring(in_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(in_p_s_apellido,
                                   1,
                                   25),
          'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
          'Origen' = in_origen,
          'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
          'Observacion' = in_observacion,
          'Codigo' = in_codigo,
          'Descripcion Origen' = (select
                                    valor
                                  from   cl_catalogo
                                  where  codigo = a.in_origen
                                     and tabla  = @w_codigo)
        from   cl_refinh a-- , cobis..cl_tabla x, cobis..cl_catalogo y
        where  in_nomlar = @i_nombre
        /*             and   x.tabla = 'cl_refinh'
                       and   x.codigo = y.tabla
                       and   y.estado = 'V'
                       and   a.in_origen = y.codigo          Se coloca en comentarios porque no se esta haciendo
                                                          nada con este join y si esta generando time out       */
        order  by in_nomlar

        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          return 1
        end
      end
      set rowcount 0
    end
    return 0
  end

  /*********Busqueda de referencia inhibitoria**********/
  if @i_operacion = 'B'
  begin
    if @t_trn != 1278
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    select
      @w_descripcion = cl_catalogo.valor
    from   cl_catalogo,
           cl_tabla,
           cl_refinh
    where  cl_tabla.tabla      = 'cl_estado_refinh'
       and cl_catalogo.tabla   = cl_tabla.codigo
       and cl_catalogo.codigo  = cl_refinh.in_estado
       and cl_refinh.in_codigo = @i_codigo

    select
      'No. Documento ID/NIT' = in_ced_ruc,
      'Nombre o Razon Social' = substring(in_nombre,
                                          1,
                                          25),
      'Fecha Ref' = convert(varchar(10), in_fecha_ref, 101),
      'Origen' = in_origen,
      'Fecha Mod' = convert(varchar(10), in_fecha_mod, 101),
      'Observacion' = in_observacion,
      'Codigo' = in_codigo,
      'Descripcion Origen' = (select
                                valor
                              from   cl_catalogo
                              where  codigo = a.in_origen
                                 and tabla  = @w_codigo),
      'Estado ' = in_estado,
      'Descripcion Estado' = @w_descripcion
    from   cl_refinh a--, cobis..cl_tabla x, cobis..cl_catalogo y
    where  in_ced_ruc = @i_ced_ruc
    /*  and   x.tabla = 'cl_refinh'
        and   x.codigo = y.tabla
        and   y.estado = 'V'
        and   a.in_origen = y.codigo             Se coloca en comentarios porque no se esta haciendo
                                                      nada con este join y si esta generando time out       */
    order  by in_ced_ruc

    if @@rowcount = 0
      return 0
  end
/*************/
/** QUERY **/
  /*Consulta para actualizar archivo de Referencias Inhibitorias */

  if @i_operacion = 'Q'
  begin
    if @t_trn != 1279
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
    else
    begin
      select distinct
        @w_descripcion = cl_catalogo.valor
      from   cl_catalogo,
             cl_tabla,
             cl_refinh
      where  cl_tabla.tabla      = 'cl_estado_refinh'
         and cl_catalogo.tabla   = cl_tabla.codigo
         and cl_catalogo.codigo  = cl_refinh.in_estado
         and cl_refinh.in_codigo = @i_codigo

      select
        'No. Documento ID/NIT' = isnull(in_ced_ruc,
                                        ''),
        'Nombre o Razon Social' = substring(in_nombre,
                                            1,
                                            25),
        'P.Apellido y/o Sigla' = substring(in_p_p_apellido,
                                           1,
                                           25),
        'S.Apellido' = substring(in_p_s_apellido,
                                 1,
                                 25),
        'Fecha_Ref' = convert(varchar(10), in_fecha_ref, 101),
        'Origen' = in_origen,
        'Fecha_Mod' = convert(varchar(10), in_fecha_mod, 101),
        'Observacion' = in_observacion,
        'Codigo' = in_codigo,
        'Tipo Cliente' = in_subtipo,
        'Tipo D.I.' = isnull(in_tipo_ced,
                             ''),
        'Descripcion Origen' = (select
                                  valor
                                from   cl_catalogo
                                where  codigo = a.in_origen
                                   and tabla  = @w_codigo),
        'Estado ' = in_estado,
        'Descripcion Estado' = @w_descripcion,
        'Sexo' = in_sexo
      from   cl_refinh a
      -- , cobis..cl_tabla x, cobis..cl_catalogo y    --LRE 06/Ene/2010
      where  in_codigo = @i_codigo
      /*and   x.tabla = 'cl_refinh'
      and   x.codigo = y.tabla
      and   y.estado = 'V'
      and   a.in_origen = y.codigo          Se coloca en comentarios porque no se esta haciendo
                                                     nada con este join y si esta generando time out       */
      return 0
    end
  end
  return 0

go

