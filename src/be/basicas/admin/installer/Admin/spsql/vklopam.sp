/************************************************************************/
/*	Archivo:		vklopam.sp				*/
/*	Stored procedure:	sp_vklopam                             */
/*	Base de datos:		cobis					*/
/*	Producto:       	ADMIN    			        */
/*	Disenado por:           Juan Loaiza 				*/
/*	Fecha de escritura:     28/MAR/05				*/
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
/*	28/03/05	Juan Loaiza	Emisión Inicila			*/
/************************************************************************/
use cobis 
go

if exists (select * from sysobjects where name = 'sp_vklopam')
   drop proc sp_vklopam
go

create proc sp_vklopam (
	@s_ssn			int = NULL,
	@s_lopam			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
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
	@t_trn			smallint = null
)
as

declare @w_return       int,
        @w_sp_name	varchar(32)

select @w_sp_name = 'sp_vklopam'

if @t_trn != 159012
   begin
   -- No corresponde codigo de transaccion
      exec sp_cerror
   	   @t_debug	 = @t_debug,
   	   @t_file	 = @t_file,
   	   @t_from	 = @w_sp_name,
   	   @i_num	 = 151051
      return 1
   end


return 0
go
