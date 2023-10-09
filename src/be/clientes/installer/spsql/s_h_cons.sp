/************************************************************************/
/*  Archivo:            s_h_cons.sp                                      */
/*  Stored procedure:   sp_soc_hecho_cons               */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Mauricio Bayas/Sandra Ortiz                          */
/*  Fecha de escritura: 02-Sep-1994                                     */
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
/*  Query de datos de sociedades de hecho                               */
/*  Search de nombre completo de sociedades de hecho                    */
/************************************************************************/
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR         RAZON                                     */
/*  02/Sep/94 C. Rodriguez V. Emision Inicial                           */
/*  05/May/2016  T. Baidal   Migracion a CEN                             */
/************************************************************************/
use cobis
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             *
           from   sysobjects
           where  name = 'sp_soc_hecho_cons')
           drop proc sp_soc_hecho_cons
go

create proc sp_soc_hecho_cons
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
  @i_ente         int = null,
  @i_sociedad     tinyint = null
)
as
  declare
    @w_today     datetime,
    @w_sp_name   varchar(32),
    @w_return    int,
    @w_siguiente int,
    @w_codigo    int

  select
    @w_sp_name = 'sp_soc_hecho_cons'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_today = getdate()

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
      i_ente = @i_ente,
      i_sociedad = @i_sociedad

    exec cobis..sp_end_debug
  end

  if @i_operacion = 'Q'
  /* consulta de datos de una sociedad de hecho */
  begin
    if @t_trn = 1245
    begin
      select
        sh_descripcion,
        sh_tipo,
        b.valor,
        convert(char(10), sh_fecha_registro, 103),
        convert(char(10), sh_fecha_modificacion, 103),
        sh_vigencia,
        sh_verificado,
        sh_funcionario,
        convert(char(10), sh_fecha_ver, 103)
      from   cl_soc_hecho,
             cl_tabla a,
             cl_catalogo b
      where  sh_ente       = @i_ente
         and sh_secuencial = @i_sociedad
         and a.tabla       = 'cl_stipo'
         and a.codigo      = b.tabla
         and b.codigo      = sh_tipo

      if @@rowcount = 0
      begin
        exec sp_cerror
          @t_debug = @t_debug,
          @t_file  = @t_file,
          @t_from  = @w_sp_name,
          @i_num   = 101001
        /*  'No existe dato solicitado'*/
        return 1
      end
      return 0

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

  /* Search */
  if @i_operacion = 'S'
  begin
    if @t_trn = 1246
    begin
      select
        'Sec.'=sh_secuencial,
        'Nombre'=substring(sh_descripcion,
                           1,
                           30),
        'Tipo'=sh_tipo,
        'Descr.Tipo'=b.valor,
        'Vig.'=sh_vigencia,
        'Verif.'=sh_verificado
      from   cl_soc_hecho,
             cl_tabla a,
             cl_catalogo b
      where  sh_ente  = @i_ente
         and a.tabla  = 'cl_stipo'
         and a.codigo = b.tabla
         and b.codigo = sh_tipo

    end
    else
    begin
      exec sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 151051
      /*  'No corresponde codigo de transaccion' */
      return 1
    end

  end

go

