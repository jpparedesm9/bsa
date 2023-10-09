/************************************************************************/
/*  Archivo:        laboral.sp                                          */
/*  Stored procedure:   sp_laboral                                      */
/*  Base de datos:      cobis                                           */
/*  Producto: Clientes                                                  */
/*  Disenado por:  Carlos Rodriguez V.                                  */
/*  Fecha de escritura: 01/Feb/1995                                     */
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
/*  Este programa procesa las transacciones de consultas de :           */
/*  - Consulta de empresas que forman parte de un grupo                 */
/*  - Personas que trabajan en una empresa determinada                  */
/*  - Empresas en las que labora una persona determinada                */
/*              MODIFICACIONES                                          */
/*  FECHA       AUTOR       RAZON                                       */
/*  01/Feb/95   C. Rodriguez V. Emision Inicial                         */
/*  04/May/2016 T. Baidal       Migracion a CEN                         */
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
           where  name = 'sp_laboral')
    drop proc sp_laboral
go

create proc sp_laboral
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
  @i_operacion    char(3),
  @i_persona      int = null,
  @i_empresa      int = null,
  @i_grupo        int = null,
  @i_ultimo       int = null
)
as
  declare
    @w_sp_name varchar(32),
    @w_return  int,
    @w_codigo  int

  select
    @w_sp_name = 'sp_laboral'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /** Empresas por grupo **/

  if @i_operacion = 'EXG'
  begin
    if @t_trn = 1253
    begin
      select
        'Cod.' = en_ente,
        'Empresa' = substring(en_nombre,
                              1,
                              30)
      from   cl_ente
      where  en_subtipo = 'C'
         and en_grupo   = @i_grupo
         and en_ente    > @i_ultimo

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

  /** Empresas por persona **/

  if @i_operacion = 'EXP'
  begin
    if @t_trn = 1254
    begin
      select
        'Cod.' = tr_empresa,
        'Empresa' = substring(en_nombre,
                              1,
                              30),
        'Rol' = tr_tipo,
        'Descrip. Rol' = a.valor,
        'Grupo' = en_grupo,
        'Nombre del Grupo' = substring(gr_nombre,
                                       1,
                                       40)
      from   cl_trabajo,
             cl_catalogo a,
             cl_tabla b,
             cl_ente
             left outer join cl_grupo
                          on en_grupo = gr_grupo
      where  tr_persona = @i_persona
         and tr_empresa = en_ente
         and tr_tipo    = a.codigo
         and a.tabla    = b.codigo
         and b.tabla    = 'cl_rol_empresa'
         and tr_empresa > @i_ultimo
      order  by tr_empresa

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

  /** Personas que trabajan en una empresa**/

  if @i_operacion = 'PXE'
  begin
    if @t_trn = 1255
    begin
      select
        'Cod.' = tr_persona,
        'Primer Apellido' = p_p_apellido,
        'Segundo Apellido' = p_s_apellido,
        'Nombre' = en_nombre,
        'Rol'= tr_tipo,
        'Descrip. Rol'= a.valor
      from   cl_trabajo,
             cl_ente,
             cl_catalogo a,
             cl_tabla b
      where  tr_empresa = @i_empresa
         and tr_persona = en_ente
         and tr_tipo    = a.codigo
         and a.tabla    = b.codigo
         and b.tabla    = 'cl_rol_empresa'
         and tr_persona > @i_ultimo
      order  by tr_persona

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

go

