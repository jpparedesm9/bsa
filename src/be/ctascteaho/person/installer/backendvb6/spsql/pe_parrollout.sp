/************************************************************************/
/*  Archivo:            pe_parrollout.sp                                */
/*  Stored procedure:   sp_par_rollout                                  */
/*  Base de datos:      cob_remesas                                     */
/*  Producto:           Personalizacion                                 */
/*  Disenado por:       Alexandra Correa                                */
/*  Fecha de escritura: 03-Oct-2011                                     */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*  Este programa procesa las transacciones de parametrización de       */
/*  productos bancarios a oficinas                                      */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*  FECHA           AUTOR           RAZON                               */
/*  03/Oct/2011     A. Correa       Emision Inicial                     */
/*      02/Mayo/2016   Roxana Sánchez    Migración a CEN                */
/************************************************************************/
use cob_remesas
go

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_par_rollout')
  drop proc sp_par_rollout
go

create proc sp_par_rollout
(
  @t_show_version bit = 0,
  @i_criterio     char(1),
  @i_producto     tinyint,
  @i_prod_banc    smallint,
  @i_oficina      smallint = null,
  @i_fecha_inicio datetime,
  @i_estado       char(1),
  @i_operacion    char(1) = 'I'
)
as
  declare
    @w_sp_name varchar(50),
    @w_debug   char(1),
    @w_prueba  char(1)

  select
    @w_sp_name = 'sp_par_rollout',
    @w_debug = 'N',
    @w_prueba = 'N'

  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  if @w_prueba = 'S'
  begin
    select
      @i_criterio = 'Z',-- T->Todo, 'R'->Territorial, 'Z'->Zona, 'O'->Oficina
      @i_producto = 4,-- 3 -> CtaCte, 4 -> Ahorros
      @i_prod_banc = 3,-- Producto Bancario
      @i_fecha_inicio = '08/01/2011',--Fecha de Inicio
      @i_estado = 'V',
      @i_oficina = 3002 --Codigo de la oficina (seg·n criterio)
  end

  if @i_operacion = 'I'
  begin
    if @i_criterio = 'T'
      insert into cob_remesas..pe_oficina_autorizada
        select
          @i_producto,@i_prod_banc,of_oficina,@i_estado,getdate(),
          getdate(),@i_fecha_inicio
        from   cobis..cl_oficina
        where  of_subtipo = 'O'
           and of_oficina not in (select
                                    oa_oficina
                                  from   cob_remesas..pe_oficina_autorizada
                                  where  oa_producto  = @i_producto
                                     and oa_prod_banc = @i_prod_banc)
    else if @i_criterio = 'R'
      insert into cob_remesas..pe_oficina_autorizada
        select
          @i_producto,@i_prod_banc,of_oficina,@i_estado,getdate(),
          getdate(),@i_fecha_inicio
        from   cobis..cl_oficina
        where  of_subtipo  = 'O'
           and of_regional = @i_oficina
           and of_oficina not in (select
                                    oa_oficina
                                  from   cob_remesas..pe_oficina_autorizada
                                  where  oa_producto  = @i_producto
                                     and oa_prod_banc = @i_prod_banc)
    else if @i_criterio = 'Z'
      insert into cob_remesas..pe_oficina_autorizada
        select
          @i_producto,@i_prod_banc,of_oficina,@i_estado,getdate(),
          getdate(),@i_fecha_inicio
        from   cobis..cl_oficina
        where  of_subtipo = 'O'
           and of_zona    = @i_oficina
           and of_oficina not in (select
                                    oa_oficina
                                  from   cob_remesas..pe_oficina_autorizada
                                  where  oa_producto  = @i_producto
                                     and oa_prod_banc = @i_prod_banc)
    else if @i_criterio = 'O'
      insert into cob_remesas..pe_oficina_autorizada
        select
          @i_producto,@i_prod_banc,of_oficina,@i_estado,getdate(),
          getdate(),@i_fecha_inicio
        from   cobis..cl_oficina
        where  of_subtipo = 'O'
           and of_oficina = @i_oficina
           and of_oficina not in (select
                                    oa_oficina
                                  from   cob_remesas..pe_oficina_autorizada
                                  where  oa_producto  = @i_producto
                                     and oa_prod_banc = @i_prod_banc)
    else
      print 'Criterio seleccionado no es valido'

    if @w_debug = 'S'
      select
        *
      from   cob_remesas..pe_oficina_autorizada
      where  oa_prod_banc = @i_prod_banc
    return 0
  end

go 
