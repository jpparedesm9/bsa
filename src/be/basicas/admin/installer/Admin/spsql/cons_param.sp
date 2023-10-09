/************************************************************************/
/*	Archivo: 		coparam.sp				*/
/*	Stored procedure: 	sp_cons_param        		        */
/*	Base de datos:  	cobis				        */
/*	Producto: Cuentas Corrientes					*/
/*	Disenado por:  Mauricio Bayas/Sandra Ortiz			*/
/*	Fecha de escritura: 02-Jun-1993					*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa realiza la consulta de los parametros definidos   */ 
/*	en default para una transaccion dada.                           */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	02/Jun/1993	P Mena		Emision inicial			*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_cons_param')
   drop proc sp_cons_param








go
create proc sp_cons_param (
	@s_ssn			int = NULL,
	@s_user			login = NULL,
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
	@t_trn			smallint =NULL,
	@i_pro		      tinyint,
	@i_mon		      tinyint,
	@i_tipo		      char(1),
	@i_trn		      smallint,
	@i_cat		      char(1)
)
as
declare @w_return		int,
	@w_sp_name		varchar(30),
	@w_cliente		int,
	@w_cuenta		int

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_cons_param'

/* Modo de debug */


if @t_trn = 15092
begin
/*  Chequeo de Existencias  */
exec @w_return = cobis..sp_catalogo
	@t_debug	= @t_debug,
	@t_file		= @t_file,
	@t_from		= @w_sp_name,
	@i_tabla	= 'cc_categoria',
	@i_operacion	= 'E',
	@i_codigo	= @i_cat
if @w_return != 0
begin
	/*  No existe categoria de cuenta corriente  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,

		@i_num	= 201018
	return 1
end

if not exists 	(select	*
		  from	cobis..cl_pro_moneda
		 where	pm_producto = @i_pro
		   and	pm_moneda = @i_mon
		   and	pm_tipo	= @i_tipo)
begin
	/*  No existe producto moneda  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 101031
	return 1
end

if not exists 	(select	*
		  from	cobis..cl_ttransaccion
		 where	tn_trn_code = @i_trn)
begin
	/*  No existe transaccion  */
	exec cobis..sp_cerror
		@t_debug= @t_debug,
		@t_file	= @t_file,
		@t_from	= @w_sp_name,
		@i_num	= 151007
	return 1
end


select	'Nemonico' = substring(dt_default, 1, 6),
	'Descripcion' = df_descripcion
  from	cobis..cl_def_tran,
	cobis..cl_default_tr
 where	dt_producto = @i_pro
   and	dt_tipo = @i_tipo
   and	dt_moneda = @i_mon
   and	dt_transaccion = @i_trn
   and	dt_categoria = @i_cat
   and	dt_default = df_nemonico

return 0
end
else
begin
	exec sp_cerror
	   @t_debug	 = @t_debug,
	   @t_file	 = @t_file,
	   @t_from	 = @w_sp_name,
	   @i_num	 = 151051
	   /*  'No corresponde codigo de transaccion' */
	return 1
end
go
