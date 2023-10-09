/************************************************************************/
/*   Archivo:            clixpvrn.sp                                    */
/*   Stored procedure:   sp_cliente_prov_rn                             */
/*   Base de datos:      cobis                                          */
/*   Producto:           MIS                                            */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*      Dado el codigo de un pais y la region natural retorna el numero */
/*      de clientes de  cada una de las provincias de esa region        */
/*      NOTA: No hay control de select de 20 en 20. el control debe     */
/*            ser administrativo                                        */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*         FECHA          AUTOR             RAZON                       */
/*      19/Feb/2000     D Villafuerte   Consulta con carga de datos     */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cliente_prov_rn')
  drop proc sp_cliente_prov_rn
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cliente_prov_rn
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
  @i_region_nat   char(2) = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int,
    @w_return   int

  select
    @w_sp_name = 'sp_cliente_prov_rn'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1171
  begin
    -- No corresponde codigo de transaccion
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

  -- Verificar si existe la region natural
  exec @w_return = cobis..sp_catalogo
    @t_debug     = @t_debug,
    @t_file      = @t_file,
    @t_from      = @w_sp_name,
    @i_tabla     = 'cl_region_nat',
    @i_operacion = 'E',
    @i_codigo    = @i_region_nat
  if @w_return <> 0
  begin
    -- No existe region natural
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 101039
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
    num_clientes int
  )

  -- Consulta de clientes por criterio
  insert into #tempdg
    select
      dg_provincia,sum(dg_numero)
    from   cobis..cl_dgeografica
    where  dg_pais   = @i_pais
       and dg_regnat = @i_region_nat
    group  by dg_provincia

  -- Envio de datos al front end
  select
    'Provincia' = pv_descripcion,
    'Clientes' = num_clientes
  from   #tempdg,
         cobis..cl_provincia
  where  provincia = pv_provincia

  return 0

go

