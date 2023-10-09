/************************************************************************/
/*	Archivo: 		cseqnos.sp				*/
/*	Stored procedure: 	sp_cseqnos				*/
/*	Base de datos:  	cobis					*/
/*	Producto: 		Administrador				*/
/*	Disenado por:  		Mauricio Bayas/Sandra Ortiz		*/
/*	Fecha de documentacion:	17/Nov/93				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*      Retornar un nuevo secuencial para la tabla pasada como          */
/*      parametro.                                                      */
/*      Notas: las tablas se inicializan con secuencial cero            */
/*             mensaje de error si secuencial llega a 2147483647        */ 
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      17/Nov/93       R. Minga V.     Documentacion                   */
/*	04/May/94	F.Espinosa	Parametros tipo "S"		*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_cseqnos')
	drop proc sp_cseqnos
go

create proc sp_cseqnos (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(30) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@i_tabla 	        varchar(30), 
	@o_siguiente 		int=null out
	)
as
declare @w_return       int,
        @w_sp_name      varchar(30)

/*  Captura nombre de Stored Procedure  */
select  @w_sp_name = 'sp_cseqnos'


/*  Modo de debug  */

begin tran
        /* si no existe el secuencial para la tabla dada, error */
	if not exists ( select siguiente
		 	  from cobis..cl_seqnos
			 where tabla = @i_tabla )
	begin
                exec cobis..sp_cerror
                        @t_debug  = @t_debug,
                        @t_file   = @t_file,
                        @t_from   = @w_sp_name,
                        @i_num    = 151028
                return 1
	end

        /* sumar uno al secuencial de la tabla */
	update cl_seqnos
		set siguiente = siguiente + 1
		where tabla = @i_tabla

        /* si no se puede realizar la modificacion, error */
	if @@error != 0
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
		from cobis..cl_seqnos
		where tabla = @i_tabla

        /* mensaje si secuencial llega al limite */
        if @o_siguiente = 2147483647
           print 'Secuencial llego al limite'


commit tran
go
