/************************************************************************/
/*  Archivo:              isba_cseqnos.sp                               */
/*  Stored procedure:     sp_isba_cseqnos                               */
/*  Base de datos:     cob_interfase                                 */
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

if object_id('sp_isba_cseqnos') is not null
   drop procedure sp_isba_cseqnos
go

create proc sp_isba_cseqnos(
@i_tabla           varchar(30)     = NULL,      
@o_siguiente       int             = NULL   out)
with encryption
as
declare
@w_return          int

exec @w_return = cob_sbancarios..sp_cseqnos
@i_tabla       = @i_tabla,
@o_siguiente   = @o_siguiente out

if @w_return <> 0 or @@error <> 0 begin
   exec cobis..sp_cerror
   @i_num = 2902990
   return 2902990
end
   
if @o_siguiente is null
   select @o_siguiente = 1
   
return 0
go

