use cob_remesas
go

declare @w_cta_aso			int,
		@w_cta_asa			int,
		@w_return			int,
		@w_trn				int,
		@w_tipo             char(1),
		@w_categoria		char(1),
		@w_tipo_ente		char(1),
		@w_rol_ente			char(1),
		@w_tipo_def			char(1),
		@w_personalizada	char(1),
		@w_cta_banco        cuenta,
		@w_producto			tinyint,
		@w_moneda           tinyint,
		@w_prod_banc		smallint,
		@w_default			int,
		@w_filial			int, 
		@w_oficina			int, 
		@w_cuenta			int,
		@w_valor			money,
		@w_fecha			datetime,
		@w_fila				int,
		@w_no_fila			int

-- Producto Final Aporte Social Ordinario
select @w_cta_aso  = pa_int
	from cobis..cl_parametro
	where pa_producto = 'AHO'
	and pa_nemonico = 'PCAASO'
-- Producto Final Aporte Social Adicional
select @w_cta_asa = pa_int
	from cobis..cl_parametro
	where pa_producto = 'AHO'
	and pa_nemonico = 'PCAASA'
  
select @w_trn = 201
select @w_fecha = fp_fecha from cobis..ba_fecha_proceso

declare @TablaCtaAho as table 
(
	id_key				 int identity, 
	ah_cuenta            INT NOT NULL,
	ah_cta_banco         CHAR (16) NOT NULL,
	ah_filial            TINYINT NOT NULL,
	ah_oficina           SMALLINT NOT NULL,
	ah_tipo              CHAR (1) NOT NULL,
	ah_categoria         CHAR (1) NOT NULL,	
	ah_tipocta           CHAR (1) NOT NULL,
	ah_rol_ente          CHAR (1) NOT NULL,
	ah_tipo_def          CHAR (1) NOT NULL,
	ah_prod_banc         SMALLINT NOT NULL,
	ah_producto          TINYINT NOT NULL,
	ah_moneda            TINYINT NOT NULL,
	ah_default           INT NOT NULL,
	ah_personalizada     CHAR (1) NOT NULL
)

insert into @TablaCtaAho (ah_cuenta, ah_cta_banco, ah_filial, ah_oficina, ah_tipo, ah_categoria, ah_tipocta, ah_rol_ente, 
			ah_tipo_def, ah_prod_banc, ah_producto, ah_moneda, ah_default, ah_personalizada)
	select	ah_cuenta, ah_cta_banco, ah_filial, ah_oficina, ah_tipo, ah_categoria, ah_tipocta, ah_rol_ente, 
			ah_tipo_def, ah_prod_banc, ah_producto, ah_moneda, ah_default, ah_personalizada
		from cob_ahorros..ah_cuenta 
			where ah_prod_banc in (@w_cta_aso, @w_cta_asa)
			order by ah_cuenta desc 

select @w_fila = min(id_key) from @TablaCtaAho
select @w_no_fila = max(id_key) from @TablaCtaAho

if (isnull(@w_fila, 0) > 0)
begin
	while @w_fila <= @w_no_fila
	begin
		select	@w_cuenta		= ah_cuenta,
				@w_cta_banco	= ah_cta_banco, 
				@w_filial		= ah_filial, 
				@w_oficina		= ah_oficina,
				@w_tipo			= ah_tipo,
				@w_categoria	= ah_categoria, 
				@w_tipo_ente	= ah_tipocta, 
				@w_rol_ente		= ah_rol_ente, 
				@w_tipo_def		= ah_tipo_def, 
				@w_prod_banc	= ah_prod_banc, 
				@w_producto		= ah_producto, 
				@w_moneda		= ah_moneda, 
				@w_default		= ah_default, 
				@w_personalizada=ah_personalizada
			from @TablaCtaAho 
			where id_key = @w_fila
					
		 exec @w_return = cob_remesas..sp_genera_costos
			@i_categoria   = @w_categoria,
			@i_tipo_ente   = @w_tipo_ente,
			@i_rol_ente    = @w_rol_ente,
			@i_tipo_def    = @w_tipo_def,
			@i_prod_banc   = @w_prod_banc,
			@i_producto    = @w_producto,
			@i_moneda      = @w_moneda,
			@i_tipo        = @w_tipo,
			@i_codigo      = @w_default,
			@i_servicio    = 'SMC',
			@i_rubro       = 'SMA',
			@i_disponible  = $0,
			@i_contable    = $0,
			@i_promedio    = $0,
			@i_personaliza = @w_personalizada,
			@i_filial      = @w_filial,
			@i_oficina     = @w_oficina,
			@i_fecha       = @w_fecha,
			@o_valor_total = @w_valor out

		--select @w_valor, @w_prod_banc, @w_tipo_ente
		if (@w_return = 0)
		begin
			if ((select count(*) from cob_ahorros..ah_tran_servicio where ts_cta_banco = @w_cta_banco and ts_tipo_transaccion = @w_trn) = 1)
			begin
				begin tran
				update cob_ahorros..ah_tran_servicio set ts_valor = isnull(@w_valor, 0) where ts_cta_banco = @w_cta_banco and ts_tipo_transaccion = @w_trn
			
				if (@@error > 0)
					rollback
				else
					commit
			end
			else
			begin
				print 'NO SE PUEDE ACTUALIZAR LA CUENTA: '+ @w_cta_banco
			end
		end
		select @w_fila = @w_fila + 1
	end
end


/*
*/