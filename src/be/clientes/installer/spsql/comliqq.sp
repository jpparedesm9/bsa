/************************************************************************/
/*  Archivo:            comliqq.sp                                      */
/*  Stored procedure:   sp_liquidacion_con                              */
/*  Base de datos:      cobis                                           */
/*  Producto:       Clientes                                            */
/*  Disenado por:   Sandra Ortiz M.                                     */
/*  Fecha de escritura: 12-May-1995                                     */
/************************************************************************/
/*              IMPORTANTE                                              */
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
/*              PROPOSITO                                               */
/*  Este stored procedure procesa:                                      */
/*  Query de datos de companias en liquidacion                          */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  12-May-95  S. Ortiz M. Emision Inicial                              */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_liquidacion_con')
  drop proc sp_liquidacion_con
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_liquidacion_con
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
  @i_tipo         char(1) = 'A',
  @i_codigo       int = null,
  @i_ced_ruc      numero = null,
  @i_nombre       descripcion = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_ced_ruc char(13),
    @w_nombre  varchar(37)

  select
    @w_sp_name = 'sp_liquidacion_con'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* Search */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 1268
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105071
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

    set rowcount 20

    /*  Busqueda por Cedula o RUC  */
    if @i_tipo = 'C'
    begin
      if @i_modo = 0
        select
          'Codigo' = cl_codigo,
          'N.I./NIT' = substring(cl_ced_ruc,
                                 1,
                                 13),
          'Nombre' = substring(cl_nombre,
                               1,
                               40),
          'Tipo' = cl_tipo,
          'Problema' = cl_problema,
          'Referencia'= cl_referencia,
          'Fecha' = cl_fecha
        from   cl_com_liquidacion
        where  cl_ced_ruc like @i_ced_ruc
        order  by cl_ced_ruc
      else
        select
          'Codigo' = cl_codigo,
          'D.I./NIT' = substring(cl_ced_ruc,
                                 1,
                                 13),
          'Nombre' = substring(cl_nombre,
                               1,
                               40),
          'Tipo' = cl_tipo,
          'Problema' = cl_problema,
          'Referencia'= cl_referencia,
          'Fecha' = cl_fecha
        from   cl_com_liquidacion
        where  cl_ced_ruc like @i_ced_ruc
           and cl_codigo > @i_codigo
        order  by cl_ced_ruc
    end
    /*  Busqueda por nombre */
    else
    begin
      if @i_modo = 0
        select
          'Codigo' = cl_codigo,
          'D.I./NIT' = substring(cl_ced_ruc,
                                 1,
                                 13),
          'Nombre' = substring(cl_nombre,
                               1,
                               40),
          'Tipo' = cl_tipo,
          'Problema' = cl_problema,
          'Referencia'= cl_referencia,
          'Fecha' = cl_fecha
        from   cl_com_liquidacion
        where  cl_nombre like @i_nombre
      else
        select
          'Codigo' = cl_codigo,
          'D.I./NIT' = substring(cl_ced_ruc,
                                 1,
                                 13),
          'Nombre' = substring(cl_nombre,
                               1,
                               40),
          'Tipo' = cl_tipo,
          'Problema' = cl_problema,
          'Referencia'= cl_referencia,
          'Fecha' = cl_fecha
        from   cl_com_liquidacion
        where  cl_nombre like @i_nombre
           and cl_codigo > @i_codigo
    end

    set rowcount 0
    return 0
  end

  /** QUERY **/
  if @i_operacion = 'Q'
  begin
    if @t_trn <> 1269
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 105071
      /*  'No corresponde codigo de transaccion' */
      return 1
    end
    else
    begin
      select
        'Codigo' = cl_codigo,
        'Nombre' = cl_nombre,
        'Tipo' = cl_tipo,
        'Problema' = cl_problema,
        'Descripcion'= valor,
        'Referencia' = cl_referencia,
        'D.I./NIT' = cl_ced_ruc,
        'Fecha' = convert(char(12), cl_fecha, 103)
      from   cl_com_liquidacion,
             cl_catalogo c,
             cl_tabla t
      where  cl_codigo = @i_codigo
         and t.tabla   = 'cl_problema'
         and c.tabla   = t.codigo
         and c.codigo  = cl_problema
      return 0
    end
  end

go

