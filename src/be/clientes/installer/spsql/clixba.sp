/************************************************************************/
/*   Archivo:                 clixba.sp                                 */
/*   Stored procedure:        sp_cliente_banca                          */
/*   Base de datos:           cobis                                     */
/*   Producto:                Clientes                                  */
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
/*                           PROPOSITO                                  */
/*      Retorna el numero de Clientes por cada una de las Bancas        */
/************************************************************************/
/*                           MODIFICACIONES                             */
/*         FECHA          AUTOR          RAZON                          */
/*      28/Mar/2001     J Anaguano      Consulta con carga de datos     */
/*      27/Jul/2001     E.Laguna        Agregar calculo porcentajes     */
/*      16/Ago/2003     E.Laguna        Ajustes por cambio catalogo ban */
/*      12/Oct/2003     E.Laguna        Cambio tipo dato catalogo en tmp*/
/*  02/Mayo/2016     Roxana Sánchez      Migración a CEN                */
/************************************************************************/
use cobis
go

if exists (select
             *
           from   sysobjects
           where  name = 'sp_cliente_banca')
  drop proc sp_cliente_banca
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cliente_banca
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
    @w_max_ente int,
    @w_total    int

  select
    @w_sp_name = 'sp_cliente_banca'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1427
  begin
    -- No corresponde codigo de transaccion
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
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
    banca        varchar(10),
    num_clientes int,
    porcentaje   smallint
  )

  /* Consulta de clientes por criterio*/
  insert into #tempdg
    select
      dg_banca,sum(dg_numero),0
    from   cobis..cl_dgeobanca,
           cobis..cl_tabla x,
           cobis..cl_catalogo y
    where  x.tabla  = 'cl_banca_cliente'
       and x.codigo = y.tabla
       and dg_banca = y.codigo
    group  by dg_banca

  select
    @w_total = sum(num_clientes)
  from   #tempdg

  update #tempdg
  set    porcentaje = num_clientes * 100 / @w_total

  -- Envio de datos al front end
  select
    'Banca' = y.valor,
    'Clientes' = num_clientes,
    'PORCENTAJES' = convert(char(3), porcentaje) + '%'
  from   #tempdg,
         cobis..cl_tabla x,
         cobis..cl_catalogo y
  where  x.tabla  = 'cl_banca_cliente'
     and x.codigo = y.tabla
     and banca    = y.codigo
  -- group by banca
  order  by num_clientes

  return 0

go

