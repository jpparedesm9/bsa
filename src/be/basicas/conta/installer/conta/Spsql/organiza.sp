/************************************************************************/
/*	Archivo: 		organiza.sp 			        */
/*	Stored procedure: 	sp_organizacion				*/
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
/*	   Mantenimiento al catalogo de Organizacion de una Empresa     */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	30/Jul/1993	G Jaramillo     Emision Inicial			*/
/*	03/12/1997	Juan Carlos Gomez Se modifica tipo de @w_oficina*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_organizacion')
	drop proc sp_organizacion  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_organizacion   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 605,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_organizacion   	tinyint = null,
	@i_descripcion  descripcion = null 
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
        @w_descripcion  descripcion,
	@w_organizacion	tinyint,
	@w_sdescripcion	descripcion,	
	@w_flag1 	tinyint,
	@w_oficina	smallint,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_organizacion'




/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6051 and @i_operacion = 'I') or
   (@t_trn <> 6052 and @i_operacion = 'U') or
   (@t_trn <> 6053 and @i_operacion = 'D') or
   (@t_trn <> 6054 and @i_operacion = 'V') or
   (@t_trn <> 6055 and @i_operacion = 'S') or
   (@t_trn <> 6056 and @i_operacion = 'Q') or
   (@t_trn <> 6057 and @i_operacion = 'A') or
   (@t_trn <> 6058 and @i_operacion = 'R') 
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
		i_organizacion 	= @i_organizacion,
		i_descripcion	= @i_descripcion 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa = or_empresa,
		@w_organizacion = or_organizacion,
		@w_descripcion = or_descripcion 
	from cb_organizacion
	where 	or_empresa = @i_empresa and
		or_organizacion = @i_organizacion

	if @@rowcount <> 0
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

	if	@i_empresa      is NULL or 
		@i_descripcion  is NULL or
		@i_organizacion is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

	if NOT EXISTS (select * from cob_conta..cb_empresa
 		where em_empresa = @i_empresa
		)
	begin
		/* 'No existe empresa especificada' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end

	
end


/* Insercion de organizacion */
/*************************/

if @i_operacion = 'I'
begin
	begin tran
		if @w_existe = 1 
		begin
			/* 'Codigo de organizacion ya existe           ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601038
			return 1
		end
	
	/* Insercion del registro */
	/**************************/
		insert into cb_organizacion
		values (@i_empresa,@i_organizacion,@i_descripcion)
		if @@error <> 0 
		begin
			/* 'Error en insercion de Organizacion     ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603013
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_organizacion
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_organizacion,@i_descripcion)

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

/* Actualizacion de organizacion  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Organizacion a actualizar NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605023
		return 1
	end
	
        /* SYR esta validacion no debe efectuarse 10/DIC/1998 */

	/* select @w_oficina = of_oficina
	from cob_conta..cb_oficina
	where of_empresa = @i_empresa and
		of_organizacion = @i_organizacion */
  
        select @w_descripcion = or_descripcion
        from cob_conta..cb_organizacion
        where or_descripcion = @i_descripcion
          and or_empresa = @i_empresa

	if @@rowcount > 0
	begin
		/* 'Organizacion relacionada con Oficinas ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609148
		return 1
	end


	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_organizacion
		set 	or_descripcion = @i_descripcion 
		where 	or_empresa = @i_empresa and
			or_organizacion = @i_organizacion

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Organizacion'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605024
			return 1
		end
		
		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_organizacion
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_organizacion,@w_descripcion)

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
		insert into ts_organizacion
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_organizacion,@i_descripcion)

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

/* Eliminacion de organizacion  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Organizacion a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607031
		return 1
	end

/**** Integridad referencial ****/
/********************************/

       	/* Si codigo de organizacion existe en catalogo de cuentas      
	   No se puede eliminar el organizacion */
     	if EXISTS (select of_organizacion 
		from cob_conta..cb_oficina
		where 	of_empresa = @i_empresa and
			of_organizacion = @i_organizacion 
		)
	begin
		/* 'Codigo de Organizacion relacionado con Oficinas ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607033
		return 1
	end

	begin tran

		select @w_siguiente = @i_organizacion + 1
		select @w_flag1 = 1
		while @w_flag1 > 0
		begin
			select @w_sdescripcion = or_descripcion 
			from cob_conta..cb_organizacion
			where or_empresa = @i_empresa and
				or_organizacion = @w_siguiente

			if @@rowcount > 0 
			begin
				if exists (select of_organizacion
					from cob_conta..cb_oficina
					where 	of_empresa = @i_empresa and
						of_organizacion = @w_siguiente
					)
				begin
				/* 'Niveles inferiores de organizacion relacionados con oficinas' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607046
	
					select @w_flag1 = 1
					return 1
				end
				else
				begin
					update cob_conta..cb_organizacion
					set or_descripcion = @w_sdescripcion 
					where or_empresa = @i_empresa and
					or_organizacion = @w_siguiente - 1

					if @@error <> 0
					begin
						/* 'Error en Eliminacion de organizacion' */
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file	 = @t_file,
						@t_from	 = @w_sp_name,
						@i_num	 = 607034
						return 1
					end

				end
				select @w_siguiente = @w_siguiente + 1
			end
			else
			begin
				select @w_flag1 = 0
				delete cob_conta..cb_organizacion
				where or_empresa = @i_empresa and
					or_organizacion = @w_siguiente - 1
				if @@error <> 0
				begin
					/* 'Error en Eliminacion de Nivel de Organizacion' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607034
					return 1
				end
      			end
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_organizacion
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_organizacion,@i_descripcion)

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

/************************************/
/* Query de Niveles de Organizacion */
/************************************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select @w_empresa,@w_organizacion,
		@w_descripcion
	else
	begin
		/* 'Nivel de Organizacion consultado no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601040
		return 1
	end
end

/*  All */
/********/

if @i_operacion = 'A'
begin
set rowcount 20
if @i_modo = 0
begin
	select or_organizacion,or_descripcion
	from cob_conta..cb_organizacion
	where or_empresa = @i_empresa
	order by or_organizacion

	if @@rowcount = 0
	begin
		/* 'No existen Niveles de Organizacion '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601041
		return 1
	end
	set rowcount 0
	return 0
end
if @i_modo = 1
begin
	select or_organizacion,or_descripcion
	from cob_conta..cb_organizacion
	where   or_empresa = @i_empresa and
		or_organizacion > @i_organizacion
	order by or_organizacion

	if @@rowcount = 0
	begin
		/* 'No existen Niveles de Organizacion '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601041
		return 1
	end
	set rowcount 0
	return 0
end
end

/**** Value ****/
/****************/

if @i_operacion = 'V'
begin
if @w_existe = 1
	select @w_descripcion
else
begin
	/* 'Nivel de Organizacion consultado no existe  '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601040
	return 1
end
return 0
end


/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Nivel' = or_organizacion,
			'Nombre Nivel' = substring(or_descripcion,1,45) 
		from cob_conta..cb_organizacion
		where or_empresa = @i_empresa
		order by or_organizacion

		if @@rowcount = 0
		begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601035
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'Nivel' = or_organizacion,
			'Nombre Nivel' = substring(or_descripcion,1,45) 
		from cob_conta..cb_organizacion
		where or_empresa = @i_empresa and
			or_organizacion > @i_organizacion
		order by or_organizacion

		if @@rowcount = 0
		begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601035
			return 1
		end
		set rowcount 0
		return 0
	end
end

if @i_operacion = 'R'
begin
	if exists (select * from cob_conta..cb_oficina
		  where of_empresa = @i_empresa)
	begin
		/* 'organizacion relacionada con centro de costos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607033
		return 1
	end

begin tran
	delete cob_conta..cb_organizacion
	where or_empresa = @i_empresa 

	if @@error <> 0
	begin
		/* 'Error en Eliminacion de organizacion' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607034
		return 1
	end
commit tran
return 0
end
go
