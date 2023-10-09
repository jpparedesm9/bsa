/************************************************************************/
/*    Archivo:                ah03_pf.sp                                */
/*    Stored procedure:       sp_ah03_pf                                */
/*    Base de datos:          cob_ahorros                               */
/*    Producto:               Ahorros                                   */
/************************************************************************/
/*                             IMPORTANTE                               */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
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
/*    Despliega para las pantallas de perfiles contables en el modulo   */
/*    de Contabilidad COBIS los valores que pueden tomar los criterios  */
/*    contables de CALIFICACION, TIPO CUSTODIA, CLASE, MONEDA           */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*  02/Mayo/2016      Ignacio Yupa        Migración a CEN               */
/************************************************************************/

use cob_ahorros
go

if exists (select
             1
           from   sysobjects
           where  name = 'sp_ah03_pf')
  drop proc sp_ah03_pf
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

create proc sp_ah03_pf
(
  @t_show_version bit = 0,
  @i_criterio     tinyint = null,
  @i_codigo       varchar(30) = null
)
as
  declare
    @w_return   int,
    @w_sp_name  varchar(32),
    @w_tabla    smallint,
    @w_codigo   varchar(30),
    @w_criterio tinyint

  select
    @w_sp_name = 'sp_ah03_pf'
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  /* LA 1A VEZ ENVIA LAS ETIQUETAS QUE APARECERAN EN LOS CAMPOS DE LA FORMA */
  if @i_criterio is null
  begin
    select
      'Moneda',
      'Estado'
  end

  select
    @w_codigo = isnull(@i_codigo,
                       '')
  select
    @w_criterio = isnull(@i_criterio,
                         0)

  /* TABLA TEMPORAL PARA LLENAR LOS DATOS DE TODOS LOS DATOS DEL F5 AL CARGAR LA PANTALLA */
  create table #ca_catalogo
  (
    ca_tabla       tinyint,
    ca_codigo      varchar(10),
    ca_descripcion varchar(50)
  )

  /* MONEDA */
  if @w_criterio <= 1
  begin
    insert into #ca_catalogo
      select
        1,cat.codigo,cat.valor
      from   cobis..cl_tabla tab,
             cobis..cl_catalogo cat
      where  tab.tabla  = 'cl_moneda'
         and tab.codigo = cat.tabla

    if @@error <> 0
      return 203042
  end

  /* ESTADO CUENTA */
  if @w_criterio <= 2
  begin
    insert into #ca_catalogo
      select
        2,cat.codigo,cat.valor
      from   cobis..cl_tabla tab,
             cobis..cl_catalogo cat
      where  tab.tabla  = 'ah_estado_cta'
         and tab.codigo = cat.tabla

    if @@error <> 0
      return 203042
  end

  /* RETORNA LOS DATOS AL FRONT-END */
  select
    ca_tabla,
    ca_codigo,
    ca_descripcion
  from   #ca_catalogo
  where  ca_tabla  > @w_criterio
      or (ca_tabla  = @w_criterio
          and ca_codigo > @w_codigo)
  order  by ca_tabla,
            ca_codigo

  return 0

go

