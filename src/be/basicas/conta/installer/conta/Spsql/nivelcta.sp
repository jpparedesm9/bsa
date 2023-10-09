/************************************************************************/
/*      Archivo:                nivelcta.sp                             */
/*      Stored procedure:       sp_nivel_cuenta                         */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:                                                   */
/*      Fecha de escritura:     30-julio-1993                           */
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
/*      Este programa procesa las transacciones de:                     */
/*         Mantenimiento al catalogo de Niveles de Cuentas              */
/*	   pertenecientes a  un tipo de plan				*/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      30/Jul/1993     G Jaramillo     Emision Inicial                 */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_nivel_cuenta')
	drop proc sp_nivel_cuenta  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_nivel_cuenta   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 602,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null,
	@t_from         varchar(30) = null,
	@i_operacion    char(1) = null,
	@i_modo         smallint = null,
	@i_empresa     	tinyint = null,
	@i_nivel_cuenta tinyint = null,
	@i_descripcion  descripcion = null,
	@i_longitud     tinyint = null,
	@i_error        smallint = null
)
as 
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_siguiente    tinyint,
	@w_empresa    	tinyint,
	@w_nivel_cuenta tinyint,
	@w_descripcion  descripcion,    
	@w_sdescripcion descripcion,    
	@w_longitud     tinyint,
	@w_slongitud    tinyint,
	@w_flag1        tinyint,
	@w_cuenta       char(16),
	@w_existe       int             /* codigo existe = 1 
					       no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_nivel_cuenta'


/************************************************/
/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6021 and @i_operacion = 'I') or
   (@t_trn <> 6022 and @i_operacion = 'U') or
   (@t_trn <> 6023 and @i_operacion = 'D') or
   (@t_trn <> 6024 and @i_operacion = 'V') or
   (@t_trn <> 6025 and @i_operacion = 'S') or
   (@t_trn <> 6027 and @i_operacion = 'A') or
   (@t_trn <> 6028 and @i_operacion = 'B') 
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
		t_file          = @t_file,
		t_from          = @t_from,
		i_operacion     = @i_operacion,
		i_nivel_cuenta  = @i_nivel_cuenta,
		i_descripcion   = @i_descripcion,
		i_longitud      = @i_longitud
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select  @w_empresa = nc_empresa,
		@w_nivel_cuenta = nc_nivel_cuenta,
		@w_descripcion = nc_descripcion,
		@w_longitud = nc_longitud
	from cb_nivel_cuenta
	where   nc_empresa = @i_empresa and
		nc_nivel_cuenta = @i_nivel_cuenta

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

	if      @i_empresa  is NULL or 
		@i_descripcion  is NULL or
		@i_longitud     is NULL or
		@i_nivel_cuenta is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601001
		return 1
	end

	if NOT EXISTS (select * from cob_conta..cb_empresa
		where em_empresa = @i_empresa
		)
	begin
		/* 'No existe empresa especificada' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601018
		return 1
	end

	
end


/* Insercion de nivel_cuenta */
/*************************/

if @i_operacion = 'I'
begin
	begin tran
		if @w_existe = 1 
		begin
			/* 'Codigo de nivel_cuenta ya existe           ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601033
			return 1
		end
	
	/* Insercion del registro */
	/**************************/
		insert into cb_nivel_cuenta
		       (nc_empresa,nc_nivel_cuenta,nc_descripcion,nc_longitud)
		values (@i_empresa,@i_nivel_cuenta,@i_descripcion,@i_longitud)
		if @@error <> 0 
		begin
			/* 'Error en insercion de Nivel de Cuenta  ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603010
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_nivel_cuenta
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_nivel_cuenta,@i_descripcion,@i_longitud)

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

/* Actualizacion de nivel_cuenta  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Nivel de Cuenta  a actualizar NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 605018
		return 1
	end
	
	select @w_cuenta = cu_cuenta
	from cob_conta..cb_cuenta
	where cu_empresa = @i_empresa and
		cu_nivel_cuenta = @i_nivel_cuenta 

	if @@rowcount > 0 
	begin
		/* 'Nivel de Cuenta  a actualizar relacionado con catalogo de cuentas ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 605031
		return 1
	end



	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_nivel_cuenta
		set     nc_descripcion = @i_descripcion,
			nc_longitud = @i_longitud
		where   nc_empresa = @i_empresa and
			nc_nivel_cuenta = @i_nivel_cuenta

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Nivel de Cuenta'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 605019
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_nivel_cuenta
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_nivel_cuenta,@w_descripcion,@w_longitud)

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
		insert into ts_nivel_cuenta
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_nivel_cuenta,@i_descripcion,@i_longitud)

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

/* Eliminacion de nivel_cuenta  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Nivel de Cuenta a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 607028
		return 1
	end

/**** Integridad referencial ****/
/********************************/

	/* Si codigo de nivel_cuenta existe en catalogo de cuentas      
	   No se puede eliminar el nivel_cuenta */
	if EXISTS (select cu_nivel_cuenta 
		from cob_conta..cb_cuenta
		where   cu_empresa = @i_empresa and
			cu_nivel_cuenta = @i_nivel_cuenta 
		)
	begin
		/* 'Nivel de cuenta relacionado con cuentas ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 607029
		return 1
	end

	begin tran

		select @w_siguiente = @i_nivel_cuenta + 1
		select @w_flag1 = 1
		while @w_flag1 > 0
		begin
			select @w_sdescripcion = nc_descripcion,
				@w_slongitud = nc_longitud
			from cob_conta..cb_nivel_cuenta
			where nc_empresa = @i_empresa and
				nc_nivel_cuenta = @w_siguiente

			if @@rowcount > 0 
			begin
				if exists (select cu_nivel_cuenta
					from cob_conta..cb_cuenta
					where   cu_empresa = @i_empresa and
						cu_nivel_cuenta = @w_siguiente
					)
				begin
				/* 'Niveles superiores de cuenta relacionados con cuentas ' */
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file,
					@t_from  = @w_sp_name,
					@i_num   = 607029
	
					select @w_flag1 = 1
					return 1
				end
				else
				begin
					update cob_conta..cb_nivel_cuenta
					set nc_descripcion = @w_sdescripcion,
					nc_longitud = @w_slongitud
					where nc_empresa = @i_empresa and
					nc_nivel_cuenta = @w_siguiente - 1

					if @@error <> 0
					begin
						/* 'Error en Eliminacion de Nivel de cuenta' */
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file  = @t_file,
						@t_from  = @w_sp_name,
						@i_num   = 607030
						REturn 1
					end

				end
				select @w_siguiente = @w_siguiente + 1
			end
			else
			begin
				select @w_flag1 = 0
				delete cob_conta..cb_nivel_cuenta
				where  nc_empresa = @i_empresa and
					nc_nivel_cuenta = @w_siguiente - 1
					if @@error <> 0
					begin
						/* 'Error en Eliminacion de Nivel de cuenta' */
						exec cobis..sp_cerror
						@t_debug = @t_debug,
						@t_file  = @t_file,
						@t_from  = @w_sp_name,
						@i_num   = 607030
						return 1
					end
					
			end
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_nivel_cuenta
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_nivel_cuenta,@i_descripcion,@i_longitud)

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


/**** Value ****/
/****************/

if @i_operacion = 'V'
begin
if @w_existe = 1
	select @w_descripcion
else
begin
	/* 'Nivel de Cuenta consultado no existe  '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601034
	return 1
end
return 0
end

/**** Busqueda Especial para ingreso de cuentas ******/
/*****************************************************/

if @i_operacion = 'B'
begin
		select nc_longitud,nc_descripcion
		from cob_conta..cb_nivel_cuenta
		where nc_empresa = @i_empresa
		order by nc_nivel_cuenta
        if @@rowcount = 0
	begin
		/* 'Nivel de Cuenta consultado no existe  '*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601034
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
		select 	'NIVEL' = nc_nivel_cuenta,
			'NOMBRE NIVEL' = substring(nc_descripcion,1,30),
			'LONGITUD' = nc_longitud
		from cob_conta..cb_nivel_cuenta
		where nc_empresa = @i_empresa
		order by nc_nivel_cuenta

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601035
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'NIVEL' = nc_nivel_cuenta,
			'NOMBRE NIVEL' = substring(nc_descripcion,1,30),
			'LONGITUD' = nc_longitud
		from cob_conta..cb_nivel_cuenta
		where nc_empresa = @i_empresa and
			nc_nivel_cuenta > @i_nivel_cuenta
		order by nc_nivel_cuenta

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601035
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
end

/******** ALL *********/

if @i_operacion = 'A'
begin
	select 'NIVEL CUENTA' = nc_nivel_cuenta,
               'DESCRIPCION' = nc_descripcion
	from cob_conta..cb_nivel_cuenta
	where nc_empresa = @i_empresa

	if @@error <> 0
	begin
		/* 'No existen Niveles de Cuentas    ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601035
		return 1
	end
	return 0
end

go
