/************************************************************************/
/*	Archivo: 		cotrans.sp				*/
/*	Stored procedure: 	sp_cons_trn        		        */
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
/*	Este programa realiza la consulta de las transacciones          */ 
/*	definidas para un producto, moneda y tipo dados.                */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	02/Jun/1993	P Mena		Emision inicial			*/
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_cons_trn')
   drop proc sp_cons_trn
go
create proc sp_cons_trn (
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
	@t_trn			smallint =NULL,
	@i_pro		      tinyint,
	@i_mon		      tinyint,
	@i_tipo		      char(1),
	@i_modo		      tinyint,
	@i_transaccion	      int = null 
)
as
declare @w_return		int,
	@w_sp_name		varchar(30)

/* Captura del nombre del Stored Procedure */
select @w_sp_name = 'sp_cons_trn'

if @t_trn = 15091
begin
set rowcount  20
if @i_modo = 0
begin
	select	distinct pt_transaccion Trn_Code,
		substring(tn_descripcion,1,35) Descripcion
	  from	cobis..ad_pro_transaccion,
		cobis..cl_ttransaccion
	 where	pt_producto = @i_pro
	   and	pt_tipo = @i_tipo
	   and	pt_moneda = @i_mon
	   and	pt_transaccion = tn_trn_code
	order by pt_transaccion
end

if @i_modo = 1
begin
	select	distinct pt_transaccion Trn_Code,
		substring(tn_descripcion,1,35) Descripcion
	  from	cobis..ad_pro_transaccion,
		cobis..cl_ttransaccion
	 where	pt_producto = @i_pro
	   and	pt_tipo = @i_tipo
	   and	pt_moneda = @i_mon
	   and	pt_transaccion = tn_trn_code
	   and  pt_transaccion > @i_transaccion
	order by pt_transaccion
end
if @i_modo = 2
begin
	select	distinct pt_transaccion Trn_Code,
		substring(tn_descripcion,1,35) Descripcion
	  from	cobis..ad_pro_transaccion,
		cobis..cl_ttransaccion
	 where	pt_producto = @i_pro
	   and	pt_tipo = @i_tipo
--	   and	pt_moneda = @i_mon
	   and	pt_transaccion = tn_trn_code
	order by pt_transaccion
end

if @i_modo = 3
begin
	select	distinct pt_transaccion Trn_Code,
		substring(tn_descripcion,1,35) Descripcion
	  from	cobis..ad_pro_transaccion,
		cobis..cl_ttransaccion
	 where	pt_producto = @i_pro
	   and	pt_tipo = @i_tipo
--	   and	pt_moneda = @i_mon
	   and	pt_transaccion = tn_trn_code
	   and  pt_transaccion > @i_transaccion
	order by pt_transaccion
end
set rowcount 0
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
