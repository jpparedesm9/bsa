/************************************************************************/
/*	Archivo:		fechapro.sp				*/
/*	Stored procedure:	sp_fechapro                             */
/*	Base de datos:		cobis					*/
/*	Producto:       	MIS    				        */
/*	Disenado por:           C. Espinel 				*/
/*	Fecha de escritura:     24/JUN/94				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes  exclusivos  para el  Ecuador  de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su  uso no autorizado  queda expresamente  prohibido asi como	*/
/*	cualquier   alteracion  o  agregado  hecho por  alguno de sus	*/
/*	usuarios   sin el debido  consentimiento  por  escrito  de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/*				PROPOSITO				*/
/*	Este programa devuelve la fecha de proceso del sistema		*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cobis 
go

if exists (select * from sysobjects where name = 'sp_fechapro')
   drop proc sp_fechapro
go

create proc sp_fechapro (
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
	@t_trn			smallint = null,
	@i_formato_fecha	int	= null
)
as

declare @w_return       int,
        @w_sp_name	varchar(32)

select @w_sp_name = 'sp_fechapro'

   if @t_trn != 15168
   begin
   -- No corresponde codigo de transaccion
      exec sp_cerror
   	   @t_debug	 = @t_debug,
   	   @t_file	 = @t_file,
   	   @t_from	 = @w_sp_name,
   	   @i_num	 = 151051
      return 1
   end

   -- Envio resultado de producto instalado y fecha de proceso
      select convert(char(10),@s_date,@i_formato_fecha)   

return 0
go
