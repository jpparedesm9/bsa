/************************************************************************/
/*	Archivo: 		consmodi.sp 			        */
/*	Stored procedure: 	sp_consulta_modifica			*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:           Marta Elena Segura	          	*/
/*	Fecha de escritura:     03-Febrero-1999				*/
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
/*	Este programa se encarga de realizar la consulta de 		*/
/*	modificaciones al plan de cuentas				*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR			RAZON			*/
/*	03-Febrero-1999	Juan Carlos Gomez     	Emision Inicial		*/
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_consulta_modifica')
	drop proc sp_consulta_modifica

go
create proc sp_consulta_modifica (
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
	@i_operacion	char(1) = null,
	@i_usuario	login = null,
	@i_cuenta	cuenta = null,
	@i_fecha_desde	datetime = null,
	@i_fecha_hasta	datetime = null,
	@i_modo		smallint = null,
	@i_ultreg	int = null 
)
as 
declare

@w_sp_name	varchar(32)	-- nombre del stored procedure
	
select @w_sp_name = 'sp_consulta_modifica'

/************************************************/
/*	Se valida si esta  en modo debug	*/
/************************************************/

--if @t_debug = 'S'
--begin
--	exec cobis..sp_begin_debug @t_file = @t_file
--	select '/** Store Procedure **/ ' = @w_sp_name,
--		t_file		= @t_file,
--		t_from		= @t_from,
--		i_operacion 	= @i_operacion,
--		i_usuario 	= @i_usuario,
--		i_cuenta	= @i_cuenta,
--		i_fecha_desde	= @i_fecha_desde,
--		i_fecha_hasta	= @i_fecha_hasta,
--		i_modo		= @i_modo,
--		i_ultreg	= @i_ultreg
--	exec cobis..sp_end_debug
--end

/************************************************/
/*	Se valida la transaccion		*/
/************************************************/

if @t_trn <> 6238
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
/*	Verifica si la operacion es para todas  */
/*	las fechas				*/
/************************************************/

if @i_operacion = 'A'
begin
	set rowcount 20

	if @i_modo = 0 
	begin
		select	'Secuencial' = secuencial,
			'Tipo de Transaccion' = tipo_transaccion,
			'Clase' = clase,
			'Fecha' = fecha,
			'Usuario' = usuario,
			'Terminal' = terminal,
			'Oficina' = oficina,
			'Empresa' = empresa,
			'Cuenta' = cuenta,
			'Descripcion' = descripcion,
			'Estado' = estado,
			'Movimiento' = movimiento,
			'Categoria' = categoria,
			'Acceso' = acceso,
			'Presupuesto' = presupuesto
		from	ts_cuenta
		where	usuario like @i_usuario
		    and cuenta like @i_cuenta
		order by secuencial

		if @@rowcount = 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601042
			return 1
		end
	end	
	else
	begin
		if @i_modo = 1
		begin
			select	'Secuencial' = secuencial,
				'Tipo de Transaccion' = tipo_transaccion,
				'Clase' = clase,
				'Fecha' = fecha,
				'Usuario' = usuario,
				'Terminal' = terminal,
				'Oficina' = oficina,
				'Empresa' = empresa,
				'Cuenta' = cuenta,
				'Descripcion' = descripcion,
				'Estado' = estado,
				'Movimiento' = movimiento,
				'Categoria' = categoria,
				'Acceso' = acceso,
				'Presupuesto' = presupuesto
			from	ts_cuenta
			where	usuario like @i_usuario
		   	    and cuenta like @i_cuenta
			    and secuencial > @i_ultreg 
			order by secuencial

			if @@rowcount = 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601043
				return 1
			end
		end
	end

	set rowcount 0
end
else
begin
	if @i_operacion = 'Q'
	begin
		set rowcount 20

		if @i_modo = 0 
		begin
			select	'Secuencial' = secuencial,
				'Tipo de Transaccion' = tipo_transaccion,
				'Clase' = clase,
				'Fecha' = fecha,
				'Usuario' = usuario,
				'Terminal' = terminal,
				'Oficina' = oficina,
				'Empresa' = empresa,
				'Cuenta' = cuenta,
				'Descripcion' = descripcion,
				'Estado' = estado,
				'Movimiento' = movimiento,
				'Categoria' = categoria,
				'Acceso' = acceso,
				'Presupuesto' = presupuesto
			from	ts_cuenta
			where	usuario = @i_usuario
			    and cuenta = @i_cuenta
			    and @i_fecha_desde <= fecha
			    and @i_fecha_hasta >= fecha
			order by secuencial

			if @@rowcount = 0
			begin
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601042
				return 1
			end
		end
		else
		begin
			if @i_modo = 1
			begin
				select	'Secuencial' = secuencial,
					'Tipo de Transaccion' = tipo_transaccion,
					'Clase' = clase,
					'Fecha' = fecha,
					'Usuario' = usuario,
					'Terminal' = terminal,
					'Oficina' = oficina,
					'Empresa' = empresa,
					'Cuenta' = cuenta,
					'Descripcion' = descripcion,
					'Estado' = estado,
					'Movimiento' = movimiento,
					'Categoria' = categoria,
					'Acceso' = acceso,
					'Presupuesto' = presupuesto
				from	ts_cuenta
				where	usuario = @i_usuario
				    and cuenta = @i_cuenta
				    and @i_fecha_desde <= fecha
				    and @i_fecha_hasta >= fecha
				    and secuencial > @i_ultreg
				order by secuencial

				if @@rowcount = 0
				begin
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 601043
					return 1
				end
			end
		end
		set rowcount 0
	end	
end

return 0

go
