/************************************************************************/
/*      Archivo:                regimen.sp                              */
/*      Stored procedure:       sp_regimen_fiscal                       */
/*      Base de datos:          cob_conta                               */
/*      Producto:               Contabilidad                            */
/*      Disenado por:           					*/
/*      Fecha de escritura:     30/10/2002                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Realizar el mantenimiento de la tabla de regimen fiscal		*/
/*                                                                      */
/*                              MODIFICACIONES                          */
/*      FECHA        AUTOR              RAZON                           */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_regimen_fiscal')
	drop proc sp_regimen_fiscal
go

create proc sp_regimen_fiscal (
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
	@t_trn			smallint = 32738,
	@i_operacion 		char(1) = null,
	@i_estado         	char(1) = null,
	@i_descripcion		descripcion = null,
	@i_codigo		varchar(10) = null,
	@i_aplica_iva		char(1) = 'N',
	@i_aplica_ica		char(1) = 'N',
	@i_aplica_renta		char(1) = 'N',
	@i_aplica_timbre	char(1) = 'N',
	@i_aplica_descontable	char(1) = 'N',
	@i_aplica_iva_cobrado	char(1) = 'N',
	@i_aplica_estampillas	char(1) = 'N',
	@i_3xm                  char(1) = 'N',
	@i_modo			tinyint = 0,
	@i_naturaleza		char(1) = null,
	@i_grancontribuyente	char(1) = null,
	@i_autorretenedor	char(1) = null,
	@i_reteiva		char(1) = 'N',
	@i_opcion		tinyint = 0
)
as

declare @w_sp_name	varchar(32),
	@w_existe	int

select @w_sp_name = 'sp_regimen_fiscal'

/* Codigos de Transacciones  */
if (@t_trn <> 6530 and @i_operacion = 'I') or	/* Insercion*/
   (@t_trn <> 6531 and @i_operacion = 'U') or	/* Actualizacion */
   (@t_trn <> 6532 and @i_operacion = 'A') or	/* Busqueda de uno*/
   (@t_trn <> 6533 and @i_operacion = 'V')	/* Busqueda de uno*/
begin
	/* tipo de transaccion no corresponde */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file, 
	@t_from  = @w_sp_name,
	@i_num   = 601077
	return 1 
end


if @i_operacion <> 'A' 
begin
	if exists (select 1
	from cob_conta..cb_regimen_fiscal
	where rf_codigo = @i_codigo)
		select @w_existe = 1
	else
		select @w_existe = 0
end


/**************** VALIDACIONES ***********************/
if @i_operacion = 'I' or @i_operacion = 'U'
begin
	if @i_codigo is null or @i_descripcion is null or @i_estado is null
	begin	/* Campos NOT NULL con valores nulos */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file, 
		@t_from  = @w_sp_name,
		@i_num   = 601001
		return 1
	end
end


if @i_operacion = 'I'
begin
	if @w_existe = 1
	begin
		/* 'Codigo de regimen fiscal ya existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609302
		return 1
	end

	insert into cb_regimen_fiscal 
               (rf_codigo,rf_descripcion,rf_iva,rf_timbre,
                rf_renta,rf_ica,rf_iva_des,rf_iva_cobrado,
                rf_estampillas,rf_3xm,rf_estado,rf_retencion_iva,
                rf_naturaleza,rf_grancontribuyente,rf_autorretenedor)
	values (@i_codigo, @i_descripcion, @i_aplica_iva,@i_aplica_timbre,
                @i_aplica_renta,@i_aplica_ica,@i_aplica_descontable,@i_aplica_iva_cobrado,
                @i_aplica_estampillas,@i_3xm,@i_estado,@i_reteiva,
                @i_naturaleza,@i_grancontribuyente,@i_autorretenedor)
	if @@error <> 0
	begin
		/* 'Error al Actualizar el regimen fiscal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609300
		return 1
	end
end


if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de Regimen Fiscal a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609300
		return 1
	end

	update cb_regimen_fiscal
	set 	rf_descripcion 	= @i_descripcion,
		rf_iva 		= @i_aplica_iva,
		rf_ica 		= @i_aplica_ica,
		rf_timbre 	= @i_aplica_timbre,
		rf_iva_des 	= @i_aplica_descontable,
		rf_renta 	= @i_aplica_renta,
		rf_iva_cobrado 	= @i_aplica_iva_cobrado,
		rf_estampillas 	= @i_aplica_estampillas,
                rf_3xm          = @i_3xm,
		rf_estado 	= @i_estado,
		rf_naturaleza     = @i_naturaleza,
		rf_grancontribuyente  = @i_grancontribuyente,
		rf_autorretenedor  = @i_autorretenedor,
		rf_retencion_iva = @i_reteiva
	where rf_codigo 	= @i_codigo
	if @@error <> 0
	begin
		/* 'Error al Actualizar el regimen fiscal' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609300
		return 1
	end
end


if @i_operacion = 'A'
begin
	if @i_opcion = 0	/* OPCION OTROS MODULOS DIFERENTES CONTA*/
	begin
		if @i_naturaleza is null or @i_grancontribuyente is null or @i_autorretenedor is null
		begin	/* Campos NOT NULL con valores nulos */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 601001
			return 1
		end

		set rowcount 20
		if @i_modo = 0
		begin
			select  'CODIGO' = rf_codigo,
				'DESCRIPCION' = rf_descripcion,
				'APLICA IVA' = rf_iva,
				'APLICA ICA' = rf_ica,
				'APLICA RENTA' = rf_renta,
				'APLICA TIMBRE' = rf_timbre,
				'APLICA DESCONTABLE' = rf_iva_des,
				'APLICA IVA COBRADO' = rf_iva_cobrado,
				'APLICA ESTAMPILLAS' = rf_estampillas,
		                'APLICA RETENCION DE IVA' = rf_retencion_iva,
	                        'APLICA GMF' = rf_3xm,
		                'APLICA A NATURALEZA' = rf_naturaleza,
		                'APLICA A GRAN CONTRIBUYENTE' = rf_grancontribuyente,
		                'APLICA AUTORRETENEDORES' = rf_autorretenedor,
				'ESTADO' = rf_estado
			from cb_regimen_fiscal
			where (rf_naturaleza = @i_naturaleza)
			and (rf_grancontribuyente = @i_grancontribuyente)
			and (rf_autorretenedor = @i_autorretenedor)
			and rf_estado = 'V'
			order by rf_codigo
		end
		else
		begin
			select 'CODIGO' = rf_codigo,
				'DESCRIPCION' = rf_descripcion,
				'APLICA IVA' = rf_iva,
				'APLICA ICA' = rf_ica,
				'APLICA RENTA' = rf_renta,
				'APLICA TIMBRE' = rf_timbre,
				'APLICA DESCONTABLE' = rf_iva_des,
				'APLICA IVA COBRADO' = rf_iva_cobrado,
				'APLICA ESTAMPILLAS' = rf_estampillas,
		                'APLICA RETENCION DE IVA' = rf_retencion_iva,
	                        'APLICA 3 X 1000' = rf_3xm,
		                'APLICA A NATURALEZA' = rf_naturaleza,
		                'APLICA A GRAN CONTRIBUYENTE' = rf_grancontribuyente,
		                'APLICA AUTORRETENEDORES' = rf_autorretenedor,
				'ESTADO' = rf_estado
			from cb_regimen_fiscal
			where rf_codigo > @i_codigo
			and (rf_naturaleza = @i_naturaleza)
			and (rf_grancontribuyente = @i_grancontribuyente)
			and (rf_autorretenedor = @i_autorretenedor)
			and rf_estado = 'V'
			order by rf_codigo
		end
	end
	else	/* OPCION SOLO PARA EL MODULO CONTA: @i_opcion = 1 */
	begin
		set rowcount 20
		if @i_modo = 0
		begin
			select  'CODIGO' = rf_codigo,
				'DESCRIPCION' = rf_descripcion,
				'APLICA IVA' = rf_iva,
				'APLICA ICA' = rf_ica,
				'APLICA RENTA' = rf_renta,
				'APLICA TIMBRE' = rf_timbre,
				'APLICA DESCONTABLE' = rf_iva_des,
				'APLICA IVA COBRADO' = rf_iva_cobrado,
				'APLICA ESTAMPILLAS' = rf_estampillas,
		                'APLICA RETENCION DE IVA' = rf_retencion_iva,
	                        'APLICA 3 X 1000' = rf_3xm,
		                'APLICA A NATURALEZA' = rf_naturaleza,
		                'APLICA A GRAN CONTRIBUYENTE' = rf_grancontribuyente,
		                'APLICA AUTORRETENEDORES' = rf_autorretenedor,
				'ESTADO' = rf_estado
			from cb_regimen_fiscal
			order by rf_codigo
		end
		else
		begin
			select 'CODIGO' = rf_codigo,
				'DESCRIPCION' = rf_descripcion,
				'APLICA IVA' = rf_iva,
				'APLICA ICA' = rf_ica,
				'APLICA RENTA' = rf_renta,
				'APLICA TIMBRE' = rf_timbre,
				'APLICA DESCONTABLE' = rf_iva_des,
				'APLICA IVA COBRADO' = rf_iva_cobrado,
				'APLICA ESTAMPILLAS' = rf_estampillas,
		                'APLICA RETENCION DE IVA' = rf_retencion_iva,
	                        'APLICA 3 X 1000' = rf_3xm,
		                'APLICA A NATURALEZA' = rf_naturaleza,
		                'APLICA A GRAN CONTRIBUYENTE' = rf_grancontribuyente,
		                'APLICA AUTORRETENEDORES' = rf_autorretenedor,
				'ESTADO' = rf_estado
			from cb_regimen_fiscal
			where rf_codigo > @i_codigo
			order by rf_codigo
		end
	end
	set rowcount 0
	return 0
end


if @i_operacion = 'V'
begin
	if @w_existe = 1
		if @i_opcion = 0
		begin
			select *
			from cb_regimen_fiscal
			where rf_codigo = @i_codigo
			and rf_estado = 'V'
		end
		else	/* OPCION EXCLUSIVA PARA EL MODULO DE CLIENTES */
		begin
			if @i_naturaleza is null or @i_grancontribuyente is null or @i_autorretenedor is null
			begin	/* Campos NOT NULL con valores nulos */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file, 
				@t_from  = @w_sp_name,
				@i_num   = 601001
				return 1
			end

			select *
			from cb_regimen_fiscal
			where rf_codigo = @i_codigo
			and rf_naturaleza = @i_naturaleza
			and rf_grancontribuyente = @i_grancontribuyente
			and rf_autorretenedor = @i_autorretenedor
			and rf_estado = 'V'
			if @@rowcount = 0
			begin	/* 'Regimen Fiscal consultado no existe  '*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 609301
				return 1
			end
		end
	else
	begin
		/* 'Regimen Fiscal consultado no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609301
		return 1
	end
end

return 0

go
