/************************************************************************/
/*   Archivo:             cl_borcobdyn.sp                               */
/*   Stored procedure:    sp_borra_cobis_dynamics                       */
/*   Base de datos:       Cobis                                         */
/*   Producto:            Batch - Clientes                              */
/*   Disenado por:        Mario Algarin                                 */
/*   Fecha:               21/Oct/2011                                   */
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
/* Proceso Batch que Borra Tabla de Interfaz Proveedores Dynamics       */
/************************************************************************/
/*                            MODIFICACIONES                            */
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
           where  name = 'sp_borra_cobis_dynamics')
  drop proc sp_borra_cobis_dynamics
go

create proc sp_borra_cobis_dynamics
(
  @t_show_version bit = 0
)
as
  declare
    @w_sp_name       varchar(30),
    @w_fecha_proceso datetime,
    @w_msg           varchar(255)

  select
    @w_sp_name = 'sp_borra_cobis_dynamics'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure= ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
  end

  set nocount on
  set ANSI_WARNINGS off

  /* CAPTURA DE FECHA PROCESO */
  select
    @w_fecha_proceso = fp_fecha
  from   cobis..ba_fecha_proceso

  begin tran

  /* BORRADO DE TABLA DE CLIENTES PROVEEDORES INTERFAZ DYNAMICS */
  if (select
        count(1)
      from   cob_externos..ex_cobis_dynamics) >= 1
  begin
    truncate table cob_externos..ex_cobis_dynamics

    if @@error <> 0
    begin
      select
        @w_msg =
      'Error Borrando Tabla de Clientes Proveedores Interfaz Dynamics'

      exec sp_errorlog
        @i_fecha       = @w_fecha_proceso,
        @i_error       = 105522,
        @i_usuario     = 'OPERADOR',
        @i_tran        = 105522,
        @i_tran_name   = @w_sp_name,
        @i_cuenta      = '',
        @i_rollback    = 'N',
        @i_descripcion = @w_msg

      print @w_msg
      return 1
    end
  end

  commit tran

  return 0

go

