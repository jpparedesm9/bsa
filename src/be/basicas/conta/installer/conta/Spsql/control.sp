/************************************************************************/
/*   Archivo: 		           control.sp                                 */
/*   Stored procedure: 	     sp_control                                 */
/*   Base de datos:  	       cob_conta                                  */
/*   Producto:               contabilidad                               */
/*   Disenado por:                                                      */
/*   Fecha de escritura:     02-enero-1995 	                            */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de	    */
/*   "MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*   "NCR CORPORATION".						                                      */
/*   Su uso no autorizado queda expresamente prohibido asi como	        */
/*   cualquier alteracion o agregado hecho por alguno de sus		        */
/*   usuarios sin el debido consentimiento por escrito de la 	          */
/*   Presidencia Ejecutiva de MACOSA o su representante.		            */
/*                  PROPOSITO				                                    */
/*   Este programa procesa las transacciones de:			                  */
/*   Mantenimiento al catalogo de Organizacion de una Empresa           */
/*                 MODIFICACIONES				                                */
/*        FECHA	     AUTOR         RAZON                                */
/*   02/Ene/1995	G Jaramillo     Emision Inicial			                  */
/*   21/oct/2005	Olga Rios	Modificacion fecha tran servicio            */
/************************************************************************/

use cob_conta
go

if exists (select * from sysobjects where name = 'sp_control')
	drop proc sp_control
go

create proc sp_control   (
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
	@i_login   	varchar(14) = null,
	@i_oficina  	smallint = null ,
	@i_area		smallint = null,
  @i_tipo         char(1)  = 'C', -- (O)rigen, (D)estino
	@i_login1	varchar(14) = null,
	@i_oficina1	smallint = null,
	@i_area1	smallint = null,
  @i_subopcion    smallint = null,
  @i_nombre	descripcion = null
)
as
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_login	varchar(10),
	@w_oficina	smallint,
	@w_area		smallint,
	@w_contador     tinyint,
        @w_tipo         char(1),
	@w_existe	int		/* codigo existe = 1
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_control'




/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6731 and @i_operacion = 'I') or
   (@t_trn <> 6733 and @i_operacion = 'D') or
   (@t_trn <> 6734 and @i_operacion = 'V') or
   (@t_trn <> 6735 and @i_operacion = 'S')
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
		i_oficina	= @i_oficina,
		i_login		= @i_login,
		i_area		= @i_area
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S'
begin
	select 	@w_empresa = cn_empresa,
		@w_login   = cn_login,
		@w_oficina = cn_oficina,
		@w_area	   = cn_area,
                @w_tipo    = cn_tipo
	from cb_control
	where 	cn_empresa = @i_empresa and
		cn_login   = @i_login and
		cn_oficina = @i_oficina and
		cn_area    = @i_area    and
                cn_tipo   like @i_tipo

	if @@rowcount <> 0
		select @w_existe = 1
	else
		select @w_existe = 0
end


/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I'
begin
	/* Validacion de datos */
	/***********************/

	if	@i_empresa is NULL or
		@i_login   is NULL or
		@i_oficina is NULL or
		@i_area    is NULL
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


/* Insercion de organizacion */
/*************************/

if @i_operacion = 'I'
begin
	begin tran
		if @w_existe = 1
		begin
			/* 'Control de ingreso ya existe ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601152
			return 1
		end

	/* Insercion del registro */
	/**************************/
		insert into cb_control
                       (cn_empresa,cn_login,cn_oficina,cn_area,cn_tipo)
		values (@i_empresa,@i_login,@i_oficina,@i_area,@i_tipo)
		if @@error <> 0
		begin
			/* 'Error en insercion de control de ingreso' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603058
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_control
		values (@s_ssn,@t_trn,'N',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@i_login,@i_oficina,@i_area,@i_tipo)

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

/* Eliminacion de control de ingreso de comprobantes */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0
	begin
		/* 'Control de ingreso a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607118
		return 1
	end

	begin tran
		delete cb_control
		where cn_empresa = @i_empresa and
		      cn_login   = @i_login and
		      cn_oficina = @i_oficina and
		      cn_area	 = @i_area

		if @@error <> 0
		begin
		/* 'Error en eliminacion de control de ingreso de comp' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607120
			return 1
		end


		insert into ts_control
		values (@s_ssn,@t_trn,'B',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@i_login,@i_oficina,@i_area,@i_tipo)

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

/**** Value *****/
if @i_operacion = 'V'
begin
--    if @i_tipo is null
       select @i_tipo = '%'
       
    select 	@w_contador = count(*)
	from cb_control 
	where 	cn_empresa = @i_empresa and
		cn_login   = @i_login and
		cn_oficina in (select je_oficina_padre
                         	from cb_jerarquia
                         	where je_empresa = @i_empresa and
                              	(je_oficina = @i_oficina or 
                              	je_oficina_padre = @i_oficina)) and
		cn_area    in (select ja_area_padre
                         	from cb_jerararea
                         	where ja_empresa = @i_empresa and
                           	(ja_area = @i_area or ja_area_padre = @i_area)) and 
		cn_tipo   like @i_tipo


	if @w_contador =  0
	begin
		/* 'Usuario no autorizado para ingresar planillas de la oficina y area dadas'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601154
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
		if @i_subopcion is null
		begin
			select 	'Login' = cn_login,
				'Descripcion' = substring(fu_nombre,1,25),
				'Oficina' = cn_oficina,
				'Area'	= cn_area,
				'Acceso' = cn_tipo
			from cob_conta..cb_control,cobis..cl_funcionario
			where 	cn_empresa = @i_empresa and
				cn_login like @i_login and
				(cn_oficina = @i_oficina or @i_oficina is null) and
				(cn_area = @i_area or @i_area is null) and
				cn_login = fu_login
			order by cn_empresa,cn_login,cn_oficina,cn_area
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 1
		begin
			select distinct	'Codigo' = of_oficina,
					'Descripcion'	= of_descripcion
			from cb_oficina, cb_control
			where of_empresa = @i_empresa
			and of_empresa = cn_empresa
			and cn_login like @s_user
			and cn_tipo  like @i_tipo
			and of_oficina = cn_oficina
			and of_movimiento  = 'S'
			and of_estado      = 'V'
			order by of_oficina
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 2
		begin
			select distinct	'Codigo' = ar_area,
					'Descripcion'	= ar_descripcion
			from cb_area, cb_control
			where ar_empresa = @i_empresa
			and ar_empresa = cn_empresa
			and (cn_oficina = @i_oficina
			or @i_oficina is null)
			and cn_login like @s_user
			and cn_tipo  like @i_tipo
			and ar_area = cn_area
			and ar_movimiento  = 'S'
			and ar_estado      = 'V'
			order by ar_area
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 3
		begin
			select count(1)
			from  cob_conta..cb_control
			where cn_empresa = @i_empresa
			and cn_login   = @i_login
			and cn_oficina = @i_oficina

			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 4
		begin
			select  'Oficina' = cn_oficina,
				'Area'    = cn_area
			from  cb_control
			where cn_empresa = @i_empresa
			and cn_login   = @i_login
			and cn_oficina = @i_oficina
			order by cn_oficina,cn_area
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 5
		begin
			select upper(fu_nombre), fu_login, fu_oficina
			from cobis..cl_funcionario
			where upper(fu_nombre) like upper(@i_nombre) + '%'
			order by fu_nombre
			if @@rowcount = 0
			begin	/* 'No existen mas registros' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 601150
				return 1
			end
		end
	end


	if @i_modo = 1
	begin
		if @i_subopcion is null
		begin
			select 	'Login'   = cn_login,
				'Descripcion' = substring(fu_nombre,1,25),
				'Oficina' = cn_oficina,
				'Area'	  = cn_area,
				'Acceso' = cn_tipo
			from cob_conta..cb_control,cobis..cl_funcionario
			where 	cn_empresa = @i_empresa and
			cn_login like @i_login and
			(cn_oficina = @i_oficina or @i_oficina is null) and
			(cn_area = @i_area or @i_area is null) and
			((cn_login = @i_login1 and
			cn_oficina = @i_oficina1 and
			cn_area > @i_area1) or
			(cn_login = @i_login1 and
			cn_oficina > @i_oficina1) or
			(cn_login > @i_login1)) and
			cn_login = fu_login
			order by cn_empresa,cn_login,cn_oficina,cn_area
			if @@rowcount = 0
			begin	/* 'No existen Mas registros'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601150
				return 1
			end
		end

		if @i_subopcion = 1
		begin
			select distinct	'Codigo' = of_oficina,
					'Descripcion'	= of_descripcion
			from cb_oficina, cb_control
			where of_empresa = @i_empresa
			and of_empresa = cn_empresa
			and cn_login like @s_user
			and cn_tipo  like @i_tipo
			and of_oficina = cn_oficina
			and of_movimiento  = 'S'
			and of_estado      = 'V'
			and of_oficina > @i_oficina
			order by of_oficina
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 2
		begin
			select distinct	'Codigo' = ar_area,
					'Descripcion'	= ar_descripcion
			from cb_area, cb_control
			where ar_empresa = @i_empresa
			and ar_empresa = cn_empresa
			and cn_login like @s_user
			and cn_tipo  like @i_tipo
			and ar_area = cn_area
			and ar_movimiento  = 'S'
			and ar_estado      = 'V'
			and ar_area > @i_area
			order by ar_area
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 3
		begin
			select  'Oficina' = cn_oficina,
				'Area'    = cn_area
			from  cb_control
			where cn_empresa = @i_empresa
			and cn_login   = @i_login
			and cn_oficina = @i_oficina
			and cn_area    > @i_area
			order by cn_oficina,cn_area
			if @@rowcount = 0
			begin	/* 'No existen registros para la consulta dada'*/
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 601153
				return 1
			end
		end

		if @i_subopcion = 5
		begin
			select upper(fu_nombre), fu_login, fu_oficina
			from cobis..cl_funcionario
			where upper(fu_nombre) > upper(@i_nombre)
			order by fu_nombre
			if @@rowcount = 0
			begin	/* 'No existen mas registros' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 601150
				return 1
			end
		end
	end
	set rowcount 0
	return 0
end

go
