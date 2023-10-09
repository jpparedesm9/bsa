/************************************************************************/
/*  Archivo:              iaho_ahndc_automatica.sp                      */
/*  Stored procedure: 	  sp_iaho_ahndc_automatica                      */
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
/*  Sp interface.                                                       */
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

if object_id('sp_iaho_ahndc_automatica') is not null begin
   drop procedure sp_iaho_ahndc_automatica
end
go

create proc sp_iaho_ahndc_automatica(
@s_srv             varchar(30)     = NULL,
@s_ofi             smallint        = NULL,
@s_ssn             int             = NULL,
@s_user            varchar(30)     = NULL,      
@s_date            datetime        = NULL,
@t_trn             smallint,		
@i_nomtrn          varchar(10)     = NULL,      
@i_cta             cuenta          = NULL, 
@i_val             money           = NULL,  
@i_cau             varchar(10)     = NULL, 
@i_mon             tinyint         = NULL, 
@i_fecha           smalldatetime   = NULL,             
@i_concepto        varchar(64)     = NULL,       
@i_alt             int             = NULL,
@i_fecha_valor_a   datetime        = NULL,
@i_is_batch        char(1)         = NULL)
with encryption
as
return 0
go
