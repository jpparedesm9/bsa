/************************************************************************/
/*	Archivo: 		corte.sp				*/
/*	Stored procedure: 	sp_corte  				*/
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
/*				PROPOSITO				*/
/*	Este programa procesa las transacciones de:			*/
/*	   Genera los cortes de un periodo de acuerdo al tipo           */
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*	04/Ago/1993	G Jaramillo     Emision Inicial			*/
/*	24/Jun/1997	F Salgado	Personalizacion Cajacoop	*/
/*					Adicion opcion 'Q' y 'S' para   */
/*					consulta del corte actual	*/
/************************************************************************/
use cob_conta
go

if exists (select * from sysobjects where name = 'sp_corte')
	drop proc sp_corte
go

create proc sp_corte       (
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
	@i_operacion	char(1) = null,
	@i_modo		smallint = null,
	@i_periodo	int = null,
	@i_empresa    	tinyint = null,
	@i_fecha_inicio	datetime = null,
	@i_fecha_fin	datetime = null,
	@i_tipo_periodo	char(1) = null,
	@i_corte	int = null,
	@i_fecha_ini	datetime = null,
	@i_fecha_finc  	datetime = null,
	@i_estado 	char(1)  = null,
        @i_formato_fecha tinyint = 1
)
as 

declare
	@w_today 	datetime,  	/* fecha del dia */
	@w_return	int,		/* valor que retorna */
	@w_sp_name	varchar(32),	/* nombre del stored procedure*/
	@w_siguiente 	tinyint,	/* siguiente codigo de periodo */
	@w_existe	int,		/* codigo existe = 1 
				               no existe = 0 */

        /* Variables utilizadas en la consulta de una periodo */
	@w_corte	int,
	@w_periodo	int ,	/* codigo de periodo */
	@w_empresa    	tinyint,        /* codigo de empresa */	
	@w_fecha_inicio	datetime,   	/* fecha inicio del periodo */
	@w_fecha_fin	datetime,    	/* fecha final del perriodo */
	@w_estado 	char(1),        /* codigo de estado  */
	@w_tipo_periodo	char(1),        /* # de cortes del periodo  */
	@w_fecha_corte	datetime,
        @fecha 		datetime,
        @fecnew1 	datetime,
        @fecnew2 	datetime,
        @fecq1   	datetime,
        @fecq2  	 datetime,
	@partes		int,
	@w_partes	int,
	@i		int,
	@w_flag1	int,
	@w_nempresa	descripcion,
	@w_fecha_ini	datetime,
	@w_fecha_finc	datetime,
        @mes            int

select @w_today = getdate()
select @w_sp_name = 'sp_corte'

/************************************************/
/*  Tipo de Transaccion = 610X 			*/

if (@t_trn <> 6101 and @i_operacion = 'I') or
   (@t_trn <> 6102 and @i_operacion = 'U') or
   (@t_trn <> 6105 and @i_operacion = 'S') or
   (@t_trn <> 6106 and @i_operacion = 'Q') or
   (@t_trn <> 6839 and @i_operacion = 'F')
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
		i_tipo_periodo	= @i_tipo_periodo
	exec cobis..sp_end_debug
end

if @i_operacion = 'U'
begin
        if @i_estado = 'A'
        begin
           select @w_estado = co_estado
           from cob_conta..cb_corte
           where co_empresa = @i_empresa
           and co_estado = 'A'
	   if @@rowcount > 0
	   begin
		/* 'existe corte actual ' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 603064
		return 1
	   end
        end

	select @w_corte = co_corte,
		@w_periodo = co_periodo,
		@w_empresa = co_empresa,
		@w_fecha_ini = co_fecha_ini,
		@w_fecha_finc = co_fecha_fin,
		@w_estado = co_estado
	from cob_conta..cb_corte
	where co_empresa = @i_empresa
	and co_periodo = @i_periodo
	and co_corte = @i_corte
	if @@rowcount = 0
	begin
		/* 'Corte especificado no existe' */
		exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 601078
		return 1
	end

        if @i_estado = 'C' and @w_estado <> 'C' and @w_estado <> 'N'
        begin
        	if exists (select 1
		from cob_conta..cb_comprobante
		where co_empresa = @i_empresa
		and co_fecha_tran between @i_fecha_ini and @i_fecha_finc
		and co_comprobante > 0
                and (co_autorizado = "N" or (co_autorizado = "S" and co_mayorizado <> "S") ))
		begin
			/* 'Existen comprobantes pendientes de Aprobación/Anulación para la fecha del corte' */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 601180
			return 1
		end
        end

	begin tran
		update cob_conta..cb_corte
		set co_fecha_ini = @i_fecha_ini,
		    co_fecha_fin = @i_fecha_finc,
		    co_estado = @i_estado
		where co_empresa = @i_empresa
		and co_periodo = @i_periodo
		and co_corte = @i_corte
		if @@error <> 0
		begin
			/* 'Error en la Actualizacion de Corte */
			exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 605040
			return 1
		end

		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_corte
		values (@s_ssn,@t_trn,'P',@s_date,@s_user,@s_term,@s_ofi,
			@w_corte,@w_periodo,@w_empresa,@w_fecha_ini,
			@w_fecha_finc,@w_estado)

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
		insert into ts_corte
		values (@s_ssn,@t_trn,'A',@s_date,@s_user,@s_term,@s_ofi,
			@i_corte,@i_periodo,@i_empresa,@i_fecha_ini,
 			@i_fecha_finc,@i_estado)

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

if @i_operacion = 'S'
begin
	set rowcount 20
	if @i_modo = 0
	begin
		select 	'FECHA INICIAL' = convert(char(12),co_fecha_ini,@i_formato_fecha),
	       		'FECHA FINAL' = convert(char(12),co_fecha_fin,@i_formato_fecha),
	 		'ESTADO' = co_estado
		from cob_conta..cb_corte
		where co_empresa = @i_empresa
		and co_periodo = @i_periodo
		and co_corte > 0
		order by co_fecha_ini
	end
	if @i_modo = 1
	begin
		select 	'FECHA INICIAL' = convert(char(12),co_fecha_ini,@i_formato_fecha),
	       		'FECHA FINAL' = convert(char(12),co_fecha_fin,@i_formato_fecha),
	 		'ESTADO' = co_estado
		from cob_conta..cb_corte
		where co_empresa = @i_empresa
		and co_periodo = @i_periodo
		and co_corte > 0
		and co_fecha_ini > @i_fecha_ini
		order by co_fecha_ini
		if @@rowcount = 0
		begin
			return 1
		end
	end
	set rowcount 0
	return 0
end

if @i_operacion = 'I'
begin
    begin tran
	if @i_tipo_periodo = 'M'
	begin
		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_corte     
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			1,@i_periodo,@i_empresa,@i_fecha_inicio,@i_fecha_fin,'M')
			
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

		select @partes = datediff(mm,@i_fecha_inicio,@i_fecha_fin) + 1
		select @fecha = @i_fecha_inicio
		select @i = 1
		while @i <= @partes
		begin
			select @fecnew1 = dateadd(mm,1,@fecha)
			select @fecnew2= dateadd(dd,-1,@fecnew1)
			select @w_partes = datediff(dd,@fecnew2,@i_fecha_fin) -- + 1
			--print 'fecha final del corte %1! final periodo %2! partes %3!', @fecnew2, @i_fecha_fin, @w_partes
			--if @fecnew2 > @i_fecha_fin
			if @w_partes < 0
			begin
				/* 'Error en la Insercion de Cortes - fecha final ' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603070
				return 1
			end
       		  	insert into cob_conta..cb_corte
			values (@i,@i_periodo,@i_empresa,@fecha,@fecnew2,'N',1)

			if @@error <> 0
			begin
				/* 'Error en la Insercion de Cortes  ' */
				exec cobis..sp_cerror
				@t_debug = @t_debug,
				@t_file	 = @t_file,
				@t_from	 = @w_sp_name,
				@i_num	 = 603018
				return 1
			end

       			select @i = @i + 1
			select @fecha = @fecnew1
		end
	end

	if @i_tipo_periodo = 'D'
	begin
		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_corte     
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			1,@i_periodo,@i_empresa,@i_fecha_inicio,@i_fecha_fin,'D')
			
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
		select @partes = datediff(dd,@i_fecha_inicio,@i_fecha_fin) + 1
		select @fecha = @i_fecha_inicio
	
		select @i = 1
       	 	insert into cob_conta..cb_corte
		values (@i,@i_periodo,@i_empresa,@fecha,@fecha,'N',1)

		select @i = 2
		while @i <= @partes
		begin
			select @fecnew1 = dateadd(dd,1,@fecha)
       		 	insert into cob_conta..cb_corte
			values (@i,@i_periodo,@i_empresa,@fecnew1,@fecnew1,'N',1)
       			select @i = @i + 1
			select @fecha = @fecnew1
		end
	end

	if @i_tipo_periodo = 'Q'
	begin
		/****************************************/
		/* TRANSACCION DE SERVICIO		*/

		insert into ts_corte     
		values (@s_ssn,@t_trn,'N',@s_date,@s_user,@s_term,@s_ofi,
			1,@i_periodo,@i_empresa,@i_fecha_inicio,@i_fecha_fin,'Q')
			
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
		select @partes = datediff(mm,@i_fecha_inicio,@i_fecha_fin) + 1
		select @fecha = @i_fecha_inicio
		select @i = 1
                while @fecha < @i_fecha_fin
		begin
                        if (select datepart(dd,@fecha)) > 15
                           begin
                           select @fecq1 = dateadd(mm,1,@fecha)
                           select @mes = datepart(dd,@fecq1)
                           select @mes = @mes * -1
                           select @fecq1 = dateadd(dd,@mes,@fecq1)   
                        end
                        else begin
                           select @mes = datepart(dd,@fecha)
                           select @mes = @mes * -1
                           select @fecq1 = dateadd(dd,@mes,@fecha)   
                           select @fecq1 = dateadd(dd,15,@fecq1)  
                        end
			select @i,@fecha,@fecq1
       		 	insert into cob_conta..cb_corte
			values (@i,@i_periodo,@i_empresa,@fecha,@fecq1,'N',1)
       			select @i = @i + 1
			select @fecha = dateadd(dd,1,@fecq1)
		end
	end
    commit tran
return 0
end

if @i_operacion = 'Q'
begin
	select @w_fecha_corte = co_fecha_ini
	from cb_corte
	where co_empresa = @i_empresa and
	co_estado = "A" 
	if @@rowcount = 0
        begin
                /* 'Corte Actual especificado no existe' */
                exec cobis..sp_cerror
                @t_debug = @t_debug,
                @t_file  = @t_file,
                @t_from  = @w_sp_name,
                @i_num   = 601079
                return 1
        end
	else
	begin
		select @w_fecha_corte
	end
end

if @i_operacion = 'F'
begin
        select convert(varchar(12),co_fecha_ini,@i_formato_fecha)
        from   cb_corte
        where  co_empresa = @i_empresa
          and  co_estado  = 'A'

        if @@rowcount = 0
                begin
                        /* 'No existen periodos' */
                        exec cobis..sp_cerror
                        @t_debug = @t_debug,
                        @t_file  = @t_file,
                        @t_from  = @w_sp_name,
                        @i_num   = 601031
                        return 1
                end
end

go
