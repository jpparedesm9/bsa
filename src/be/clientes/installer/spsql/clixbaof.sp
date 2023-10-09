/************************************************************************/
/*   Archivo:                 clixbaof.sp                               */
/*   Stored procedure:        sp_cliente_banca_oficina                  */
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
/*                             PROPOSITO                                */
/*      Retorna el numero de Clientes por Banca dada una Oficina        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*   FECHA          AUTOR          RAZON                                */
/*      28/Mar/2001     J Anaguano      Consulta con carga de datos     */
/*      27/Jul/2001     E.Laguna        Se agrega calculo de porcentaje */
/*      07/Ene/2005 D.Duran        Optimizacion                         */
/*  02/Mayo/2016     Roxana Sánchez       Migración a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cliente_banca_oficina')
  drop proc sp_cliente_banca_oficina
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cliente_banca_oficina
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_pais         smallint = null,
  @i_oficina      smallint = null
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int,
    @w_total    int

  select
    @w_sp_name = 'sp_cliente_banca_oficina'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1429
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

  select
    of_oficina,
    'of_nombre' = substring(of_nombre,
                            1,
                            20),
    'banca' = substring(cl_catalogo.valor,
                        1,
                        20),
    'num_clientes' = count(en_ente)
  into   #cliente_banca_oficina
  from   cobis..cl_oficina,
         cobis..cl_ente,
         cobis..cl_catalogo,
         cl_tabla
  where  of_oficina        = @i_oficina
     and en_oficina        = of_oficina
     and en_banca          = cl_catalogo.codigo
     and cl_catalogo.tabla = cl_tabla.codigo
     and cl_tabla.tabla    = 'cl_banca_cliente'
  group  by of_oficina,
            of_nombre,
            cl_catalogo.valor

  select
    @w_total = sum(num_clientes)
  from   #cliente_banca_oficina

  select
    'Banca' = banca,
    'Clientes' = num_clientes,
    'PORCENTAJES '= convert (char(3), ((num_clientes*100)/ @w_total )) + '%'
  from   #cliente_banca_oficina
  order  by num_clientes

  return 0

go

