/************************************************************************/
/*        Archivo:            clixpvro.sp                               */
/*        Stored procedure:   sp_cliente_prov_ro                        */
/*        Base de datos:      cobis                                     */
/*        Producto:           MIS                                       */
/************************************************************************/
/*                       IMPORTANTE                                     */
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
/*                       PROPOSITO                                      */
/*      Dado el codigo de un pais y la region operativa retorna el      */
/*      numero  de clientes de  cada una de las provincias de esa region*/
/*      NOTA: No hay control de select de 20 en 20. el control debe     */
/*            ser administrativo                                        */
/************************************************************************/
/*                       MODIFICACIONES                                 */
/*        FECHA          AUTOR               RAZON                      */
/*      19/Feb/2000     D Villafuerte   Consulta con carga de datos     */
/*      27/Jul/2001     E.Laguna        Agregar calculo porcentajes     */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cliente_prov_ro')
  drop proc sp_cliente_prov_ro
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cliente_prov_ro
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
  @t_file         varchar(10) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_pais         smallint = null,
  @i_region_ope   char(3) = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int,
    @w_return   int,
    @w_total    int

  select
    @w_sp_name = 'sp_cliente_prov_ro'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1172
  begin
    -- No corresponde codigo de transaccion
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

  -- Verificar que exista la region operativa
  exec @w_return = cobis..sp_catalogo
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'cl_region_ope',
    @i_operacion = 'E',
    @i_codigo    = @i_region_ope

  if @w_return = 1
  begin
    -- No existe region operativa
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101040
    return 1
  end

  -- Verificar si existe el pais
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
    provincia    smallint,
    num_clientes int,
    porcentaje   smallint
  )

  -- Consulta de clientes por criterio
  insert into #tempdg
    select
      dg_provincia,sum(dg_numero),0
    from   cobis..cl_dgeografica
    where  dg_pais   = @i_pais
       and dg_regope = @i_region_ope
    group  by dg_provincia

  select
    @w_total = sum(num_clientes)
  from   #tempdg

  update #tempdg
  set    porcentaje = (num_clientes * 100) / @w_total

  -- Envio de datos al front end
  select
    'Departamento' = substring(pv_descripcion,
                               1,
                               15),
    'Clientes' = num_clientes,
    'PORCENTAJES' = convert(char(3), porcentaje) + '%' /*'ELA JUL/2001 CL00013*/
  from   #tempdg,
         cobis..cl_provincia
  where  provincia = pv_provincia
  order  by pv_provincia
  return 0

go

