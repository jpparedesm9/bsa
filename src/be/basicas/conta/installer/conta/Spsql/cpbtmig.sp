/************************************************************************/
/*	Archivo: 		cpbtmig.sp			        */
/*	Stored procedure: 	sp_comprobtmig				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
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
/*	Inserta el header de comprobante en la tabla temporal  		*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comprobtmig')
	drop proc sp_comprobtmig  
go
create proc sp_comprobtmig (
	@s_ssn			int = null,
	@s_date			datetime = null,
	@s_user			login = null,
	@s_term			descripcion = null,
	@s_corr			char(1) = null,
	@s_ssn_corr		int = null,
        @s_ofi	        	smallint = null,
	@t_rty			char(1) = null,
        @t_trn			smallint = null,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1) = null,
	@i_modo			smallint = null,
	@i_comprobante 		int = null, 
	@i_empresa  		tinyint = null, 
  	@i_fecha_tran 		datetime = null,    
	@i_oficina_orig 	smallint = null,
	@i_area_orig		smallint = null,
	@i_fecha_dig 		datetime = null,    
        @i_fecha        	datetime = null,
	@i_fecha_mod 		datetime = null,    
	@i_digitador 		descripcion = null,   
	@i_descripcion 		descripcion = null, 
	@i_mayorizado 		char (1)  = null,    
	@i_comp_tipo 		int    = null ,
	@i_detalles 		int = null,         
	@i_tot_debito 		money = null,    
	@i_tot_credito 		money = null,    
	@i_tot_debito_me 	money = null,
	@i_tot_credito_me 	money = null,
	@i_automatico		smallint = 0,
	@i_reversado		char(1) = null,
	@i_autorizado		char(1) = 'S',
	@i_mayoriza		char(1) = null ,
	@i_autorizante 		descripcion = null,
        @i_referencia 		varchar(10) = null
)
as
declare
	@w_today 		datetime,  	
	@w_return		int,		
	@w_sp_name		varchar(32),	
	@w_numero_actual 	int,
	@w_siguiente		int




select @w_today = getdate()
select @i_fecha_dig = @w_today
select @i_fecha_mod = @w_today
select @w_sp_name = 'sp_comprobtmig'




exec @w_return = cob_conta..sp_cseqcomp
	@i_empresa = @i_empresa,
	@i_fecha   = @i_fecha_tran,
	@i_tabla   = 'cb_tcomprobante',
	@i_modulo  = 6,
	@i_modo    = 1,
	@o_siguiente = @w_siguiente out


if @w_return <> 0
begin
	return @w_return
end



select @w_numero_actual = @w_siguiente


begin tran
	insert into cb_tcomprobante (
		ct_comprobante,ct_empresa,ct_fecha_tran,
		ct_oficina_orig,ct_area_orig,ct_fecha_dig,
		ct_fecha_mod,ct_digitador,ct_descripcion,
		ct_mayorizado,ct_comp_tipo,ct_detalles,
		ct_tot_debito,ct_tot_credito,ct_tot_debito_me,
		ct_tot_credito_me,ct_automatico,ct_reversado,
		ct_autorizado,ct_mayoriza,ct_autorizante,ct_referencia
	)
	values (
		@w_numero_actual,@i_empresa,@i_fecha_tran,
		@i_oficina_orig,@i_area_orig,@i_fecha_dig,
		@i_fecha_mod,@i_digitador,@i_descripcion,
		@i_mayorizado,@i_comp_tipo,@i_detalles,
		@i_tot_debito,@i_tot_credito,@i_tot_debito_me,
		@i_tot_credito_me,@i_automatico,@i_reversado,
		@i_autorizado,@i_mayoriza,@i_autorizante,@i_referencia
	)

	if @@error <> 0  
	begin
		exec cobis..sp_cerror            
			@t_debug	= @t_debug,      
			@t_file 	= @t_file,       
			@t_from		= @w_sp_name,    
			@i_num		= 603019         
		return 1
	end

	select @w_numero_actual 
commit tran
return 0

go
