/************************************************************************/
/*	Archivo: 		periodo.sp			*/
/*	Stored procedure: 	sp_periodo				*/
/*	Base de datos:  	cob_conta  				*/
/*	Producto:               contabilidad                		*/
/*	Disenado por:                                               	*/
/*	Fecha de escritura:     04-Agosto-1993				*/
/************************************************************************/
/*				IMPORTANTE				*/
/*	Este programa es parte de los paquetes bancarios propiedad de	*/
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	*/
/*	"NCR CORPORATION".						*/
/*	Su uso no autorizado queda expresamente prohibido asi como	*/
/*	cualquier alteracion o agregado hecho por alguno de sus		*/
/*	usuarios sin el debido consentimiento por escrito de la 	*/
/*	Presidencia Ejecutiva de MACOSA o su representante.		*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Mantenimiento al catalogo de Periodos Contables de una       */
/*	   empresa							*/
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*      14/11/1997	Martha Gil V.	Control de periodos repetidos   */
/*      20/11/1997      Sandra Robayo   Cambio de tipo de dato para     */
/*                                      periodo tinyint por int         */
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_periodo')
	drop proc sp_periodo    

go

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER OFF
GO

create proc sp_periodo     (
	@s_ssn		int = null,
	@s_date		datetime = null,
	@s_user		login = null,
	@s_term		descripcion = null,
	@s_corr		char(1) = null,
	@s_ssn_corr	int = null,
        @s_ofi		smallint = null,
	@t_rty		char(1) = null,
        @t_trn		smallint = 609,
	@t_debug	char(1) = 'N',
	@t_file		varchar(14) = null,
	@t_from		varchar(30) = null,
	@i_operacion	char(1),
	@i_modo		smallint = null,
	@i_periodo	int = null,
	@i_empresa    	tinyint = null,
	@i_fecha_inicio	datetime = null,
	@i_fecha_fin	datetime = null,
	@i_estado 	char(1)  = null,
	@i_tipo_periodo	char(1) = null,
	@i_formato_fecha tinyint = 1
)
as 
declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_strfi	char(12),
	@w_strin 	char(12),
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */

	@w_periodo	int ,	/* codigo de periodo */
	@w_empresa    	tinyint,        /* codigo de empresa */	
	@w_fecha_inicio	char(12),   	/* fecha inicio del periodo */
	@w_fecha_fin	char(12),    	/* fecha final del perriodo */
	@w_estado 	char(1),        /* codigo de estado  */
	@w_tipo_periodo	char(1),        /* # de cortes del periodo  */
	@w_nempresa	descripcion

select @w_today = getdate()
select @w_sp_name = 'sp_periodo'


/************************************************/
/*  Tipo de Transaccion       			*/

if (@t_trn <> 6091 and @i_operacion = 'I') or
   (@t_trn <> 6092 and @i_operacion = 'U') or
   (@t_trn <> 6093 and @i_operacion = 'D') or
   (@t_trn <> 6094 and @i_operacion = 'V') or
   (@t_trn <> 6095 and @i_operacion = 'S') or
   (@t_trn <> 6096 and @i_operacion = 'Q') or
   (@t_trn <> 6097 and @i_operacion = 'A') 
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
		i_periodo	= @i_periodo,
		i_empresa      	= @i_empresa,      
		i_fecha_inicio	= @i_fecha_inicio,
		i_fecha_fin	= @i_fecha_fin,
		i_estado 	= @i_estado, 
		i_tipo_periodo	= @i_tipo_periodo
	exec cobis..sp_end_debug
end

/* Chequeo de Existencias */
/**************************/

if @i_operacion <> 'S' and @i_operacion <> 'A'
begin
	select 	@w_periodo = pe_periodo,
		@w_empresa = pe_empresa,
		@w_fecha_inicio	= convert(char(12),pe_fecha_inicio,
					  @i_formato_fecha),
		@w_fecha_fin	= convert(char(12),pe_fecha_fin,
					  @i_formato_fecha),
		@w_estado = pe_estado,  
		@w_tipo_periodo = pe_tipo_periodo,
		@w_nempresa = em_descripcion
	from cob_conta..cb_periodo, cob_conta..cb_empresa
	where 	pe_periodo = @i_periodo and
		pe_empresa = @i_empresa and
		pe_empresa = em_empresa
	
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

	if @i_periodo is NULL or @i_empresa is NULL or
	   @i_fecha_inicio is NULL or @i_fecha_fin is NULL or
	   @i_estado is NULL or @i_tipo_periodo is NULL
	begin
		/* 'Campos NOT NULL con valores nulos' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601001
		return 1
	end

/**** Integridad Referencial ****/
/********************************/	

	if NOT EXISTS (select * from cob_conta..cb_empresa
			where em_empresa = @i_empresa    
		      )
	begin
		/* 'No existe codigo de empresa especificada' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601018
		return 1
	end
end


/* Insercion de periodos */
/*************************/

if @i_operacion = 'I'
begin
	if @w_existe = 1 
	begin
		/* 'Codigo de periodo ya existe           ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601005
		return 1
	end

       if EXISTS (select * from cob_conta..cb_periodo
                        where pe_empresa = @i_empresa and
		              ((pe_fecha_inicio <= @i_fecha_inicio and
                              pe_fecha_fin    >= @i_fecha_inicio) or
			      (pe_fecha_inicio <= @i_fecha_fin and
                              pe_fecha_fin    >= @i_fecha_fin))
        )
        begin      
              /* 'Fechas del periodo ya existen        ' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 601170 
                return 1
        end       
	/* Insercion del registro */
	/**************************/

	begin tran
		insert into cb_periodo
                  (pe_periodo,pe_empresa,pe_fecha_inicio,pe_fecha_fin,
                   pe_estado,pe_tipo_periodo)
		values (@i_periodo,@i_empresa,@i_fecha_inicio,
			@i_fecha_fin,@i_estado,@i_tipo_periodo
			)
			
		if @@error <> 0 
		begin
			/* 'Error en Insercion de Periodo         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603008
			return 1
		end
		else 
		begin
			exec @w_return = cob_conta..sp_corte
			@s_ssn,@s_date,@s_user,@s_term,@s_corr,
			@s_ssn_corr,@s_ofi,@t_rty,6101,
			'N',NULL,NULL,@i_operacion,NULL,
			@i_periodo,
			@i_empresa,
			@i_fecha_inicio,
			@i_fecha_fin,
			@i_tipo_periodo ,null,null,null,
			'N'             /* estado */

			if @w_return <> 0
			begin
				/* 'Error en insercion de cortes' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603018
				return 1
			end
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into cb_tran_servicio (   
                  ts_secuencial, ts_tipo_transaccion,ts_clase,
                  ts_fecha,ts_usuario,ts_terminal,ts_oficina,ts_periodo,
                  ts_empresa,ts_fecha_ini,ts_fecha_fin,ts_estado,ts_tipo_doc)
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			@i_periodo,@i_empresa,@i_fecha_inicio,@i_fecha_fin,
			@i_estado,@i_tipo_periodo)

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

/* Actualizacion de periodos  (Update) */
/***************************************/

if @i_operacion = 'U'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de periodo a actualizar NO existe  ' */
			exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 605001
		return 1
	end

	if EXISTS (select * from cob_conta..cb_periodo
                        where pe_empresa = @i_empresa and
                              pe_periodo <> @i_periodo and
		             ( (pe_fecha_inicio <= @i_fecha_inicio and
                              pe_fecha_fin    >= @i_fecha_inicio) or
			      (pe_fecha_inicio <= @i_fecha_fin and
                              pe_fecha_fin    >= @i_fecha_fin))
        )
        begin      
              /* 'Fechas del periodo ya existen        ' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 601170 
                return 1
        end       



	/*  Actualizacion del registro  */
	/********************************/

	begin tran
            if @i_estado <> 'C'
            begin
		if not exists (select *
				from cob_conta_his..cb_hist_saldo
				where hi_empresa = @i_empresa
				and hi_periodo = @i_periodo
				)
		begin
			update cob_conta..cb_periodo
			set 	pe_fecha_inicio = @i_fecha_inicio,
				pe_fecha_fin = @i_fecha_fin,
				pe_estado = @i_estado,
				pe_tipo_periodo = @i_tipo_periodo
			where 	pe_periodo = @i_periodo	and
				pe_empresa = @i_empresa

			if @@error <> 0
			begin
				/* 'Error en Actualizacion de Periodo ' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603008
				return 1
			end
			else
			begin
				delete cob_conta..cb_corte
				where co_periodo = @i_periodo and
				co_empresa = @i_empresa

				exec @w_return = cob_conta..sp_corte
				@s_ssn,@s_date,@s_user,@s_term,@s_corr,
				@s_ssn_corr,@s_ofi,@t_rty,6101,
				'N',NULL,NULL,'I',NULL,
				@i_periodo,
				@i_empresa,
				@i_fecha_inicio,
				@i_fecha_fin,
				@i_tipo_periodo ,null,null,null,
				'N'             /* estado */

				if @w_return <> 0
				begin
				/*'Error en insercion de cortes'*/
					exec cobis..sp_cerror
					@t_debug = @t_debug,
					@t_file	 = @t_file,
					@t_from	 = @w_sp_name,
					@i_num	 = 603018
					return 1
				end
			end
		end
		else
		begin
			/* 'Error en Actualizacion de Periodo ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603008
			return 1
		end
           end
           else
           begin

		update cob_conta..cb_periodo
		set 	pe_fecha_inicio = @i_fecha_inicio,
			pe_fecha_fin = @i_fecha_fin,
			pe_estado = @i_estado,
			pe_tipo_periodo = @i_tipo_periodo
		where 	pe_periodo = @i_periodo	and
			pe_empresa = @i_empresa

		if @@error <> 0
		begin
			/* 'Error en Actualizacion de Periodo ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 603008
			return 1
		end


           end

	   /****************************************/
	   /* TRANSACCION DE SERVICIO		*/

	   insert into cb_tran_servicio (   
                  ts_secuencial, ts_tipo_transaccion,ts_clase,
                  ts_fecha,ts_usuario,ts_terminal,ts_oficina,ts_periodo,
                  ts_empresa,ts_fecha_ini,ts_fecha_fin,ts_estado,ts_tipo_doc)
	   values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_periodo,@w_empresa,@w_fecha_inicio,@w_fecha_fin,
			@w_estado,@w_tipo_periodo)

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

	   insert into cb_tran_servicio (   
                  ts_secuencial, ts_tipo_transaccion,ts_clase,
                  ts_fecha,ts_usuario,ts_terminal,ts_oficina,ts_periodo,
                  ts_empresa,ts_fecha_ini,ts_fecha_fin,ts_estado,ts_tipo_doc)
	   values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@w_periodo,@w_empresa,@w_fecha_inicio,@w_fecha_fin,
			@w_estado,@w_tipo_periodo)

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

/* Eliminacion de periodos  (Delete) */
/***************************************/

if @i_operacion = 'D'
begin
	if @w_existe = 0 
	begin
		/* 'Codigo de periodo a eliminar NO existe   ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607001
		return 1
	end

/**** Integridad Referencial ****/
/********************************/

       	/* Si codigo de periodo existe en catalogo de saldos 
	   No se puede eliminar la periodo */

     	if EXISTS (select hi_periodo
		from cob_conta_his..cb_hist_saldo 
		where hi_empresa = @i_empresa
		and hi_periodo = @i_periodo
		)
	begin
		/* 'Codigo de periodo relacionado con SALDOS  ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 607024
		return 1
	end

	/*  Eliminacion del registro  */
	/********************************/

	begin tran
		delete cob_conta..cb_corte
		where co_periodo = @i_periodo and
			co_empresa = @i_empresa

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Cortes      ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607025
			return 1
		end

  		delete cob_conta..cb_periodo
		where pe_periodo = @i_periodo and
			pe_empresa = @i_empresa

		if @@error <> 0
		begin
			/* 'Error en Eliminacion de Periodo     ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 607026
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into cb_tran_servicio (   
                  ts_secuencial, ts_tipo_transaccion,ts_clase,
                  ts_fecha,ts_usuario,ts_terminal,ts_oficina,ts_periodo,
                  ts_empresa,ts_fecha_ini,ts_fecha_fin,ts_estado,ts_tipo_doc)
		values (@s_ssn,@t_trn,'B',@s_date,@s_user,@s_term,@s_ofi,
			@i_periodo,@i_empresa,@i_fecha_inicio,@i_fecha_fin,
			@i_estado,@i_tipo_periodo)

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

if @i_operacion = 'Q'
begin
	if @w_existe = 1
		select @w_periodo,@w_empresa,@w_fecha_inicio,@w_fecha_fin,@w_estado,@w_tipo_periodo
	else
	begin
		/* 'Periodo consultado no existe        ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601030
		return 1
	end
end

/******************     ALL     ********************/

if @i_operacion = 'A'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'PERIODO' = pe_periodo, 
			'FECHA INICIAL' = convert(char(12),pe_fecha_inicio,
					  @i_formato_fecha),
			'FECHA FINAL' = convert(char(12),pe_fecha_fin,
					@i_formato_fecha)
        	from cob_conta..cb_periodo
		where pe_empresa = @i_empresa
   		order by pe_periodo

		if @@rowcount = 0
		begin
			/* 'No existen Periodos         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601031
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
		select 	'PERIODO' = pe_periodo,
			'FECHA INICIAL' = convert(char(12),pe_fecha_inicio,
					  @i_formato_fecha),
			'FECHA FINAL' = convert(char(12),pe_fecha_fin,
					@i_formato_fecha)
		from cob_conta..cb_periodo
		where pe_periodo > @i_periodo and
			pe_empresa = @i_empresa
		order by pe_periodo
		if @@rowcount = 0
		begin
			/* 'No existen Periodos         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601031
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end

/******************   VALUE     ********************/

if @i_operacion = 'V'
begin
	if @w_existe = 1 
	begin 
		select @w_strin = convert(char(12),@w_fecha_inicio,
				  @i_formato_fecha)
		select @w_strfi = convert(char(12),@w_fecha_fin,
				  @i_formato_fecha)
		select @w_strin + ' - ' + @w_strfi
	end
        else
	begin
		/* 'Periodo consultado no existe        ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601030
		return 1
	end
        return 0
end
/******************   SEARCH    ********************/

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
	select 	'PERIODO'  = pe_periodo,
		'FECHA INICIAL'	= convert(char(12),pe_fecha_inicio,
				  @i_formato_fecha),
		'FECHA FINAL' = convert(char(12),pe_fecha_fin,@i_formato_fecha),
		'TIPO DE CORTE' = pe_tipo_periodo ,
		'ESTADO' = pe_estado
        	from cob_conta..cb_periodo
		where pe_empresa = @i_empresa 

		if @@rowcount = 0
		begin
			/* 'No existen Periodos         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601031
			set rowcount 0
			return 1
		end
		set rowcount 0
        	return 0
	end
	if  @i_modo = 1
	begin
	select 	'PERIODO'  = pe_periodo,
		'FECHA INICIAL'	= convert(char(12),pe_fecha_inicio,
				  @i_formato_fecha),
		'FECHA FINAL' = convert(char(12),pe_fecha_fin,@i_formato_fecha),
		'TIPO DE CORTE' = pe_tipo_periodo ,
		'ESTADO' = pe_estado
        	from cob_conta..cb_periodo
		where pe_periodo > @i_periodo and
			pe_empresa = @i_empresa
		if @@rowcount = 0
		begin
			/* 'No existen Periodos         ' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601031
			set rowcount 0
			return 1
		end
		set rowcount 0
		return 0
	end
end

go
