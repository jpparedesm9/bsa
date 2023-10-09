/************************************************************************/
/*	Archivo: 		comprobs.sp                             */
/*	Stored procedure: 	sp_scomprobante                         */
/*	Base de datos:  	cob_conta                               */
/*	Producto:               contabilidad                            */
/*	Disenado por:           Pablo Mena / Ruben Martinez A.          */
/*	Fecha de escritura:     30-julio-1993                           */
/************************************************************************/
/*				IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de   */
/*	"MACOSA", representantes exclusivos para el Ecuador de la       */
/*	"NCR CORPORATION".                                              */
/*	Su uso no autorizado queda expresamente prohibido asi como      */
/*	cualquier alteracion o agregado hecho por alguno de sus         */
/*	usuarios sin el debido consentimiento por escrito de la         */
/*	Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*				PROPOSITO                               */
/*	Este programa procesa las transacciones de:                     */
/*	Inserta el header de comprobante en la tabla temporal           */
/*	de comprobantes generados por un subsistema                     */
/*	Elimina el header de comprobante en la tabla temporal           */
/*	de comprobantes generados por un subsistema,pone estado='A'     */
/*	NOTA: PARA CONVERTIR ESTE STORED PROCEDURE EN GENERICO          */
/*	     -cambiar los cod.de transacciones COBIS asignadas a las de */
/*	      contabilidad.                                             */
/*	     -adicionar la conversion de codigos de filial y oficina de */
/*	      cobis-admin a cobis-conta utilizando tabla cb_reloficina  */
/*	     -confirmar la version de contabilidad en el banco para     */
/*	      determinar de donde se tomara el contador de comprobantes */
/*	      para la tabla cb_scomprobante. cobis o cob_conta          */
/************************************************************************/
/*				MODIFICACIONES                          */
/*	FECHA		AUTOR		RAZON                           */
/*	30/Jul/1993	G Jaramillo     Emision Inicial                 */
/*	31/Jul/1995	R.Martinez A.   Actualizacion para interface    */
/*	24-Abr-1996	R.Martinez A.   Actualizacion para anulacion    */
/*	09-May-1996	R.Martinez A.   Actualizacion para soportar las */
/*	                                versiones 1 y 2 de la contabil. */
/*	30-May-1996     S. de la Cruz   Modificaciones                  */
/*	07-Jul-1996     D. Guerrero     Modificaciones                  */
/*      10-Mar-1999     M. Perez --Map  Modifico la actualizacion del   */
/*                                      cb_scomprobante                 */
/* CMDO 15-Mar-1999     C.De Orcajo     Especificacion COR047           */
/* 08-Jun-2003  A. Núñez        Se añade @i_operacion = 'Q'             */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_scomprobante')
	drop proc sp_scomprobante  
go

create proc sp_scomprobante (
	@t_rty			char(1)		= null,
	@t_trn			smallint	= null,
	@t_debug		char(1)		= 'N',
	@t_file			varchar(14)	= null,
	@t_from			varchar(30)	= null,
	@s_ssn			int		= null,
	@s_date			datetime	= null,
	@s_user			login		= null,
	@s_term			descripcion	= null,
	@s_corr			char(1)		= null,
	@s_ssn_corr		int		= null,
	@s_ofi			smallint	= null,
	@i_operacion		char(1)		= null,
	@i_modo			smallint	= 0,
	@i_producto		tinyint		= null,
	@i_producto1		tinyint		= 155,
	@i_comprobante		int		= 0,
	@i_comprobante1		int		= 2147483647,
	@i_empresa		tinyint		= null,
	@i_fecha_tran		datetime	= '01/01/1980',
	@i_fecha_tran1		datetime	= '12/31/2099',
	@i_oficina_orig		smallint	= null,
	@i_oficina_orig1	smallint	= 32767,
	@i_asiento		int	= null,
	@i_area_orig		smallint	= null,
	@i_area_orig1		smallint	= 32767,
	@i_digitador		descripcion	= null,
	@i_descripcion		descripcion	= null,
	@i_perfil		varchar(20)	= null,
	@i_detalles		int		= null,
	@i_tot_debito		money		= null,
	@i_tot_credito		money		= null,
	@i_tot_debito_me	money		= null,
	@i_tot_credito_me	money		= null,
	@i_formato_fecha 	tinyint		= 1,
	@i_automatico		smallint	= 0,
	@i_reversado		char(1)		= null,
	@i_estado		estado		= null,
	@i_mayorizado		char(1)		= 'N',
	@i_observaciones	descripcion	= null,
	@i_comp_definit		int		= null,
	@i_usuario_modulo	descripcion	= 'sa',
	@i_tran_modulo		varchar(20)	= '6',
	@o_comprobante		int		= null out,
	@o_desc_error		varchar(255)	= null out
)
as
declare
	@w_today		datetime,     /* fecha del dia */
	@w_return		int,          /* valor que retorna */
	@w_sp_name		varchar(32),  /* nombre del stored procedure*/
	@w_error		descripcion,  /* mensaje de error generado en el sp */
	@w_numero_actual	int,
	@w_estado		char(1),
	@w_oficina1		smallint,
	@w_oficina2		smallint,
	@w_area1		smallint,
	@w_area2		smallint,
	@w_producto1		tinyint,
	@w_producto2		tinyint,
	@w_siguiente		int,
	@w_existe		int,
	@w_count		int

select @w_count = @@trancount

select @w_today = convert(char(10),getdate(),101)
select @w_sp_name = 'sp_scomprobante'


/*             TIPO DE TRANSACCION                */
if (@t_trn = 6344 and @i_operacion <> 'U') or
   (@t_trn = 6345 and @i_operacion <> 'I') or
   (@t_trn = 6346 and @i_operacion <> 'A') or
   (@t_trn = 6347 and @i_operacion <> 'Q')
begin	/* 'Tipo de transaccion no corresponde' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601077
	return 1
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file			= @t_file,
		t_from			= @t_from,
		i_operacion		= @i_operacion,
		i_modo			= @i_modo,
		i_empresa		= @i_empresa,
		i_comprobante		= @i_comprobante,
		i_oficina_orig		= @i_oficina_orig,
		i_area_orig		= @i_area_orig,
		i_fecha_tran		= @i_fecha_tran,
		i_digitador		= @i_digitador,
		i_descripcion		= @i_descripcion,
		i_perfil		= @i_perfil,
		i_detalles		= @i_detalles,
		i_tot_debito		= @i_tot_debito,
		i_tot_credito		= @i_tot_credito,
		i_tot_debito_me		= @i_tot_debito_me,
		i_tot_credito_me	= @i_tot_credito_me,
		i_automatico		= @i_automatico,
		i_reversado		= @i_reversado,
		i_estado		= @i_estado
	exec cobis..sp_end_debug
end


if @i_operacion = 'I' and @i_modo = 0	/* INSERTAR SIN VALIDACIONES */
begin
	if @i_comprobante = 0
	begin
		exec @w_return = cob_conta..sp_cseqcomp
			@i_tabla     = 'cb_scomprobante',
			@i_empresa   = @i_empresa,
			@i_fecha     = @i_fecha_tran,
			@i_modulo    = @i_producto,
			@i_modo	     = 0, /* 0 para numerar por empresa */
					/* 1 para numerar por empresa y por dia */
			@o_siguiente = @w_siguiente out
		if @w_return <> 0
		begin
			return @w_return
		end
	end
	else
	begin
		select @w_siguiente = @i_comprobante
	end

	insert into cob_conta_tercero..ct_scomprobante_tmp (
		sc_producto,sc_comprobante,sc_empresa,sc_fecha_tran,
		sc_oficina_orig,sc_area_orig,sc_fecha_gra,
		sc_digitador,sc_descripcion,
		sc_perfil,sc_detalles,
		sc_tot_debito,sc_tot_credito,sc_tot_debito_me,
		sc_tot_credito_me,sc_automatico,sc_reversado,
		sc_estado,sc_mayorizado,
		sc_observaciones,sc_comp_definit,
		sc_usuario_modulo,sc_tran_modulo,sc_error)
	values (@i_producto,@w_siguiente,@i_empresa,@i_fecha_tran,
		@i_oficina_orig,@i_area_orig,@w_today,
		@i_digitador,@i_descripcion,
		@i_perfil,@i_detalles,
		@i_tot_debito,@i_tot_credito,@i_tot_debito_me,
		@i_tot_credito_me,@i_automatico,@i_reversado,
		@i_estado,@i_mayorizado,
		@i_observaciones,@i_comp_definit,
		@i_usuario_modulo,@i_tran_modulo,'N')
		if @@error <> 0  
		begin	/* Error en insercion de header de comprobante en tabla temporal */
			return 603019
		end
		select @o_comprobante = @w_siguiente
	return 0
end


if @i_operacion = 'I' or @i_operacion = 'U'
begin
	select @w_estado = co_estado
	from cob_conta..cb_corte
	where co_empresa = @i_empresa and
		co_periodo >= 0 and
		co_corte >= 0 and
		co_fecha_ini <= @i_fecha_tran and
		co_fecha_fin >= @i_fecha_tran 
	if @@rowcount = 0
	begin	/* 'PERIODO O CORTE NO VIGENTE O CERRADO' */
		while @@trancount > 0
		      rollback tran
		begin tran
		select @w_error = 'Periodo o Corte no vigente o Cerrado'
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 603023,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end

		return 603023
	end

	if @w_estado <> 'A' and @w_estado <> 'V'
	begin	/* 'Fecha no autorizada para procesar interfaz contable' */
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'Fecha no autorizada para procesar interfaz contable'
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601181,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601181
	end
end


/***************** VALIDACIONES DE CAMPOS *****************/
if @i_operacion = 'I'
begin	
	/**** VALIDA LA EMPRESA ****/
	if not exists (select 1 from cob_conta..cb_empresa 
		where em_empresa = @i_empresa)
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'No existe codigo de empresa especificada: '
		                + convert(varchar(5),@i_empresa)
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601018,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601018
	end

	/**** VALIDA EL PRODUCTO EN COBIS ****/
	if exists (select 1 from cobis..cl_producto
		where pd_producto = @i_producto
		and pd_estado = 'V')
		goto ETIQUETA1
	else
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'No existe producto '
		                + convert(varchar(5), @i_producto)
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 101032,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 101032
	end

ETIQUETA1:
	/**** VALIDA EL PRODUCTO EN CONTABILIDAD ****/
	if exists (select 1 from cb_producto 
			where pr_empresa = @i_empresa
			and pr_producto = @i_producto
			and pr_estado   = 'V')
		goto ETIQUETA2
	else
	begin	/* 'Registro no existe   ' */
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'No existe definido el producto para interfaz contable'
		        + convert(varchar(5), @i_producto)
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601168,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601168
	end

ETIQUETA2:
	/**** VALIDA LA OFICINA ****/
	if exists (select 1 from cb_oficina where
			of_empresa = @i_empresa and
			of_oficina = @i_oficina_orig and 
			of_movimiento = 'S' and
			of_estado = 'V')
		goto ETIQUETA3
	else
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'Oficina consultada no existe o no es de movimiento'
			+ convert(varchar(10), @i_oficina_orig)
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601131,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601131
	end

ETIQUETA3:
	/**** VALIDA EL AREA ****/
	if exists (select 1 from cb_area where
		ar_empresa = @i_empresa and
		ar_area    = @i_area_orig and 
		ar_movimiento = 'S' and
		ar_estado = 'V')
		goto ETIQUETA4
	else
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'Area consultada no existe o no es de movimiento'
				+ convert(varchar(10), @i_area_orig)
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601132,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601132
	end

ETIQUETA4:
	/**** VALIDA CUADRE  DE TOTALES ****/
	if round(@i_tot_debito,2) <> round(@i_tot_credito,2)
	begin
		while @@trancount > 0
		rollback tran
		begin tran
		select @w_error = 'Total debitos y creditos en tabla temporal descuadrados'
		select @o_desc_error = @w_error

		exec @w_return = cob_interface..sp_errorcconta
		@t_trn		= 60011,
		@i_operacion	= 'I',
		@i_empresa	= @i_empresa,
		@i_fecha	= @w_today,
		@i_producto	= @i_producto,
		@i_tran_modulo	= @i_tran_modulo,
		@i_asiento	= 0,
		@i_fecha_conta	= @i_fecha_tran,
		@i_numerror	= 601056,
		@i_mensaje	= @w_error,
		@i_perfil	= @i_perfil,
		@i_valor	= @i_tot_debito,
		@i_oficina	= @i_oficina_orig

		if @w_return <> 0
		begin
			return @w_return
		end
		commit tran
		while @w_count > 0
		begin
			select @w_count = @w_count -1
			begin tran
		end
		return 601056
	end

/*
	if exists (select 1 from cobis..cl_parametro, cobis..cl_dias_feriados
	where df_ciudad = pa_int
	and df_fecha = @i_fecha_tran
	and pa_producto = 'CON'
	and pa_nemonico = 'CIUN')
	begin
        	select @w_error = 'Error fecha comprobante corresponde a un dia feriado' + convert(varchar(10),@i_fecha_tran,101)
		select @o_desc_error = @w_error
		return 609227
	end
*/

/**** OBTIENE EL SECUENCIAL DEL COMPROBANTE ****/
/***********************************************/
/* Si la contabilidad es version 1 el contador esta en cobis        */
/* habilitar el siguiente segmento y comentar el segmento version 2 */

-- VERSION 1 --
	-- exec @w_return = cobis..sp_cseqnos 
        --                  @i_tabla = 'cb_scomprobante',
	-- 		 @o_siguiente = @w_siguiente out
	-- if @w_return <> 0
	-- begin
	-- 	return @w_return
	-- end
        /* Si la contabilidad es version 2  el contador esta en cob_conta   */
        /* habilitar el siguiente segmento y comentar el segmento version 1 */


-- VERSION 2 --
	exec @w_return = cob_conta..sp_cseqcomp
		@i_tabla   = 'cb_scomprobante',
		@i_empresa = @i_empresa,
		@i_fecha     = @i_fecha_tran,
		@i_modulo    = @i_producto,
		@i_modo	     = 0, /* 0 para numerar por empresa */
				/* 1 para numerar por empresa y por dia */
		@o_siguiente = @w_siguiente out
	if @w_return <> 0
	begin
		return @w_return
	end
end

begin tran
if @i_operacion = 'I'
begin
	select @w_numero_actual = @w_siguiente
end
else begin
	select @w_numero_actual = @i_comprobante
end

if @i_operacion = 'I'
begin
	insert into cob_conta_tercero..ct_scomprobante (
		sc_producto,sc_comprobante,sc_empresa,sc_fecha_tran,
		sc_oficina_orig,sc_area_orig,sc_fecha_gra,
		sc_digitador,sc_descripcion,
		sc_perfil,sc_detalles,
		sc_tot_debito,sc_tot_credito,sc_tot_debito_me,
		sc_tot_credito_me,sc_automatico,sc_reversado,
		sc_estado,sc_mayorizado,
		sc_observaciones,sc_comp_definit,
		sc_usuario_modulo,sc_tran_modulo)
	values (@i_producto,@w_numero_actual,@i_empresa,@i_fecha_tran,
		@i_oficina_orig,@i_area_orig,@w_today,
		@i_digitador,@i_descripcion,
		@i_perfil,@i_detalles,
		@i_tot_debito,@i_tot_credito,@i_tot_debito_me,
		@i_tot_credito_me,@i_automatico,@i_reversado,
		@i_estado,@i_mayorizado,
		@i_observaciones,@i_comp_definit,
		@i_usuario_modulo,@i_tran_modulo)
		if @@error <> 0  
		begin	/* Error en insercion de header de comprobante en tabla temporal */
			while @@trancount > 0
			rollback tran
			begin tran
			select @w_error = 'Error en insercion de cabecera de comprobante en tabla temporal'
			select @o_desc_error = @w_error

			exec @w_return = cob_interface..sp_errorcconta
			@t_trn		= 60011,
			@i_operacion	= 'I',
			@i_empresa	= @i_empresa,
			@i_fecha	= @w_today,
			@i_producto	= @i_producto,
			@i_tran_modulo	= @i_tran_modulo,
			@i_asiento	= 0,
			@i_fecha_conta	= @i_fecha_tran,
			@i_numerror	= 603019,
			@i_mensaje	= @w_error,
			@i_perfil	= @i_perfil,
			@i_valor	= @i_tot_debito,
			@i_oficina	= @i_oficina_orig

			if @w_return <> 0
			begin
				return @w_return
			end
			commit tran
			while @w_count > 0
			begin
				select @w_count = @w_count -1
				begin tran
			end

			exec cobis..sp_cerror
			@t_debug	= @t_debug,
			@t_file 	= @t_file,
			@t_from		= @w_sp_name,
			@i_num		= 603019
			return 603019
		end

	select @o_comprobante = @w_numero_actual
end


if @i_operacion = 'U'
begin
	/*** ANULACION DEL COMPROBANTE CONTABLE ***/
	update cob_conta_tercero..ct_scomprobante
	set sc_estado = @i_estado
	where  sc_empresa = @i_empresa
	and    sc_producto = @i_producto
	and    sc_fecha_tran  = @i_fecha_tran
	and    sc_comprobante = @i_comprobante
	if @@error <> 0  
	begin
		/* Error en actualizacion de header de comprobante en tabla */
		exec cobis..sp_cerror
		@t_debug	= @t_debug,
		@t_file 	= @t_file,
		@t_from		= @w_sp_name,
		@i_num		= 603022
		select @w_error = 'Error en actualizacion de cabecera de comprobante en tabla temporal'
		select @o_desc_error = @w_error
		return 603022
	end
end
commit tran


if @i_operacion = 'A'
begin

	if @i_area_orig is null
		select @i_area_orig = 0, @i_area_orig1 = 32767
    else
       select @i_area_orig1 = @i_area_orig

	if @i_oficina_orig is null
		select @i_oficina_orig = 0, @i_oficina_orig1 = 32767
    else
       select @i_oficina_orig1 = @i_oficina_orig

	if @i_producto is null
	    select @i_producto = 0, @i_producto1 = 155
    else
        select @i_producto1 = @i_producto

	if isnull(@i_comprobante,0) = 0
		select @i_comprobante = 0, @i_comprobante1 = 2147483647

	set rowcount 20
	if @i_modo = 0
	begin


		select 'PRODUCTO'	= sc_producto,
			'COMPROBANTE'	= sc_comprobante,
			'FECHA TRAN.'	= convert(varchar(10),sc_fecha_tran,103),
			'OF. ORIG.'	= sc_oficina_orig,
			'AREA ORIG.'	= sc_area_orig,
			'DESCRIPCION'	= sc_descripcion,
			'DEBITO'	= sc_tot_debito,
			'CREDITO'	= sc_tot_credito,
			--'MAYORIZA'	= sc_mayorizado,
			'COMP. DEF.'	= sc_comp_definit,
			'TRAN. MODULO'	= sc_tran_modulo
		from cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa
		and sc_producto between @i_producto and @i_producto1
		and sc_fecha_tran between @i_fecha_tran and @i_fecha_tran1
		and sc_comprobante between @i_comprobante and @i_comprobante1
		and sc_oficina_orig between @i_oficina_orig and @i_oficina_orig1
		and sc_area_orig between @i_area_orig and @i_area_orig1
		and sc_estado like @i_estado
		order by sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante
		if @@rowcount = 0
		begin	/* No existen registros para la consulta dada */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 601153
			set rowcount 0
			return 1 
		end
	end
	else
	begin
		select 'PRODUCTO'	= sc_producto,
			'COMPROBANTE'	= sc_comprobante,
			'FECHA TRAN.'	= convert(varchar(10),sc_fecha_tran,103),
			'OF. ORIG.'	= sc_oficina_orig,
			'AREA ORIG.'	= sc_area_orig,
			'DESCRIPCION'	= sc_descripcion,
			'DEBITO'	= sc_tot_debito,
			'CREDITO'	= sc_tot_credito,
			--'MAYORIZA'	= sc_mayorizado,
			'COMP. DEF.'	= sc_comp_definit,
			'TRAN. MODULO'	= sc_tran_modulo
		from cob_conta_tercero..ct_scomprobante
		where sc_empresa = @i_empresa
		and (
		((sc_producto > @i_producto and sc_producto <= @i_producto))
		or
		((sc_producto = @i_producto and sc_producto <= @i_producto)
		and (sc_fecha_tran > @i_fecha_tran and sc_fecha_tran <= @i_fecha_tran1))
		or
		((sc_producto = @i_producto and sc_producto <= @i_producto)
		and (sc_fecha_tran = @i_fecha_tran)
		and (sc_comprobante > @i_comprobante and sc_comprobante <= @i_comprobante1))
		or
		((sc_producto > @i_producto and sc_producto <= @i_producto)
		and (sc_fecha_tran > '01/01/1900' and sc_fecha_tran <= @i_fecha_tran1)
		and (sc_comprobante >= 0 and sc_comprobante <= @i_comprobante1))
		)
		and sc_oficina_orig between @i_oficina_orig and @i_oficina_orig1
		and sc_area_orig between @i_area_orig and @i_area_orig1
		and sc_estado like @i_estado
		order by sc_empresa, sc_producto, sc_fecha_tran, sc_comprobante
		if @@rowcount = 0
		begin	/* No existen registros para la consulta dada */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 601153
			set rowcount 0
			return 1 
		end
	end
	set rowcount 0
	return 0
end


/********* QUERY *******/
if @i_operacion = 'Q'
begin
	set rowcount 20
	if @i_modo = 0 
	begin
		select sc_oficina_orig,
			sc_area_orig,
			sc_comprobante,
			substring(sc_descripcion,1,120),
			convert(char(12),sc_fecha_tran,@i_formato_fecha),
			sc_mayorizado,
			sc_comp_definit,
			sc_tot_debito,
			sc_tot_credito,
			sc_tot_debito_me,
			sc_tot_credito_me,
			substring(of_descripcion,1,40),
			substring(ar_descripcion,1,40),
			sc_automatico,
			substring(sc_digitador,1,15),
			substring(sc_usuario_modulo,1,15),
			substring(CAST(sc_comp_origen AS varchar(20)),1,10),
			sc_estado,
			sc_causa_error,
			convert(char(12),sc_fecha_gra,@i_formato_fecha),
			sc_tran_modulo,
			sc_reversado
		from cob_conta_tercero..ct_scomprobante,cob_conta..cb_oficina,cob_conta..cb_area
		where sc_empresa = @i_empresa and
		sc_producto = @i_producto and
		sc_fecha_tran = @i_fecha_tran and
		sc_comprobante = @i_comprobante and
		sc_oficina_orig = @i_oficina_orig and
		of_empresa = @i_empresa and
		of_oficina = sc_oficina_orig and
		ar_empresa = @i_empresa and
		ar_area = sc_area_orig
		
		if @@rowcount = 0
		begin	/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601061
			set rowcount 0
			return 1
		end

		select sa_oficina_dest,
			sa_area_dest,
			sa_cuenta,
			sa_tipo_doc,
			sa_debito,
			sa_credito,
			sa_debito_me,
			sa_credito_me,
			sa_cotizacion,
			sa_tipo_tran,
			substring(sa_concepto,1,60),
			sa_moneda,
			sa_ente
		from cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
		sa_producto = @i_producto and
		sa_fecha_tran = @i_fecha_tran and
		sa_comprobante = @i_comprobante
		order by sa_asiento
	end
	else
	begin
		select sa_oficina_dest,
			sa_area_dest,
			sa_cuenta,
			sa_tipo_doc,
			sa_debito,
			sa_credito,
			sa_debito_me,
			sa_credito_me,
			sa_cotizacion,
			sa_tipo_tran,
			substring(sa_concepto,1,60),
			sa_moneda,
			sa_ente
		from cob_conta_tercero..ct_sasiento
		where sa_empresa = @i_empresa and
		sa_producto = @i_producto and
		sa_fecha_tran = @i_fecha_tran and
		sa_comprobante = @i_comprobante and
		sa_asiento > @i_asiento
		order by sa_asiento
		
		if @@rowcount = 0 
		begin	/* 'Comprobante consultado no existe'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
			set rowcount 0
			return 1
		end
	end
	set rowcount 0
	return 0
end

return 0
go
