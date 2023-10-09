/************************************************************************/
/*  Archivo:              icar_abono_bv_cca.sp                          */
/*  Stored procedure: 	  sp_icar_abono_bv_cca                          */
/*  Base de datos:  	  cob_interfase                                 */
/*  Producto:             PFIJO                                         */
/*  Disenado por:         Byron Ron                                     */
/*  Fecha de escritura:   15-Jul-2009                                   */
/************************************************************************/
/*              IMPORTANTE                                              */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  'MACOSA', representantes exclusivos para el Ecuador de la           */
/*  'NCR CORPORATION'.                                                  */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier alteracion o agregado hecho por alguno de sus             */
/*  usuarios sin el debido consentimiento por escrito de la             */
/*  Presidencia Ejecutiva de MACOSA o su representante.                 */
/************************************************************************/
/*                 PROPOSITO                                            */
/*  Sp interfase.                                                       */
/************************************************************************/ 
/*              MODIFICACIONES                                          */
/*  FECHA           AUTOR           RAZON                               */
/*  15-JUL-2009     B. RON          Emision Inicial                     */
/************************************************************************/
use cob_interfase
go

SET NOCOUNT ON
go

SET ANSI_NULLS OFF
go

SET QUOTED_IDENTIFIER OFF
go

if object_id('sp_icar_abono_bv_cca') is not null begin
   drop procedure sp_icar_abono_bv_cca
end
go

create proc sp_icar_abono_bv_cca(
@s_user            varchar(30)     = NULL,      
@s_term            descripcion     = NULL,      
@s_date            datetime        = NULL,
@s_sesn            int             = NULL,
@s_ofi             smallint        = NULL,
@s_srv             varchar(30)     = NULL,      
@s_ssn             int             = NULL,      
@s_lsrv            varchar(30)     = NULL,      
@i_cta             cuenta          = NULL,      
@i_banco           cuenta          = NULL,      
@i_mon             tinyint         = NULL,                 
@i_monto_mpg       money           = NULL,           
@i_canal           tinyint         = NULL,
@i_fecha_vig       datetime        = NULL,
@i_en_linea        char            = NULL,
@o_secuencial_pag  int             = NULL    out)
with encryption
as
select @o_secuencial_pag = 0
return 0
go
