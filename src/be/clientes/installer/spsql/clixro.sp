/************************************************************************/
/*   Archivo:                 clixro.sp                                 */
/*   Stored procedure:        sp_cliente_regope                         */
/*   Base de datos:           cobis                                     */
/*   Producto:                MIS                                       */
/************************************************************************/
/*                                 IMPORTANTE                           */
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
/*                              PROPOSITO                               */
/*      Dado el pais presenta el numero de clientes para cada region    */
/*      operativa que se haya definido                                  */
/*      NOTA: No hay control de select de 20 en 20. el control debe     */
/*            ser administrativo                                        */
/************************************************************************/
/*                                 MODIFICACIONES                       */
/*        FECHA          AUTOR               RAZON                      */
/*      19/Feb/2000     D Villafuerte   Consulta con carga de datos     */
/*      28/Jul/2001     E Laguna        Agregar Calculo de Porcentajes  */
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
           where  name = 'sp_cliente_regope')
  drop proc sp_cliente_regope
go

create proc sp_cliente_regope
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
  @i_pais         smallint = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int

  select
    @w_sp_name = 'sp_cliente_regope'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn != 1174
  begin
    -- No corresponde codigo de transaccion
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    return 1
  end

begin
  if not exists (select
                   pa_pais
                 from   cl_pais
                 where  pa_pais = @i_pais)
  begin
    -- verificar si existe el pais
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
    reg_operativa char(3),
    num_clientes  int
  )

  -- Consulta de clientes por criterio
  insert into #tempdg
    select
      dg_regope,sum(dg_numero)
    from   cobis..cl_dgeografica
    where  dg_pais = @i_pais
    group  by dg_regope

  -- Envio de datos al front end
  select
    'Region Operativa' = y.valor,
    'Clientes' = num_clientes,
    'PORCENTAJES '= convert (char(3), ((num_clientes*100)/ num_clientes )) + '%'
  /*'ELA JUL/2001 CL00013*/
  from   #tempdg,
         cobis..cl_tabla x,
         cobis..cl_catalogo y
  where  x.tabla       = 'cl_region_ope'
     and x.codigo      = y.tabla
     and reg_operativa = y.codigo
  return 0
end

go

