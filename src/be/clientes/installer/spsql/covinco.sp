/************************************************************************/
/*  Archivo:            covinco.sp                                      */
/*  Stored procedure:   sp_covinco_con                                  */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:   Sandra Ortiz M.                                     */
/*  Fecha de escritura: 22-Mar-1995                                     */
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
/*  Query de datos de covinco                                           */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_covinco_con')
  drop proc sp_covinco_con
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_covinco_con
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
    @w_today = getdate()
  select
    @w_sp_name = 'sp_covinco_con'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_debug = 'S'
  begin
    exec cobis..sp_begin_debug
      @t_file = @t_file
    select
      '/** Stored Procedure **/ ' = @w_sp_name,
      s_ssn = @s_ssn,
      s_user = @s_user,
      s_term = @s_term,
      s_date = @s_date,
      s_srv = @s_srv,
      s_lsrv = @s_lsrv,
      s_ofi = @s_ofi,
      s_rol = @s_rol,
      s_org_err = @s_org_err,
      s_error = @s_error,
      s_sev = @s_sev,
      s_msg = @s_msg,
      s_org = @s_org,
      t_trn = @t_trn,
      t_file = @t_file,
      t_from = @t_from,
      i_operacion = @i_operacion,
      i_modo = @i_modo,
      i_tipo = @i_tipo,
      i_ced_ruc = @i_ced_ruc,
      i_nombre = @i_nombre,
      i_codigo = @i_codigo
    exec cobis..sp_end_debug
  end

  /* Search */
  if @i_operacion = 'S'
  begin
    if @t_trn <> 1256
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
    begin
      if @i_modo = 0
      begin
        select
          'Estado' = cv_estado,
          'N.I.' = cv_ced_ruc,
          'Nombre' = substring(cv_nombre,
                               1,
                               25),
          'Af' = cv_af,
          'Jz' = cv_jz,
          'Sb' = cv_sb,
          'Fecha' = cv_fecha,
          'Codigo' = cv_codigo
        from   cl_covinco
        where  cv_ced_ruc like @i_ced_ruc
        order  by cv_ced_ruc,
                  cv_codigo
      end
      else
      begin
        if @i_modo = 1
          select
            'Estado' = cv_estado,
            'N.I.' = cv_ced_ruc,
            'Nombre' = substring(cv_nombre,
                                 1,
                                 25),
            'Af' = cv_af,
            'Jz' = cv_jz,
            'Sb' = cv_sb,
            'Fecha' = cv_fecha,
            'Codigo'= cv_codigo
          from   cl_covinco
          where  cv_ced_ruc like @i_ced_ruc
             and cv_codigo > @i_codigo
          order  by cv_ced_ruc,
                    cv_codigo
      end
    end
    else
    begin
      if @i_modo = 0
      begin
        select
          'Estado' = cv_estado,
          'N.I.' = cv_ced_ruc,
          'Nombre' = substring(cv_nombre,
                               1,
                               25),
          'Af' = cv_af,
          'Jz' = cv_jz,
          'Sb' = cv_sb,
          'Fecha' = cv_fecha,
          'Codigo' = cv_codigo
        from   cl_covinco
        where  cv_nombre like @i_nombre
        order  by cv_codigo,
                  cv_nombre
      end
      else if @i_modo = 1
        select
          'Estado' = cv_estado,
          'N.I.' = cv_ced_ruc,
          'Nombre' = substring(cv_nombre,
                               1,
                               25),
          'Af' = cv_af,
          'Jz' = cv_jz,
          'Sb' = cv_sb,
          'Fecha' = cv_fecha,
          'Codigo' = cv_codigo
        from   cl_covinco
        where  cv_nombre like @i_nombre
           and cv_codigo > @i_codigo
        order  by cv_codigo,
                  cv_nombre
    end
    set rowcount 0
    return 0
  end

/** QUERY **/
  /*Consulta para actualizar archivo de COVINCO*/

  if @i_operacion = 'Q'
  begin
    if @t_trn <> 1257
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
        'Estado' = cv_estado,
        'N.I.' = cv_ced_ruc,
        'Nombre' = cv_nombre,
        'Af' = cv_af,
        'Jz' = cv_jz,
        'Sb' = cv_sb,
        'Fecha' = cv_fecha,
        'Codigo' = cv_codigo
      from   cl_covinco
      where  cv_codigo = @i_codigo
      return 0
    end
  end

go

