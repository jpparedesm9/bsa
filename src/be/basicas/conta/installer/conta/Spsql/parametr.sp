/************************************************************************/
/*      Archivo:                parametro.sp                            */
/*      Stored procedure:       sp_parametro                            */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           M.Suarez                                */
/*      Fecha de escritura:     27-julio-1995                           */
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
/*         Mantenimiento a la tabla de parametros para perfile          */
/*	   contable.		                          		*/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      27/Jul/1995     N.Maldonado     Emision Inicial                 */
/*	19/May/1997	F.Salgado	Personalizacion CajaCoop	*/
/*					Adicion campo empresa		*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_parametro')
	drop proc sp_parametro  

go
create proc sp_parametro   (
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
	@i_parametro    varchar(10) = null,
	@i_descripcion  varchar(150) = null,
	@i_stored       varchar(20) = null,
	@i_transaccion  int = null,
	@i_error        smallint = null
)
as 
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_existe       int,            /* codigo existe = 1 
					       no existe = 0 */
	@w_parametro    varchar(10),
        @w_stored       varchar(20),
        @w_transaccion  varchar(5),
        @w_descripcion  varchar(150),
	@w_empresa	tinyint

select @w_today = getdate()
select @w_sp_name = 'sp_parametro'

/************************************************/
/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6921 and @i_operacion = 'I') or
   (@t_trn <> 6922 and @i_operacion = 'U') or
   (@t_trn <> 6923 and @i_operacion = 'D') or
   (@t_trn <> 6924 and @i_operacion = 'Q') or
   (@t_trn <> 6925 and @i_operacion = 'S') or 
   (@t_trn <> 6926 and @i_operacion = 'A')
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
		i_parametro     = @i_parametro
	exec cobis..sp_end_debug
end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/

if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if      @i_empresa is NULL or 
		@i_parametro is NULL or
                @i_descripcion is NULL or
                @i_stored      is NULL or
                @i_transaccion is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601001
		return 1
	end
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' 
begin
	select  @w_empresa   = pa_empresa, 
		@w_parametro = pa_parametro,
		@w_descripcion = pa_descripcion,
		@w_stored = pa_stored,
                @w_transaccion = convert(char(5),pa_transaccion)
	from cb_parametro
	where   pa_empresa = @i_empresa and 
		pa_parametro = @i_parametro
	if @@rowcount <> 0
		select @w_existe = 1
	else
		select @w_existe = 0
end


/* Insercion */
/*************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	begin
		/* 'Codigo ya existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601160
		return 1
	end
	
	/* Insercion del registro */
	/**************************/
	begin tran
		insert into cb_parametro
		       (pa_empresa,pa_parametro,pa_descripcion,pa_stored,pa_transaccion)
		values (@i_empresa,@i_parametro,@i_descripcion,@i_stored,@i_transaccion)
		if @@error <> 0 
		begin
			/* 'Error en insercion de registro ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601161
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into cob_conta..ts_parametro
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
		        @i_empresa,@i_parametro,@i_descripcion,@i_stored,@i_transaccion)

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
		/* 'Registro NO existe  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end
	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cb_parametro
		set  pa_empresa	    = @i_empresa, 
		     pa_descripcion = @i_descripcion,
                     pa_stored      = @i_stored,
                     pa_transaccion = @i_transaccion
		where   pa_empresa   = @i_empresa and 
			pa_parametro = @i_parametro 

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Registro '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601162
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into cob_conta..ts_parametro
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
		        @i_empresa,@i_parametro,@i_descripcion,@i_stored,@i_transaccion)

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

/* Eliminacion */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'registro a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
	end

	begin tran

		delete cb_parametro
		where   pa_empresa = @i_empresa and 
			pa_parametro = @i_parametro 

		if @@error <> 0
		begin
			/* 'Error en delete de Registro '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601164
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into cob_conta..ts_parametro
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
		        @i_empresa,@i_parametro,@i_descripcion,@i_stored,@i_transaccion)

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


/**** query ****/
/****************/

if @i_operacion = 'Q'
begin
if @w_existe = 1
	select  @w_descripcion,@w_stored, @w_transaccion
else
begin
	/* 'Registro no existe  '*/
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601159
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
		select  'PARAMETRO' = pa_parametro,
                        'DESCRIPCION' = pa_descripcion,
                        'STORED PROCEDURE' = pa_stored,
                        'TRANSACCION' = pa_transaccion
		from cb_parametro
		where   pa_empresa = @i_empresa and 
			pa_parametro like @i_parametro
		order by pa_parametro
		
		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen registros '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select  'PARAMETRO' = pa_parametro,
                        'DESCRIPCION' = pa_descripcion,
                        'STORED PROCEDURE' = pa_stored,
                        'TRANSACCION' = pa_transaccion
		from cb_parametro
		where   pa_empresa = @i_empresa and 
			pa_parametro > @i_parametro
		order by pa_parametro
		
		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
end
/**** Search ****/
/****************/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'PARAMETRO' = pa_parametro,
                        'DESCRIPCION' = pa_descripcion
		from cb_parametro
		where   pa_empresa = @i_empresa 
		and 	pa_parametro like @i_parametro
        and pa_transaccion = @i_transaccion
		
        if @@rowcount = 0
		begin
            if @i_error <> 1
            begin
			/* 'No existen registros '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
            end
		    set rowcount 0
		    return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'PARAMETRO'   = pa_parametro,
                'DESCRIPCION' = pa_descripcion
		from cb_parametro
		where   pa_empresa = @i_empresa 
		and pa_transaccion = @i_transaccion
		and     pa_parametro > @i_parametro

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen Niveles de Cuentas '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601150
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
end
go
