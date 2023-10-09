/************************************************************************/
/*   Stored procedure:     sp_causa_E014                                */
/*   Base de datos:        cob_ahorros                                  */
/************************************************************************/
/*                                  IMPORTANTE                          */
/*   Esta aplicacion es parte de los paquetes bancarios propiedad       */
/*   de COBISCorp.                                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado  hecho por alguno de sus           */
/*   usuarios sin el debido consentimiento por escrito de COBISCorp.    */
/*   Este programa esta protegido por la ley de derechos de autor       */
/*   y por las convenciones  internacionales   de  propiedad inte-      */
/*   lectual.    Su uso no  autorizado dara  derecho a COBISCorp para   */
/*   obtener ordenes  de secuestro o retencion y para  perseguir        */
/*   penalmente a los autores de cualquier infraccion.                  */
/************************************************************************/
/*                            PROPOSITO                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   02/May/2016        J. Calderon     Migración a CEN                 */
/************************************************************************/

use cob_ahorros
GO

set ANSI_NULLS off
GO
set QUOTED_IDENTIFIER off
GO

if exists (select
             1
           from   sysobjects
           where  name = 'sp_causa_E014')
  drop proc sp_causa_E014
go

create proc sp_causa_E014
(
  @s_date         datetime,
  @s_user         login,
  @s_ofi          int = null,
  @t_show_version bit = 0,
  @i_operacion    char(1),-- 'E' -> Ejecutar, 'R' -> Reversar, 'A' -> Anular
  @i_idorden      int = 0,
  @i_ref1         int = 0,
  @i_ref2         int = 0,
  @i_ref3         varchar(30) = '',
  @i_debug        char(1) = 'N',
  @i_interfaz     char(1) = 'N'
)
as
  declare
    @w_error   int,
    @w_sp_name varchar(30)

  /* Captura del nombre del Store Procedure */
    select
    @w_sp_name = 'sp_causa_E014'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  --------------------------------------------------
  --MARCAR COMO EJECUTADA UNA ORDEN DE COBRO O PAGO 
  --------------------------------------------------

  if @i_operacion = 'E'
  begin
    ------------------------------------------------------------
    --Actualiza estado del registro de cierre
    ------------------------------------------------------------   
    update cob_ahorros..ah_his_cierre
    set    hc_estado = 'P',
           hc_fecha_act = @s_date,
           hc_usuario_pg = @s_user
    where  hc_cuenta       = @i_ref1
       and hc_sec_ord_pago = @i_idorden

    if @@error <> 0
        or @@rowcount <> 1
    begin
      --Error al Actualizar Cuenta en Historico de Cierre

      select
        @w_error = 258004
      if @i_interfaz = 'S'
        return @w_error
      else
        goto ERROR
    end
    return 0
  end

  --------------------------------------
  -- REVERSAR UNA ORDEN DE COBRO O PAGO 
  --------------------------------------

  if @i_operacion = 'R'
  begin
    ------------------------------------------------------------
    --Actualiza estado del registro de cierre
    ------------------------------------------------------------   
    update cob_ahorros..ah_his_cierre
    set    hc_estado = 'C',
           hc_fecha_act = null,
           hc_usuario_pg = null
    where  hc_cuenta       = @i_ref1
       and hc_estado       = 'P'
       and hc_sec_ord_pago = @i_idorden

    if @@error <> 0
        or @@rowcount <> 1
    begin
      --Error al Actualizar Cuenta en Historico de Cierre
      select
        @w_error = 258004
      if @i_interfaz = 'S'
        return @w_error
      else
        goto ERROR
    end
    return 0
  end

  -------------------------------------------------
  -- MARCAR COMO ANULADA UNA ORDEN DE COBRO O PAGO
  ------------------------------------------------- 

  if @i_operacion = 'A'
  begin
    ------------------------------------------------------------
    --Actualiza estado del registro de cierre
    ------------------------------------------------------------   

    update cob_ahorros..ah_his_cierre
    set    hc_estado = 'R' --@i_operacion
    where  hc_cuenta       = @i_ref1
       and hc_sec_ord_pago = @i_idorden

    if @@error <> 0
        or @@rowcount <> 1
    begin
      --Error al Actualizar Cuenta en Historico de Cierre
      select
        @w_error = 258004
      if @i_interfaz = 'S'
        return @w_error
      else
        goto ERROR
    end
    return 0
  end

  return 0

  ERROR:
  exec cobis..sp_cerror
    @i_num = @w_error
  return @w_error

go

