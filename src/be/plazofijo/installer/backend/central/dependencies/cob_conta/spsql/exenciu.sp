/************************************************************************/
/*	Archivo:            exenciu.sp                                      */
/*	Stored procedure:   sp_exenciu                                      */
/*	Base de datos:      cob_conta                                       */
/*	Producto:           contabilidad                                    */
/*	Disenado por:       Jose Orlando Forero                             */
/*	Fecha de escritura: 05-Noviembre-2002                               */
/************************************************************************/
/*                              IMPORTANTE                              */
/*	Este programa es parte de los paquetes bancarios propiedad de       */
/*	"MACOSA", representantes exclusivos para el Ecuador de la           */
/*	"NCR CORPORATION".                                                  */
/*	Su uso no autorizado queda expresamente prohibido asi como          */
/*	cualquier alteracion o agregado hecho por alguno de sus             */
/*	usuarios sin el debido consentimiento por escrito de la             */
/*	Presidencia Ejecutiva de MACOSA o su representante.                 */
/*                              PROPOSITO                               */
/*	Este programa procesa las transacciones de:                         */
/*	Mantenimiento al catalogo ciudades exentas de impuestos.            */
/*                            MODIFICACIONES                            */
/*	FECHA           AUTOR           RAZON                               */
/*  26/dic/2003     C.Ruiz          Agregar indicador @i_pit            */
/*  26/abr/2013     R.Reyes         Alianzas                            */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_exenciu')
	drop proc sp_exenciu
go
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO
---NR000353 partiendo de la verion Inicial
create proc sp_exenciu(
	@s_ssn          int = null,
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
	@i_operacion    char(1),
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
	@i_impuesto		char(1) = null,
	@i_concepto     char(4) = null,
	@i_debcred		char(1) = null,
	@i_ciudad   	int = null,
	@i_oficonta   	char(1) = "N",
	@i_ente   		int = null,
	@i_apl_ofi_orig char(1) = null,
	@i_apl_ofi_dest char(1) = null,
	@i_oforig_admin	smallint = null,
	@i_ofdest_admin	smallint = null,
	@i_producto	  	tinyint = null,
	@i_crea_ext     char(1)  = null,
    @i_pit          char(1) = 'N',
	@o_exento		char(1) = "N" out,
    @o_msg_msv      varchar(255) = null out
)
as 
declare
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_asociada		varchar(10),
	@w_ciudad		int,
	@w_apl_ofi_orig 	char(1),
	@w_apl_ofi_dest 	char(1),
	@w_oforig_admin		int,
	@w_ofdest_admin		int,
	@w_impuesto		char(1) 

select @w_sp_name = 'sp_exenciu'

select @o_exento = 'N'


if (@t_trn <> 6248 and @i_operacion = 'I') or
   (@t_trn <> 6249 and @i_operacion = 'D') or
   (@t_trn <> 6250 and @i_operacion = 'S') or
   (@t_trn <> 6251 and @i_operacion = 'F') /* Search exención x Ente, Oficina y Ciudad */
begin
	/* 'Tipo de transaccion no corresponde' */
	if @i_crea_ext is null
	begin
		exec cobis..sp_cerror1
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601077,
	        @i_pit   = @i_pit
		return 1
	end
	ELSE
	begin
           select @o_msg_msv = 'Error en Tipo de Transaccion'
	   return 601077
	end
end


if @t_debug = 'S'
begin
	exec cobis..sp_begin_debug @t_file = @t_file
	select '/** Store Procedure **/ ' = @w_sp_name,
		t_file		= @t_file,
		t_from		= @t_from,
		i_operacion	= @i_operacion,
		i_empresa	= @i_empresa,
		i_modo 		= @i_modo,
		i_impuesto 	= @i_impuesto,
		i_concepto	= @i_concepto,
		i_debcred       = @i_debcred,
		i_ciudad 	= @i_ciudad,
		i_ofiadmin      = @i_ofdest_admin,
		i_oficonta      = @i_oficonta,
		i_ente          = @i_ente
	exec cobis..sp_end_debug
end


/**************** VALIDACIONES ***********************/
if @i_operacion = 'F'
begin
	if @i_empresa is null or @i_impuesto is null or @i_concepto is null
	or @i_debcred is null or @i_oforig_admin is null or @i_ofdest_admin is null
	begin	/* Campos NOT NULL con valores nulos */

		if @i_crea_ext is null
	        begin	
			exec cobis..sp_cerror1
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 601001,
	                @i_pit   = @i_pit
			return 1
		end
		ELSE
		begin
	           select @o_msg_msv = 'Error en Tipo de Transaccion'
	           return 601001
		end
	end

	/* PARAMETRO Y VALIDACION SOLO PARA EL MODULO DE CONTABILIDAD */
	if @i_oficonta = "S"
	begin
		/* A PARTIR DE LAS OFICINAS DE CONTABILIDAD GENERA LAS DE ADMIN */
		select @w_oforig_admin = c.re_ofadmin
		from cobis..cl_oficina a, cob_conta..cb_oficina b, cob_conta..cb_relofi c
		where a.of_oficina = c.re_ofadmin
		and a.of_filial = c.re_filial
		and c.re_empresa = @i_empresa
		and c.re_empresa = b.of_empresa
		and b.of_oficina = c.re_ofconta
		and b.of_oficina = @i_oforig_admin
		--and c.re_ofadmin = @i_ofdest_admin
		and b.of_estado = 'V'
		and b.of_movimiento = 'S'

		select @w_ofdest_admin = c.re_ofadmin
		from cobis..cl_oficina a, cob_conta..cb_oficina b, cob_conta..cb_relofi c
		where a.of_oficina = c.re_ofadmin
		and a.of_filial = c.re_filial
		and c.re_empresa = @i_empresa
		and c.re_empresa = b.of_empresa
		and b.of_oficina = c.re_ofconta
		and b.of_oficina = @i_ofdest_admin
		--and c.re_ofadmin = @i_ofdest_admin
		and b.of_estado = 'V'
		and b.of_movimiento = 'S'

		select @i_oforig_admin = @w_oforig_admin, @i_ofdest_admin = @w_ofdest_admin
	end
end


if @i_operacion = 'I'
begin
	if exists (select 1 from cb_exencion_ciudad, cobis..cl_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = @i_impuesto
		and ec_concepto = @i_concepto
		and ec_debcred = @i_debcred
		and ec_ciudad = @i_ciudad
		and ec_ciudad = ci_ciudad
		and ci_estado = 'V')
	begin
		/* 'Error en creacion de ciudad' */
		if @i_crea_ext is null
	        begin	
			exec cobis..sp_cerror1
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 103019,
	                @i_pit   = @i_pit
			return 1
		end
		ELSE
		begin
	           select @o_msg_msv = 'Error en creacion de ciudad'
	           return 103019
		end
	end
	else
	begin
		insert into cb_exencion_ciudad
		       (ec_empresa,ec_impuesto,ec_concepto,ec_debcred,
		       ec_ciudad,ec_ofi_orig,ec_ofi_dest)
		values (@i_empresa,@i_impuesto,@i_concepto,@i_debcred,
			@i_ciudad,@i_apl_ofi_orig,@i_apl_ofi_dest)
		if @@error <> 0 
		begin
			/* 'Error en creacion de ciudad' */
			if @i_crea_ext is null
		                begin				
				exec cobis..sp_cerror1
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 103019,
	                        @i_pit   = @i_pit
				return 1
			 end
			 ELSE
			 begin
	                    select @o_msg_msv = 'Error en creacion de ciudad'
	                    return 103019
			 end	
		end
	end
	return 0
end



if @i_operacion = 'D'
begin
	if exists (select 1 from cb_exencion_ciudad, cobis..cl_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = @i_impuesto
		and ec_concepto = @i_concepto
		and ec_debcred = @i_debcred
		and ec_ciudad = @i_ciudad
		and ec_ciudad = ci_ciudad
		and ci_estado = 'V')
	begin
		delete cb_exencion_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = @i_impuesto
		and ec_concepto = @i_concepto
		and ec_debcred = @i_debcred
		and ec_ciudad = @i_ciudad
		if @@error <> 0 
		begin
			/* 'Error en eliminacion de ciudad' */
			if @i_crea_ext is null
		        begin				
				exec cobis..sp_cerror1
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 107019,
                                @i_pit   = @i_pit
				return 1
			end
			ELSE
			begin
	                   select @o_msg_msv = 'Error en eliminacion de ciudad'
	                   return 107019
			end
		end
	end
	else
	begin
		/* 'Error en eliminacion de ciudad' */
			if @i_crea_ext is null
		        begin				
		
				exec cobis..sp_cerror1
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 107019,
		                @i_pit   = @i_pit
				return 1
			end
			ELSE
			begin
	                   select @o_msg_msv = 'Error en eliminacion de ciudad'
	                   return 107019
			end
	end
	return 0
end



if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
        select 'EMPRESA' = ec_empresa, 'DEB/CRED' = ec_debcred,
		'IMPUESTO' = ec_impuesto, 'CONCEPTO' = ec_concepto, 'DESCRIPCION' = iva_descripcion,
		'COD. CIUDAD' = ci_ciudad, 'NOM. CIUDAD' = ci_descripcion,
		'COD. DEPTO' = pv_provincia, 'DEPARTAMENTO' = pv_descripcion,
		'OFI. ORIG' = ec_ofi_orig, 'OFI. DEST' = ec_ofi_dest
		from cb_exencion_ciudad, cb_iva, cobis..cl_ciudad, cobis..cl_provincia
		where ec_empresa = @i_empresa
		and ec_impuesto in ('I')
		and ec_concepto = @i_concepto
		and ec_debcred in ('D','C')
		and ec_ciudad = ci_ciudad
		and ci_provincia = pv_provincia
		and ci_estado = 'V'
		and pv_estado = 'V'
		and iva_empresa = ec_empresa
		and iva_codigo = ec_concepto
        group by ec_empresa, ec_debcred, ec_impuesto, ec_concepto, iva_descripcion, ci_ciudad, ci_descripcion, pv_provincia, pv_descripcion, ec_ofi_orig, ec_ofi_dest
        order by ec_impuesto,ec_concepto,ec_debcred
        
	end
	else
	begin
        select 'EMPRESA' = ec_empresa, 'DEB/CRED' = ec_debcred,
		'IMPUESTO' = ec_impuesto, 'CONCEPTO' = ec_concepto, 'DESCRIPCION' = iva_descripcion,
		'COD. CIUDAD' = ci_ciudad, 'NOM. CIUDAD' = ci_descripcion,
		'COD. DEPTO' = pv_provincia, 'DEPARTAMENTO' = pv_descripcion,
		'OFI. ORIG' = ec_ofi_orig, 'OFI. DEST' = ec_ofi_dest
		from cb_exencion_ciudad, cb_iva, cobis..cl_ciudad, cobis..cl_provincia
		where ec_empresa = @i_empresa
		and ec_impuesto in ('I','C','R','T','P','E')
		and ec_concepto = @i_concepto
		and ec_debcred in ('D','C')
		and ec_ciudad = ci_ciudad
		and ci_provincia = pv_provincia
		and ci_estado = 'V'
		and pv_estado = 'V'
		and iva_empresa = ec_empresa
		and iva_codigo = ec_concepto
		and ((ec_impuesto > @i_impuesto) or (ec_impuesto = @i_impuesto and ec_concepto > @i_concepto) or (ec_impuesto = @i_impuesto and ec_concepto = @i_concepto and ec_debcred > @i_debcred)
		or (ec_impuesto = @i_impuesto and ec_concepto = @i_concepto and ec_debcred = @i_debcred and ec_ciudad > @i_ciudad))
		group by ec_empresa, ec_debcred, ec_impuesto, ec_concepto, iva_descripcion, ci_ciudad, ci_descripcion, pv_provincia, pv_descripcion, ec_ofi_orig, ec_ofi_dest
        order by ec_impuesto,ec_concepto,ec_debcred
	end
	set rowcount 0
	return 0
end


if @i_operacion = 'F'
begin
	if @i_impuesto = 'V'
		select @w_impuesto = 'I'
	else
		select @w_impuesto = @i_impuesto

	if (@i_oforig_admin is not null and @i_oforig_admin > 0) and @o_exento = "N"
	begin
		/* CONSULTA LA CIUDAD DE LA OFICINA ADMIN ORIGEN */
		select @w_ciudad = a.of_ciudad
		from cobis..cl_oficina a, cob_conta..cb_oficina b, cob_conta..cb_relofi c
		where a.of_oficina = c.re_ofadmin
		and a.of_filial = c.re_filial
		and c.re_empresa = @i_empresa
		and c.re_empresa = b.of_empresa
		and b.of_oficina = c.re_ofconta
		and re_ofadmin = @i_oforig_admin
		and b.of_estado = 'V'
		and b.of_movimiento = 'S'

		/* DETERMINA SI A LA CIUDAD LE APLICA O NO EL IMPUESTO */
		select @w_apl_ofi_orig = isnull(ec_ofi_orig,"N")
		from cob_conta..cb_exencion_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = @w_impuesto
		and ec_concepto = @i_concepto
		and ec_debcred = @i_debcred
		and ec_ciudad = @w_ciudad

		if isnull(@w_apl_ofi_orig,'N') = "N"
			select @o_exento = "N"	-- NO EXENTO DE IMPUESTO
		else
			select @o_exento = "S"	-- EXENTO DE IMPUESTO

	end


	if (@i_ofdest_admin is not null and @i_ofdest_admin > 0) and @o_exento = "N"
	begin
		/* CONSULTA LA CIUDAD DE LA OFICINA ADMIN DESTINO */
		select @w_ciudad = a.of_ciudad
		from cobis..cl_oficina a, cob_conta..cb_oficina b, cob_conta..cb_relofi c
		where a.of_oficina = c.re_ofadmin
		and a.of_filial = c.re_filial
		and c.re_empresa = @i_empresa
		and c.re_empresa = b.of_empresa
		and b.of_oficina = c.re_ofconta
		and re_ofadmin = @i_ofdest_admin
		and b.of_estado = 'V'
		and b.of_movimiento = 'S'

		/* DETERMINA SI A LA CIUDAD LE APLICA O NO EL IMPUESTO */
		select @w_apl_ofi_dest = isnull(ec_ofi_dest,"N")
		from cob_conta..cb_exencion_ciudad
		where ec_empresa = @i_empresa
		and ec_impuesto = @w_impuesto
		and ec_concepto = @i_concepto
		and ec_debcred = @i_debcred
		and ec_ciudad = @w_ciudad

		if isnull(@w_apl_ofi_dest,'N') = "N"
			select @o_exento = "N"	-- NO EXENTO DE IMPUESTO
		else
			select @o_exento = "S"	-- EXENTO DE IMPUESTO
	end



	if (@i_ente is not null and @i_ente > 0) and @o_exento = 'N'
	begin
		select @w_asociada = en_asosciada
		from cobis..cl_ente
		where en_ente = @i_ente
		if @@rowcount = 0
		begin	/* 'No existe cliente'*/
			exec cobis..sp_cerror1
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 101146,
                        @i_pit   = @i_pit
			return 1
		end

		/* Si APLICA Impuesto NO hay exencion */
		if @i_impuesto = "R"	--RENTA
			select @o_exento = case rf_renta when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
		else if @i_impuesto = "I"	--IVA
			select @o_exento = case rf_retencion_iva when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
		else if @i_impuesto = "C"	--ICA
			select @o_exento = case rf_ica when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
		else if @i_impuesto = "T"	--TIMBRE
			select @o_exento = case rf_timbre when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
		else if @i_impuesto = "P"	--IVA PAGADO PERO SE USA IVA COBRADO
			select @o_exento = case rf_iva when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
		else if @i_impuesto = "V"	--IVA PAGADO PERO SE USA IVA COBRADO
			select @o_exento = case rf_iva_cobrado when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
		else if @i_impuesto = "E"	--ESTAMPILLAS
			select @o_exento = case rf_estampillas when "S" then "N" else "S" end
			from cb_regimen_fiscal
			where rf_codigo = @w_asociada and rf_estado = 'V'
	end
	if (@i_producto is not null ) and @o_exento = 'N'
	begin
		if exists ( select 1 from cob_conta..cb_exencion_producto
				where ep_empresa = @i_empresa
				and   ep_regimen = @w_asociada 
				and   ep_producto = @i_producto
				and   ep_impuesto = @i_impuesto
				and   ep_concepto = @i_concepto
			)
			select @o_exento = "S"	-- EXENTO DE IMPUESTO
		else
			select @o_exento = "N"	-- NO EXENTO DE IMPUESTO			
		

	end
	return 0
end

go
