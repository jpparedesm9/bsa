/************************************************************************/
/*      Archivo:                codvalor.sp                             */
/*      Stored procedure:       sp_codvalor                             */
/*      Base de datos:          cob_conta                               */
/*      Producto:               contabilidad                            */
/*      Disenado por:           Luis Lopez                              */
/*      Fecha de escritura:     26-Julio-1995                           */
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
/*        Mantenimiento al catalogo de codigo Valor                     */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_codvalor')
	drop proc sp_codvalor  

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_codvalor   (
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
	@i_producto     tinyint = null,
	@i_codigo_valor int = null,
	@i_descripcion  descripcion = null,
	@i_error        smallint = null
)
as 
declare
	@w_today        datetime,       /* fecha del dia */
	@w_return       int,            /* valor que retorna */
	@w_sp_name      varchar(32),    /* nombre del stored procedure*/
	@w_siguiente    tinyint,
	@w_empresa    	tinyint,
	@w_producto     tinyint,
       	@w_codigo_valor int,
	@w_descripcion  descripcion,    
	@w_flag1        tinyint,
	@w_cuenta       char(16),
	@w_existe       int             /* codigo existe = 1 
					       no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_codvalor'


/************************************************/
/*  Tipo de Transaccion = 			*/

if (@t_trn <> 6941 and @i_operacion = 'I') or
   (@t_trn <> 6942 and @i_operacion = 'U') or
   (@t_trn <> 6943 and @i_operacion = 'D') or
   (@t_trn <> 6944 and @i_operacion = 'V') or
   (@t_trn <> 6945 and @i_operacion = 'S') or
   (@t_trn <> 6946 and @i_operacion = 'A') or
   (@t_trn <> 6947 and @i_operacion = 'B') 
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
		i_producto      = @i_producto,
		i_codigo_valor  = @i_codigo_valor,
		i_descripcion   = @i_descripcion
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/
if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	
	select  @w_empresa      = cv_empresa,	
		@w_producto     = cv_producto,
		@w_codigo_valor = cv_codval,
                @w_descripcion  = cv_descripcion
	from cb_codigo_valor
	where   cv_empresa   = @i_empresa  and 
		cv_producto  = @i_producto and
		cv_codval    = @i_codigo_valor

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

	if      @i_empresa is NULL or 
		@i_descripcion is NULL or
		@i_producto is NULL or
		@i_codigo_valor is NULL
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


/* Insercion de codigo valor */
/*************************/

if @i_operacion = 'I'
begin
		if @w_existe = 1 
		begin
		/* Codigo de product ya existe */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 601133
			return 1
		end
	
	begin tran
	/* Insercion del registro */
	/**************************/
		insert into cb_codigo_valor
		   (cv_empresa,cv_producto,cv_codval,cv_descripcion) 
		values (@i_empresa,@i_producto,@i_codigo_valor,@i_descripcion)

		if @@error <> 0 
		begin
			/* 'Error en insercion de codigo valor' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 603051
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_codigo_valor
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_producto,@i_codigo_valor,@i_descripcion)

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

/* Actualizacion de codigo valor  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'codigo producto a actualizar NO existe ' */
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
		update cob_conta..cb_codigo_valor
		set     cv_descripcion = @i_descripcion
		where   cv_empresa  = @i_empresa  and 
			cv_producto = @i_producto and
			cv_codval   = @i_codigo_valor

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de codigo valor'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 605070
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_codigo_valor
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_producto,@w_codigo_valor,@w_descripcion)

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
		insert into ts_codigo_valor
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_empresa,@i_producto,@i_codigo_valor,@i_descripcion)

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

/* Eliminacion de codigo valor  (Delete) */
/***************************************/


if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo valor a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 601159
		return 1
        end
begin tran

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_codigo_valor
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@w_empresa,@w_producto,@w_codigo_valor,@w_descripcion)

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

	delete cob_conta..cb_codigo_valor
	where  cv_empresa  = @i_empresa and 
	       cv_producto = @i_producto and
	       cv_codval   = @i_codigo_valor
	if @@error <> 0
	begin

	/* 'Error en Eliminacion de codigo valor' */
       	   exec cobis..sp_cerror
	   @t_debug = @t_debug,
           @t_file  = @t_file,
	   @t_from  = @w_sp_name,
	   @i_num   = 607108
           return 1
	end
   commit tran
   return 0
end

/**** Search ****/
/****************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'COD.PROD'   = cv_producto,
			'PRODUCTO'   = pd_descripcion,
	        	'COD.VALOR'   = cv_codval,
	                'DESCRIPCION' = substring(cv_descripcion,1,70)
		from cob_conta..cb_codigo_valor, cobis..cl_producto
	        where cv_empresa = @i_empresa
		  and pd_producto = cv_producto
                  and cv_producto = @i_producto
		order by cv_producto, cv_codval

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen Codigo valor'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 =601153
                   end
		   set rowcount 0
		   return 1
		end
		set rowcount 0
		return 0
	end
	if @i_modo = 1
	begin
		select 	'COD.PROD'   = cv_producto,
			'PRODUCTO'   = pd_descripcion,
			'COD.VALOR'   = cv_codval,
			'DESCRIPCION' = substring(cv_descripcion,1,70)
		from cob_conta..cb_codigo_valor, cobis..cl_producto
		where cv_empresa = @i_empresa 
   		  and cv_codval > @i_codigo_valor
                  and cv_producto = @i_producto
		  and pd_producto = cv_producto
		order by cv_producto, cv_codval

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen mas niveles de Cuentas de presupuesto'*/
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

/******** ALL *********/

if @i_operacion = 'A'
begin
     set rowcount 20
     if @i_modo = 0
     begin
	select 	'COD.PROD'   = cv_producto,
		'PRODUCTO'   = pd_descripcion,
	        'COD.VALOR'   = cv_codval,
                'DESCRIPCION' = substring(cv_descripcion,1,70)
	from cob_conta..cb_codigo_valor, cobis..cl_producto
        where cv_empresa = @i_empresa
	  and pd_producto = cv_producto
	order by cv_producto, cv_codval

        if @@rowcount = 0
	begin
            if @i_error <> 1
            begin
			/* 'No existen Codigo valor'*/
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
		select 	'COD.PROD'   = cv_producto,
			'PRODUCTO'   = pd_descripcion,
			'COD.VALOR'   = cv_codval,
			'DESCRIPCION' = substring(cv_descripcion,1,70)
		from cob_conta..cb_codigo_valor, cobis..cl_producto
		where cv_empresa = @i_empresa and 
		      ((cv_producto = @i_producto and
   			cv_codval > @i_codigo_valor) or
                      cv_producto > @i_producto)
		  and pd_producto = cv_producto
		order by cv_producto, cv_codval

		if @@rowcount = 0
		begin
                   if @i_error <> 1
                   begin
			/* 'No existen mas niveles de Cuentas de presupuesto'*/
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
/******** VALUE *********/

if @i_operacion = 'V'
begin
        if @w_existe = 0
        begin
			/* 'No existe Codigo producto'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601153
	    return 1
	end
        select @w_descripcion
        return 0
end 
go
