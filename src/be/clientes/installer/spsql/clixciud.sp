/************************************************************************/
/*   Archivo:            clixciud.sp                                    */
/*   Stored procedure:   sp_cliente_ciudad                              */
/*   Base de datos:      cobis                                          */
/*   Producto:           MIS                                            */
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
/*  Selecciona la ciudad y el numero de clientes del banco y            */
/*  clientes potenciales de una provincia y pais de la vista            */
/*  cl_cliente_ciud                                                     */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*   FECHA               AUTOR               RAZON                      */
/*  19/Feb/2000     D Villafuerte   Consulta con carga de datos         */
/*  28/Jul/2001     E Laguna        Calculo de Porcentajes              */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cliente_ciudad')
  drop proc sp_cliente_ciudad
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cliente_ciudad
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
  @i_provincia    smallint = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int,
    @w_return   int,
    @w_total    int

  select
    @w_sp_name = 'sp_cliente_ciudad'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1168
  begin
    -- No corresponde codigo de transaccion
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

  -- si no exista la provincia, error
  if not exists (select
                   pv_provincia
                 from   cl_provincia
                 where  pv_provincia = @i_provincia)
  begin
    -- No existe provincia
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101038
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
    ciudad       int,
    num_clientes int,
    porcentaje   smallint
  )

  -- Consulta de clientes por criterio
  insert into #tempdg
    select
      dg_ciudad,sum(dg_numero),0
    from   cobis..cl_dgeografica
    where  dg_pais      = @i_pais
       and dg_provincia = @i_provincia
    group  by dg_ciudad

  select
    @w_total = sum(num_clientes)
  from   #tempdg

  update #tempdg
  set    porcentaje = ((num_clientes * 100) / (@w_total))

  update #tempdg
  set    porcentaje = 1
  where  porcentaje <= 0

  select
    'CIUDAD' = substring(ci_descripcion,
                         1,
                         15),
    'CLIENTES' = num_clientes,
    'PORCENTAJES' = convert(char(3), porcentaje) + '%'
  from   #tempdg,
         cobis..cl_ciudad
  where  ciudad = ci_ciudad

  return 0

go

