/************************************************************************/
/*	Archivo: 		temprtip.sp			        */
/*	Stored procedure: 	sp_tretencion_tipo			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marta Elena Segura                    	*/
/*	Fecha de escritura:     18-Febrero-1999				*/
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
/*	Este programa maneja las transacciones de las tabla temporales  */
/*	de terceros para los comprobantes tipo				*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	18-Feb-1999	Juan C. G¢mez	Emisi¢n Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tretencion_tipo')
	drop proc sp_tretencion_tipo
go

create proc sp_tretencion_tipo   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_empresa	tinyint = null,
	@i_comprobante	int = null,
	@i_asiento	smallint = null,
	@i_ente		int=null,
	@i_tipo		char(2) = null,
	@i_identifica	char(11) = null,
	@i_cuenta	cuenta = null,
	@i_concepto	char(4) = null,
	@i_base		money = null,
	@i_valret	money = null,
	@i_valor_asiento money = null,
	@i_valor_iva	money = null, 
	@i_valor_ica	money = null,
	@i_iva_retenido money = null,
	@i_con_iva	char(4) = null,
	@i_con_iva_reten	char(4) = null,
	@i_con_timbre		char(4)	= null,
	@i_valor_timbre		money	= null,
	@i_codigo_regimen	char(4) = null,
	@i_con_ica		char(4) = null,
	@i_con_ivapagado	char(4) = null,
	@i_valor_ivapagado	money   = null,
	@i_operacion		char(1) = null
)
as 
declare
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32)	/* nombre del stored procedure*/

select @w_sp_name = 'sp_tretencion_tipo'

/************************************************/
/* Se validan las transacciones			*/
/************************************************/

if (@t_trn <> 6133 and @i_operacion = 'I') 
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

/************************************************/
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa  	= @i_empresa,
		i_comprobante	= @i_comprobante
	exec cobis..sp_end_debug
end

/***************** Insert **********************/

if @i_operacion = 'I' 
begin
	/************************************************/
	/* Se verifica la existencia del registro	*/
	/************************************************/

	if not exists (select * from cb_tretencion_tipo 
		       where tt_empresa = @i_empresa 
		 	 and tt_comprobante = @i_comprobante
			 and tt_asiento = @i_asiento )
			
	begin
		begin tran
			insert into cb_tretencion_tipo 
			values (
				@i_empresa,
				@i_comprobante,
				@i_asiento,
				@i_ente,
				@i_identifica,
				@i_tipo,
				@i_cuenta,
				@i_concepto,
				@i_base,
				@i_valret,
				@i_valor_asiento,
				@i_valor_iva,
				@i_valor_ica,
				@i_iva_retenido,
				@i_con_iva,
				@i_con_iva_reten,
				@i_con_timbre,
				@i_valor_timbre,
				@i_codigo_regimen,
				@i_con_ica,
				@i_con_ivapagado,
				@i_valor_ivapagado
			       )	

			if @@error <> 0
			begin
				/* Error en la inserci¢n */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603009

				rollback

				return 1
			end
			else
			begin
				commit tran
			end

	end
	else
	begin
		/* Ya existe el registro */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601032
		return 1
	end
end							

return 0
go
