/************************************************************************/
/*	Archivo: 		intconsu.sp			        */
/*	Stored procedure: 	sp_interna_consu			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Gonzalo Jaramillo			*/
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
/*	Generacion de asientos automaticos para registro en las cuentas */
/*	de Sucursales y Agencias definidas en Cuenta Proceso - Cuenta   */
/*	Asociada (Proceso Nro. 6002)					*/
/*				MODIFICACIONES				*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_interna_consu')
	drop proc sp_interna_consu
go

create proc sp_interna_consu   (
	@s_ssn			int		= null,
	@s_date			datetime	= null,
	@s_user			login		= null,
	@s_term			descripcion	= null,
	@s_corr			char(1)		= null,
	@s_ssn_corr		int		= null,
	@s_ofi			smallint	= null,
	@t_rty			char(1)		= null,
	@t_trn			smallint	= null,
	@t_debug		char(1)		= 'N',
	@t_file			varchar(14)	= null,
	@t_from			varchar(30)	= null,
	@i_operacion		char(1)		= null,
	@i_modo			smallint	= null,
	@i_empresa 		tinyint		= null,
	@i_fecha_tran		datetime	= null,
	@i_comprobante 		int		= null,
	@i_oficina_orig 	smallint	= null,
	@i_detalles		int		= null,
	@i_batch 		int		= null,
	@o_desc_error		descripcion     = null out
)
as
declare
	@w_sp_name		varchar(32),	
	@w_oficina_orig		smallint,
	@w_tipo_doc		char(1),
	@w_tipo_tran		char(1),
	@w_asiento		int,
	@w1_cta_proc    	char(20),
	@w_debito		money,
	@w_credito		money,
	@w_debito_me		money,
	@w_credito_me		money,
	@w_cotizacion		money,
	@w_moneda		tinyint,
	@w_area_orig		smallint,
	@w_area_dest		smallint,
	@w_concepto		descripcion, 
	@w_contador  		int,
	@w_oficina_dest 	smallint,
	@w_filas		int,
	@w_auxiliar		int,
	@w_cuenta		cuenta

select @w_sp_name = 'sp_interna_consu'


if @i_operacion = 'I' 
begin
--begin tran
    if not exists (select 1 from cb_cuenta_proceso where cp_proceso = 6002)
	   return 0
	   
	insert into cob_conta..cb_tinterna
		(ti_cuenta,ti_fecha_tran,ti_comprobante,ti_empresa,
		ti_tipo_doc,ti_tipo_tran,ti_moneda,ti_oficina_dest,
		ti_area_dest,ti_asiento,ti_debito,ti_credito,
		ti_debito_me,ti_credito_me,ti_contador,ti_oficina_orig)
	select	ta_cuenta,ta_fecha_tran,ta_comprobante,ta_empresa,
		ta_tipo_doc,ta_tipo_tran,ta_moneda,ta_oficina_dest,
		ta_area_dest,ta_asiento,sum(ta_debito),sum(ta_credito),
		sum(ta_debito_me),sum(ta_credito_me),0,ta_oficina_orig
	from cb_tasiento, cb_tcomprobante
	where	ta_empresa	= @i_empresa and
		ta_fecha_tran	= @i_fecha_tran and
		ta_comprobante	= @i_comprobante and
		ta_asiento	>= 0 and
		ta_oficina_orig	= @i_oficina_orig and
		ct_empresa	= @i_empresa and
		ct_fecha_tran	= @i_fecha_tran and
		ct_comprobante	= @i_comprobante and
		ct_oficina_orig	= ta_oficina_orig and
		ta_oficina_dest	<> ct_oficina_orig and
		substring(ta_cuenta,1,1) not in ('6','8')
	group by ta_cuenta,ta_fecha_tran,ta_comprobante,ta_empresa,ta_tipo_doc,
	ta_tipo_tran,ta_moneda,ta_oficina_dest,ta_area_dest,ta_asiento,ta_oficina_orig
	if @@error <> 0
	begin
		select @o_desc_error = 'SyA: Error Insersion cb_tinterna'
		return 603074
	end  

	select @w_auxiliar = count(1) from cb_tinterna
	where	ti_empresa = @i_empresa and
		ti_fecha_tran = @i_fecha_tran and
		ti_comprobante = @i_comprobante and
		ti_asiento >= 0 and
		ti_oficina_dest >= 0 and
		ti_area_dest >= 0 and
		ti_oficina_orig = @i_oficina_orig
	if @w_auxiliar <> 0
	begin
		select	@w_oficina_orig = ct_oficina_orig,
			@w_area_orig = ct_area_orig
		from cb_tcomprobante
		where ct_empresa = @i_empresa and
		ct_fecha_tran = @i_fecha_tran and
		ct_comprobante = @i_comprobante and
		ct_oficina_orig = @i_oficina_orig

		select @w_concepto = 'ASIENTO AUTOMATICO ENTRE SUCURSALES'
	end



	select @w_filas = 1, @w_contador = 1, @w_asiento = @i_detalles

 	while @w_filas = 1 
	begin
		set rowcount 1
		select  @w_cuenta    = ti_cuenta,
			@w_tipo_doc  = ti_tipo_doc,
			@w_tipo_tran = ti_tipo_tran,
			@w_moneda    = ti_moneda,
			@w_oficina_dest = ti_oficina_dest,
			@w_area_dest = ti_area_dest,
			@w_debito    = ti_debito,
			@w_credito   = ti_credito,
			@w_debito_me = ti_debito_me,
			@w_credito_me = ti_credito_me
		from cob_conta..cb_tinterna
		where   ti_empresa = @i_empresa and
			ti_fecha_tran = @i_fecha_tran and
		   	ti_comprobante = @i_comprobante and
			ti_asiento >= 0 and
			ti_oficina_dest >= 0 and
			ti_area_dest >= 0 and
			ti_oficina_orig = @i_oficina_orig and
			ti_contador = 0
		if @@rowcount = 0
		begin
			select @w_filas = 0
		end
		else
		begin
			update cob_conta..cb_tinterna
			set ti_contador = @w_contador
			where ti_empresa = @i_empresa and
			ti_fecha_tran  = @i_fecha_tran and
			ti_comprobante = @i_comprobante and
			ti_asiento >= 0 and
			ti_oficina_dest= @w_oficina_dest and
			ti_area_dest   = @w_area_dest and
			ti_tipo_doc    = @w_tipo_doc and
			ti_tipo_tran   = @w_tipo_tran and
			ti_moneda      = @w_moneda and
			ti_oficina_orig = @i_oficina_orig and
			ti_contador    = 0
			if @@error <> 0
			begin
				select @o_desc_error = 'SyA: Error Actualizacion cb_tinterna'
				return 603075
			end

			select @w_contador = @w_contador + 1

			set rowcount 1
			select @w1_cta_proc = ca_cuenta
			from cb_cuenta_asociada
			where ca_empresa = @i_empresa and
			ca_proceso = 6002 and
			ca_cta_asoc = @w_cuenta

			if @@rowcount = 0
			begin	
				select @o_desc_error = 'SyA: Cuenta Asociada ' + @w_cuenta
				return 603056
			end


			if not exists (select cu_empresa
			from cb_cuenta
			where cu_empresa = @i_empresa
			and cu_cuenta = @w1_cta_proc
			and cu_movimiento = 'S')
			begin
				select @o_desc_error = 'SYA: La cuenta ' + @w1_cta_proc + ' no existe, no esta vigente o no es de movimiento'
				return 601109
			end

			if not exists (select pg_empresa
			from cb_plan_general
			where pg_empresa = @i_empresa
			and pg_cuenta = @w1_cta_proc
			and pg_oficina = @w_oficina_dest
			and pg_area    = @w_area_dest)
			begin
				select @o_desc_error = 'SyA: No existe asociacion Cuenta ' + rtrim(@w1_cta_proc) + ' Oficina ' + convert(varchar,@w_oficina_dest) + ' Area ' + convert(varchar,@w_area_dest)
				return 601109
			end

			if not exists (select pg_empresa 
			from cb_plan_general
			where pg_empresa = @i_empresa
			and pg_cuenta = @w1_cta_proc
			and pg_oficina = @w_oficina_orig
			and pg_area    = @w_area_orig)
			begin
				select @o_desc_error = 'SYA: No existe asociacion Cuenta ' + rtrim(@w1_cta_proc) + ' Oficina ' + convert(varchar,@w_oficina_orig) + ' Area ' + convert(varchar,@w_area_orig)
				return 601109
			end

			select @w_asiento = @w_asiento + 1
			insert into cb_tasiento
				(ta_fecha_tran,ta_comprobante,ta_empresa,
				ta_asiento,ta_cuenta,ta_oficina_dest,
				ta_area_dest,ta_credito,ta_debito,
				ta_credito_me,ta_debito_me,ta_tipo_doc,
				ta_tipo_tran,ta_moneda,ta_concepto,ta_mayorizado,
				ta_cotizacion,ta_consolidado,ta_oficina_orig)
			values
				(@i_fecha_tran,@i_comprobante,@i_empresa,
				@w_asiento,@w1_cta_proc,@w_oficina_dest,
				@w_area_dest,@w_debito,@w_credito,@w_debito_me,
				@w_credito_me,'N','A',@w_moneda,
				@w_concepto,'N',@w_cotizacion,'N',@i_oficina_orig)
			if @@error <> 0
			begin
				select @o_desc_error = 'SyA: Error en insersion cb_tasiento' 
				return 603020
			end

			select @w_asiento = @w_asiento + 1
			insert into cb_tasiento
				(ta_fecha_tran,ta_comprobante,ta_empresa,
				ta_asiento,ta_cuenta,ta_oficina_dest,
				ta_area_dest,ta_credito,ta_debito,
				ta_credito_me,ta_debito_me,ta_tipo_doc,
				ta_tipo_tran,ta_moneda,ta_concepto,ta_mayorizado,
				ta_cotizacion,ta_consolidado,ta_oficina_orig)
			values
				(@i_fecha_tran,@i_comprobante,@i_empresa,
				@w_asiento,@w1_cta_proc,@w_oficina_orig, /* C */
				@w_area_orig,@w_credito,@w_debito,@w_credito_me,
				@w_debito_me,'N','A',@w_moneda, @w_concepto,'N',
				@w_cotizacion,'N',@i_oficina_orig)
			if @@error <> 0
			begin
				select @o_desc_error = 'SyA: Error en insersion cb_tasiento' 
				return 603020
			end
		end	
	end	

	set rowcount 0
	delete cb_tinterna 
	where	ti_empresa = @i_empresa and
		ti_fecha_tran = @i_fecha_tran and
		ti_comprobante = @i_comprobante and
		ti_asiento >= 0 and
		ti_oficina_dest >= 0 and
		ti_area_dest >= 0 and
		ti_oficina_orig = @i_oficina_orig
	if @@error <> 0
	begin
		select @o_desc_error = 'SyA: Error en borrado cb_tinterna'
		return 603076
	end

	if @i_batch = 1
	begin
		select	count(1),sum(ta_debito),sum(ta_credito),
			sum(ta_debito_me),sum(ta_credito_me)
		from cb_tasiento
		where ta_empresa = @i_empresa and
		ta_fecha_tran = @i_fecha_tran and
		ta_comprobante = @i_comprobante and
		ta_asiento >= 0 and
		ta_oficina_orig = @i_oficina_orig
	end
	else
	begin
		select @w_asiento
	end
--commit tran
end





return 0

go
