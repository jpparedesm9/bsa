/************************************************************************/
/*   Archivo:                 clixprov.sp                               */
/*   Stored procedure:        sp_cliente_prov                           */
/*   Base de datos:           cobis                                     */
/*   Producto:                MIS                                       */
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
/*      Dado el codigo de un pais retorna el numero de clientes de      */
/*      cada una de las provincias de ese pais                          */
/*      NOTA: No hay control de select de 20 en 20. el control debe     */
/*            ser administrativo                                        */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*   FECHA          AUTOR          RAZON                                */
/*      19/Feb/2000     D Villafuerte   Consulta con carga de datos     */
/*      27/Jul/2001     E.Laguna        Agregar calculo porcentajes     */
/*  02/Mayo/2016     Roxana S�nchez       Migraci�n a CEN               */
/************************************************************************/
use cobis
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_cliente_prov')
  drop proc sp_cliente_prov
go

set ANSI_NULLS off
GO

set QUOTED_IDENTIFIER off
GO

create proc sp_cliente_prov
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          smallint = null,
  @t_show_version bit = 0,
  @i_pais         smallint
)
as
  declare
    @w_sp_name  varchar(32),
    @w_ente     int,
    @w_max_ente int,
    @w_total    int

  select
    @w_sp_name = 'sp_cliente_prov'

/**************/
/* VERSION    */
  /**************/
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @t_trn <> 1170
  begin
    exec sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151051
    /*  'No corresponde codigo de transaccion' */
    return 1
  end

  -- Verificar si existe el pais
  if not exists (select
                   pa_pais
                 from   cl_pais
                 where  pa_pais = @i_pais)
  begin
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
      dg_provincia,sum(dg_numero),0--(dg_numero*100)/sum(dg_numero)
    from   cobis..cl_dgeografica
    where  dg_pais = @i_pais
    group  by dg_provincia

  select
    @w_total = sum(num_clientes)
  from   #tempdg

  update #tempdg
  set    porcentaje = ((num_clientes * 100) / @w_total)

  update #tempdg
  set    porcentaje = 1
  where  porcentaje <= 0

  select
    'Departamento' = pv_descripcion,
    'Clientes' = num_clientes,
    'PORCENTAJES ' = convert (char(3), (porcentaje)) + '%'
  from   #tempdg,
         cobis..cl_provincia
  where  provincia = pv_provincia
  order  by num_clientes
  return 0

go

