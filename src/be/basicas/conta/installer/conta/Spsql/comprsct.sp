/************************************************************************/
/*	Archivo: 		comprcst.sp			        */
/*	Stored procedure: 	sp_tscomprobante			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           M.Suarez                            	*/
/*	Fecha de escritura:     07-oct/1995   				*/
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
/*	07/Oct/1995	M.Suarez        Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_tscomprobante')
	drop proc sp_tscomprobante  
go
create proc sp_tscomprobante (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi	        smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_comprobante 	int = null, 
	@i_empresa  	tinyint = null, 
	@i_producto  	tinyint = null, 
  	@i_fecha_tran 	datetime = null,    
	@i_oficina_orig smallint = null,
	@i_area_orig	smallint = null,
	@i_digitador 	descripcion = null,   
	@i_descripcion 	descripcion = null, 
        @i_perfil       varchar(10) = null,
	@i_detalles 	int = null,         
	@i_tot_debito 	money = null,    
	@i_tot_credito 	money = null,    
	@i_tot_debito_me money = null,
	@i_tot_credito_me money = null,
	@i_automatico	smallint = 0,
	@i_reversado	char(1) = null
)
as
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_numero_actual int,
	@w_estado	char(1),
	@w_corte	int,
	@w_siguiente	int,
	@w_periodo	int,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_tscomprobante'
if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa  	= @i_empresa , 
		i_comprobante 	= @i_comprobante,
		i_oficina_orig	= @i_oficina_orig,
		i_area_orig	= @i_area_orig,
  		i_fecha_tran 	= @i_fecha_tran,
		i_digitador 	= @i_digitador,
		i_descripcion 	= @i_descripcion,
		i_detalles 	= @i_detalles,
		i_tot_debito 	= @i_tot_debito,
		i_tot_credito 	= @i_tot_credito,
		i_tot_debito_me = @i_tot_debito_me,
		i_tot_credito_me = @i_tot_credito_me,
		i_automatico	= @i_automatico,
		i_reversado	= @i_reversado
	exec cobis..sp_end_debug
end

/************************************************/
/*  Tipo de Transaccion =     			*/

if @t_trn <> 6951
begin
	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end

/***************** VALIDACIONES DE CAMPOS *****************/

	if NOT EXISTS (select * from cb_empresa 
			where em_empresa = @i_empresa)
	begin
		-- Empresa especificada no existe   
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

	if NOT EXISTS (select * from cobis..cl_producto 
			where pd_producto = @i_producto)
	begin
            --  Producto no existe
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151011
		return 1
	end

        if NOT EXISTS (select * from cb_oficina where
                        of_empresa = @i_empresa and 
                        of_oficina = @i_oficina_orig and of_movimiento = 'S')
	begin
	        -- Oficina no existe o no es de movimiento
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601131
		return 1
	end

        if NOT EXISTS (select * from cb_area where
                        ar_empresa = @i_empresa and 
                        ar_area    = @i_area_orig and ar_movimiento = 'S')
	begin
	        -- Oficina no existe o no es de movimiento
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601132
		return 1
	end


        -- Obtiene el numero secuencial temporal

         exec @w_return = cob_conta..sp_cseqcomp
                        @i_empresa = @i_empresa,
                        @i_fecha   = @i_fecha_tran,
                        @i_modulo  = @i_producto,
                        @o_siguiente = @w_siguiente out

	if @w_return <> 0
	begin
		return @w_return
	end


begin tran
if @i_operacion = 'I'
begin
       	select @w_numero_actual = @w_siguiente
end
else begin
	select @w_numero_actual = @i_comprobante
end

insert into cb_tcomprobante (
			ct_comprobante,ct_empresa,ct_fecha_tran,
			ct_oficina_orig,ct_area_orig,ct_fecha_dig,
			ct_fecha_mod,ct_digitador,ct_descripcion,
			ct_mayorizado,ct_comp_tipo,ct_detalles,
			ct_tot_debito,ct_tot_credito,ct_tot_debito_me,
			ct_tot_credito_me,ct_automatico,ct_reversado,
			ct_autorizado,ct_mayoriza,ct_autorizante
			)
		values (@w_numero_actual,@i_empresa,@i_fecha_tran,
			@i_oficina_orig,@i_area_orig,@w_today,
			@w_today,@i_digitador,@i_descripcion,
			'N',@i_producto,@i_detalles, 0,0,0,0,
                        @i_automatico,'N','N','N',@i_perfil
			)

		if @@error <> 0  
		begin
			/* Error en insercion de header de comprobante en tabla temporal */
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
