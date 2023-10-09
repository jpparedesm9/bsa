/************************************************************************/
/*      Archivo:                cl_estconv.sp                           */
/*      Stored procedure:       sp_estadisticasconv                     */
/*      Base de datos:          COBIS                                   */
/*      Producto:               CLIENTES                                */
/*      Disenado por:           Etna Laguna                             */
/*      Fecha de escritura:     11/03/06                                */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*                             PROPOSITO                                */
/* Actualización de la información de Clientes y vinculación de         */
/* direcciones y telefonos a porductos desde pit                        */
/************************************************************************/
/*                            MODIFICACIONES                            */
/*      FECHA           AUTOR               RAZON                       */
/*      11/03/2006      Etna Laguna         Emision Inicial             */
/*      02/05/2016      DFu                 Migracion CEN               */
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
           where  name = 'sp_estadisticasconv')
  drop proc sp_estadisticasconv
go

create proc sp_estadisticasconv
(
  @t_show_version      bit = 0,
  @o_interfase         int output,
  @o_procesados        int output,
  @o_rechazados        int output,
  @o_registros_totales int output,
  @o_fecha_proceso     datetime output
)
as
  declare
    @w_sp_name           char(30),
    @w_interfase         int,
    @w_procesados        int,
    @w_rechazados        int,
    @w_registros_totales int,
    @w_fecha_proceso     datetime

  select
    @w_sp_name = 'sp_estadisticasconv'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  select
    @w_interfase = ec_interfase
  from   cobis..cl_est_convivencia

  select
    @w_procesados = count(0)
  from   cobis..cl_actente_conv
  where  aac_error = 5

  select
    @w_rechazados = count(0)
  from   cobis..cl_actente_conv
  where  aac_error <> 5

  select
    @w_registros_totales = count(0)
  from   cobis..cl_actente_conv

  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  select
    @o_interfase = @w_interfase
  select
    @o_procesados = @w_procesados
  select
    @o_rechazados = @w_rechazados
  select
    @o_registros_totales = @w_registros_totales
  select
    @o_fecha_proceso = @w_fecha_proceso

  select
    @o_interfase
  select
    @o_procesados
  select
    @o_rechazados
  select
    @o_registros_totales
  select
    @o_fecha_proceso

  return 0

go

