/************************************************************************/
/*   Archivo:       clixzona.sp                                         */
/*   Stored procedure:   sp_cliente_ciudad_zona                         */
/*   Base de datos:      cobis                                          */
/*   Producto:               CLIENTES                                   */
/************************************************************************/
/*                  IMPORTANTE                                          */
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
/*                  PROPOSITO                                           */
/************************************************************************/
/*                  MODIFICACIONES                                      */
/*   FECHA          AUTOR          RAZON                                */
/*      28/Mar/2001     J Anaguano      Consulta con carga de datos     */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
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
           where  name = 'sp_cliente_ciudad_zona')
  drop proc sp_cliente_ciudad_zona
go

create proc sp_cliente_ciudad_zona
(
  @s_ssn          int = null,
  @s_user         login = null,
  @s_term         varchar(30) = null,
  @s_date         datetime = null,
  @s_srv          varchar(30) = null,
  @s_lsrv         varchar(30) = null,
  @s_rol          smallint = null,
  @s_ofi          smallint = null,
  @s_org_err      char(1) = null,
  @s_error        int = null,
  @s_sev          tinyint = null,
  @s_msg          descripcion = null,
  @s_org          char(1) = null,
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_pais         smallint = null,
  @i_ciudad       int = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int,
    @w_return   int

  select
    @w_sp_name = 'sp_cliente_ciudad_zona'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn != 1426
  begin
    -- No corresponde codigo de transaccion
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

  -- si no exista la ciudad, error
  if not exists (select
                   ci_ciudad
                 from   cl_ciudad
                 where  ci_ciudad = @i_ciudad)
  begin
    -- No existe ciudad
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101024
    return 1
  end

  -- si no exista el pais, error
  if not exists (select
                   pa_pais
                 from   cl_pais
                 where  pa_pais = @i_pais)
  begin
    -- No existe pais
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101018
    return 1
  end

  -- Crea tabla temporal de trabajo
  create table #tempdg
  (
    zona         char(3),
    num_clientes int
  )

  -- Consulta de clientes por criterio
  insert into #tempdg
    select
      dg_zona,sum(dg_numero)
    from   cobis..cl_dgeografica
    where  dg_pais   = @i_pais
           --     and dg_provincia = @i_provincia
           and dg_ciudad = @i_ciudad
    group  by dg_zona

  /*select  'Zona'    = 'Norte',--substring(ci_descripcion,1,15),
          'Clientes'  = num_clientes
    from  #tempdg--,
    --      cobis..cl_ciudad
   -- where ciudad = ci_ciudad*/

  select
    'Zona' = substring(a.valor,
                       1,
                       30),
    'Clientes' = num_clientes
  from   #tempdg,
         cl_catalogo a,
         cl_tabla b
  where  zona    = a.codigo
     and a.tabla = b.codigo
     and b.tabla = 'cl_zona'

  return 0

go

