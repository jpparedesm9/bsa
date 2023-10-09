/************************************************************************/
/*	Archivo: 		comprobt.sp			        */
/*	Stored procedure: 	sp_comprobt				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     30-julio-1993 				*/
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
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_comprobt')
	drop proc sp_comprobt  
go

create proc sp_comprobt (
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
	@i_tot_debito_me	money = null,
	@i_tot_credito_me	money = null,
	@i_automatico		smallint = 0,
	@i_reversado		char(1) = null,
	@i_autorizado		char(1) = 'S',
	@i_mayoriza		char(1) = null ,
	@i_autorizante 		descripcion = null,
        @i_referencia 		varchar(10) = null,
        @o_tcomprobante		int = null out
)
as
declare @w_return		int,		/* valor que retorna */
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_numero_actual	int,
	@w_siguiente		int,
	@w_fecha        	datetime

select @i_fecha_dig = getdate()
select @i_fecha_mod = getdate()
select @w_sp_name = 'sp_comprobt'


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_modo		= @i_modo,
		i_empresa  	= @i_empresa , 
		i_comprobante 	= @i_comprobante,
		i_oficina_orig	= @i_oficina_orig,
		i_area_orig	= @i_area_orig,
  		i_fecha_tran 	= @i_fecha_tran,
		i_fecha_dig 	= @i_fecha_dig,
		i_fecha_mod 	= @i_fecha_mod,
		i_digitador 	= @i_digitador,
		i_descripcion 	= @i_descripcion,
		i_mayorizado 	= @i_mayorizado,
		i_comp_tipo 	= @i_comp_tipo,
		i_detalles 	= @i_detalles,
		i_tot_debito 	= @i_tot_debito,
		i_tot_credito 	= @i_tot_credito,
		i_tot_debito_me = @i_tot_debito_me,
		i_tot_credito_me = @i_tot_credito_me,
		i_automatico	= @i_automatico,
		i_reversado	= @i_reversado,
		i_autorizado	= @i_autorizado
	exec cobis..sp_end_debug
end



/* 'TIPO DE TRANSACCION NO CORRESPONDE' */
if @t_trn <> 6111 and @t_trn <> 6109
begin	
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end



/***  DETERMINAR A QUE CORTE PERTENECE EL ASIENTO  ***/
if @i_operacion <> 'V'
begin
	if not exists (select 1 from cb_empresa 
			where em_empresa = @i_empresa)
	begin
		/* 'Empresa especificada no existe    ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

	/* OBTIENE EL NUMERO SECUENCIAL TEMPORAL */
	exec	@w_return = cob_conta..sp_cseqcomp
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
end


if @i_operacion = 'I'
begin
   	select @w_numero_actual = @w_siguiente
end
else begin
	select @w_numero_actual = @i_comprobante
end


if @i_operacion = 'I'
begin
     insert into cb_tcomprobante (
			ct_comprobante,ct_empresa,ct_fecha_tran,
			ct_oficina_orig,ct_area_orig,ct_fecha_dig,
			ct_fecha_mod,ct_digitador,ct_descripcion,
			ct_mayorizado,ct_comp_tipo,ct_detalles,
			ct_tot_debito,ct_tot_credito,ct_tot_debito_me,
			ct_tot_credito_me,ct_automatico,ct_reversado,
			ct_autorizado,ct_mayoriza,ct_autorizante,ct_referencia)
		values (@w_numero_actual,@i_empresa,@i_fecha_tran,
			@i_oficina_orig,@i_area_orig,@i_fecha_dig,
			@i_fecha_mod,@i_digitador,@i_descripcion,
			@i_mayorizado,@i_comp_tipo,@i_detalles,
			@i_tot_debito,@i_tot_credito,@i_tot_debito_me,
			@i_tot_credito_me,@i_automatico,@i_reversado,
			@i_autorizado,@i_mayoriza,@i_autorizante,@i_referencia)
		if @@error <> 0  
		begin	/* Error insercion de header de comprobante en tabla temporal */
  			exec cobis..sp_cerror            
		  	@t_debug	= @t_debug,      
		  	@t_file 	= @t_file,       
		  	@t_from		= @w_sp_name,    
		  	@i_num		= 603019         
			return 1
		end

	select @o_tcomprobante = @w_numero_actual
	select @w_numero_actual
	return 0
end


if @i_operacion = 'V'
begin
	select @w_fecha = co_fecha_ini
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and   @i_fecha between co_fecha_ini and co_fecha_fin
	and   co_estado in ('A','V')
	if @@rowcount = 0
	begin	/* 'ES UN CORTE NO VIGENTE O ACTUAL' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603023
		return 1
	end
	return 0
end

return 0
go
