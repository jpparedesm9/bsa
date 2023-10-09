/************************************************************************/
/*    Archivo:             cons_nom_ctahorro.sp                         */
/*    Stored procedure:    sp_cons_nom_ctahorro                         */
/*    Base de datos:       cob_ahorros                                  */
/*    Producto:            Cuentas de Ahorros                           */
/*    Disenado por:        Mauricio Bayas/Sandra Ortiz                  */
/*    Fecha de escritura:  24-Nov-1993                                  */
/************************************************************************/
/*                            IMPORTANTE                                */
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
/*    Este programa realiza la transaccion de consulta del nombre       */
/*    de la cuenta de ahorros.                                          */
/************************************************************************/
/*                          MODIFICACIONES                              */
/*    FECHA          AUTOR           RAZON                              */
/*    24/Nov/1993    P. Mena         Emision inicial                    */
/*    02/May/2016    J. Calderon     Migración a CEN                    */
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
           where  name = 'sp_cons_nom_ctahorro')
  drop proc sp_cons_nom_ctahorro
go

create proc sp_cons_nom_ctahorro
(
  @t_debug        char(1) = 'N',
  @t_file         varchar(14) = null,
  @t_from         varchar(32) = null,
  @t_trn          int,
  @t_show_version bit = 0,
  @i_cta          cuenta,
  @i_mon          tinyint,
  @i_operacion    char(1) = 'Q',
  @o_nombre_cta   varchar(60) = null out,
  @o_ced_ruc      varchar(15) = null out
)
as
  declare
    @w_return  int,
    @w_sp_name varchar(30),
    @w_cuenta  int,
    @w_nombre  descripcion,
    @w_ced_ruc numero

  /* Captura del nombre del Store Procedure */
  select
    @w_sp_name = 'sp_cons_nom_ctahorro'

  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  if @t_show_version = 1
  begin
    print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    return 0
  end

  if @i_operacion = 'Q'
  begin
    /* Variables de Trabajo */
    select
      @o_nombre_cta = ah_nombre,
      @o_ced_ruc = ah_ced_ruc
    from   cob_ahorros..ah_cuenta
    where  ah_cta_banco = @i_cta
       and ah_moneda    = @i_mon

    if @@rowcount = 0
    begin
      /* No existe cuenta_banco */
      exec cobis..sp_cerror
        @t_debug = @t_debug,
        @t_file  = @t_file,
        @t_from  = @w_sp_name,
        @i_num   = 251001,
        @i_sev   = 0,
        @i_msg   = 'No existe cuenta de ahorros'
      return 251001
    end

  end

  return 0

go


