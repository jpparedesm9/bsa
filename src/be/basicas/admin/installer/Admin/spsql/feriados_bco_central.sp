/************************************************************************/
/*      Archivo:                feriados_bco_central.sp                 */
/*      Stored procedure:       sp_feriados_bco_central                 */
/*      Base de datos:          cobis                                   */
/*      Producto:               Administracion                          */
/*      Disenado por:           Franklin Villao M.                      */
/*      Fecha de escritura:     18-Jul-2012                             */
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
/*      Insercion de dias feriados                                      */
/*      Eliminacion de dias feriados                                    */
/*      Query de dias feriados                                          */
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR             RAZON                         */
/*      18/Jul/2012     Franklin Villao   Copia del sp feriado          */
/*      01/Ago/2013     JTA	  No acepta feriados antes de fecha proceso */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_feriados_bco_central')
   drop proc sp_feriados_bco_central
go

create proc sp_feriados_bco_central(
        @s_ssn                  int = NULL,
        @s_user                 login = NULL,
        @s_sesn                 int = NULL,
        @s_term                 varchar(32) = NULL,
        @s_date                 datetime = NULL,
        @s_srv                  varchar(30) = NULL,
        @s_lsrv                 varchar(30) = NULL,
        @s_rol                  smallint = NULL,
        @s_ofi                  smallint = NULL,
        @s_org_err              char(1) = NULL,
        @s_error                int = NULL,
        @s_sev                  tinyint = NULL,
        @s_msg                  descripcion = NULL,
        @s_org                  char(1) = NULL,
        @t_debug                char(1) = 'N',
        @t_file                 varchar(14) = null,
        @t_from                 varchar(32) = null,
        @t_trn                  smallint =NULL,
        @t_show_version         bit = 0, -- Mostrar la versión del programa
        @i_operacion            varchar(1),
        @i_anio                 smallint,
        @i_mes                  tinyint,
        @i_dia                  tinyint = null,
        @i_ciudad               int = null, /* PES version Colombia */
        @i_central_transmit     varchar(1) = null,
        @i_nacional             char(1) = 'N',
		@i_nacional_real        varchar(1) ='S',
        @o_exito                tinyint = null out
)
as
declare
        @w_sp_name              varchar(30),
        @w_fecha                datetime,
        @w_cmdtransrv           varchar(60),
        @w_nt_nombre            varchar(32),
        @w_num_nodos            smallint,
        @w_contador             smallint,
        @w_clave                int,
        @w_ciudad_nacional      int,
        @w_return               int,
        @w_cod_pais             smallint,
		@w_fecha_proceso		datetime

select @w_sp_name = 'sp_feriados_bco_central'

if @t_show_version = 1
begin
    print 'Stored procedure sp_feriados_bco_central, Version 4.0.0.1'
    return 0
end

/* Carga de Ciudad Nacional para feriados Nacionales*/
select @w_ciudad_nacional = pa_smallint
        from cl_parametro
where pa_nemonico = 'CFN'

/* ** Insert ** */
if @i_operacion = 'I'
begin
if @t_trn = 15400
begin
		/* chequeo de claves principales */
		if @i_nacional ='N'
		begin
				 if (@i_anio is NULL OR @i_mes is NULL
					 OR @i_dia is NULL or @i_ciudad is NULL )
				 begin
						 /* 'No se llenaron todos los campos' */
						exec sp_cerror
							 @t_debug     = @t_debug,
							 @t_file      = @t_file,
							 @t_from      = @w_sp_name,
							 @i_msg       = 'No se llenaron todos los campos',
							 @i_num       = 107151
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
						 @i_msg       = 'No se llenaron todos los campos',
						 @i_num       = 107151
					return 1
				end
		end

		/* ****************** Incidencia 2804 *************************************
		 -- chequeo de que el feriado sea posterior a la fecha actual
		 if ((@i_anio < datepart(yy,getdate())) or
			 (@i_anio = datepart(yy,getdate()) and @i_mes < datepart(mm,getdate())) or
			 (@i_anio = datepart(yy,getdate()) and @i_mes = datepart(mm,getdate())
			  and @i_dia <= datepart(dd,getdate())))
		 begin
		 -- 'Feriado es menor a la fecha actual' 
				exec sp_cerror
					 @t_debug     = @t_debug,
					 @t_file      = @t_file,
					 @t_from      = @w_sp_name,
					 @i_msg       = 'Feriado es menor a la fecha actual',
					 @i_num       = 107151
					 select @o_exito = 1
				return 1
		 end
		******************* Incidencia 2804 *********************************** */

		select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))
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

begin tran
if @i_nacional='N'
begin
        insert into cl_dias_feriados_bcocentral(df_fecha,df_ciudad,df_real)
        values     (@w_fecha, @i_ciudad,@i_nacional_real)

        if @@error != 0
        begin
		/* 'Error en insercion de dia feriado'*/
             exec sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_msg       = 'Error en insercion de dia feriado',
               @i_num       = 107151
             return 1
        end
end
else
begin

if exists (  select count (*)    from cl_dias_feriados_bcocentral where df_fecha = @w_fecha )
begin
     Delete cl_dias_feriados_bcocentral
      where df_fecha = @w_fecha
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
             @i_num       = 107151
        return 1
    end

    if exists (select * from cobis..cl_ciudad where ci_ciudad = @w_ciudad_nacional and ci_pais = @w_cod_pais)
    begin
        exec sp_cerror
             @t_debug     = @t_debug,
             @i_msg       = 'ERROR: EXISTE UNA CIUDAD CON EL MISMO CODIGO DE FERIADOS NACIONALES',
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_num       = 107151
        return 1
    end

        insert into cl_dias_feriados_bcocentral(df_fecha,df_ciudad,df_real)
        values     (@w_fecha, @w_ciudad_nacional,@i_nacional_real)

        insert into cl_dias_feriados_bcocentral(df_fecha,df_ciudad,df_real)
        select @w_fecha, ci_ciudad,@i_nacional_real
        from cl_ciudad
        where ci_pais = @w_cod_pais

        if @@error != 0
        begin
             /* 'Error en insercion de dia feriado'*/
             exec sp_cerror
               @t_debug     = @t_debug,
               @t_file      = @t_file,
               @t_from      = @w_sp_name,
               @i_msg       = 'Error en insercion de dia feriado',
               @i_num       = 107151
             return 1
        end
end

   /* transaccion de servicio */
   insert into ts_feriados_bcocentral (secuencia, tipo_transaccion, clase, fecha,
                       oficina_s, usuario, terminal_s, srv, lsrv,
                       feriado)
               values (@s_ssn, 15400, 'N', @s_date,
                       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                       @w_fecha)
   if @@error != 0
   begin
        /*  'Error en creacion de transaccion de servicio' */
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg       = 'Error en creacion de transaccion de servicio',
           @i_num       = 107151
        return 1
   end

  commit tran

   select @o_exito=0
   return 0
end
else
begin
        /*  'No corresponde codigo de transaccion' */
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg       = 'No corresponde codigo de transaccion',
           @i_num       = 107151

        return 1
end
end



/* ** Delete **/
if @i_operacion = 'D'
begin
if @t_trn = 15401
begin
 /* chequeo de claves principales */
  if (@i_anio is NULL OR @i_mes is NULL OR @i_dia is NULL)
  begin
        /*  'No se llenaron todos los campos' */
        exec sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_msg       = 'No se llenaron todos los campos',
             @i_num       = 107151
        return 1
  end

if @i_nacional='N'
begin
  select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))

  select df_fecha
    from cl_dias_feriados_bcocentral
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
             @i_msg       = 'No existe la fecha ingresada',
             @i_num       = 107151
        return 1
  end

  select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))

  select df_fecha
    from cl_dias_feriados_bcocentral
   where df_fecha = @w_fecha

  if @@rowcount= 0
  begin
        /*  'No existe la fecha ingresada' */
        exec sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_msg       = 'No existe la fecha ingresada',
             @i_num       = 107151
        return 1
  end
end
else
begin
    /*28/jun/1999 Se asigna a una variable de tipo fecha la conversion de la fecha antes de hacer
      la comparacion en la condici¢n where.  Cambio por migracion a SQLServer*/
  select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))

  select df_fecha
    from cl_dias_feriados_bcocentral
   where df_fecha = @w_fecha

  if @@rowcount= 0
  begin
        /*  'No existe la fecha ingresada' */
        exec sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_msg       = 'No existe la fecha ingresada',
             @i_num       = 107151
        return 1
  end
end

/* ****************** Incidencia 2804 *************************************
 -- chequeo de que el feriado sea posterior a la fecha actual
 if ((@i_anio < datepart(yy,getdate())) or
     (@i_anio = datepart(yy,getdate()) and @i_mes < datepart(mm,getdate())) or
     (@i_anio = datepart(yy,getdate()) and @i_mes = datepart(mm,getdate())
      and @i_dia <= datepart(dd,getdate())))
 begin
        select @o_exito = 1

        --'Feriado es menor a la fecha actual' 
        exec sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_msg       = 'Feriado es menor a la fecha actual',
             @i_num       = 107151
        return 1
 end
******************* Incidencia 2804 *********************************** */
select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))
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
/* borrado de la fecha */
  begin tran

if @i_nacional='N'
begin
    select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))

    Delete cl_dias_feriados_bcocentral
      where df_fecha = @w_fecha
        and df_ciudad = @i_ciudad --CNA 27/12/2001

   if @@error != 0
   begin
     /*  'Error en eliminacion de fecha' */
     exec sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_msg       = 'Error en eliminacion de fecha',
             @i_num       = 107151
     return 1
   end
end
else
begin

    select @w_fecha = convert(datetime,(convert(char(2),@i_mes)+'/'+convert(char(2),@i_dia)+'/'+convert(char(4),@i_anio)))

    Delete cl_dias_feriados_bcocentral
      where df_fecha = @w_fecha

   if @@error != 0
   begin
     /*  'Error en eliminacion de fecha' */
     exec sp_cerror
             @t_debug     = @t_debug,
             @t_file      = @t_file,
             @t_from      = @w_sp_name,
             @i_msg       = 'Error en eliminacion de fecha',
             @i_num       = 107151
     return 1
   end
end

/* transaccion de servicio */
   insert into ts_feriados_bcocentral (secuencia, tipo_transaccion, clase, fecha,
                       oficina_s, usuario, terminal_s, srv, lsrv,
                       feriado)
               values (@s_ssn, 15401, 'B', @s_date,
                       @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
                       @w_fecha)
   if @@error != 0
   begin
        /*  'Error en creacion de transaccion de servicio' */
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg       = 'Error en creacion de transaccion de servicio',
           @i_num       = 107151
        return 1
   end
 commit tran

 select @o_exito=0

 return 0
end
else
   begin
        /*  'No corresponde codigo de transaccion' */
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg       = 'No corresponde codigo de transaccion',
           @i_num       = 107151
        return 1
    end
end

/* ** Query ** */
if @i_operacion = 'Q'
begin
If @t_trn = 15402
begin
if @i_nacional='N'
begin
        select  datepart(dd,df_fecha)
         from   cl_dias_feriados_bcocentral
        where   datepart(yy,df_fecha) = @i_anio
          and   datepart(mm,df_fecha)  = @i_mes
          and   df_ciudad              = @i_ciudad
end
else
begin
        select  datepart(dd,df_fecha)
         from   cl_dias_feriados_bcocentral
        where   datepart(yy,df_fecha) = @i_anio
          and   datepart(mm,df_fecha)  = @i_mes
          and   df_ciudad              = @w_ciudad_nacional
end

 return 0
end
else
    begin
        /*  'No corresponde codigo de transaccion' */
        exec sp_cerror
           @t_debug      = @t_debug,
           @t_file       = @t_file,
           @t_from       = @w_sp_name,
           @i_msg       = 'No corresponde codigo de transaccion',
           @i_num       = 107151
        return 1
    end
end

go
