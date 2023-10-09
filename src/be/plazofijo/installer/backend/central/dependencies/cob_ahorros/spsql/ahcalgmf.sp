/************************************************************************/
/*   Archivo:             ahcalgmf.sp                                   */
/*   Stored procedure:    sp_calcula_gmf                                */
/*   Base de datos:  	  cob_ahorros                                   */
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
/************************************************************************/
use cob_ahorros
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_calcula_gmf')
   drop proc sp_calcula_gmf
go

create proc sp_calcula_gmf( 
@s_user                                    varchar(30)      = null,
@s_date                                    datetime,        
@s_ofi                                     smallint         = null,        
@t_debug                                   char(1)          = 'N',
@t_file                                    varchar(14)      = null,
@t_from                                    varchar(32)      = null,
@t_trn                                     smallint         = null,
@t_ssn_corr                                int              = null,
@i_factor                                  smallint         = null,  
@i_mon                                     tinyint          = 0,
@i_cta                                     cuenta           = null,          
@i_cuenta                                  int,             
@i_val                                     money            = 0,
@i_numdeciimp                              tinyint          = 0,
@i_producto                                tinyint          = 4,
@i_operacion                               char(1)          = 'Q',
@i_corr                                    char(1)          = null,
@i_reverso                                 char(1)          = null,
@i_val_tran                                money            = null,
@i_total                                   char(1)          = 'N',
@i_acum_deb                                money            = 0,
@i_is_batch                                char(1)          = 'N',
@i_cliente                                 int              = null,      
@o_total_gmf                               money            = 0      OUT,
@o_acumu_deb                               money            = 0      OUT,
@o_actualiza                               char(1)          = null   OUT,
@o_base_gmf                                money            = 0      OUT,
@o_concepto                                smallint         = 0      OUT,
@o_tasa                                    float            = 0      OUT,
@o_difer_gmf                               money            = 0      OUT,
@o_tasa_reintegro                          float            = 0      OUT,
@o_valor_reintegro                         money            = 0      OUT 
)
as
select @o_total_gmf       = 0   
select @o_acumu_deb       = 0   
select @o_actualiza       = 'N'
select @o_base_gmf        = 0
select @o_concepto        = 0
select @o_tasa            = 0
select @o_difer_gmf       = 0
select @o_tasa_reintegro  = 0
select @o_valor_reintegro = 0
return 0
go
