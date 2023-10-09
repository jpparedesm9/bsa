/************************************************************************/
/*  Archivo:            mercado.sp                                      */
/*  Stored procedure:   sp_mercado_con                                  */
/*  Base de datos:      cobis                                           */
/*  Producto:           Clientes                                        */
/*  Disenado por:       Octavio Hoyos F.                                */
/*  Fecha de escritura: 26-Jun-1996                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Query de datos de referencias de mercado                            */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/* 26-Jun-1996  O. Hoyos    Emision Inicial Proyecto Latincorp          */
/* 08-Jul-1996  A.Ramirez   Busqueda de referencia de mercado BRM       */
/* 23-Ene-2001  E.Laguna    Estado Referencias Inhibitorias/Mercado     */
/* 27-May-2001  J.Anaguano  Bœsqueda alfab'tica por el campo me_nomlar  */
/* 13/Mar/2007  S. Lievano  DEFECTO 8012                                */
/* 19/Jun/2012  A.Muñoz     Incidencia 065043                           */
/* 04/May/2016  T. Baidal   Migracion a CEN                             */
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
           where  name = 'sp_mercado_con')
    drop proc sp_mercado_con
go

create proc sp_mercado_con
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
  @w_descripcion  varchar(37) = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),
  @i_modo         tinyint = null,
  @i_tipo         char(1) = 'N',
  @i_ced_ruc      char(13) = '%',
  @i_nombre       varchar(37) = '%',
  @i_codigo       int = null
)
as
  declare
    @w_today   datetime,
    @w_sp_name varchar(32),
    @w_return  int,
    @w_ced_ruc char(13),
    @w_nombre  varchar(37)

  select
    @w_sp_name = 'sp_mercado_con'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

  /* Search */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 1283
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
    if @i_tipo = 'C' --codigo
    begin
      if @i_modo = 0
      begin
        select
          'Tipo Doc.' = me_tipo_ced,
          'No. Documento ID/NIT' = me_ced_ruc,
          'Nombre o Razon Social' = substring(me_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(me_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(me_s_apellido,
                                   1,
                                   25),
          'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
          'Calificador' = me_calificador,
          'Calificacion' = me_calificacion,
          'Fuente' = substring(me_fuente,
                               1,
                               15),
          'Observacion'=substring(me_observacion,
                                  1,
                                  15),
          'Codigo' = me_codigo
        from   cl_mercado
        --where me_ced_ruc like @i_ced_ruc
        where  me_ced_ruc >= @i_ced_ruc
        order  by me_ced_ruc--, me_codigo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      if @i_modo = 1
      begin
        select
          'Tipo Doc.' = me_tipo_ced,
          'No. Documento ID/NIT' = me_ced_ruc,
          'Nombre o Razon Social' = substring(me_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(me_p_apellido,
                                             1,
                                             15),
          'S.Apellido' = substring(me_s_apellido,
                                   1,
                                   25),
          'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
          'Calificador' = me_calificador,
          'Calificacion' = me_calificacion,
          'Fuente' = substring(me_fuente,
                               1,
                               15),
          'Observacion'=substring(me_observacion,
                                  1,
                                  15),
          'Codigo' = me_codigo
        from   cl_mercado
        --where me_ced_ruc like @i_ced_ruc
        --and me_codigo > @i_codigo
        where  me_ced_ruc > @i_ced_ruc
        order  by me_ced_ruc--, me_codigo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      if @i_modo = 2
      begin
        select
          'Tipo Doc.' = me_tipo_ced,
          'No. Documento ID/NIT' = me_ced_ruc,
          'Nombre o Razon Social' = substring(me_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(me_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(me_s_apellido,
                                   1,
                                   25),
          'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
          'Calificador' = me_calificador,
          'Calificacion' = me_calificacion,
          'Fuente' = substring(me_fuente,
                               1,
                               15),
          'Observacion'=substring(me_observacion,
                                  1,
                                  15),
          'Codigo' = me_codigo
        from   cl_mercado
        where  me_ced_ruc = @i_ced_ruc
        order  by me_ced_ruc,
                  me_codigo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
    end /* i_tipo = 'C' */
    else
    begin --Tipo N
      if @i_modo = 0
      begin
        select
          'Tipo Doc.' = me_tipo_ced,
          'No. Documento ID/NIT' = me_ced_ruc,
          'Nombre o Razon Social' = substring(me_nomlar,
                                              1,
                                              50),
          'P.Apellido y/o Sigla' = substring(me_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(me_s_apellido,
                                   1,
                                   25),
          'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
          'Calificador' = me_calificador,
          'Calificacion' = me_calificacion,
          'Fuente' = substring(me_fuente,
                               1,
                               15),
          'Observacion'=substring(me_observacion,
                                  1,
                                  15),
          'Codigo' = me_codigo
        from   cl_mercado
        --JAN MAY/01 where me_nombre >=  @i_nombre
        where  me_nomlar like '%' + @i_nombre + '%'
        order  by me_ced_ruc --JAN MAY/01 me_nombre--, me_codigo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      if @i_modo = 1
      begin
        select
          'Tipo Doc.' = me_tipo_ced,
          'No. Documento ID/NIT' = me_ced_ruc,
          'Nombre o Razon Social' = substring(me_nomlar,
                                              1,
                                              50),
          'P.Apellido y/o Sigla' = substring(me_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(me_s_apellido,
                                   1,
                                   25),
          'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
          'Calificador' = me_calificador,
          'Calificacion' = me_calificacion,
          'Fuente' = substring(me_fuente,
                               1,
                               15),
          'Observacion'=substring(me_observacion,
                                  1,
                                  15),
          'Codigo' = me_codigo
        from   cl_mercado
        --where me_nombre like @i_nombre
        --and me_codigo > @i_codigo
        --where me_nombre > @i_nombre
        where  me_nomlar like '%' + @i_nombre + '%'
           and me_ced_ruc > @i_ced_ruc
        order  by me_ced_ruc --JAN MAY/01 me_nombre--, me_codigo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 151121
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
      if @i_modo = 2
      begin
        select
          'Tipo Doc.' = me_tipo_ced,
          'No. Documento ID/NIT' = me_ced_ruc,
          'Nombre o Razon Social' = substring(me_nombre,
                                              1,
                                              25),
          'P.Apellido y/o Sigla' = substring(me_p_apellido,
                                             1,
                                             25),
          'S.Apellido' = substring(me_s_apellido,
                                   1,
                                   25),
          'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
          'Calificador' = me_calificador,
          'Calificacion' = me_calificacion,
          'Fuente' = substring(me_fuente,
                               1,
                               15),
          'Observacion'=substring(me_observacion,
                                  1,
                                  15),
          'Codigo' = me_codigo
        from   cl_mercado
        --JAN MAY/01 where me_nombre =  @i_nombre
        where  me_nomlar = @i_nombre
        order  by me_nomlar --JAN MAY/01 me_nombre, me_codigo
        if @@rowcount = 0
        begin
          exec sp_cerror
            @t_debug = @t_debug,
            @t_file  = @t_file,
            @t_from  = @w_sp_name,
            @i_num   = 101001
          /* 'No existe dato solicitado'*/
          return 1
        end
      end
    end /* i_tipo = 'C' */
    set rowcount 0
    return 0
  end /* i_operacion = 'S'*/

/******BRM******/
  /*********Busqueda de referencia de mercado**********/
  if @i_operacion = 'B'
  begin
    if @t_trn <> 1283
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
      'No. Documento ID/NIT' = me_ced_ruc,
      'Nombre o Razon Social' = substring(me_nombre,
                                          1,
                                          25),
      'Fecha_Ref' = me_fecha_ref,
      'Calificador' = me_calificador,
      'Calificacion' = me_calificacion,
      'Fuente' = me_fuente,
      'Observacion'= me_observacion,
      'Codigo' = me_codigo
    from   cl_mercado
    where  me_ced_ruc like @i_ced_ruc
    order  by me_ced_ruc
  end
/*************/
/** QUERY **/
  /*Consulta para actualizar archivo de Referencias Inhibitorias */

  if @i_operacion = 'Q'
  begin
    if @t_trn <> 1284
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
      select
        @w_descripcion = cl_catalogo.valor
      from   cl_catalogo,
             cl_tabla,
             cl_mercado
      where  cl_tabla.tabla     = 'cl_estado_refmer'
         and cl_catalogo.tabla  = cl_tabla.codigo
         and cl_catalogo.codigo = me_estado
         and me_codigo          = @i_codigo

      select
        'No. Documento ID/NIT' = me_ced_ruc,
        'Nombre o Razon Social' = substring(me_nombre,
                                            1,
                                            25),
        'P.Apellido y/o Sigla' = me_p_apellido,
        'S.Apellido' = me_s_apellido,
        'Fecha_Ref' = convert(char(10), me_fecha_ref, 101),
        'Calificador' = me_calificador,
        'Calificacion' = me_calificacion,
        'Fuente' = me_fuente,
        'Observacion'=me_observacion,
        'Codigo' = me_codigo,
        'Tipo D.I.'= me_tipo_ced,
        'Subtipo' = me_subtipo,
        'Fecha Mod' = convert(char(10), me_fecha_mod, 101),
        'Estado ' = me_estado,
        'Descripcion Estado' = @w_descripcion
      --           'sexo'                  = me_sexo
      from   cl_mercado
      where  me_codigo = @i_codigo

      return 0
    end
  end

go

