/************************************************************************/
/*	Archivo: 		astotmig.sp			        */
/*	Stored procedure: 	sp_asientotmig				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           					*/
/*	Fecha de escritura:     02-Dic-1999 				*/
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
/*	Este programa procesa las transacciones de:			*/
/*	Inserta los asientos de un comprobante a la tabla temporal      */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_asientotmig')
	drop proc sp_asientotmig  

go

create proc sp_asientotmig   (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi			smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1) = null,
	@i_modo			smallint = null,
	@i_fecha_tran		datetime = null,
        @i_comprobante		int = null,    
	@i_empresa 		tinyint = null,
	@i_asiento		smallint = null,
	@i_cuenta   		cuenta = null,
	@i_oficina_dest 	smallint = null,
	@i_area_dest    	smallint  = null,
	@i_credito		money = null,
	@i_debito		money = null,
	@i_concepto		descripcion = null,
	@i_credito_me		money = null,
	@i_debito_me		money = null,
	@i_cotizacion		money = null,
	@i_tipo_doc		char(1) =null,
	@i_tipo_tran		char(1) = null,
	@i_mayorizado		char(1) = null,
        @i_moneda		tinyint =  null
)
as 
declare
	@w_today 		datetime,  	
	@w_sp_name		varchar(32),	
	@w_moneda		tinyint	
				        


select @w_today = getdate()
select @w_sp_name = 'sp_asientotmig'





if @i_mayorizado = NULL
begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
	    	@t_file	 = @t_file,
	    	@t_from	 = @w_sp_name,
	    	@i_num	 = 601001
	return 1
end


if @i_moneda = null
begin
	select @w_moneda = cu_moneda
	from cob_conta..cb_cuenta
	where cu_empresa = @i_empresa and
	cu_cuenta  = @i_cuenta
end
else
begin
	select @w_moneda = @i_moneda
end


begin tran
	insert into cb_tasiento     
	(
		ta_fecha_tran,ta_comprobante,ta_empresa,
		ta_asiento,ta_cuenta,
		ta_oficina_dest,ta_area_dest,
		ta_credito,ta_debito,ta_concepto,
		ta_credito_me,ta_debito_me,ta_cotizacion,
		ta_tipo_doc,ta_tipo_tran,ta_mayorizado,ta_moneda
	)
	values 
	(
		@i_fecha_tran,@i_comprobante,@i_empresa,
		@i_asiento,@i_cuenta,
		@i_oficina_dest,@i_area_dest,
		@i_credito,@i_debito,@i_concepto,
		@i_credito_me,@i_debito_me,@i_cotizacion,
		@i_tipo_doc,@i_tipo_tran,@i_mayorizado,@w_moneda
	)

	if @@error <> 0  
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603020

		delete cob_conta..cb_tasiento
		where   ta_fecha_tran = @i_fecha_tran and
			ta_comprobante = @i_comprobante and
			ta_empresa = @i_empresa 

		delete cob_conta..cb_tcomprobante
		where 	ct_fecha_tran = @i_fecha_tran and
			ct_comprobante = @i_comprobante and
			ct_empresa = @i_empresa 
		return 1
	end

commit tran
return 0
go
