/************************************************************************/
/*   Archivo:             b_cseqno.sp                                   */
/*   Stored procedure:    sp_cseqnos		                            */
/*   Base de datos:  	  cob_interfase                                 */
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
/*   Este stored procedure permite generar un secuencial para una       */
/*   tabla especifica de servicios bancarios                            */
/************************************************************************/
/*                              CAMBIOS                                 */
/*   FECHA              AUTOR             CAMBIOS                       */
/*   19/Jul/2016        Oscar Saavedra    Instalador Version Davivienda */
/************************************************************************/
use cob_sbancarios
go

SET NOCOUNT ON
go

SET ANSI_NULLS ON
go

SET QUOTED_IDENTIFIER ON
go

if exists (select 1 from sysobjects where name = 'sp_cseqnos')
   drop proc sp_cseqnos
go

create proc sp_cseqnos(
@s_ssn			                           int              = NULL,
@s_user			                           varchar(14)      = NULL,
@s_sesn			                           int              = NULL,
@s_term			                           varchar(30)      = NULL,
@s_date			                           datetime         = NULL,
@s_srv			                           varchar(30)      = NULL,
@s_lsrv			                           varchar(30)      = NULL, 
@s_rol			                           smallint         = NULL,
@s_ofi			                           smallint         = NULL,
@s_org_err		                           char(1)          = NULL,
@s_error                                   int              = NULL,
@s_sev			                           tinyint          = NULL,
@s_msg			                           varchar(64)      = NULL,
@s_org			                           char(1)          = NULL,
@t_debug		                           char(1)          = 'N',
@t_file			                           varchar(14)      = null,
@t_from			                           varchar(32)      = null,
@i_tabla 	       		                   varchar(30),      
@i_batch			                       char(1)          = 'N',	
@o_siguiente 		                       int              = null   OUT
)
as
declare
@w_return                                  int,
@w_sp_name                                 varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cseqnos'

/*  Modo de debug  */
if @i_batch = 'N'
   begin tran
   
if not exists (select siguiente from sb_seqnos where tabla = @i_tabla) begin
   exec cobis..sp_cerror
   @t_debug  = @t_debug,
   @t_file   = @t_file,
   @t_from   = @w_sp_name,
   @i_num    = 151028,
   @i_sev    = 0
   
   if @i_batch = 'N'
      rollback tran
   
  return 1
end

/* sumar uno al secuencial de la tabla */
update sb_seqnos
set    siguiente = siguiente + 1
where  tabla     = @i_tabla

/* si no se puede realizar la modificacion, error */
if @@error <> 0 begin
   exec cobis..sp_cerror
   @t_debug = @t_debug,
   @t_file  = @t_file,
   @t_from  = @w_sp_name,
   @i_num   = 105001
   return 1
end

/* retornar el nuevo secuencial */
select @o_siguiente = siguiente
from   sb_seqnos
where  tabla        = @i_tabla

/* mensaje si secuencial llega al limite */
if @o_siguiente = 2147483647
   print 'Secuencial llego al limite'

if @i_batch = 'N'
   commit tran

return 0
go
