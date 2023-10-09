/****************************************************************/
/* ARCHIVO:         b_cseqno.sp                                 */
/* NOMBRE LOGICO:   sp_cseqnos		                        */
/* PRODUCTO:        SERVICIOS BANCARIOS                         */
/****************************************************************/
/*                         IMPORTANTE                           */
/* Esta aplicacion es parte de los paquetes bancarios propiedad */
/* de MACOSA S.A.                                               */
/* Su uso no  autorizado queda  expresamente prohibido asi como */
/* cualquier  alteracion  o agregado  hecho por  alguno  de sus */
/* usuarios sin el debido consentimiento por escrito de MACOSA. */
/* Este programa esta protegido por la ley de derechos de autor */
/* y por las  convenciones  internacionales de  propiedad inte- */
/* lectual.  Su uso no  autorizado dara  derecho a  MACOSA para */
/* obtener  ordenes de  secuestro o retencion y  para perseguir */
/* penalmente a los autores de cualquier infraccion.            */
/****************************************************************/
/*                          PROPOSITO                           */
/* Este stored procedure permite generar un secuencial para una */
/* tabla especifica de servicios bancarios .		        */
/****************************************************************/
/*                      MODIFICACIONES                          */
/* FECHA         AUTOR            RAZON                         */
/* 10/Ene/2000	 L. Chango 	  Emision Inicial		*/
/****************************************************************/

use cob_sbancarios
go

if exists (select 1 from sysobjects where name = 'sp_cseqnos')
	drop proc sp_cseqnos
go

create proc sp_cseqnos (
	@s_ssn			int = NULL,
	@s_user			varchar(14) = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error			int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			varchar(64) = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@i_tabla 	       		varchar(30), 
	@i_batch			char(1)	= 'N',	
	@o_siguiente 		int=null out
	)
as
declare @w_return       int,
        @w_sp_name      varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cseqnos'


/*  Modo de debug  */
if @i_batch = 'N'
   begin tran
        /* si no existe el secuencial para la tabla dada, error */
	if not exists ( select siguiente
		 	  from sb_seqnos
			 where tabla = @i_tabla )
	begin
                exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file    = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 151028,
                        @i_sev 	  = 0

                if @i_batch = 'N'        
                   rollback tran         
                
                return 1
	end

        /* sumar uno al secuencial de la tabla */
	update sb_seqnos
		set siguiente = siguiente + 1
		where tabla = @i_tabla

        /* si no se puede realizar la modificacion, error */
	if @@error <> 0
	begin
                exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 105001
                return 1
	end

        /* retornar el nuevo secuencial */
	select @o_siguiente = siguiente 
		from sb_seqnos
		where tabla = @i_tabla

        /* mensaje si secuencial llega al limite */
        if @o_siguiente = 2147483647
           print 'Secuencial llego al limite'

if @i_batch = 'N'
   commit tran



return 0
go

