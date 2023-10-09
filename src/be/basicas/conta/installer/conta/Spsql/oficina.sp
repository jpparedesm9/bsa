/************************************************************************/
/*	Archivo: 		oficina.sp 			        */
/*	Stored procedure: 	sp_oficina     				*/
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
/*	   Mantenimiento al catalogo de Oficinas                        */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	3/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones	*/
/*	10/Jul/1996	G Jaramillo     Agregar tablas cb_jerarquia	*/
/*					y cb_jerararea			*/
/*      11/dic/1997    MVGaray		valida si la oficina es una	*/
/*      11/dic/1997    MVGaray		sucursal MVG DIC/11/1997	*/
/*	09-Feb-1999	Juan Carlos G¢mez Se modifica mensaje de error  */
/*			JCG10						*/
/*	31-Ene-2006     Mauricio Rincon Consulta Regionales - Frontend  */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_oficina')
	drop proc sp_oficina

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_oficina   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 615,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(30) = null,
	@i_operacion		char(1),
	@i_modo			smallint = null,
	@i_empresa		tinyint = null,
	@i_oficina   		smallint = null,
	@i_oficina_padre   	smallint = null,
	@i_descripcion  	descripcion = null,
	@i_estado       	char(1) = null ,
	@i_organizacion		tinyint = null ,
	@i_consolida		char(1) = null,
	@i_movimiento		char(1) = null,
	@i_codigo		descripcion = null,
	@i_tabla                varchar(30) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_oficina	smallint,
	@w_oficina_padre	smallint,
	@w_descripcion	descripcion,	
	@w_nofi_padre	descripcion,
	@w_norganiza	descripcion,
	@w_estado	char(1),
	@w_estado_ant	char(1),
	@w_estado_padre	char(1),
	@w_movimiento	char(1),
	@w_empresa	tinyint,
	@w_organizacion tinyint,
	@w_organizacion1 tinyint,
	@w_organiza1	tinyint,
	@w_organiza2	tinyint,
	@w_codigo	descripcion,
	@w_ofi_temp	smallint,
	@w_flag		tinyint,
	@w_padre	int,
	@w_nivel	int,
	@w_nivel1	int,
	@w_consolida	char(1),
        @w_nombre_exc   char(20),
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */
    @w_org            tinyint

select @w_today = getdate()
select @w_sp_name = 'sp_oficina'

if @i_organizacion is null 
begin
	select  @w_organiza1 = 1,
		@w_organiza2 = 255
end
else
begin
	select  @w_organiza1 = @i_organizacion,
		@w_organiza2 = @i_organizacion
end


/************************************************/
/*  Tipo de Transaccion =     			*/
if (@t_trn <> 6151 and @i_operacion = 'I') or
   (@t_trn <> 6152 and @i_operacion = 'U') or
   (@t_trn <> 6153 and @i_operacion = 'D') or
   (@t_trn <> 6154 and @i_operacion = 'V') or
   (@t_trn <> 6155 and @i_operacion = 'S') or
   (@t_trn <> 6156 and @i_operacion = 'Q') or
   (@t_trn <> 6157 and @i_operacion = 'A') or
   (@t_trn <> 6158 and @i_operacion = 'M') or
   (@t_trn <> 6724 and @i_operacion = 'N') or
   (@t_trn <> 6159 and @i_operacion = 'L') or
   (@t_trn <> 6150 and @i_operacion = 'H') or
   (@t_trn <> 6285 and @i_operacion = 'C') or
   (@t_trn <> 6300 and @i_operacion = 'O') or
   (@t_trn <> 6304 and @i_operacion = 'E') or
   (@t_trn <> 6159 and @i_operacion = 'R')
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
		i_oficina 	= @i_oficina,
		i_oficina_padre 	= @i_oficina_padre,
		i_descripcion	= @i_descripcion,
		i_estado 	= @i_estado,
		i_organizacion	= @i_organizacion 
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/


if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_empresa = of_empresa,
		@w_oficina = of_oficina,
		@w_oficina_padre = of_oficina_padre,
		@w_descripcion = of_descripcion,
		@w_estado = of_estado,
		@w_organizacion = of_organizacion ,
		@w_consolida = of_consolida,
		@w_movimiento = of_movimiento,
		@w_codigo    = of_codigo,
		@w_norganiza = or_descripcion,
		@w_estado    = of_estado
	from cob_conta..cb_oficina, cob_conta..cb_organizacion
	where 	of_empresa = @i_empresa and
		of_oficina = @i_oficina and
		or_empresa = @i_empresa and
		or_organizacion = of_organizacion

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

	select @w_nofi_padre = of_descripcion,
		@w_estado_padre = of_estado
	from cob_conta..cb_oficina
	where of_empresa = @i_empresa and
		of_oficina = @w_oficina_padre
end

/* Valida si la oficina es una sucursal*/ /*MVG DIC/11/1997*/

if @i_operacion =  'C'
begin
  select  @w_nivel = or_organizacion
   from cb_organizacion
   where or_empresa = @i_empresa 
   and or_descripcion like 'SUCURSAL'


  select  @w_nivel1 = of_organizacion
   from cb_oficina
  where of_empresa = @i_empresa
  and of_oficina = @i_oficina
      if @w_nivel = @w_nivel1  and  @w_existe = 1 and @w_estado = 'V' 
		select @w_descripcion
	else begin
        	/* 'Oficina consultada no existe o no es de Mov. '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601131
		return 1
	end
end
 /*    de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if @i_descripcion is NULL or
	   @i_estado is NULL or @i_empresa is NULL or @i_organizacion is NULL or
	   @i_consolida is NULL or @i_movimiento is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end
	if  @i_oficina_padre = 0
		select @i_oficina_padre=null

/**** Integridad Referencial *****/
/*********************************/
	if @i_organizacion > 1
	begin
		select @w_estado_padre = of_estado
		from cb_oficina
		where 	of_empresa = @i_empresa and
			of_oficina = @i_oficina_padre

		if @@rowcount = 0
		begin
			/* 'No existe Nivel Superior de Oficina especificado' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601080
			return 1
		end
	end
end


/* Insercion de oficina */
/*************************/

if @i_operacion = 'I'
begin

	if @w_existe = 1 
	begin
		/* 'Codigo de oficina ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609310
		return 1
	end
	
	select 1
	from cob_conta..cb_oficina
	where of_oficina = @i_oficina_padre
	and   of_movimiento = 'S'
	
	if @@rowcount > 0
	begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 609310
      return 1
    end

	select @w_organizacion1 = of_organizacion
	from cob_conta..cb_oficina
	where of_oficina = @i_oficina_padre
	
	select 	@w_organizacion1
	
	if (@w_organizacion1 >= @i_organizacion) 
	begin
      exec cobis..sp_cerror
      @t_debug  = @t_debug,
      @t_file   = @t_file,
      @t_from   = @w_sp_name,
      @i_num    = 609310
      return 1
    end	
	
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_oficina
		       (of_empresa,of_oficina,of_oficina_padre,
			of_descripcion,of_estado, of_organizacion,
			of_consolida, of_movimiento,of_codigo)
		values (@i_empresa,@i_oficina,@i_oficina_padre,
			@i_descripcion,@i_estado, @i_organizacion,
			@i_consolida, @i_movimiento,@i_codigo)

		if @@error <> 0 
		begin
			/* 'Error en insercion de Oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603033
			return 1
		end
		if @i_movimiento = 'S'
		begin
		   select @w_ofi_temp = @i_oficina
		   select @w_flag = @i_organizacion - 1
		   insert into cb_jerarquia (je_empresa,je_nivel,je_oficina,						  je_oficina_padre)
		   values (@i_empresa,@i_organizacion,@i_oficina,@i_oficina)
		   while @w_flag > 0
		   begin
			select @w_padre = of_oficina_padre 
			from cb_oficina
			where of_empresa = @i_empresa
			and   of_oficina = @i_oficina
		       
			select @i_oficina = @w_padre 
			if not exists(select * from cb_jerarquia
				      where je_empresa = @i_empresa
				      and   je_nivel = @w_flag
				      and   je_oficina = @w_ofi_temp
				      and   je_oficina_padre = @w_padre)
                        begin
		   	   insert into cb_jerarquia (je_empresa,je_nivel,
						je_oficina, je_oficina_padre) 
			   values (@i_empresa,@w_flag,@w_ofi_temp,@w_padre)
			    
			end
			select @w_flag = @w_flag - 1   
		   end
		   select @i_oficina = @w_ofi_temp
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_oficina
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@w_siguiente,@i_oficina_padre,@i_descripcion,
			@i_estado, @i_organizacion)

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

/* Actualizacion de oficina  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de oficina a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605046
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_oficina
		set 	of_oficina_padre = @i_oficina_padre,
			of_descripcion = @i_descripcion,
			of_estado = @i_estado,
			of_organizacion = @i_organizacion ,
			of_consolida = @i_consolida,
			of_movimiento = @i_movimiento,
			of_codigo = @i_codigo
		where 	of_empresa = @i_empresa and
			of_oficina = @i_oficina 

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Oficina'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605047
			return 1
		end

		delete from cb_jerarquia
		where je_empresa = @i_empresa
		and   je_oficina = @i_oficina


		if @i_movimiento = 'S'
		begin
		   select @w_ofi_temp = @i_oficina
		   select @w_flag = @i_organizacion - 1
		   insert into cb_jerarquia (je_empresa,je_nivel,je_oficina,						  je_oficina_padre)
		   values (@i_empresa,@i_organizacion,@i_oficina,@i_oficina)
		   while @w_flag > 0
		   begin
			select @w_padre = of_oficina_padre 
			from cb_oficina
			where of_empresa = @i_empresa
			and   of_oficina = @i_oficina
		       
			select @i_oficina = @w_padre 
			if not exists(select * from cb_jerarquia
				      where je_empresa = @i_empresa
				      and   je_nivel = @w_flag
				      and   je_oficina = @w_ofi_temp
				      and   je_oficina_padre = @w_padre)
                        begin
		   	   insert into cb_jerarquia (je_empresa,je_nivel,
						je_oficina, je_oficina_padre) 
			   values (@i_empresa,@w_flag,@w_ofi_temp,@w_padre)
			    
			end
			select @w_flag = @w_flag - 1   
		   end
		   select @i_oficina = @w_ofi_temp
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_oficina
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_oficina,@w_oficina_padre,@w_descripcion,
			@w_estado,@w_organizacion)

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
		insert into ts_oficina
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_oficina,@i_oficina_padre,@i_descripcion,
			@i_estado,@i_organizacion)

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

/* Eliminacion de oficina  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de Oficina  a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607063
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

	/* si codigo de oficina es nivel superior de otras oficinas
	, No se puede eliminar el registro */

	select @w_oficina = of_oficina
	from cob_conta..cb_oficina
	where 	of_empresa = @i_empresa and
		of_oficina_padre = @i_oficina 

	if @@rowcount > 0
	begin
	     /*'Oficina a eliminar es Nivel Superior de oficinas existentes'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607065
		return 1
	end

	/* Oficina posee comprobantes contables */
	/****************************************/

	select @w_oficina = co_oficina_orig
	from   cb_comprobante
	where  co_empresa = @i_empresa and
	       co_oficina_orig = @i_oficina

	if @@rowcount = 0
	begin
		select @w_oficina = ct_oficina_orig
		from   cb_comp_tipo
		where  ct_empresa = @i_empresa and
	       	       ct_oficina_orig = @i_oficina

		if @@rowcount > 0
		begin
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607125
			return 1
		end
	end
	else
	begin
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607125
		return 1
	end

        select @w_oficina = pg_oficina
        from cb_plan_general
        where pg_oficina = @i_oficina and
              pg_empresa = @i_empresa

        if @@rowcount > 0
        begin
	   /* 'Error en Eliminacion de Oficina' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609144
		return 1
        end 

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
  		delete cob_conta..cb_oficina
		where 	of_empresa = @i_empresa and
			of_oficina = @i_oficina 

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Oficina' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607066
			return 1
		end
		
		delete cob_conta..cb_jerarquia
		where je_empresa = @i_empresa
		and   je_oficina = @i_oficina

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_oficina
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_oficina,@i_oficina_padre,@i_descripcion,
			@i_estado,@i_organizacion)

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
/* Query de Oficinas        */
/****************************/

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select 	@w_empresa,@w_oficina,@w_oficina_padre,
			@w_descripcion,@w_estado,@w_organizacion,@w_nofi_padre,
			@w_norganiza,@w_consolida,@w_movimiento,@w_codigo
	else begin
	  /* 'Oficina consultada no existe ' */
       		exec cobis..sp_cerror
  		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601082
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
		select 'Oficina' = of_oficina, 'Descripcion' = of_descripcion
		from cob_conta..cb_oficina
		where of_empresa = @i_empresa
		order by of_oficina

		if @@rowcount = 0
		begin
			/* 'No existen Oficinas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'Oficina' = of_oficina, 'Descripcion' = of_descripcion
		from cob_conta..cb_oficina
		where 	of_empresa = @i_empresa and
			of_oficina > @i_oficina
		order by of_oficina
		if @@rowcount = 0
		begin

			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
end


/*  All  excepto oficina consolidada (255)*/
/********/

if @i_operacion = 'L'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 'Oficina' = of_oficina,
                       'Descripcion' = of_descripcion
		from cob_conta..cb_oficina
		where of_empresa = @i_empresa and
		      of_movimiento like @i_movimiento
		order by of_oficina

		if @@rowcount = 0
		begin
			/* 'No existen Oficinas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 'Oficina' = of_oficina,
                       'Descripcion' = of_descripcion
		from cob_conta..cb_oficina
		where 	of_empresa = @i_empresa and
		of_oficina > @i_oficina and 
		of_movimiento like @i_movimiento
		order by of_oficina

		if @@rowcount = 0
		begin
			/* 'No existen Oficinas'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
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
        begin
		 --select substring(@w_descripcion,1,20)
		 select @w_descripcion
                 return 0
        end
	else
	begin
		/* 'Oficina consultada no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601082
                select @w_nombre_exc = 'NO EXISTE OFICINA'
                select @w_nombre_exc
		return 1
	end
	return 0
end

/**** N  ****/
/************/
if @i_operacion = 'N'
begin
	if @w_existe = 1 and @w_movimiento = 'S' 
		select @w_descripcion
	else
	begin
		/* 'Oficina consultada no existe o no es de Mov. '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601131
		return 1
	end
	return 0
end

/**** M  ****/
/************/

if @i_operacion = 'M'
begin
	if @w_existe = 1 and @w_movimiento = 'S' and @w_estado = 'V' 

		select @w_descripcion
	else
	begin
		if @w_estado <> 'V' and @w_existe = 1
		begin
			/* 'Oficina consultada No esta vigente '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601158
			return 1
		end
		else begin
			/* 'Oficina consultada no existe o no es de Mov. '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601131
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
		select  'Oficina' = of_oficina,
			'Nombre de Oficina' = substring(of_descripcion,1,30),
			'Jerarquia' = of_organizacion,
			'Oficina Superior' = isnull(convert(char,of_oficina_padre),'')
		from cob_conta..cb_oficina
		where of_empresa = @i_empresa and
		    of_descripcion like @i_descripcion and
		    of_organizacion between @w_organiza1 and @w_organiza2	
		order by of_oficina

		if @@rowcount = 0
		begin
			/* 'No existen Oficinas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
	else
	begin
		select  'Oficina' = of_oficina,
			'Nombre de Oficina' = substring(of_descripcion,1,30),
			'Jerarquia' = of_organizacion,
			'Oficina Superior' = isnull(convert(char,of_oficina_padre),'')
		from cob_conta..cb_oficina
		where 	of_empresa = @i_empresa and
		  of_oficina > @i_oficina and
		  of_descripcion like @i_descripcion and
		  of_organizacion between @w_organiza1 and @w_organiza2	
		order by of_oficina

		if @@rowcount = 0
		begin
			/* 'No existen Oficinas ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601082
			return 1
		end
		set rowcount 0
		return 0
	end
end


if @i_operacion = 'H'
begin
	select of_oficina,of_descripcion
	from cb_oficina
	where 	of_empresa = @i_empresa and
		of_oficina_padre = @i_oficina
        order by of_oficina

	if @@rowcount = 0
	begin
			/* 'No existen Oficinas ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601172	--JCG10
			return 1
		end
end

if @i_operacion = 'O'
begin
	if @w_existe = 1 and @w_movimiento = 'N' 
		select @w_descripcion
	else
	begin
          /* 'Oficina consultada no existe o no consolidadora '*/
	       exec cobis..sp_cerror
	        @t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 609146
		return 1
	end
end


/* PARA LA HOJA DE EXCEL */
if @i_operacion = 'E'
begin
/*
	if @w_existe <> 1
	begin
		/* 'Oficina consultada no existe o no es de Mov. '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601131
		return 1
	end
*/
	select convert(varchar(10),of_oficina) + ' - ' +
		of_nombre + ' - ' + ci_descripcion,
		of_direccion
	from cobis..cl_oficina, cobis..cl_ciudad
	where of_filial = @i_empresa
	and of_ciudad = ci_ciudad
	and of_oficina = @i_oficina

	return 0
end


if @i_operacion = 'Z'
begin
exec cobis..sp_cseqnos   
     @i_tabla     = @i_tabla,
     @o_siguiente = @w_siguiente out
     
     select @w_siguiente

     return 0
end

/*  Consulta de Regionales */
/***************************/
if @i_operacion = 'R'
begin
	set rowcount 20

	if @i_oficina is not null and @i_modo <> 1 and @i_modo <> 3
	   select @i_modo = 2

	if @i_modo = 0
	begin
	  select 'Oficina' = of_oficina,
                 'Descripcion' = of_descripcion
		  from cob_conta..cb_oficina
           where of_empresa = @i_empresa
	     and of_organizacion = 3
	   order by of_oficina

	  if @@rowcount = 0
	  begin
	    /* 'No existen Oficinas '*/
	 	exec cobis..sp_cerror
	 	@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601082
		return 1
	  end
	  set rowcount 0
	  return 0
	end
	if @i_modo = 1
	begin
	  select 'Oficina' = of_oficina,
                 'Descripcion' = of_descripcion
	    from cob_conta..cb_oficina
	   where of_empresa = @i_empresa
	     and of_oficina > @i_oficina
	     and of_organizacion = 3
	   order by of_oficina

	  if @@rowcount = 0
	  begin
	    /* 'No existen Oficinas'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601082
		return 1
	  end
	end
	if @i_modo = 2
	begin
	   if @i_oficina = 9000
             select of_descripcion
               from cob_conta..cb_oficina
              where of_empresa = @i_empresa
                and of_oficina = @i_oficina
           else
             begin
	        select of_descripcion
	          from cob_conta..cb_oficina
	         where of_empresa = @i_empresa
	           and of_oficina = @i_oficina
	           and of_organizacion = 3
	         order by of_oficina
	     end
	  if @@rowcount = 0
	  begin
	    /* 'No existen Oficinas'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601082
		return 1
	  end
	  set rowcount 0
	  return 0
       end       
       if @i_modo = 3
       begin
          if @i_oficina = 9000
             select of_oficina
               from cob_conta..cb_oficina
              where of_empresa = @i_empresa
                and of_oficina = @i_oficina
          else
             begin
                select isnull(je_oficina_padre,9000)
                  from cob_conta..cb_jerarquia,cob_conta..cb_oficina
                 where je_empresa = @i_empresa
                   and je_oficina_padre = of_oficina
                   and of_empresa = @i_empresa
                   and ((je_nivel = 3 and of_organizacion <> 1)
                    or  (of_oficina = 9000 and je_empresa = @i_empresa))
                   and je_oficina > 0
                   and je_nivel > 0
                   and je_oficina_padre > 0
                   and je_oficina = @i_oficina
             end
	     set rowcount 0
	     return 0
       end

end

if @i_operacion = 'J'
begin
    delete cb_ofi_org
    
    select @w_org = of_organizacion
    from cob_conta..cb_oficina
    where of_oficina = @i_oficina
    and   of_empresa = @i_empresa
    
    insert into cb_ofi_org
    values (@w_org, @i_oficina)

    select @w_flag = 0
    
    while @w_org < @i_organizacion
    begin
        select @w_flag = 1    
        select @w_org = @w_org + 1
    
        select oficina, nivel
        into #of_ant
        from cob_conta..cb_ofi_org
        where nivel = @w_org - 1
    
        insert into cb_ofi_org
        Select
              of_organizacion,
              of_oficina
        from cob_conta..cb_oficina
        where of_oficina_padre in (select oficina from #of_ant)
        and   of_empresa = @i_empresa
    
        drop table #of_ant
    end         
    
    if @w_flag = 1
    begin
       select oficina, of_descripcion
       from cb_ofi_org,
            cb_oficina
       where nivel = @i_organizacion
       and   oficina = of_oficina
       and   of_empresa = @i_empresa
       order by oficina
    end
    
	if @@rowcount = 0
	begin
			/* 'No existen Oficinas ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601172	--JCG10
			return 1
		end
end

go
