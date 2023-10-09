/************************************************************************/
/*  Archivo:              icar_consulta_cuota.sp                        */
/*  Stored procedure: 	  sp_icar_consulta_cuota                        */
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

if object_id('sp_icar_consulta_cuota') is not null
   drop procedure sp_icar_consulta_cuota
go

create proc sp_icar_consulta_cuota(
@i_operacionca       int             = NULL,
@i_fecha_proceso     datetime        = NULL,
@i_incluir_vigente   char(1)         = NULL,      
@i_moneda            int             = NULL,      
@o_monto             money           = NULL      out)
with encryption
as
select @o_monto = 0
return 0
go
