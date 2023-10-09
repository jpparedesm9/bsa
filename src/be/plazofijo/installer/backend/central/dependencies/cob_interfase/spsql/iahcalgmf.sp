/************************************************************************/
/*   Archivo:             ahcalgmf.sp                                   */
/*   Stored procedure:    sp_calcula_gmf                                */
/*   Base de datos:        cob_ahorros                                   */
/*   Producto:            Plazo Fijo                                    */
/*   Disenado por:        Oscar Saavedra                                */
/*   Fecha de escritura:  19 de Julio de 2016                           */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA". Su uso no autorizado queda expresamente prohibido asi    */
/*   como cualquier alteracion o agregado hecho por alguno de sus       */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                             PROPOSITO                                */
/*   Creacion Stored Procedure Cascara para instalacion de Plazo Fijo   */
/*   Version Davivienda                                                 */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   19/Jul/2016        Oscar Saavedra    Instalador Version Davivienda */
/*   09/Sep/2016        Esteban Moran     integracion AHO - llamado a sp*/
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_icalcula_gmf')
   drop proc sp_icalcula_gmf
go

create proc sp_icalcula_gmf( 
  @s_user            varchar(30) = null,
  @s_date            datetime,
  @s_ofi             smallint    = null,
  @t_debug           char(1)     = 'N',
  @t_file            varchar(14) = null,
  @t_from            varchar(32) = null,
  @t_trn             smallint    = null,
  @t_ssn_corr        int         = null,
  @t_show_version    bit         = 0,
  @i_factor          smallint    = null,
  @i_mon             tinyint     = 0,
  @i_cta             cuenta      = null,
  @i_cuenta          int,
  @i_val             money       = 0,
  @i_numdeciimp      tinyint     = 0,
  @i_producto        tinyint     = 4,
  @i_operacion       char(1)     = 'Q',
  @i_corr            char(1)     = null,
  @i_reverso         char(1)     = null,
  @i_val_tran        money       = null,
  @i_total           char(1)     = 'N',
  @i_acum_deb        money       = 0,
  @i_is_batch        char(1)     = 'N',
  @i_cliente         int         = null,
  @o_total_gmf       money       = 0    out,
  @o_acumu_deb       money       = 0    out,
  @o_actualiza       char(1)     = null out,
  @o_base_gmf        money       = 0    out,
  @o_concepto        smallint    = 0    out,
  @o_tasa            float       = 0    out,
  @o_difer_gmf       money       = 0    out,
  @o_tasa_reintegro  float       = 0    out,
  @o_valor_reintegro money       = 0    out)
as


declare @w_return  int,
        @w_sp_name varchar(30)
        
    select @w_sp_name = 'sp_icalcula_gmf'
    
------------------------------------------- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
if @t_show_version = 1
begin
    print 'Stored Procedure = ' + @w_sp_name + ' Version= ' + '4.0.0.0'
    return 0
end
-------------------------------------------------------------------------------------------------------------------

    exec  @w_return = cob_ahorros..sp_calcula_gmf
          @s_user                = @s_user,
          @s_date                = @s_date,
          @s_ofi                 = @s_ofi,
          @t_debug               = @t_debug,
          @t_file                = @t_file,
          @t_from                = @t_from,
          @t_trn                 = @t_trn,
          @t_ssn_corr            = @t_ssn_corr,
          @t_show_version        = @t_show_version,
          @i_factor              = @i_factor,
          @i_mon                 = @i_mon,
          @i_cta                 = @i_cta,
          @i_cuenta              = @i_cuenta,
          @i_val                 = @i_val,
          @i_numdeciimp          = @i_numdeciimp,
          @i_producto            = @i_producto,
          @i_operacion           = @i_operacion,
          @i_corr                = @i_corr,
          @i_reverso             = @i_reverso,
          @i_val_tran            = @i_val_tran,
          @i_total               = @i_total,
          @i_acum_deb            = @i_acum_deb,
          @i_is_batch            = @i_is_batch,
          @i_cliente             = @i_cliente,
          @o_total_gmf           = @o_total_gmf,
          @o_acumu_deb           = @o_acumu_deb,
          @o_actualiza           = @o_actualiza,
          @o_base_gmf            = @o_base_gmf,
          @o_concepto            = @o_concepto,
          @o_tasa                = @o_tasa,
          @o_difer_gmf           = @o_difer_gmf,
          @o_tasa_reintegro      = @o_tasa_reintegro
          
    if @w_return <> 0
    begin
        exec cobis..sp_cerror
             @t_debug = @t_debug,
             @t_file  = @t_file,
             @t_from  = @w_sp_name,
             @i_num   = 357055
        return 357055
    end

return 0
go
