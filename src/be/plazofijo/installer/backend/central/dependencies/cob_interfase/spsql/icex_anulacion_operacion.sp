/************************************************************************/
/*  Archivo:              icex_anulacion_operacion.sp                   */
/*  Stored procedure: 	  sp_icex_anulacion_operacion                   */
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
/*  Sp interfase                                                        */
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

if object_id('sp_icex_anulacion_operacion') is not null
   drop procedure sp_icex_anulacion_operacion
go

create proc sp_icex_anulacion_operacion(
@s_ssn             int             = NULL,
@s_srv             varchar(30)     = NULL,
@s_lsrv            varchar(30)     = NULL,
@s_user            varchar(30)     = NULL,      
@s_sesn            int             = NULL,
@s_term            varchar(10)     = NULL,
@s_date            datetime        = NULL,
@s_org             char(1)	       = NULL,      
@s_ofi             smallint        = NULL,
@s_rol             smallint        = NULL,                                  
@t_trn             smallint,		                                          
@i_opeban          cuenta          = NULL,
@i_feceta          datetime        = NULL, 
@i_opesba          int             = NULL,
@i_secsba          int             = NULL)
with encryption
as
return 0
go
