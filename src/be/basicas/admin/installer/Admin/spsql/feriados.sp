/************************************************************************/
/*      Archivo:                feriados.sp                             */
/*      Stored procedure:       sp_feriados                             */
/*      Base de datos:          cobis                                   */
/*      Producto: Administracion                                        */
/*      Disenado por:  Mauricio Bayas/Sandra Ortiz                      */
/*      Fecha de escritura: 22-Dic-1993                                 */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA', representantes exclusivos para el Ecuador de la       */
/*      'NCR CORPORATION'.                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/*                              PROPOSITO                               */
/*      Este programa procesa las transacciones de:                     */
/*      Insercion de dias feriados                                      */
/*      Eliminacion de dias feriados                                    */
/*      Query de dias feriados                                          */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      22/Dic/1993     F. Espinosa     Emision inicial                 */
/*	25/Abr/94	F.Espinosa	Parametros tipo 'S'		*/
/*					Transacciones de Servicio	*/
/*	04/May/95	S. Vinces       Admin Distribuido  		*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_feriados')
   drop proc sp_feriados





go
create proc sp_feriados(
	@s_ssn			int = NULL,
	@s_user			login = NULL,
	@s_sesn			int = NULL,
	@s_term			varchar(32) = NULL,
	@s_date			datetime = NULL,
	@s_srv			varchar(30) = NULL,
	@s_lsrv			varchar(30) = NULL, 
	@s_rol			smallint = NULL,
	@s_ofi			smallint = NULL,
	@s_org_err		char(1) = NULL,
	@s_error		int = NULL,
	@s_sev			tinyint = NULL,
	@s_msg			descripcion = NULL,
	@s_org			char(1) = NULL,
	@t_debug		char(1) = 'N',
	@t_file			varchar(14) = null,
	@t_from			varchar(32) = null,
	@t_trn			smallint =NULL,
	@t_show_version bit = 0,
	@i_operacion            varchar(1),
	@i_anio                 smallint,
	@i_mes                  tinyint,
	@i_dia                  tinyint = null,
	@i_ciudad               int = null, /* PES version Colombia */
	@i_central_transmit     varchar(1) = null,
	@i_nacional             char(1) = 'N',
	@o_exito                tinyint = null out

)
as
declare
	@w_sp_name              varchar(30),
	@w_fecha		datetime,
	@w_cmdtransrv           varchar(60),
	@w_nt_nombre        	varchar(32),
	@w_num_nodos        	smallint,    
	@w_contador          	smallint,
	@w_clave		int,
	@w_ciudad_nacional	int,
	@w_return               int, 
	@w_cod_pais             smallint,
	@w_fecha_proceso		datetime

select @w_sp_name = 'sp_feriados'
------------------------------------------
---VERSIONAMIENTO PROGRAMA-----------------
-------------------------------------------
if @t_show_version = 1 
begin
      print 'Stored procedure sp_feriados, version 4.0.0.1'
      return 0
end

/* Carga de Ciudad Nacional para feriados Nacionales*/

select @w_ciudad_nacional = pa_smallint 
	from cl_parametro
where pa_nemonico = 'CFN'



/* ** Insert ** */
if @i_operacion = 'I'
begin
	if @t_trn = 594 
	begin
		 /* chequeo de claves principales */
		if @i_nacional ='N'
		begin
			 if (@i_anio is NULL OR @i_mes is NULL OR @i_dia is NULL or @i_ciudad is NULL )
			 begin
				/* 'No se llenaron todos los campos' */
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 151001
				return 1
			 end
		end
		else
		begin
			 if (@i_anio is NULL OR @i_mes is NULL
				 OR @i_dia is NULL)
			 begin
			 /* 'No se llenaron todos los campos' */
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 151001
				return 1
			 end
		end
		/******************* Incidencia 2804 *************************************
		  chequeo de que el feriado sea posterior a la fecha actual
		 if ((@i_anio < datepart(yy,getdate())) or
			 (@i_anio = datepart(yy,getdate()) and @i_mes < datepart(mm,getdate())) or 
			 (@i_anio = datepart(yy,getdate()) and @i_mes = datepart(mm,getdate())
			  and @i_dia <= datepart(dd,getdate())))
		 begin
		  'Feriado es menor a la fecha actual' 
			exec sp_cerror
				 @t_debug     = @t_debug,
				 @t_file      = @t_file,
				 @t_from      = @w_sp_name,
				 @i_num       = 153039
					 select @o_exito = 1
			return 1
		 end
		******************* Incidencia 2804 ************************************/
		select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))
		-- ********************************************************
		-- ROR 01/08/2012  Incidencia: 902
		select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
		
		if CAST(@w_fecha as date) <= CAST(@w_fecha_proceso as date)   
		begin
			   -- 'Error en creaci¢n de d¡a feriado, fecha menor o igual a la fecha actual' 
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 153039
						 select @o_exito = 1
				return 1
		end		
		-- ********************************************************
		begin tran

		if @i_nacional='N'
		begin
			insert into cl_dias_feriados (df_fecha,df_ciudad) values (@w_fecha, @i_ciudad)
			if @@error != 0
			begin
			/* 'Error en insercion de dia feriado'*/
				 exec sp_cerror
				   @t_debug     = @t_debug,
				   @t_file      = @t_file,
				   @t_from      = @w_sp_name,
				   @i_num       = 153039
				 return 1
			end
		end
		else
		begin
			if exists (select count (*)    from cl_dias_feriados where df_fecha = @w_fecha )
			begin
				 Delete cl_dias_feriados where df_fecha = @w_fecha
			end
			/* validacion de parametro general del pais */
			/* ADU: 20051214 */
			select @w_cod_pais = pa_smallint
			from cobis..cl_parametro
			where pa_nemonico='CP' and pa_producto='ADM'
			
			if (@w_cod_pais is null)
			begin  
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @i_msg       = 'NO EXISTE PARAMETRO DE CODIGO DE PAIS (CP)',
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 101077
				return 1
			end
			if exists (select * from cobis..cl_ciudad where ci_ciudad = @w_ciudad_nacional and ci_pais = @w_cod_pais)
			begin  
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @i_msg       = 'ERROR: EXISTE UNA CIUDAD CON EL MISMO CODIGO DE FERIADOS NACIONALES',
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 151035
				return 1
			end
			insert into cl_dias_feriados (df_fecha,df_ciudad) values (@w_fecha, @w_ciudad_nacional)

			insert into cl_dias_feriados (df_fecha,df_ciudad)
			select @w_fecha, ci_ciudad 
			from cl_ciudad
			where ci_pais = @w_cod_pais

			if @@error != 0
			begin
				/* 'Error en insercion de dia feriado'*/
				 exec sp_cerror
				   @t_debug     = @t_debug,
				   @t_file      = @t_file,
				   @t_from      = @w_sp_name,
				   @i_num       = 153039
				 return 1
			end
		end

		/* transaccion de servicio */
		insert into ts_feriados (secuencia, tipo_transaccion, clase, fecha,
					   oficina_s, usuario, terminal_s, srv, lsrv,
					   feriado)
				values (@s_ssn, 594, 'N', @s_date,
					   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
						   @w_fecha)
		if @@error != 0
		begin
			/*  'Error en creacion de transaccion de servicio' */
			exec sp_cerror
			   @t_debug	 = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 153023
			return 1
		end
		commit tran

		select @o_exito=0
		return 0
	end
	else
	begin
		exec sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 151051
		   /*  'No corresponde codigo de transaccion' */
		return 1
	end
end



/* ** Delete **/

if @i_operacion = 'D'   
begin
	if @t_trn = 595
	begin
	/* chequeo de claves principales */
	if (@i_anio is NULL OR @i_mes is NULL OR @i_dia is NULL)
	begin
		/*'No se llenaron todos los campos' */
		exec sp_cerror
			@t_debug     = @t_debug,
			@t_file      = @t_file,
			@t_from      = @w_sp_name,
			@i_num       = 151001
		return 1
		end

		if @i_nacional='N'
		begin
			select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))
			select df_fecha
			from cl_dias_feriados
			where df_fecha = @w_fecha
			 and df_ciudad=@w_ciudad_nacional
  
			if @@rowcount <> 0
			begin
				select @o_exito=1
				/*  'No existe la fecha ingresada' */
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 189000
				return 1
			end

			select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))
			select df_fecha
			from cl_dias_feriados
			where df_fecha = @w_fecha
  
			if @@rowcount= 0
			begin
				/*'No existe la fecha ingresada' */
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 151002
				return 1
			end
		end
		else
		begin
			/*28/jun/1999 Se asigna a una variable de tipo fecha la conversion de la fecha antes de hacer
			la comparacion en la condici¢n where.  Cambio por migracion a SQLServer*/
			select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))
			select df_fecha
			from cl_dias_feriados
			where df_fecha = @w_fecha

			if @@rowcount= 0
			begin
				/*  'No existe la fecha ingresada' */
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 151002
				return 1
			end
		end

		/******************* Incidencia 2804 *************************************
		  chequeo de que el feriado sea posterior a la fecha actual
		 if ((@i_anio < datepart(yy,getdate())) or
			 (@i_anio = datepart(yy,getdate()) and @i_mes < datepart(mm,getdate())) or 
			 (@i_anio = datepart(yy,getdate()) and @i_mes = datepart(mm,getdate())
			  and @i_dia <= datepart(dd,getdate())))
		 begin

			select @o_exito = 1
		  'Feriado es menor a la fecha actual' 
			exec sp_cerror
				 @t_debug     = @t_debug,
				 @t_file      = @t_file,
				 @t_from      = @w_sp_name,
				 @i_num       = 101154
			return 1
		 end
		******************* Incidencia 2804 ************************************/
		-- ********************************************************
		-- ROR 01/08/2012 Incidencia: 902
		select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))  
		select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso	
		if CAST(@w_fecha as date) <= CAST(@w_fecha_proceso as date)   
		begin
		 --'Error en actualizaci¢n de d¡a feriado, fecha menor o igual a la fecha actual' 
			exec sp_cerror
				 @t_debug     = @t_debug,
				 @t_file      = @t_file,
				 @t_from      = @w_sp_name,
				 @i_num       = 101154
			return 1
		 end		 
		-- ********************************************************

		/* borrado de la fecha */
		begin tran

		if @i_nacional='N'
		begin
			select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))   
			delete cl_dias_feriados
			where df_fecha = @w_fecha
			and df_ciudad = @i_ciudad --CNA 27/12/2001
		   
			if @@error != 0
			begin
				/*'Error en eliminacion de fecha' */
				 exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 157001
				 return 1
			end
		end
		else
		begin
			select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))   
			Delete cl_dias_feriados
			where df_fecha = @w_fecha
 			if @@error != 0
			begin
				/*'Error en eliminacion de fecha' */
				 exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_num       = 157001
				 return 1
			end
		end 
		
		/* transaccion de servicio */
		insert into ts_feriados (secuencia, tipo_transaccion, clase, fecha,
				   oficina_s, usuario, terminal_s, srv, lsrv,
				   feriado)
			   values (@s_ssn, 595, 'B', @s_date,
				   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,	
				   @w_fecha)
		if @@error != 0
		begin
			/*  'Error en creacion de transaccion de servicio' */
			exec sp_cerror
			   @t_debug	 = @t_debug,
			   @t_file	 = @t_file,
			   @t_from	 = @w_sp_name,
			   @i_num	 = 153023
			return 1
		end
		commit tran

		select @o_exito=0
		return 0
	end
	else
	begin
		exec sp_cerror
		@t_debug	 = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151051
		/*  'No corresponde codigo de transaccion' */
		return 1
	end
end




/* ** Query ** */
if @i_operacion = 'Q'
begin
	If @t_trn = 15000
	begin
		if @i_nacional='N'
		begin
			select  datepart(dd,df_fecha)
			 from   cl_dias_feriados
			where   datepart(yy,df_fecha) = @i_anio
			  and   datepart(mm,df_fecha)  = @i_mes
			  and   df_ciudad              = @i_ciudad
		end
		else
		begin
			select  datepart(dd,df_fecha)
			 from   cl_dias_feriados
			where   datepart(yy,df_fecha) = @i_anio
			  and   datepart(mm,df_fecha)  = @i_mes
			  and   df_ciudad              = @w_ciudad_nacional
		end
		return 0
	end
	else
    begin
		exec sp_cerror
		   @t_debug	 = @t_debug,
		   @t_file	 = @t_file,
		   @t_from	 = @w_sp_name,
		   @i_num	 = 151051
		   /*  'No corresponde codigo de transaccion' */
		return 1
    end
end
go

