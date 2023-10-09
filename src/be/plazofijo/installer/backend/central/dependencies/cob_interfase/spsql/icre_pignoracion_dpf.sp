/************************************************************************/
/*  Archivo:              icre_pignoracion_dpf.sp                       */
/*  Stored procedure: 	  sp_icre_pignoracion_dpf                       */
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

if object_id('sp_icre_pignoracion_dpf') is not null
   drop procedure sp_icre_pignoracion_dpf
go

create proc sp_icre_pignoracion_dpf(
@s_ssn             int             = NULL,      
@s_user            varchar(30)     = NULL,      
@s_term            descripcion     = NULL,      
@s_srv             varchar(30)     = NULL,      
@s_ofi             smallint        = NULL,
@s_org             smallint        = NULL,
@s_lsrv            varchar(30)     = NULL,      
@s_rol             smallint        = NULL,      
@s_date            datetime        = NULL,                             
@i_modo            tinyint         = NULL,      
@i_tasa_actual     float           = NULL,      
@i_tasa_ant        float           = NULL,                 
@i_num_operacion   varchar(30)     = NULL,           
@i_producto        int             = NULL)
with encryption
as
return 0
go
