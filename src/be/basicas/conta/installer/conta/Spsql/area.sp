/************************************************************************/
/*	Archivo: 		area.sp 			        */
/*	Stored procedure: 	sp_area     				*/
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
/*	   Mantenimiento al catalogo de areas	                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	21/Sep/1994	G Jaramillo     Emision Inicial			*/
/*	10/Jul/1996	G Jaramillo     Agregar tablas cb_jerarquia	*/
/*					y cb_jerararea			*/
/*	09-Feb-1999	Juan Carlos G¢mez Modificaciones en operaci¢n H */
/*			JCG10						*/									
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_area')
	drop proc sp_area

go
create proc sp_area   (
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
	@i_area   		smallint = null,
	@i_area_padre   	smallint = null,
	@i_descripcion  	descripcion = null,
	@i_estado       	char(1) = null ,
	@i_nivel_area		tinyint = null ,
	@i_consolida		char(1) = null,
	@i_movimiento		char(1) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_area	        smallint ,
	@w_area_padre	smallint ,
	@w_descripcion	descripcion,	
	@w_nofi_padre	descripcion,
	@w_nnivel	descripcion,
	@w_estado	char(1),
	@w_area_temp	smallint,
	@w_flag		tinyint,
	@w_padre	int,
	@w_estado_ant	char(1),
	@w_estado_padre	char(1),
	@w_movimiento	char(1),
	@w_empresa	tinyint,
	@w_nivel_area   tinyint,
	@w_organiza1	tinyint,
	@w_organiza2	tinyint,
	@w_consolida	char(1),
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_area'

if @i_nivel_area = null 
begin
	select 	@w_organiza1 = 1,
	 	@w_organiza2 = 255
end
else
begin
	select 	@w_organiza1 = @i_nivel_area,
		@w_organiza2 = @i_nivel_area
end


/************************************************/
/*  Tipo de Transaccion = 603 			*/

if (@t_trn <> 6511 and @i_operacion = 'I') or
   (@t_trn <> 6512 and @i_operacion = 'U') or
   (@t_trn <> 6513 and @i_operacion = 'D') or
   (@t_trn <> 6514 and @i_operacion = 'V') or
   (@t_trn <> 6515 and @i_operacion = 'S') or
   (@t_trn <> 6516 and @i_operacion = 'Q') or
   (@t_trn <> 6517 and @i_operacion = 'A') or
   (@t_trn <> 6518 and @i_operacion = 'M') or
   (@t_trn <> 6519 and @i_operacion = 'L') or
   (@t_trn <> 6510 and @i_operacion = 'H') 
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
		i_area 		= @i_area,
		i_area_padre 	= @i_area_padre,
		i_descripcion	= @i_descripcion,
		i_estado 	= @i_estado,
		i_nivel_area	= @i_nivel_area 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa = ar_empresa,
		@w_area = ar_area,
		@w_area_padre = ar_area_padre,
		@w_descripcion = ar_descripcion,
		@w_estado = ar_estado,
		@w_nivel_area = ar_nivel_area ,
		@w_consolida = ar_consolida,
		@w_movimiento = ar_movimiento,
		@w_nnivel = na_descripcion
	from cob_conta..cb_area, cob_conta..cb_nivel_area
	where 	ar_empresa    = @i_empresa and
		ar_area       = @i_area and
		ar_empresa    = na_empresa and
		na_nivel_area = ar_nivel_area

	if @@rowcount > 0
	begin
		select @w_estado_ant = @w_estado,
		       @w_existe = 1
	end
	else
	begin
		select @w_existe = 0,
			@w_estado_ant = @i_estado
	end

	select @w_nofi_padre   = ar_descripcion,
	       @w_estado_padre = ar_estado
	from cob_conta..cb_area
	where   ar_empresa = @i_empresa and
		ar_area    = @w_area_padre
end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if @i_descripcion = NULL or
	   @i_estado      = NULL or 
	   @i_empresa     = NULL or 
	   @i_nivel_area  = NULL or
	   @i_consolida   = NULL or 
	   @i_movimiento = NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

/**** Integridad Referencial *****/
/*********************************/
	if @i_nivel_area > 1
	begin
		select @w_estado_padre = ar_estado
		from cb_area
		where 	ar_empresa = @i_empresa and
			ar_area = @i_area_padre

		if @@rowcount = 0
		begin
			/* 'No existe Nivel Superior de area especificado' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601126
			return 1
		end
	end
	
end


/* Insercion de area */
/*************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	begin
		/* 'Codigo de area ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601127
		return 1
	end
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_area
		       (ar_empresa,ar_area,ar_area_padre,
			ar_descripcion,ar_estado, ar_nivel_area,
			ar_consolida, ar_movimiento)
		values (@i_empresa,@i_area,@i_area_padre,
			@i_descripcion,@i_estado, @i_nivel_area,
			@i_consolida, @i_movimiento)

		if @@error <> 0 
		begin
			/* 'Error en insercion de Area' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603050
			return 1
		end


		if @i_movimiento = 'S'
		begin
		   select @w_area_temp = @i_area
		   select @w_flag = @i_nivel_area - 1
		   insert into cb_jerararea (ja_empresa,ja_nivel,ja_area,
					     ja_area_padre)
		   values (@i_empresa,@i_nivel_area,@i_area,@i_area)
		   while @w_flag > 0
		   begin
			select @w_padre = ar_area_padre 
			from cb_area
			where ar_empresa = @i_empresa
			and   ar_area = @i_area
		       
			select @i_area = @w_padre 
			if not exists(select * from cb_jerararea
				      where ja_area = @i_empresa
				      and   ja_nivel = @w_flag
				      and   ja_area = @w_area_temp
				      and   ja_area_padre = @w_padre)
                        begin
		   	   insert into cb_jerararea (ja_empresa,ja_nivel,
						ja_area, ja_area_padre) 
			   values (@i_empresa,@w_flag,@w_area_temp,@w_padre)
			    
			end
			select @w_flag = @w_flag - 1   
		   end
		   select @i_area = @w_area_temp
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_area
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@w_siguiente,@i_area_padre,@i_descripcion,
			@i_estado, @i_nivel_area)

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

/* Actualizacion de area  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de area a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605066
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_area
		set 	ar_area_padre = @i_area_padre,
			ar_descripcion = @i_descripcion,
			ar_estado = @i_estado,
			ar_nivel_area = @i_nivel_area ,
			ar_consolida = @i_consolida,
			ar_movimiento = @i_movimiento
		where 	ar_empresa = @i_empresa and
			ar_area = @i_area 

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Area'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605067
			return 1
		end

		if @i_movimiento = 'S'
		begin
		   select @w_area_temp = @i_area
		   select @w_flag = @i_nivel_area - 1
		   insert into cb_jerararea (ja_empresa,ja_nivel,ja_area,
					     ja_area_padre)
		   values (@i_empresa,@i_nivel_area,@i_area,@i_area)
		   while @w_flag > 0
		   begin
			select @w_padre = ar_area_padre 
			from cb_area
			where ar_empresa = @i_empresa
			and   ar_area = @i_area
		       
			select @i_area = @w_padre 
			if not exists(select * from cb_jerararea
				      where ja_area = @i_empresa
				      and   ja_nivel = @w_flag
				      and   ja_area = @w_area_temp
				      and   ja_area_padre = @w_padre)
                        begin
		   	   insert into cb_jerararea (ja_empresa,ja_nivel,
						ja_area, ja_area_padre) 
			   values (@i_empresa,@w_flag,@w_area_temp,@w_padre)
			    
			end
			select @w_flag = @w_flag - 1   
		   end
		   select @i_area = @w_area_temp
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_area
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_area,@w_area_padre,@w_descripcion,
			@w_estado,@w_nivel_area)

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
		insert into ts_area
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_area,@i_area_padre,@i_descripcion,
			@i_estado,@i_nivel_area)

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

/* Eliminacion de area  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de area a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607104
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

	/* si codigo de area es nivel superior de otras areas
	, No se puede eliminar el registro */

	select @w_area = ar_area
	from cob_conta..cb_area
	where 	ar_empresa = @i_empresa and
		ar_area_padre = @i_area 
	if @@rowcount > 0
	begin
	     /*'Area a eliminar es Nivel Superior de areas existentes'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607105
		return 1
	end

	/* Area posee comprobantes contables */
	/*************************************/

	select @w_area = co_area_orig
	from   cb_comprobante
	where  co_empresa = @i_empresa and
	       co_area_orig = @i_area
	if @@rowcount = 0
	begin
		select @w_area = ct_area_orig
		from   cb_comp_tipo
		where  ct_empresa = @i_empresa and
		       ct_area_orig = @i_area
		if @@rowcount <> 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607126
			return 1
		end
	end
	else
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607126
		return 1
	end


        select @w_area = pg_area
        from cb_plan_general
        where pg_empresa = @i_empresa 
          and pg_area = @i_area


        if @@rowcount > 0
        begin
           /* 'Error en Eliminacion de area' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 609144
                return 1
        end  

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_area
		where 	ar_empresa = @i_empresa and
			ar_area = @i_area 

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Area' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607106
			return 1
		end

		delete cb_jerararea 
		where ja_empresa = @i_empresa
		and   ja_area = @i_area

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_area
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_area,@i_area_padre,@i_descripcion,
			@i_estado,@i_nivel_area)

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

/****************************/
/* Query de Areas           */
/****************************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select 	@w_empresa,@w_area,@w_area_padre,
			@w_descripcion,@w_estado,@w_nivel_area,@w_nofi_padre,
			@w_nnivel,@w_consolida,@w_movimiento
	else
begin
	/* 'Area consultada no existe ' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601128
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
		select 'Area' = ar_area, 'Descripcion' = ar_descripcion
		from cob_conta..cb_area
		where ar_empresa = @i_empresa
		order by ar_area

		if @@rowcount = 0
		begin
			/* 'No existen Areas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601129
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'Area' = ar_area, 'Descripcion' = ar_descripcion
		from cob_conta..cb_area
		where 	ar_empresa = @i_empresa and
			ar_area > @i_area
		order by ar_area

		if @@rowcount = 0
		begin
			/* 'No existen mas Areas'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601130
			return 1
		end
		set rowcount 0
		return 0
	end
end


/*  All  excepto area consolidada (255)*/
/********/

if @i_operacion = 'L'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Area' = ar_area,
                       'Descripcion' = ar_descripcion
		from cob_conta..cb_area
		where ar_empresa = @i_empresa and
		      ar_movimiento like @i_movimiento 
		order by ar_area

		if @@rowcount = 0
		begin
			/* 'No existen Areas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601129
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'Area' = ar_area,
                       'Descripcion' = ar_descripcion
		from cob_conta..cb_area
		where 	ar_empresa = @i_empresa and
			ar_area > @i_area and
		        ar_movimiento like @i_movimiento  
		order by ar_area

		if @@rowcount = 0
		begin
			/* 'No existen mas Areas'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601130
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
		select @w_descripcion
	else
	begin
		/* 'Area consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601128
		return 1
	end
	return 0
end

/**** M  ****/
/****************/

if @i_operacion = 'M'
begin
	if @w_existe = 1 and @w_movimiento = 'S' and @w_estado = 'V'
		select @w_descripcion
	else
	begin
		if @w_estado <> 'V' and @w_existe = 1
		begin
			/* 'Area consultada no esta vigente '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601159
			return 1
		end
		else begin
			/* 'Area consultada no existe o no es mov. '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601132
			return 1
		end
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
		select  'Area' = ar_area,
			'Nombre de Area' = substring(ar_descripcion,1,30),
			'Nivel' = ar_nivel_area,
			'Area Superior' = ar_area_padre
		from cob_conta..cb_area
		where ar_empresa = @i_empresa and
		    ar_descripcion like @i_descripcion and
		    ar_nivel_area between @w_organiza1 and @w_organiza2	
		order by ar_area

		if @@rowcount = 0
		begin
			/* 'No existen Areas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601129
			return 1
		end
		set rowcount 0
		return 0
	end
	else
	begin
		select  'Area' = ar_area,
			'Nombre de Area' = substring(ar_descripcion,1,30),
			'Nivel' = ar_nivel_area,
			'Area Superior' = ar_area_padre
		from cob_conta..cb_area
		where 	ar_empresa = @i_empresa and
		  ar_area > @i_area and
		  ar_descripcion like @i_descripcion and
		  ar_nivel_area between @w_organiza1 and @w_organiza2	
		order by ar_area

		if @@rowcount = 0
		begin
			/* 'No existen mas areas ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601130
			return 1
		end
		set rowcount 0
		return 0
	end
end



if @i_operacion = 'H'
begin
	select ar_area, (' ' + ar_descripcion)	--JCG10
	from cb_area
	where 	ar_empresa = @i_empresa and
		ar_area_padre = @i_area
	order by ar_area	--JCG10

	if @@rowcount = 0
	begin
			/* 'No existen Areas ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601173
			return 1
		end
end
go
