/************************************************************************/
/*	Archivo: 		ta_divd.sp	                        */
/*	Stored procedure: 	sp_tare_divd                     	*/
/*	Base de datos:  	cobis                                   */
/*	Producto: 		Admin                                   */
/*	Disenado por:           Nidia Elena Silva                       */
/*	Fecha de escritura: 	1996-05-22                              */
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
/*      Mantenimiento y consulta de divisas diarias                     */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		 AUTOR		  RAZON                         */
/*     22/Mayo/1996      N.Silva          Emision inicial               */
/*     16/May0/2000      R.Minga          RMI16May00: Adaptacion tasas  */
/*                                        referenciales ADMIN           */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_divd')
        drop proc sp_tare_divd
go


create proc sp_tare_divd (
        @s_ssn          int = null,
        @s_srv          varchar(30) = null,
        @s_lsrv         varchar(30) = null,
        @s_user         varchar(30) = null,
        @s_sesn         int = null,
        @s_ofi          smallint = null,   
        @s_term         varchar(10) = null,
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
        @i_moneda       tinyint = null, 
        @i_mercado      tinyint = null,    
        @i_tasacomp     money = null,   
        @i_tasaventa    money = null,    
        @i_tascoch	money = null, 
        @i_tasvech      money = null,
        @i_cosint       money = null,
        @i_numtasa      int = null,
        @i_cond         char(1) = null,
        @i_fechaini     datetime = null,
        @i_fechafin     datetime = null,
        @i_fecha_proceso datetime = null,
        @i_destino      char(1) = "F",
        @o_moneda       tinyint = null out, 
        @o_mercado      tinyint = null out,    
        @o_tasacomp     money = null out,   
        @o_tasaventa    money = null out,    
        @o_tascoch	money = null out, 
        @o_tasvech      money = null out,
        @o_cosint       money = null out,
        @o_numtasa      int = null out,
        @o_fecha        datetime = null out,
        @o_hora         datetime = null out,
        @i_formato_fecha int = 103
)
as

declare	@w_sp_name      varchar(20),
	@w_return      smallint,
	@w_fecha_char  varchar(10),
	@w_hora        varchar(8),  
	@w_maxfecha    datetime,
	@w_maxhora     datetime,
	@w_numtasa     int,
	@w_actu        char(1),
        @w_borro       char(1),
	@w_fecha       datetime,
      @w_moneda       tinyint, 
      @w_mercado      tinyint,    
      @w_tasacomp     money,   
      @w_tasaventa    money,    
      @w_tascoch	money, 
      @w_tasvech      money,
      @w_cosint       money


select @w_sp_name='sp_tare_divd'

if (@t_trn <> 15205 and @i_operacion = "I") or
   (@t_trn <> 15206 and @i_operacion = "U") or
   (@t_trn <> 15207 and @i_operacion = "D") or
   (@t_trn <> 15208 and @i_operacion in ("S","H")) or
   (@t_trn <> 15209 and @i_operacion = "Q") 
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
  select @w_hora = convert(varchar(8),getdate(),108)
  select @w_fecha_char = convert(varchar(10),getdate(),@i_formato_fecha)

  /* buscar fecha max en tabla cotizaciones */
  select @w_maxfecha = max(td_fecha)
    from te_tasa_divisas
   where td_moneda = @i_moneda
     and td_cod_mercado = @i_mercado

  if @@rowcount != 0
  begin
	/* buscar hora max en tabla cotizaciones */
	select	@w_maxhora = max(td_hora)
	from	te_tasa_divisas
	where	td_moneda = @i_moneda
	and	td_cod_mercado = @i_mercado
	and	td_fecha = @w_maxfecha

	/* Analizar que no se repita la ultima tasa de divisas */
	if exists (select * 
		from	te_tasa_divisas
		where	td_moneda  = @i_moneda
		and	td_cod_mercado = @i_mercado
		and	td_tasa_compra = @i_tascoch 
		and	td_tasa_venta = @i_tasvech
		and	td_tasa_compra_billete = @i_tasacomp
		and	td_tasa_venta_billete = @i_tasaventa
		and	td_costo_interno = @i_cosint
		and	td_fecha = @w_maxfecha
		and	td_hora = @w_maxhora)
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 151111
		return 1
	end
  end

  begin tran
	/* obtener un nuevo secuencial */
	exec cobis..sp_cseqnos
        	@t_debug     = @t_debug,
	        @t_file      = @t_file,
        	@t_from      = @w_sp_name,
		@i_tabla     = 'te_tasa_divisas',
        	@o_siguiente = @w_numtasa     out

	insert into te_tasa_divisas
		(td_num_tasa, 
            td_moneda,           
		td_cod_mercado,
		td_fecha,      
		td_hora,        
		td_tasa_compra_billete,  
		td_tasa_venta_billete,    
		td_tasa_compra, 
		td_tasa_venta,
		td_costo_interno) 
        values	(@w_numtasa,
                @i_moneda,    
                @i_mercado,   
                getdate(),         
                convert(varchar(10),getdate(),101)+ ' ' + convert(varchar(10),getdate(),108),   
                @i_tasacomp,   
                @i_tasaventa,
		@i_tascoch, 
	   	@i_tasvech,
       	   	@i_cosint)

	if @@error <> 0
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file	 = @t_file,
			@t_from	 = @w_sp_name,
			@i_num	 = 153048
        	rollback tran
	        return 1
	end


  -- Ingresar transaccion de servicio
  insert into ts_divd (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_tasa, moneda, cod_mercado, fecha_ing,      
         hora, 
         tasa_compra_billete, tasa_venta_billete,    
         tasa_compra, tasa_venta, costo_interno)
  values (@s_ssn, 15205, 'N', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_numtasa, @i_moneda, @i_mercado, getdate(),         
       convert(varchar(10),getdate(),101)+ ' ' + convert(varchar(10),getdate(),108),   
       @i_tasacomp, @i_tasaventa,
       @i_tascoch, @i_tasvech, @i_cosint)

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

  select @w_hora    
  select @w_fecha_char
  select @w_numtasa

  return 0 
end

-- Si se trata de una modificacion
if @i_operacion = "U"
begin
  if not exists(select *
       from te_tasa_divisas      
       where td_num_tasa = @i_numtasa)
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 155050
    return 1
  end

 select @w_moneda  = td_moneda,           
        @w_mercado = td_cod_mercado,
        @w_fecha   = td_fecha,      
        @w_hora    = td_hora,        
	  @w_tasacomp= td_tasa_compra_billete,  
        @w_tasaventa = td_tasa_venta_billete,    
        @w_tascoch = td_tasa_compra, 
        @w_tasvech = td_tasa_venta,
	  @w_cosint = td_costo_interno
   from te_tasa_divisas
  where td_num_tasa = @i_numtasa

  begin tran
  update te_tasa_divisas     
       set td_fecha = getdate(),
           td_hora = getdate(), 
           td_tasa_compra_billete = @i_tasacomp,
	   td_tasa_venta_billete = @i_tasaventa,
	   td_tasa_compra = @i_tascoch, 
	   td_tasa_venta = @i_tasvech,
       	   td_costo_interno  = @i_cosint
       where td_num_tasa = @i_numtasa and td_fecha = @s_date
       and td_hora = (select max(td_hora) from te_tasa_divisas 
					  where td_num_tasa = @i_numtasa 
					  and td_fecha = @s_date)

  /* Toma el numero total de registros actualizados */
  if @@rowcount = 0
    select @w_actu = "N"
  else
    select @w_actu = "S"    

   select @w_actu

  -- Ingresar transaccion de servicio
  insert into ts_divd (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_tasa, moneda, cod_mercado, fecha_ing,      
         hora, 
         tasa_compra_billete, tasa_venta_billete,    
         tasa_compra, tasa_venta, costo_interno)
  values (@s_ssn, 15206, 'P', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_numtasa, @w_moneda, @w_mercado, @w_fecha,         
       @w_hora,
       @w_tasacomp, @w_tasaventa,
       @w_tascoch, @w_tasvech, @w_cosint)

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
  insert into ts_divd (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_tasa, moneda, cod_mercado, fecha_ing,      
         hora, 
         tasa_compra_billete, tasa_venta_billete,    
         tasa_compra, tasa_venta, costo_interno)
  values (@s_ssn, 15206, 'A', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_numtasa, @w_moneda, @w_mercado, getdate(),         
       getdate(),
       @i_tasacomp, @i_tasaventa,
       @i_tascoch, @i_tasvech, @i_cosint)

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

 select @w_moneda  = td_moneda,           
        @w_mercado = td_cod_mercado,
        @w_fecha   = td_fecha,      
        @w_hora    = td_hora,        
	  @w_tasacomp= td_tasa_compra_billete,  
        @w_tasaventa = td_tasa_venta_billete,    
        @w_tascoch = td_tasa_compra, 
        @w_tasvech = td_tasa_venta,
	  @w_cosint = td_costo_interno
   from te_tasa_divisas
  where td_num_tasa = @i_numtasa

  begin tran
  delete te_tasa_divisas    
       where td_num_tasa = @i_numtasa  
	     and td_fecha = @s_date

  if @@rowcount = 0
    select @w_borro = "N"
  else
    select @w_borro = "S"

  select @w_borro

  -- Ingresar transaccion de servicio
  insert into ts_divd (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         num_tasa, moneda, cod_mercado, fecha_ing,      
         hora, 
         tasa_compra_billete, tasa_venta_billete,    
         tasa_compra, tasa_venta, costo_interno)
  values (@s_ssn, 15207, 'B', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_numtasa, @w_moneda, @w_mercado, @w_fecha,         
       @w_hora,
       @w_tasacomp, @w_tasaventa,
       @w_tascoch, @w_tasvech, @w_cosint)

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
  /* buscar fecha max en tabla cotizaciones */
  select @w_maxfecha = max(td_fecha)
    from te_tasa_divisas
   where td_moneda = @i_moneda
     and td_cod_mercado = isnull(@i_mercado,1)
     and datediff(dd,td_fecha,isnull(@i_fecha_proceso, @s_date)) >= 0

 select @w_maxhora = max(td_hora)
   from te_tasa_divisas
  where td_moneda = @i_moneda
    and td_cod_mercado = isnull(@i_mercado,1)
    and datediff(dd,td_fecha,@w_maxfecha) = 0
    and datediff(ss,td_fecha,isnull(@i_fecha_proceso, @s_date)) >= 0

 -- Seleccionar la cotizacion vigente
 if @i_destino = "F"
 begin
   select "NUM TASA" = td_num_tasa, 
	  "MONEDA"   = td_moneda,           
          "MERCADO"  = td_cod_mercado,
          "FECHA"    = td_fecha,      
          "HORA"     = td_hora,        
	  "TASA COM" = td_tasa_compra_billete,  
          "TASA VEN" = td_tasa_venta_billete,    
          "T COM CH" = td_tasa_compra, 
          "T VEN CH" = td_tasa_venta,
	  "COS INT"  = td_costo_interno
     from te_tasa_divisas
    where td_moneda = @i_moneda
      and td_cod_mercado = isnull(@i_mercado,1)
      and datediff(dd,td_fecha,@w_maxfecha) = 0
      and datediff(ss,td_hora,@w_maxhora) = 0
  end
  else
  begin
   select @o_numtasa = td_num_tasa, 
	  @o_moneda  = td_moneda,           
          @o_mercado = td_cod_mercado,
          @o_fecha   = td_fecha,      
          @o_hora    = td_hora,        
	  @o_tasacomp= td_tasa_compra_billete,  
          @o_tasaventa = td_tasa_venta_billete,    
          @o_tascoch = td_tasa_compra, 
          @o_tasvech = td_tasa_venta,
	  @o_cosint = td_costo_interno
     from te_tasa_divisas
    where td_moneda = @i_moneda
      and td_cod_mercado = isnull(@i_mercado,1)
      and td_fecha = @w_maxfecha
      and td_hora = @w_maxhora
  end

  if @@rowcount = 0
  begin
 select @o_numtasa = null, 
	  @o_moneda  = null,           
        @o_mercado = null,
        @o_fecha   = null,      
        @o_hora    = null,        
	  @o_tasacomp= null,  
        @o_tasaventa = null,    
        @o_tascoch = null, 
        @o_tasvech = null,
	  @o_cosint = null
	return 1
  end
  return 0
end

-- Si se trata de una busqueda
if @i_operacion = "S"
begin
  set rowcount 46

  if @i_cond = "T"
  begin
    select @w_fecha = td_fecha
      from te_tasa_divisas
     where td_fecha = (select max(td_fecha) from te_tasa_divisas
                        where (td_moneda = @i_moneda or @i_moneda is null)
                          and (td_cod_mercado = @i_mercado or @i_mercado is null))
  
     select "COD. SEC" = td_num_tasa,
            "COD. MON"  = td_moneda,           
            "COD. MERC" = td_cod_mercado,
            "FECHA"             = convert(varchar(10),td_fecha,@i_formato_fecha),
            "HORA"              = convert(varchar(10),td_hora,108),
            "COTZ BILL COMP"    = td_tasa_compra_billete,
            "COTZ BILL VENT"    = td_tasa_venta_billete,
            "COTZ CHE COMP"     = td_tasa_compra,
            "COTZ CHE VENT"     = td_tasa_venta,
            "COSTO INT"         = td_costo_interno
    from te_tasa_divisas
    where td_num_tasa > @i_numtasa      
    and (td_moneda = @i_moneda or @i_moneda is null)
    and (td_cod_mercado = @i_mercado or @i_mercado is null) /* = NULL)*/
    and td_fecha = @w_fecha
    and td_hora = (select max(td_hora) from te_tasa_divisas
                    where (td_moneda = @i_moneda or @i_moneda is null)
                      and (td_cod_mercado = @i_mercado or @i_mercado is null)
                      and (td_fecha = @w_fecha))

  end
  else
  begin
    select distinct "COD. SEC" = td_num_tasa,
           "COD. MON"  = td_moneda,           
           "COD. MERC" = td_cod_mercado,  
           "FECHA"             = convert(varchar(10),td_fecha,@i_formato_fecha),
           "HORA"              = convert(varchar(10),td_hora,108),
           "COTZ BILL COMP"    = td_tasa_compra_billete,
           "COTZ BILL VENT"    = td_tasa_venta_billete,
           "COTZ CHE COMP"     = td_tasa_compra,
           "COTZ CHE VENT"     = td_tasa_venta,
           "COSTO INT"         = td_costo_interno
    from te_tasa_divisas
    where td_num_tasa > @i_numtasa
  end

  if @@rowcount = 0
   begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
        @t_from  = @w_sp_name,

	@i_num   = 151112
	return 1
   end
   else
 	select 46

  set rowcount 0
  return 0
  end

-- Si se trata de una busqueda por fechas
if @i_operacion = "H"
begin

  set rowcount 46

  select distinct 
	  "COD. SEC"		= td_num_tasa,
	  "COD. MON"		= td_moneda,
	  "COD. MERC"		= td_cod_mercado,  
	  "FECHA"		= convert(varchar(10),td_fecha,@i_formato_fecha),
	  "HORA"		= convert(varchar(10),td_hora,108),
	  "COTZ BILL COMP"	= td_tasa_compra_billete,
	  "COTZ BILL VENT"	= td_tasa_venta_billete,
	  "COTZ CHE COMP"	= td_tasa_compra,
	  "COTZ CHE VENT"	= td_tasa_venta,
	  "COSTO INT"	        = td_costo_interno
  from	te_tasa_divisas
  where	td_num_tasa >= @i_numtasa      
  and	(td_fecha >= @i_fechaini or @i_fechaini = null) 
  and	(td_fecha <= @i_fechafin or @i_fechafin = null)
  and	(@i_moneda = td_moneda or @i_moneda = null) 
  and	(@i_mercado = td_cod_mercado or @i_mercado = null)                                

  /* En caso de que no existan registros en la tabla */
  if @@rowcount = 0
  begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
        	@t_from  = @w_sp_name,
		@i_num   = 151112
	return 1
  end
  else
	select 46

  set rowcount 0

  return 0
end
go
