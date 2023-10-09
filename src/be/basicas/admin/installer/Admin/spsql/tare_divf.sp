/************************************************************************/
/*	Archivo: 		ta_divf.sp	                        */
/*	Stored procedure: 	sp_tare_divf                            */
/*	Base de datos:  	cobis                                   */
/*	Producto: 		Admin                                   */
/*	Disenado por:           Nidia Elena Silva                       */
/*	Fecha de escritura: 	1996-05-20                              */
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
/*      Mantenimiento de divisas futuras                                */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		 AUTOR		   RAZON                        */
/*     21/Mayo/1996      N.Silva           Emision inicial              */
/*     16/Mayo/2000      R. Minga          RMI16May00: Adaptacion       */
/*                                         tasas referenciales ADMIN    */
/*     11-04-2016        BBO               Migracion Sybase-Sqlserver FAL*/
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_divf')
        drop proc sp_tare_divf
go

create proc sp_tare_divf (
        @s_ssn          int = null,
        @s_srv          varchar(30) = null,
        @s_lsrv         varchar(30) = null,
        @s_user         varchar(30) = null,
        @s_sesn         int = null,
        @s_ofi          smallint = null,   
        @s_term         varchar(32) = null,
        @s_date         datetime = null,
        @s_rol          smallint = null,
        @s_org          char(1) = null,
        @t_corr         char(1) = null,
        @t_debug        char(1) = 'N',
        @t_file         varchar(14) = null, 
        @t_from         varchar(32) = null,  
        @t_rty          char(1) = 'N',
        @t_trn          smallint,
        @i_operacion    char(1),
        @i_numreg       int = null,
        @i_moneda       tinyint = null,
        @i_plazo        smallint = null,   
        @i_tasacomp     money = null,   
        @i_tasaventa    money = null,
        @i_fechaini     datetime = null,
        @i_fechafin     datetime = null,
        @i_cond         char(1) = null,
        @i_fecha_proceso datetime = null,
        @i_destino      char(1) = "F",
        @o_numreg       int = null out,
        @o_moneda       tinyint = null out,
        @o_plazo        smallint = null out,   
        @o_tasacomp     money = null out,   
        @o_tasaventa    money = null out,
        @o_fechaini     datetime = null out,
        @o_fechafin     datetime = null out,
         @o_func        varchar(14) = null out, 
        @o_fecha_modificacion datetime = null out, 
        @i_formato_fecha int = 103
)
as

declare	@w_mensaje     varchar(80),
	@w_sp_name     varchar(20), 
	@w_return      smallint,
	@w_numreg      int,
        @w_date        char(10),
        @w_moneda      tinyint,
        @w_plazo       smallint,   
	@w_fechaini    datetime,
	@w_fechafin    datetime,
       @w_tasacomp   money,
       @w_tasaventa   money,
       @w_funcionario  login,
  	 @w_fecha_modificacion  datetime

select @w_sp_name='sp_tare_divf'

if (@t_trn <> 15210 and @i_operacion = "I") or
   (@t_trn <> 15211 and @i_operacion = "U") or
   (@t_trn <> 15212 and @i_operacion = "D") or
   (@t_trn <> 15213 and @i_operacion in ("S","H")) or
   (@t_trn <> 15214 and @i_operacion = "Q") 
  begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151051
	return 1
end

-- Si se trata de una insercion
if @i_operacion = "I"
begin
   -- Verificar que no existan datos para un plazo en una misma fecha
   if exists (select * 
                from te_divisa_futura
               where (  
                        (@i_fechaini <= df_fecha_inicio
                         and 
                         @i_fechafin >= df_fecha_inicio
                        ) 
                      or
		        (@i_fechaini <= df_fecha_fin
                         and 
                         @i_fechafin >= df_fecha_fin
                        ) 
                      or
		        (
                         @i_fechaini >= df_fecha_inicio
                         and 
                         @i_fechafin <= df_fecha_fin
                        )
                     )
                 and @i_plazo = df_plazo
                 and @i_moneda = df_moneda
             )
  begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151113
        return 1
  end

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_divisa_futura
	      where @i_fechafin < df_fecha_inicio
                and @i_plazo = df_plazo
                and @i_moneda = df_moneda)
   begin
     print "ALERTA: Los datos ingresados tienen un rango de fecha anterior a otro ya ingresado, sin embargo los datos seran ingresados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @i_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas a ingresar es menor a la fecha de proceso ' + @w_date + ', sin embargo los datos seran ingresados"
  end


  begin tran
	exec cobis..sp_cseqnos
		@t_debug     = null,
		@t_file      = null,
		@t_from      = @w_sp_name,
		@i_tabla     = 'te_divisa_futura',
		@o_siguiente = @w_numreg  out

	/* realizar la insercion en tasa de divisas futuras */
	insert into te_divisa_futura
		(df_num_registro,
		df_moneda,           
		df_plazo,  
		df_fecha_inicio,
		df_fecha_fin,   
		df_tasa_compra,  
		df_tasa_venta,   
		df_funcionario, 
		df_fecha_modificacion)
        values (@w_numreg, 
                @i_moneda,  
                @i_plazo,     
                @i_fechaini,
                @i_fechafin,     
                @i_tasacomp,
                @i_tasaventa,
                @s_user,       
                @s_date)   
                
	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 153049
	        rollback tran
		return 1
	end

  -- Ingresar transaccion de servicio
  insert into ts_divf (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_registro, moneda, plazo,  
         fecha_inicio, fecha_fin, tasa_compra,  
         tasa_venta, funcionario, fecha_modificacion)
  values (@s_ssn, 15210, 'N', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_numreg, @i_moneda, @i_plazo,     
       @i_fechaini, @i_fechafin, @i_tasacomp,
       @i_tasaventa, @s_user,@s_date)

  -- Si no se puede insertar la transaccion de servicio error y salir
  if @@error != 0
  begin
    exec sp_cerror 
	@t_debug= @t_debug,
	@t_file = @t_file,
	@t_from = @w_sp_name,
	@i_num  = 153023
    return 1
  end


  commit tran

  select @w_numreg
  select @s_user

  return 0 
end

-- Si se trata de una modificacion
if @i_operacion = "U"
begin


  if not exists(select *
                  from te_divisa_futura     
                 where df_num_registro = @i_numreg)
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 151114    
    return 1
  end

select @w_moneda = df_moneda,
       @w_plazo = df_plazo,
       @w_fechaini = df_fecha_inicio,
       @w_fechafin = df_fecha_fin,
       @w_tasacomp = df_tasa_compra,
       @w_tasaventa = df_tasa_venta,
       @w_funcionario = df_funcionario, 
	 @w_fecha_modificacion = df_fecha_modificacion
  from te_divisa_futura     
 where df_num_registro = @i_numreg

  -- Verificar que no existan datos para un plazo en una misma fecha
   if exists (select * 
                from te_divisa_futura
               where (  
                        (@w_fechaini <= df_fecha_inicio
                         and 
                         @w_fechafin >= df_fecha_inicio
                        ) 
                      or
		        (@w_fechaini <= df_fecha_fin
                         and 
                         @w_fechafin >= df_fecha_fin
                        ) 
                      or
		        (
                         @w_fechaini >= df_fecha_inicio
                         and 
                         @w_fechafin <= df_fecha_fin
                        )
                     )
                 and @w_plazo = df_plazo
                 and @w_moneda = df_moneda
                 and df_num_registro <> @i_numreg
             )
  begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151113
        return 1
  end

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_divisa_futura
	      where @w_fechafin < df_fecha_inicio
                and @w_plazo = df_plazo
                and @w_moneda = df_moneda)
   begin
     print "ALERTA: Los datos ingresados tienen un rango de fecha anterior a otro ya ingresado, sin embargo los datos seran ingresados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @w_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas a ingresar es menor a la fecha de proceso ' + @w_date + ', sin embargo los datos seran ingresados"
  end

  begin tran
  update te_divisa_futura    
       set df_plazo = @i_plazo,
           df_tasa_compra = @i_tasacomp, 
           df_tasa_venta = @i_tasaventa,
           df_funcionario = @s_user,
           df_fecha_inicio = @i_fechaini,
           df_fecha_fin    = @i_fechafin,
           df_fecha_modificacion = @s_date
       where df_num_registro = @i_numreg

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 155051
    return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_divf (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_registro, moneda, plazo,  
         fecha_inicio, fecha_fin, tasa_compra,  
         tasa_venta, funcionario, fecha_modificacion)
  values (@s_ssn, 15211, 'P', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @i_numreg, @w_moneda, @w_plazo,     
       @w_fechaini, @w_fechafin, @w_tasacomp,
       @w_tasaventa, @w_funcionario,@w_fecha_modificacion)

  -- Si no se puede insertar la transaccion de servicio error y salir
  if @@error != 0
  begin
    exec sp_cerror 
	@t_debug= @t_debug,
	@t_file = @t_file,
	@t_from = @w_sp_name,
	@i_num  = 153023
    return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_divf (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_registro, moneda, plazo,  
         fecha_inicio, fecha_fin, tasa_compra,  
         tasa_venta, funcionario, fecha_modificacion)
  values (@s_ssn, 15211, 'A', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @i_numreg, @w_moneda, @i_plazo,     
       @i_fechaini, @i_fechafin, @i_tasacomp,
       @i_tasaventa, @s_user,@s_date)

  -- Si no se puede insertar la transaccion de servicio error y salir
  if @@error != 0
  begin
    exec sp_cerror 
	@t_debug= @t_debug,
	@t_file = @t_file,
	@t_from = @w_sp_name,
	@i_num  = 153023
    return 1
  end

  commit tran
  return 0 
end

-- Si se trata de una eliminacion
if @i_operacion = "D"
begin

  if not exists(select *
                  from te_divisa_futura     
                 where df_num_registro = @i_numreg)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151114
    return 1
  end

select @w_moneda = df_moneda,
       @w_plazo = df_plazo,
       @w_fechaini = df_fecha_inicio,
       @w_fechafin = df_fecha_fin,
       @w_tasacomp = df_tasa_compra,
       @w_tasaventa = df_tasa_venta,
       @w_funcionario = df_funcionario, 
	 @w_fecha_modificacion = df_fecha_modificacion
  from te_divisa_futura     
 where df_num_registro = @i_numreg

  begin tran
  delete te_divisa_futura    
        where df_num_registro = @i_numreg  

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 157075
    return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_divf (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_registro, moneda, plazo,  
         fecha_inicio, fecha_fin, tasa_compra,  
         tasa_venta, funcionario, fecha_modificacion)
  values (@s_ssn, 15212, 'B', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @i_numreg, @w_moneda, @w_plazo,     
       @w_fechaini, @w_fechafin, @w_tasacomp,
       @w_tasaventa, @w_funcionario,@w_fecha_modificacion)

  -- Si no se puede insertar la transaccion de servicio error y salir
  if @@error != 0
  begin
    exec sp_cerror 
	@t_debug= @t_debug,
	@t_file = @t_file,
	@t_from = @w_sp_name,
	@i_num  = 153023
    return 1
  end

  commit tran
  return 0 
end


-- Si se trata de una busqueda especifica
if @i_operacion = "Q"
begin
 -- Seleccionar la cotización vigente
 if @i_destino = "F"
 begin
    select "NUM REG" = df_num_registro,
           "MONEDA"  = df_moneda,           
	   "PLAZO"   = df_plazo,  
	   "FECHA INI" = df_fecha_inicio,
	   "FECHA FIN" = df_fecha_fin,   
	   "TASA COM"  = df_tasa_compra,  
	   "TASA VEN"  = df_tasa_venta,   
	   "FUNC"      = df_funcionario, 
	   "FECH MOD"  = df_fecha_modificacion
   from te_divisa_futura
  where df_moneda = @i_moneda
    and df_plazo = @i_plazo
    and isnull(@i_fecha_proceso,@s_date) 
         between df_fecha_inicio
         and df_fecha_fin
 end
 else
 begin
    select @o_numreg    = df_num_registro,
           @o_moneda    = df_moneda,           
	   @o_plazo     = df_plazo,  
	   @o_fechaini  = df_fecha_inicio,
	   @o_fechafin  = df_fecha_fin,   
	   @o_tasacomp  = df_tasa_compra,  
	   @o_tasaventa = df_tasa_venta,   
	   @o_func      = df_funcionario, 
	   @o_fecha_modificacion  = df_fecha_modificacion
   from te_divisa_futura
  where df_moneda = @i_moneda
    and df_plazo = @i_plazo
    and isnull(@i_fecha_proceso,@s_date) 
         between df_fecha_inicio
         and df_fecha_fin
 end

  if @@rowcount = 0
  begin
	return 1
  end
  return 0
end

-- Si se trata de una busqueda
if @i_operacion = "S"
begin

  set rowcount 44
  select "COD. SEC" = df_num_registro,
         "COD. MON"  = df_moneda,           
         "FECHA INI"     = convert(varchar(10),df_fecha_inicio,@i_formato_fecha),
         "FECHA FIN"       = convert(varchar(10),df_fecha_fin,@i_formato_fecha),
         "TASA COMPRA"    = df_tasa_compra,
         "TASA VENTA"     = df_tasa_venta,
         "PLAZO"= df_plazo,
         "FUNCIONARIO"       = df_funcionario
  from te_divisa_futura                   

  where @i_moneda = df_moneda     
  and @i_fechaini<= df_fecha_inicio       
  and @i_fechafin >= df_fecha_fin                              
  and df_num_registro > @i_numreg   

  if @@rowcount = 0
   begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
        @t_from  = @w_sp_name,
	@i_num   = 151115
	return 1
   end
   else
 	select 44

 set rowcount 0
 return 0
end


-- Si se trata de una busqueda por fechas
if @i_operacion = "H"
begin
  set rowcount 44
  if @i_cond = "T" 
  begin
    select "COD. SEC" = df_num_registro,
         "COD. MON"  = df_moneda,           
         "FECHA INI"     = convert(varchar(10),df_fecha_inicio,@i_formato_fecha),
         "FECHA FIN"       = convert(varchar(10),df_fecha_fin,@i_formato_fecha),
         "TASA COMPRA"    = df_tasa_compra,
         "TASA VENTA"     = df_tasa_venta,
         "PLAZO"= df_plazo,
         "FUNCIONARIO"       = df_funcionario
    from te_divisa_futura                   

    where @i_moneda = df_moneda     
      and df_fecha_fin = (select max(df_fecha_fin) from te_divisa_futura   
                           where @i_moneda = df_moneda)
      and df_num_registro > @i_numreg   
  end
  else
  begin
    select "COD. SEC" = df_num_registro,
         "COD. MON"  = df_moneda,           
         "FECHA INI"     = convert(varchar(10),df_fecha_inicio,@i_formato_fecha),
         "FECHA FIN"       = convert(varchar(10),df_fecha_fin,@i_formato_fecha),
         "TASA COMPRA"    = df_tasa_compra,
         "TASA VENTA"     = df_tasa_venta,
         "PLAZO"= df_plazo,
         "FUNCIONARIO"       = df_funcionario
    from te_divisa_futura                   

    where df_num_registro > @i_numreg
  end

  if @@rowcount = 0
   begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
        @t_from  = @w_sp_name,
	@i_num   = 151115
	return 1
   end
   else
 	select 44

   set rowcount 0
   return 0
end
go




