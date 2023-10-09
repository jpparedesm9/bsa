/************************************************************************/
/*	Archivo: 		nivelare.sp 			        */
/*	Stored procedure: 	sp_nivel_area				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     20-septiembre-1994 			*/
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
/*	   Mantenimiento al catalogo de niveles de areas                */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	20/Sep/1994	G Jaramillo     Emision Inicial			*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_nivel_area')
	drop proc sp_nivel_area  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_nivel_area   (
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
	@i_nivel_area  	tinyint = null,
	@i_descripcion  descripcion = null  
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_nivel_area	tinyint,
	@w_descripcion	descripcion,	
	@w_sdescripcion	descripcion,	
	@w_flag1 	tinyint,
	@w_oficina	smallint,
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_nivel_area'




/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6501 and @i_operacion = 'I') or
   (@t_trn <> 6502 and @i_operacion = 'U') or
   (@t_trn <> 6503 and @i_operacion = 'D') or
   (@t_trn <> 6504 and @i_operacion = 'V') or
   (@t_trn <> 6505 and @i_operacion = 'S') or
   (@t_trn <> 6506 and @i_operacion = 'Q') or
   (@t_trn <> 6507 and @i_operacion = 'A') or
   (@t_trn <> 6508 and @i_operacion = 'R') 
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
		i_nivel_area 	= @i_nivel_area,
		i_descripcion	= @i_descripcion 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa = na_empresa,
		@w_nivel_area = na_nivel_area,
		@w_descripcion = na_descripcion  
	from cb_nivel_area
	where 	na_empresa = @i_empresa and
		na_nivel_area = @i_nivel_area

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

	if	@i_empresa     is NULL or 
		@i_descripcion is NULL or
		@i_nivel_area  is NULL 
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


/* Insercion de nivel_area */
/*************************/

if @i_operacion = 'I'
begin
	begin tran
		if @w_existe = 1 
		begin
			/* 'Codigo de nivel_area ya existe           ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601122
			return 1
		end
	
	/* Insercion del registro */
	/**************************/
		insert into cb_nivel_area
		values (@i_empresa,@i_nivel_area,@i_descripcion )

		if @@error <> 0 
		begin
			/* 'Error en insercion de nivel de area ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603049
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_nivel_area
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_nivel_area,@i_descripcion)

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

/* Actualizacion de nivel_area  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Nivel de area a actualizar NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605064
		return 1
	end
	
	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_nivel_area
		set 	na_descripcion = @i_descripcion  
		where 	na_empresa = @i_empresa and
			na_nivel_area = @i_nivel_area

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Nivel de area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605065
			return 1
		end
		
		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_nivel_area
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_nivel_area,@w_descripcion)

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
		insert into ts_nivel_area
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_nivel_area,@i_descripcion)

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

/* Eliminacion de nivel_area  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Nivel de area a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607100
		return 1
	end

/**** Integridad referencial ****/
/********************************/

       	/* Si codigo de nivel_area existe en catalogo de areas             
	   No se puede eliminar el nivel_area */
     	if EXISTS (select ar_nivel_area 
		from cob_conta..cb_area
		where 	ar_empresa = @i_empresa and
			ar_nivel_area = @i_nivel_area 
		)
	begin
		/* 'Codigo de nivel area relacionado con Areas ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607101
		return 1
	end

	begin tran

		select @w_siguiente = @i_nivel_area + 1
		select @w_flag1 = 1
		while @w_flag1 > 0
		begin
			select @w_sdescripcion = na_descripcion  
			from cob_conta..cb_nivel_area
			where na_empresa = @i_empresa and
				na_nivel_area = @w_siguiente

			if @@rowcount > 0 
			begin
				if exists (select ar_nivel_area
					from cob_conta..cb_area
					where 	ar_empresa = @i_empresa and
						ar_nivel_area = @w_siguiente
					)
				begin
				/* 'Niveles inferiores de nivel_area relacionados con catalogo de areas' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607102
	
					select @w_flag1 = 1
					return 1
				end
				else
				begin
					update cob_conta..cb_nivel_area
					set na_descripcion = @w_sdescripcion  
					where na_empresa = @i_empresa and
					na_nivel_area = @w_siguiente - 1

					if @@error <> 0
					begin
						/* 'Error en Eliminacion de nivel_area' */
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file	 = @t_file,
						@t_from	 = @w_sp_name,
						@i_num	 = 607103
						return 1
					end

				end
				select @w_siguiente = @w_siguiente + 1
			end
			else
			begin
				select @w_flag1 = 0
				delete cob_conta..cb_nivel_area
				where na_empresa = @i_empresa and
					na_nivel_area = @w_siguiente - 1
				if @@error <> 0
				begin
					/* 'Error en Eliminacion de Nivel de area' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 607103
					return 1
				end
      			end
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_nivel_area
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_nivel_area,@i_descripcion)

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
		select @w_empresa,@w_nivel_area,
		@w_descripcion
	else
	begin
		/* 'Nivel de Area consultado no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601123
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
	select na_nivel_area,na_descripcion
	from cob_conta..cb_nivel_area
	where na_empresa = @i_empresa
	order by na_nivel_area

	if @@rowcount = 0
	begin
		/* 'No existen Niveles de Area '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601124
		return 1
	end
	set rowcount 0
	return 0
end
if @i_modo = 1
begin
	select na_nivel_area,na_descripcion
	from cob_conta..cb_nivel_area
	where   na_empresa = @i_empresa and
		na_nivel_area > @i_nivel_area
	order by na_nivel_area

	if @@rowcount = 0
	begin
		/* 'No existen mas niveles de areas '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601125
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
	/* 'Nivel de Area consultado no existe  '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601123
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
		select 	'Nivel' = na_nivel_area,
			'Nombre Nivel' = substring(na_descripcion,1,45) 
		from cob_conta..cb_nivel_area
		where na_empresa = @i_empresa
		order by na_nivel_area

		if @@rowcount = 0
		begin
			/* 'No existen Niveles de Areas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601124
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'Nivel' = na_nivel_area,
			'Nombre Nivel' = substring(na_descripcion,1,45) 
		from cob_conta..cb_nivel_area
		where na_empresa = @i_empresa and
			na_nivel_area > @i_nivel_area
		order by na_nivel_area

		if @@rowcount = 0
		begin
			/* 'No existen Mas Niveles de areas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601125
			return 1
		end
		set rowcount 0
		return 0
	end
end

if @i_operacion = 'R'
begin
	if exists (select * from cob_conta..cb_area
		  where ar_empresa = @i_empresa
		and	ar_nivel_area = @i_nivel_area)
	begin
		/* 'nivel_area relacionada con catalogo de areas' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607101
		return 1
	end

begin tran
	delete cob_conta..cb_nivel_area
	where na_empresa = @i_empresa 

	if @@error <> 0
	begin
		/* 'Error en Eliminacion de nivel_area' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607103
		return 1
	end
commit tran
return 0
end
go
