/************************************************************************/
/*	Archivo: 		ctaproc.sp			                                */
/*	Stored procedure: 	sp_cuenta_proceso			                    */
/*	Base de datos:  	cob_conta  				                        */
/*	Producto:               contabilidad                		        */
/*	Disenado por:                                               	    */
/*	Fecha de escritura:     30-julio-1993 				                */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				PROPOSITO				                                */
/*	Este programa procesa las transacciones de:			                */
/*	   Mantenimiento al catalogo de cuentas asociadas a un proceso      */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/*	7/ene/1994	G Jaramillo     Emision Inicial		                    */
/*	21/Jun/1994	G Jaramillo     Eliminacion de secciones                */
/*	19/Ago/1997	F Salgado	Opcion B, que traiga todos los              */
/*					registros			                                */
/*	26/Nov/1997	Ma.Victoria Garay Cambiar mensaje de Error              */
/*      30/Dic/1997     M.Claudia Morales Cambia Codigo de Error 609125 */
/*                                        por 601102. (MCM001)          */
/*      16/May/2005     Olga Rios         Se modifica tipo de dato a    */
/*                                       variables i_proceso y w_proceso*/     
/*	21/oct/2005	Olga Rios	Modificacion fecha tran servicio            */
/*  23/Nov/2017 Fco. Vargas B146376 Ingreso de Comprobantes             */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_cuenta_proceso')
	drop proc sp_cuenta_proceso

go

SET ANSI_NULLS OFF
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_cuenta_proceso   (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = null,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_empresa	tinyint = null,
	@i_proceso	int = null,
	@i_cuenta	cuenta = null,
	@i_oficina	smallint = null,
	@i_area		smallint = null,
	@i_proceso1	smallint = null,
        @i_texto        descripcion = null,
        @i_condicion    char(4) = null,
        @i_imprime      char(1) = null
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente	tinyint,
	@w_empresa	tinyint,
	@w_proceso 	int,
	@w_proceso1	int,
	@w_proceso2	int,
	@w_nproceso	descripcion,
	@w_cuenta	cuenta,
	@w_ncuenta	varchar(80),
	@w_oficina	smallint,
	@w_noficina	descripcion,
	@w_area		smallint,
	@w_narea	descripcion,
        @w_texto        descripcion,
        @w_condicion    char(4),
        @w_imprime      char(1),
	@w_existe	int		/* codigo existe = 1 
				               no existe = 0 */

select @w_today = getdate()
select @w_sp_name = 'sp_cuenta_proceso'

/************************************************/
/*  Tipo de Transaccion = 622X 			*/

if (@t_trn <> 6221 and @i_operacion = 'I') or
   (@t_trn <> 6222 and @i_operacion = 'U') or
   (@t_trn <> 6223 and @i_operacion = 'D') or
   (@t_trn <> 6224 and @i_operacion = 'V') or
   (@t_trn <> 6225 and @i_operacion = 'S') or
   (@t_trn <> 6226 and @i_operacion = 'Q') or
   (@t_trn <> 6218 and @i_operacion = 'P') or
   (@t_trn <> 6219 and @i_operacion in ('C', 'F')) or
   (@t_trn <> 6227 and @i_operacion = 'A') or
   (@t_trn <> 6220 and @i_operacion = 'B')
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
		i_proceso	= @i_proceso,
		i_cuenta	= @i_cuenta,
		i_oficina	= @i_oficina,
		i_area		= @i_area,
		i_condicion	= @i_condicion
	exec cobis..sp_end_debug
end


if @i_proceso is null
begin
	select @w_proceso1 = 0
	select @w_proceso2 = 32600
end
else begin
	select @w_proceso1 = @i_proceso
	select @w_proceso2 = @i_proceso
end

/* Chequeo de Existencias */

/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A' and @i_operacion <> 'B'
begin
    if @i_condicion is null
    begin
	    select 	@w_empresa = cp_empresa,
	            @w_proceso = cp_proceso,
	            @w_cuenta  = cp_cuenta,
	            @w_oficina = cp_oficina,
	            @w_area	   = cp_area,
	            @w_nproceso = ba_nombre,
	            @w_ncuenta  = cu_nombre,
                @w_texto    = cp_texto,
                @w_condicion = cp_condicion,
                @w_imprime   = cp_imprima
	    from cob_conta..cb_cuenta_proceso,cob_conta..cb_cuenta,
	         cobis..ba_batch
	    where 	cp_empresa = @i_empresa and
	    	cp_proceso = @i_proceso and
	    	cp_cuenta  = @i_cuenta and
	    	cp_oficina = @i_oficina and
	    	cp_area    = @i_area and
	    	cu_empresa = cp_empresa and
	    	cu_cuenta  = cp_cuenta and
	    	ba_batch = cp_proceso
 	    	
	end
	else
	begin
        select @w_empresa = cp_empresa,
               @w_proceso = cp_proceso,
               @w_cuenta  = cp_cuenta,
               @w_oficina = cp_oficina,
               @w_area	   = cp_area,
               @w_nproceso = ba_nombre,
               @w_ncuenta  = cu_nombre,
               @w_texto    = cp_texto,
               @w_condicion = cp_condicion,
               @w_imprime   = cp_imprima
        from cob_conta..cb_cuenta_proceso,cob_conta..cb_cuenta,
        cobis..ba_batch
        where 	cp_empresa = @i_empresa and
        cp_proceso = @i_proceso and
        cp_cuenta  = @i_cuenta and
        cp_oficina = @i_oficina and
        cp_area    = @i_area and
        cu_empresa = cp_empresa and
        cu_cuenta  = cp_cuenta and
        cp_condicion = @i_condicion and 
        ba_batch = cp_proceso

    end
    
    if @@rowcount = 0
	   select @w_existe = 0
    else
       select @w_existe = 1         

        
end

/* Validacion de datos para insercion y actualizacion */
/******************************************************/


if @i_operacion = 'I' or @i_operacion = 'U'
begin
	/* Validacion de datos */
	/***********************/

	if @i_empresa is NULL or @i_proceso is NULL or @i_cuenta is null
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
		where ba_batch = @i_proceso)
   begin
	/* 'No existe codigo de Proceso especificado' */
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 601097
	return 1
   end


end

/* Insercion de Proceso */
/************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	 begin
		/* 'Cuenta ya esta relacionada a proceso  '*/ 
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

		insert into cob_conta..cb_cuenta_proceso
		       (cp_proceso,cp_empresa,cp_cuenta,cp_oficina,
                        cp_area, cp_texto,cp_condicion,cp_imprima)
		values (@i_proceso,@i_empresa,@i_cuenta,@i_oficina,
                        @i_area,@i_texto,@i_condicion,@i_imprime)
		if @@error <> 0 
		begin
		/* error en insercion de cuenta relacionada a proceso*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603040
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_proceso
		values (@s_ssn,@t_trn,'N',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@i_proceso,@i_cuenta,@i_oficina,@i_texto,
                        @i_condicion,@i_imprime)

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
		/* 'Codigo de cuenta Proceso a actualizar NO existe'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605058
		return 1
	end

	/*  Actualizacion del registro  */
	/********************************/

	begin tran
		update cob_conta..cb_cuenta_proceso
		set 	cp_oficina= @i_oficina ,
			cp_area = @i_area
		where 	cp_empresa = @i_empresa and
			cp_proceso = @i_proceso and
			cp_cuenta = @i_cuenta

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de cuenta-Proceso'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605058
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_proceso
		values (@s_ssn,@t_trn,'P',getdate(),@s_user,@s_term,@s_ofi,
			@w_empresa,@w_proceso,@w_cuenta,@w_oficina,null,
                        null,null)

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
		insert into ts_cuenta_proceso
		values (@s_ssn,@t_trn,'N',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@i_proceso,@i_cuenta,@i_oficina,null,
                         null,null)

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
		/* 'Codigo de cuenta-Proceso a eliminar NO existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607083
		return 1
	end

	/**** Integridad Referencial ****/
	/********************************/

       	/* Si existen cuentas asociadas al proceso,
	   No se puede eliminar el proceso */

     	if EXISTS (select ca_proceso
		from cob_conta..cb_cuenta_asociada
		where 	ca_empresa = @i_empresa and
			ca_proceso = @i_proceso and
			ca_cuenta  = @i_cuenta and
			ca_oficina = @i_oficina and
			ca_area    = @i_area
		)
	begin
		/* 'Codigo de Proceso relacionado cuentas'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607084
		return 1
	end


	/*  Eliminacion del registro  */
	/********************************/

	begin tran


  		delete cob_conta..cb_cuenta_proceso
		where 	cp_empresa = @i_empresa and
			cp_proceso = @i_proceso and
			cp_cuenta = @i_cuenta and
			cp_oficina = @i_oficina and
			cp_area   = @i_area and 
                        (cp_condicion = @i_condicion or @i_condicion is null)

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Cuenta-Proceso' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607085
			return 1
		end


		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_cuenta_proceso
		values (@s_ssn,@t_trn,'B',getdate(),@s_user,@s_term,@s_ofi,
			@i_empresa,@w_proceso,@w_cuenta,@w_oficina,null,
                         null,null)

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
	select @w_noficina = null,
	       @w_narea    = null

	if @w_existe = 1
	begin
		if @w_oficina is not null
                begin
			select @w_noficina = of_descripcion
			from cob_conta..cb_oficina
			where of_oficina = @i_oficina 
                          and of_empresa = @i_empresa
		end
		if @w_area is not null
		begin
			select @w_narea = ar_descripcion
			from cob_conta..cb_area
			where ar_area = @i_area
                          and ar_empresa = @i_empresa
		end
		select 	@w_proceso,@w_cuenta,
			isnull(convert(char(4),@w_oficina),NULL),
			isnull(convert(char(4),@w_area),NULL),
			@w_nproceso,@w_ncuenta,@w_noficina,@w_narea,
                        @w_texto,@w_condicion,@w_imprime
        end
	else
	begin
		/* 'cuenta-Proceso consultado no existe ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601101
		return 1
	end
	return 0
end

/*  All */
/********/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	cp_proceso, cp_cuenta,cp_oficina,cp_area
		from cob_conta..cb_cuenta_proceso
		where cp_empresa = @i_empresa 

		if @@rowcount = 0
		begin
			/* 'No existen cuentas relacionadas Procesos '*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102  /* MCM001 */
			return 1
		end
		set rowcount 0
		return 0
	end
	else
	begin
		select cp_proceso,cp_cuenta,cp_oficina,cp_area
		from cob_conta..cb_cuenta_proceso
		where 	cp_empresa = @i_empresa and
			((cp_proceso = @i_proceso and cp_cuenta > @i_cuenta) or
			(cp_proceso > @i_proceso))

		if @@rowcount = 0
		begin
			/* 'No existen cuentas relacionadas a Procesos'*/
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601102 /* MCM001 */
			return 1
		end
		set rowcount 0
		return 0
	end
end

/* Search */
/**********/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'Cuenta' = cp_cuenta,
			'Oficina' = isnull(convert(char(4),cp_oficina),NULL),
			'Area' = isnull(convert(char(4),cp_area),NULL)
		from cob_conta..cb_cuenta_proceso
		where 	cp_empresa = @i_empresa and
			cp_proceso = @i_proceso 

		if @@rowcount = 0
		begin
			/* 'No existen cuentas relacionadas Procesos '*/
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
		select 'Cuenta' = cp_cuenta,
			'Oficina' = isnull(convert(char(4),cp_oficina),NULL),
			'Area' = isnull(convert(char(4),cp_oficina),NULL)
		from cob_conta..cb_cuenta_proceso
		where 	cp_empresa = @i_empresa and
			cp_proceso = @i_proceso and 
			((cp_cuenta = @i_cuenta and cp_oficina = @i_oficina) or
			 (cp_cuenta = @i_cuenta and cp_oficina > @i_oficina) or
			(cp_cuenta > @i_cuenta))

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

/* B   seleccion de procesos dado una empresa */
/**********************************************/


if @i_operacion = 'B'
begin
	set rowcount 100 
	if @i_modo = 0
	begin
                if @i_proceso = 6095
                begin
                     select codigo, valor  
                     into #catalogo_conta
                     from cobis..cl_catalogo
                     where tabla = (select codigo from cobis..cl_tabla
                                    where tabla = 'cb_tipo_impuesto')
                     
                     select
                     'Proceso' = cp_proceso,
                     'Cuenta' = cp_cuenta,
                     'Oficina' = isnull(convert(char(4),cp_oficina),NULL),
                     'Area' = isnull(convert(char(4),cp_area),NULL),
                     'Operacion' = cp_condicion,
                     'Descripcion' = valor,
                     'Imprime'   = cp_imprima,
                     'Texto'     = cp_texto
                      from cob_conta..cb_cuenta_proceso
                      left outer join #catalogo_conta on
                         cp_condicion = codigo
                      where cp_proceso = @i_proceso
                      order by cp_proceso,cp_cuenta,cp_oficina,cp_area
                      
                end
                else
                begin
                     if @i_proceso = 6004
                     begin
                          exec sp_proc_6004
                          @i_empresa = @i_empresa
                          
                          select 
                                 'Proceso' = proceso,
                                 'Cuenta'  = cuenta,
                                 'Oficina' = oficina,
                                 'Area'    = area,
                                 'Operacion' = condicion,
                                 'Descripción' = descripcion,
                                 'Imprime'     = imprima,
                                 'Texto'       = texto
                          from cob_conta..cb_cuenta6004
                          order by proceso, cuenta, oficina, area
                     end
                     else
                     begin
                     

                		     select 'Proceso' = cp_proceso,
                		         'Cuenta' = cp_cuenta,
                		         'Oficina' = isnull(convert(char(4),cp_oficina),NULL),
                		         'Area' = isnull(convert(char(4),cp_area),NULL),
                                 'Operacion' = cp_condicion,
                                 'Imprime'   = cp_imprima,
                                 'Texto'     = cp_texto
                		     from cob_conta..cb_cuenta_proceso
                		     where 	cp_empresa = @i_empresa and
                		     	cp_proceso between @w_proceso1 and @w_proceso2
                		     order by cp_proceso,cp_cuenta,cp_oficina,cp_area
                     end
                end

		        if @@rowcount = 0 and  @i_proceso not in(6095,6003)
		        begin
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
                if @i_proceso = 6095
                begin	
                     select codigo, valor  
                     into #catalogo_conta1
                     from cobis..cl_catalogo
                     where tabla = (select codigo from cobis..cl_tabla
                                    where tabla = 'cb_tipo_impuesto')
                                                    
                     select  'Proceso' = cp_proceso,
                     'Cuenta' = cp_cuenta,
                     'Oficina' = isnull(convert(char(4),cp_oficina),NULL),
                     'Area' = isnull(convert(char(4),cp_area),NULL),
                     'Operacion' = cp_condicion,
                     'Descripcion' = valor,
                     'Imprime'   = cp_imprima,
                     'Texto'     = cp_texto
                     from cob_conta..cb_cuenta_proceso
                          left outer join #catalogo_conta1 on
                             cp_condicion = codigo
                     where 	cp_empresa = @i_empresa and
                            ((cp_proceso = @i_proceso and
                            cp_cuenta    = @i_cuenta and
                            cp_oficina   = @i_oficina and
                            cp_area      = @i_area and
                            cp_condicion > @i_condicion) or
                            (cp_proceso  = @i_proceso and
                            cp_cuenta    = @i_cuenta and
                            cp_oficina   = @i_oficina and
                            cp_area      > @i_area) or
                            (cp_proceso  = @i_proceso and
                            cp_cuenta    = @i_cuenta and
                            cp_oficina   > @i_oficina) or
                            (cp_proceso  = @i_proceso and
                            cp_cuenta    > @i_cuenta))
                     order by cp_proceso,cp_cuenta,cp_oficina,cp_area
                end
                else
		        begin
                     if @i_proceso = 6004
		             begin

                          select 
                               'Proceso' = proceso,
                               'Cuenta'  = cuenta,
                               'Oficina' = oficina,
                               'Area'    = area,
                               'Operacion' = condicion,
                               'Descripción' = descripcion,
     'Imprime'     = imprima,
                               'Texto'       = texto
                          from cob_conta..cb_cuenta6004
                          where (cuenta = @i_cuenta 
                          and oficina = @i_oficina 
                          and area = @i_area 
                          and condicion > @i_condicion) 
                          or (cuenta = @i_cuenta 
                          and oficina = @i_oficina 
                          and area > @i_area) 
                          or (cuenta = @i_cuenta 
                          and oficina > @i_oficina) 
                          or cuenta > @i_cuenta
                          order by proceso, cuenta, oficina, area
                     end
                     else
                     begin
                          select  'Proceso' = cp_proceso,
                          'Cuenta' = cp_cuenta,
                          'Oficina' = isnull(convert(char(4),cp_oficina),NULL),
                          'Area' = isnull(convert(char(4),cp_area),NULL),
                          'Operacion' = cp_condicion,
                          'Imprime'   = cp_imprima,
                          'Texto'     = cp_texto
                          from cob_conta..cb_cuenta_proceso
                          where 	cp_empresa = @i_empresa and
                               ((cp_proceso = @i_proceso and
                               cp_cuenta = @i_cuenta and
                               cp_oficina = @i_oficina and
                               cp_area = @i_area and
                               cp_condicion > @i_condicion) or
                               (cp_proceso = @i_proceso and
                               cp_cuenta = @i_cuenta and
                               cp_oficina = @i_oficina and
                               cp_area > @i_area) or
                               (cp_proceso = @i_proceso and
                               cp_cuenta = @i_cuenta and
                               cp_oficina > @i_oficina) or
                               (cp_proceso = @i_proceso and
                               cp_cuenta > @i_cuenta))
                          order by cp_proceso,cp_cuenta,cp_oficina,cp_area
                     end
                end
		
                if @@rowcount = 0 and @i_proceso not in(6095,6003)
                begin
                     exec cobis..sp_cerror
                     @t_debug = @t_debug,
                     @t_file = @t_file,
                     @t_from = @w_sp_name,
                     @i_num	 = 601102  
                     return 1
                end

        set rowcount 0
		return 0
	end
end

/* P	dice si una cuenta dada esta asociada a un proceso */
/***********************************************************/

if @i_operacion = 'P'
begin
	if exists (select * from cb_cuenta_proceso
		    where cp_cuenta = @i_cuenta
		      and cp_proceso = @i_proceso
		      and cp_empresa = @i_empresa)
	  select 1
	else
	  select 0

        return 0
end

/* C 	devuelve las cuentas asociadas a un proceso */
/****************************************************/

if @i_operacion = 'C'
begin
	select cp_cuenta , cu_movimiento
	  from cb_cuenta_proceso, cb_cuenta
	 where cp_proceso = @i_proceso
	   and cp_empresa = @i_empresa
           and cp_condicion  = @i_condicion
	   and cu_empresa = @i_empresa
	   and cu_cuenta = cp_cuenta

	if @@rowcount > 1
	begin
		/* 'Hay mas de una cuenta relacionada'*/
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601167
		return 1
	end

        return 0
end

if  @i_operacion = 'F'
begin
    set rowcount 20
    if @i_modo = 0
    begin
        select cp_cuenta,
               (select cu_nombre 
                from cob_conta..cb_cuenta
                where cu_cuenta = cp_cuenta
                and   cu_empresa = @i_empresa)
         from cob_conta..cb_cuenta_proceso
         where cp_proceso = @i_proceso
         and   cp_empresa = @i_empresa
         order by cp_cuenta
    end
    if @i_modo = 1
    begin
        select cp_cuenta,
               (select cu_nombre 
                from cob_conta..cb_cuenta
                where cu_cuenta = cp_cuenta
                and   cu_empresa = @i_empresa)
         from cob_conta..cb_cuenta_proceso
         where cp_proceso = @i_proceso
         and   cp_cuenta  > @i_cuenta
         and   cp_empresa = @i_empresa
         order by cp_cuenta
    end
end
    return 0
GO
