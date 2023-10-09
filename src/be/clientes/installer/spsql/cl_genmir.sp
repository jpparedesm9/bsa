/************************************************************************/
/*    Archivo:             cl_genmir.sp                                 */
/*    Stored procedure:    sp_genera_mir                                */
/*    Base de datos:       cobis                                        */
/*    Producto:            MIS                                          */
/************************************************************************/
/*                              IMPORTANTE                              */
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
/*                                                                      */
/************************************************************************/
/*                MODIFICACIONES                                        */
/*    FECHA             AUTOR         RAZON                             */
/*    May/02/2016     DFu             Migracion CEN                     */
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
           where  name = 'sp_genera_mir')
  drop proc sp_genera_mir
go

create proc sp_genera_mir
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name char(30),
    @w_fecha   datetime,
    @w_fecha1  datetime

  select
    @w_sp_name = 'sp_genera_mir'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_fecha = pa_datetime
  from   cobis..cl_parametro
  where  pa_nemonico = 'FECMIR'
     and pa_producto = 'MIS'

  select
    @w_fecha1 = pa_datetime
  from   cobis..cl_parametro
  where  pa_nemonico = 'FEMIRB'
     and pa_producto = 'MIS'

  if @w_fecha is not null
    update cobis..cl_orden_consulta_ext
    set    oc_estado = 'ING',
           oc_fecha_real_ing = @w_fecha,
           oc_fecha_ing = @w_fecha
    where  oc_tconsulta      = '05'
       and oc_usuario        = 'opbatch'
       and oc_fecha_real_ing >= @w_fecha1 - 1
       and oc_fecha_real_ing <= @w_fecha1 + 1
       and oc_estado         <> 'PRO'

  return 0

go

