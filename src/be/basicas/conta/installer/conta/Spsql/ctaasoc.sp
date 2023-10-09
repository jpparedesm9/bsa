/************************************************************************/
/*	Archivo: 		ctaasoc.sp			        */
/*	Stored procedure: 	sp_cuenta_asociada			*/
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
/*	   Mantenimiento al catalogo de cuentas asociadas a una cuenta  */
/*	que interviene en un proceso					*/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	7/ene/1994	G Jaramillo     Emision Inicial			*/
/*	21/Nov/97	Juan Carlos Gomez cambio en operacion 'S'	*/
/*	29/Nov/97       Maria Victoria Garay Validacion de Cta asociad	*/
/*	07/Ene/1998	Juan Carlos Gomez Cambio en tipo de datos	*/
/*			JCG10						*/
/*      16/May/2005     Olga Rios       Se modifica tipo de dato a      */
/*                                      variables i_proceso             */     
/*	21/oct/2005	Olga Rios	Modificacion fecha tran servicio*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cuenta_asociada')
	drop proc sp_cuenta_asociada
go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_cuenta_asociada   (
	@s_ssn			int = null,
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
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
	@i_cuenta		cuenta = null,
	@i_oficina		smallint = null,
	@i_area			smallint = null,
	@i_proceso		int = null,
	@i_secuencial		smallint = null,  /* JCG10 */
	@i_condicion		smallint = null,
	@i_cta_asoc		char(20) = null,
	@i_oficina_destino	smallint = null,
	@i_area_destino		smallint = null,
	@i_debcred		char(1) = null
)
as 
declare
	@w_today 		datetime,  	/* fecha del dia */
	@w_return		int,		/* valor que retorna */
	@w_sp_name		varchar(32),	/* nombre del stored procedure*/
	@w_siguiente		tinyint,
	@w_empresa		tinyint,
	@w_cuenta		cuenta,
	@w_oficina		smallint,   /* JCG10 */
	@w_proceso 		int,
	@w_secuencial		smallint,   /* JCG10 */
	@w_condicion		smallint,
	@w_cta_asoc		char(20),
	@w_oficina_destino	smallint,
	@w_area_destino		smallint,
	@w_debcred		char(1),
	@w_existe		int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_cuenta_asociada'



/************************************************/
/*  Tipo de Transaccion = 623X 			*/

if (@t_trn <> 6231 and @i_operacion = 'I') or
   (@t_trn <> 6232 and @i_operacion = 'U') or
   (@t_trn <> 6233 and @i_operacion = 'D') or
   (@t_trn <> 6234 and @i_operacion = 'V') or
   (@t_trn <> 6235 and @i_operacion = 'S') or
   (@t_trn <> 6236 and @i_operacion = 'Q') or
   (@t_trn <> 6237 and @i_operacion = 'A') 
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
		i_empresa	= @i_empresa,
		i_cuenta	= @i_cuenta,
		i_oficina	= @i_oficina,
		i_proceso	= @i_proceso,
		i_secuencial	= @i_secuencial,
		i_condicion	= @i_condicion,
		i_cta_asoc	= @i_cta_asoc,
		i_debcred	= @i_debcred
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A' 
begin 
	select 	@w_empresa    = ca_empresa,
 
		@w_cuenta     = ca_cuenta,
		@w_oficina    = ca_oficina,
		@w_proceso    = ca_proceso,
		@w_secuencial = ca_secuencial,
		@w_condicion  = ca_condicion,
		@w_cta_asoc   = ca_cta_asoc,
		@w_oficina_destino = ca_oficina_destino,
		@w_area_destino    = ca_area_destino,
		@w_debcred         = ca_debcred
		
	from cob_conta..cb_cuenta_asociada
	where 	ca_empresa = @i_empresa and
		ca_cuenta  = @i_cuenta and
		ca_oficina = @i_oficina and
                ca_area    = @i_area and  /* NMA - Mzo 95 */
		ca_proceso = @i_proceso and
	/*	ca_secuencial = @i_secuencial and*/ 
                ca_cta_asoc = @i_cta_asoc /*MVG*/ 


	if @@rowcount > 0
		select @w_existe = 1
	else
		select @w_existe = 0 
end  
/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if @i_empresa is NULL or @i_proceso is NULL or @i_cuenta is null or
	   @i_secuencial is null
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end
end

/**** Integridad Referencial *****/
/*********************************/
	
if NOT EXISTS (select * from cob_conta..cb_empresa
			where  em_empresa = @i_empresa)
begin
	/* 'No existe codigo de Empresa especificada' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601018
	return 1
end

if NOT EXISTS (select * from cobis..ba_batch
	  where	ba_batch = @i_proceso)
begin
	/* 'No existe codigo de Proceso especificado' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601097
	return 1
end

if NOT EXISTS (select * from cob_conta..cb_cuenta_proceso
	       where cp_empresa = @i_empresa and
	       cp_cuenta = @i_cuenta and
	       cp_proceso = @i_proceso)
begin
	/* 'Cuenta no esta relacionada a proceso' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601101
	return 1
end


/* Insercion de cuenta asociada */
/********************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	begin
		/* 'Cuenta ya esta asociada a cuenta proceso  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601100
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran

		insert into cob_conta..cb_cuenta_asociada
		       (ca_empresa,ca_cuenta,ca_oficina,
                        ca_area,                             /* NMA -Mzo 95 */
			ca_proceso,ca_secuencial,ca_condicion,
			ca_cta_asoc,ca_oficina_destino,ca_area_destino,
			ca_debcred)
		values (@i_empresa,@i_cuenta,@i_oficina, @i_area,
			@i_proceso,@i_secuencial,@i_condicion,
			@i_cta_asoc,@i_oficina_destino,@i_area_destino,
			@i_debcred)

		if @@error <> 0 
		begin
		/* error en insercion de cuenta asociada*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603041
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_asociada
		values (@s_ssn,@t_trn,'N',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@i_proceso,@i_cuenta,@i_oficina,
			@i_secuencial,@i_cta_asoc,@i_condicion,@i_debcred)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
	commit tran
	return 0
end

/* Actualizacion de Proceso (Update) */
/***************************************/

if @i_operacion = 'U' 
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de cuenta asociada a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605060
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update 	cob_conta..cb_cuenta_asociada
		set 	ca_condicion = @i_condicion,
			ca_cta_asoc = @i_cta_asoc,   
			ca_oficina_destino = @i_oficina_destino,
			ca_area_destino = @i_area_destino,
			ca_debcred = @i_debcred
		where 	ca_empresa = @i_empresa and
			ca_cuenta = @i_cuenta and
			ca_oficina = @i_oficina and
			ca_proceso = @i_proceso and
			ca_secuencial = @i_secuencial

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de cuenta asociada'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605061
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_asociada
		values (@s_ssn,@t_trn,'P',getdate(),@s_user,@s_term,@s_ofi,
			@w_empresa,@w_proceso,@w_cuenta,@w_oficina,
			@w_secuencial,@w_cta_asoc,@w_condicion,@w_debcred)
		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
		insert into ts_cuenta_asociada
		values (@s_ssn,@t_trn,'N',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@i_proceso,@i_cuenta,@i_oficina,
			@i_secuencial,@i_cta_asoc,@i_condicion,@i_debcred)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
	commit tran
	return 0
end

/* Eliminacion de Proceso  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de cuenta asociada a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607086
		return 1
	end

	/**** Integridad Referencial ****/
	/********************************/


	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_cuenta_asociada
		where 	ca_empresa = @i_empresa and
			ca_cuenta = @i_cuenta and
			ca_proceso = @i_proceso and
			ca_secuencial = @i_secuencial

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Cuenta asociada' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607087
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_asociada
		values (@s_ssn,@t_trn,'B',getdate(),@s_user,@s_term,@s_ofi,
			@w_empresa,@w_proceso,@w_cuenta,@w_oficina,
			@w_secuencial,@w_cta_asoc,@w_condicion,@w_debcred)

		if @@error <> 0
		begin
			/* 'Error en insercion de transaccion de servicio' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603032
			return 1
		end
	commit tran
	return 0
end

/**********************/
/* Query de Procesos  */
/**********************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select 	@w_cuenta,@w_oficina,@w_proceso,
			@w_secuencial,@w_condicion,@w_cta_asoc,
			@w_oficina_destino,@w_area_destino,@w_debcred
	else
	begin
		/* 'Cuenta Asociada no existe' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601103
		return 1
	end
end

/*  All */
/********/

if @i_operacion = 'A'
begin
/*	set rowcount 20 */
	if @i_modo = 0
	begin
		select 	ca_cuenta,isnull(convert(char(4),ca_oficina),"NULL"),
			isnull(convert(char(4),ca_area),"NULL"),
			ca_proceso,ca_secuencial
		from cob_conta..cb_cuenta_asociada
		where ca_empresa = @i_empresa and
			ca_oficina = @i_oficina and
			ca_proceso = @i_proceso 

		if @@rowcount = 0
		begin
			/* 'No existen cuentas asociadas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		end
		set rowcount 0
		return 0
	end
	else
	begin
		select 	ca_cuenta,isnull(convert(char(4),ca_oficina),"NULL"),
			isnull(convert(char(4),ca_area),"NULL"),
			ca_proceso,ca_secuencial
		from cob_conta..cb_cuenta_asociada
		where 	ca_empresa = @i_empresa and
			((ca_proceso = @i_proceso and ca_cuenta > @i_cuenta) or
			(ca_proceso > @i_proceso))

		if @@rowcount = 0
		begin
			/* 'No existen cuentas relacionadas a Procesos'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		end
		set rowcount 0
		return 0
	end
end

/*  Search */
/***********/

if @i_operacion = 'S'
begin
	set rowcount 80
	if @i_modo = 0
	begin
		select  'Secuencial' = ca_secuencial, 
			'Cuenta' = ca_cta_asoc,
			'Condicion' = ca_condicion,
			'Ofic.Dest' = isnull(convert(char(4),ca_oficina_destino)," "),
			'Area_Dest' = isnull(convert(char(4),ca_area_destino)," "),
			'Deb/Cred' = ca_debcred
		from cob_conta..cb_cuenta_asociada
		where ca_empresa = @i_empresa and
			ca_cuenta  = @i_cuenta and 
			ca_proceso = @i_proceso and
			ca_oficina = @i_oficina and
			ca_area    = @i_area 

		if @@rowcount = 0
		begin
			/* 'No existen cuentas asociadas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		end
		set rowcount 0
		return 0
	end
	else
	begin
		select 	'Secuencial' = ca_secuencial,
			'Cuenta' = ca_cta_asoc,
			'Condicion' = ca_condicion,
			'Ofic.Dest' = isnull(convert(char(4),ca_oficina_destino)," "),
			'Area_Dest' = isnull(convert(char(4),ca_area_destino)," "),
			'Deb/Cred' = ca_debcred
		from cob_conta..cb_cuenta_asociada
		where 	ca_empresa = @i_empresa and
			ca_cuenta = @i_cuenta and
                        ca_proceso = @i_proceso and
			ca_secuencial > @i_secuencial

		if @@rowcount = 0
		begin
			/* 'No existen cuentas relacionadas a Procesos'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102
			return 1
		end
		set rowcount 0
		return 0
	end
end

/**** Value  ****/
/****************/

if @i_operacion = 'V'
begin
	if @w_existe = 1
		select @w_oficina
	else
	begin
		/* 'cuenta no esta relacionada a Proceso '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601101
		return 1
	end
	return 0
end
go
