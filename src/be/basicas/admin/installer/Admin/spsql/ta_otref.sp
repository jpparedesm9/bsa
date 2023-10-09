/************************************************************************/
/*	Archivo: 		ta_otref.sp	                        */
/*	Stored procedure: 	sp_tare_otras_referencias          	*/
/*	Base de datos:  	cobis                                   */
/*	Producto: 		ADMIN                                   */
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
/*	Este SP mantiene y consulta los datos de la pesta¤a Otras       */
/*      Referencias en la pantalla de Pizarra.                          */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		 AUTOR		       RAZON			*/
/*    22/Mayo/1996   Nidia Elena Silva     Emision inicial              */
/*    16/Mayo/2000   Roberth Minga V.      RMI16May00: Adaptacion de    */
/*                                         tasas referenciales a ADMIN  */
/************************************************************************/
use cobis
go


if exists (select * from sysobjects where name = 'sp_tare_otras_referencias')
        drop proc sp_tare_otras_referencias
go


create proc sp_tare_otras_referencias(
        @s_ssn          int = null,
        @s_srv          varchar(30) = null,
        @s_lsrv         varchar(30) = null,
        @s_user         varchar(30) = null,
        @s_sesn         int= null,
        @s_ofi          smallint = null,     /* Localidad origen transaccion */
        @s_term         varchar(10) = null,
        @s_date         datetime = null,
        @s_rol          smallint = null,
        @s_org          char(1) = null,
        @t_debug        char(1) = 'N',
        @t_file         varchar(14) = null, 
        @t_from         varchar(32) = null,  
        @t_rty          char(1) = 'N',
        @t_trn          smallint,
        @i_operacion    char(1),
        @i_codpizarra   int = null,
        @i_moneda       tinyint = null, 
	@i_cond		char(1) = null,
        @i_tipo_ref     catalogo = null,
        @i_valor        float = null,      
        @i_fechaini     datetime = null,
        @i_fechafin     datetime = null,
        @i_referencia   catalogo = null,
        @i_periodo      smallint = null,
        @i_modalidad    char(1) = null,
        @i_tipovalor    char(1) = null,
        @i_tipotasa     char(1) = null,
        @i_rango_desde  smallint = null,
        @i_rango_hasta  smallint = null,
        @i_dias         smallint = null,
        @i_fecha_proceso datetime = null,
        @i_formato_fecha int = 103,
        @i_destino      char(1) = "F",
        @o_codpizarra   int = null out,
        @o_moneda       tinyint = null out,           
        @o_referencia   catalogo = null out,    
        @o_periodo      smallint = null out,
        @o_modalidad    char(1) = null out,
        @o_rango_desde  smallint = null out,
        @o_rango_hasta  smallint = null out,
        @o_valor        float = null out,
        @o_fechaini     datetime = null out,
        @o_fechafin     datetime = null out,
        @o_tipovalor    char(1) = null out,
        @o_tipotasa     char(1) = null out

)
as

declare @w_sp_name     varchar(20),  /* nombre del sp para debug */
        @w_return      smallint,
        @w_pizarra     int,
        @w_date_inf    datetime,
        @w_date_sup    datetime,
        @w_rango_inf   smallint,
        @w_rango_sup   smallint,
        @w_rango       char(1),
        @w_referencia  catalogo,
        @w_periodo     smallint,
        @w_modalidad   char(1),
        @w_date        char(10),
        @w_valor       float,
        @w_fechaini    datetime,
        @w_fechafin    datetime,      
        @w_tipovalor   char(1),
        @w_tipotasa    char(1),
        @w_rango_desde smallint,
        @w_rango_hasta smallint,
        @w_moneda      tinyint

select @w_sp_name='sp_tare_otras_referencias'

/***************************/
/*  Tipo de Transaccion    */
/***************************/

if (@t_trn <> 15195 and @i_operacion = "I") or
   (@t_trn <> 15196 and @i_operacion = "U") or
   (@t_trn <> 15197 and @i_operacion = "D") or
   (@t_trn <> 15194 and @i_operacion = "S") or
   (@t_trn <> 15198 and @i_operacion = "H") or
   (@t_trn <> 15199 and @i_operacion = "Q") 
begin

	/* 'Tipo de transaccion no corresponde' */

	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151051 	
	return 1
end

-- Limites para cuando se dan campos nulos
select @w_date_inf = "01/01/1753",
       @w_date_sup = "12/31/9999",
       @w_rango_inf = 1,
       @w_rango_sup = 32767

-- Si se trata de una insercion de otras referencias
if @i_operacion = "I"
begin

  -- Analizar si la referencia acepta rango multiple o unico 
  select @w_rango = ca_rango
    from te_caracteristicas_tasa
   where ca_tasa = @i_referencia
     and ca_periodo = @i_periodo
     and ca_modalidad = @i_modalidad

  if @w_rango = null
  begin
  	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151102
        return 1
  end

  -- Si la referencia acepta rango multiple (varios rangos)
  if @w_rango = "M"
  begin   
     
     -- Analizar que el rango de fechas de vigencia aun no exista con un rango de dias
     -- ya ingresado para la tasa referencial 
     if exists (select * 
	  from te_pizarra 
	  where (  
                 (
                  isnull(@i_fechaini,@w_date_inf) 
                        <= isnull(pi_fecha_inicio,@w_date_inf)
                  and 
                  isnull(@i_fechafin,@w_date_sup) 
                        >= isnull(pi_fecha_inicio,@w_date_inf)
                  ) 
                or
		  (
                   isnull(@i_fechaini,@w_date_inf) 
                        <= isnull(pi_fecha_fin,@w_date_sup)
                   and 
                   isnull(@i_fechafin,@w_date_sup)
                        >= isnull(pi_fecha_fin,@w_date_sup)
                  ) 
                or
		  (
                   isnull(@i_fechaini,@w_date_inf)
                        >= isnull(pi_fecha_inicio,@w_date_inf)
                   and 
                   isnull(@i_fechafin,@w_date_sup) 
                        <= isnull(pi_fecha_fin,@w_date_sup)
                  )
                )
	    and (  
                 (
                  isnull(@i_rango_desde,@w_rango_inf) 
                        <= isnull(pi_rango_desde,@w_rango_inf)
                  and 
                  isnull(@i_rango_hasta,@w_rango_sup) 
                        >= isnull(pi_rango_desde,@w_rango_inf)
                  ) 
                or
		  (
                   isnull(@i_rango_desde,@w_rango_inf) 
                        <= isnull(pi_rango_hasta,@w_rango_sup)
                   and 
                   isnull(@i_rango_hasta,@w_rango_sup)
                        >= isnull(pi_rango_hasta,@w_rango_sup)
                  ) 
                or
		  (
                   isnull(@i_rango_desde,@w_rango_inf)
                        >= isnull(pi_rango_desde,@w_rango_inf)
                   and 
                   isnull(@i_rango_hasta,@w_rango_sup) 
                        <= isnull(pi_rango_hasta,@w_rango_sup)
                  )
                ) 
  	  and   pi_referencia = @i_referencia
          and   pi_periodo = @i_periodo
          and   pi_modalidad = @i_modalidad
	  and   pi_tipo_tasa = @i_tipotasa
	  and   pi_moneda = @i_moneda)
     begin
  	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151105
        return 1
     end
  end  
  -- Si la referencia acepta solo rango unico
  else 
  begin   
    -- Analizar que no exista una tasa ingresada para la
    -- tasa referencial que se desea ingresar en un rango de fechas dado
     if exists (select * 
	  from te_pizarra 
	  where (  
                 (
                  isnull(@i_fechaini,@w_date_inf) 
                        <= isnull(pi_fecha_inicio,@w_date_inf)
                  and 
                  isnull(@i_fechafin,@w_date_sup) 
                        >= isnull(pi_fecha_inicio,@w_date_inf)
                  ) 
                or
		  (
                   isnull(@i_fechaini,@w_date_inf) 
                        <= isnull(pi_fecha_fin,@w_date_sup)
                   and 
                   isnull(@i_fechafin,@w_date_sup)
                        >= isnull(pi_fecha_fin,@w_date_sup)
                  ) 
                or
		  (
                   isnull(@i_fechaini,@w_date_inf)
                        >= isnull(pi_fecha_inicio,@w_date_inf)
                   and 
                   isnull(@i_fechafin,@w_date_sup) 
                        <= isnull(pi_fecha_fin,@w_date_sup)
                  )
                )
  	  and   pi_referencia = @i_referencia
          and   pi_periodo = @i_periodo
          and   pi_modalidad = @i_modalidad
	  and   pi_tipo_tasa = @i_tipotasa
	  and   pi_moneda = @i_moneda)
     begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151107
        return 1
     end
  end

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_pizarra 
	      where isnull(@i_fechafin,@w_date_sup) 
                    < isnull(pi_fecha_inicio,@w_date_inf)
  	  and   pi_referencia = @i_referencia
          and   pi_periodo = @i_periodo
          and   pi_modalidad = @i_modalidad
	  and   pi_tipo_tasa = @i_tipotasa
          and   pi_moneda = @i_moneda)
   begin
     print "ALERTA: Los datos ingresados tienen un rango de fecha anterior a otro ya ingresado, sin embargo los datos seran ingresados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @i_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas a ingresar es menor a la fecha de proceso" + convert(varchar(10), @w_date, 101) + ", sin embargo los datos seran ingresados"
  end

  begin tran
  exec cobis..sp_cseqnos
        @t_debug     = null,
        @t_file      = null,
        @t_from      = @w_sp_name,
	@i_tabla     = 'te_pizarra',
        @o_siguiente = @w_pizarra     out

  insert into te_pizarra(pi_cod_pizarra, pi_moneda, pi_valor, pi_fecha_fin,
                         pi_fecha_inicio, pi_referencia, pi_periodo, pi_modalidad, 
                         pi_tipo_valor, pi_tipo_tasa, pi_rango_desde, pi_rango_hasta)
                            
          values (@w_pizarra, @i_moneda, @i_valor, @i_fechafin,
                  @i_fechaini, @i_referencia, @i_periodo, @i_modalidad,
                  @i_tipovalor, @i_tipotasa, @i_rango_desde, @i_rango_hasta)

  if @@error <> 0
  begin

	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 153046	/*colocar el numero de error correcto*/
        return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_pizarra (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         cod_pizarra, moneda, valor, fecha_fin,
         fecha_inicio, referencia, periodo, modalidad, 
         tipo_valor, tipo_tasa, rango_desde, rango_hasta)
  values (@s_ssn, 15195, 'N', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	 @w_pizarra, @i_moneda, @i_valor, @i_fechafin,
         @i_fechaini, @i_referencia, @i_periodo, @i_modalidad,
         @i_tipovalor, @i_tipotasa, @i_rango_desde, @i_rango_hasta)

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

  select @w_pizarra
  commit tran
  return 0 
end

-- Si se trata de una modificacion de otras referencias
if @i_operacion = "U"
begin

  if not exists(select *
         from te_pizarra           
         where pi_cod_pizarra = @i_codpizarra)
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 151106     
    return 1
  end

  -- Tomar los datos de la referencia a modificar
  select @w_referencia = pi_referencia,
         @w_periodo = pi_periodo,
         @w_modalidad = pi_modalidad,
         @w_valor = pi_valor,
         @w_fechaini = pi_fecha_inicio,
         @w_fechafin = pi_fecha_fin,      
         @w_tipovalor = pi_tipo_valor,
         @w_tipotasa = pi_tipo_tasa,
         @w_rango_desde = pi_rango_desde,
         @w_rango_hasta = pi_rango_hasta,
         @w_moneda = pi_moneda
    from te_pizarra
    where pi_cod_pizarra = @i_codpizarra

  -- Analizar si la referencia acepta rango multiple o unico 
  select @w_rango = ca_rango
    from te_caracteristicas_tasa
   where ca_tasa = @w_referencia
     and ca_periodo = @w_periodo
     and ca_modalidad = @w_modalidad

  if @w_rango = null
  begin
  	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151102
        return 1
  end

  -- Si acepta multiple 
  if @w_rango = "M"
  begin   
     
     -- Analizar que el rango de fechas de vigencia aun no exista para un rango de dias
     -- ya ingresado en la tasa referencial 
     if exists (select * 
	  from te_pizarra 
	  where (  
                 (
                  isnull(@i_fechaini,@w_date_inf) 
                        <= isnull(pi_fecha_inicio,@w_date_inf)
                  and 
                  isnull(@i_fechafin,@w_date_sup) 
                        >= isnull(pi_fecha_inicio,@w_date_inf)
                  ) 
                or
		  (
                   isnull(@i_fechaini,@w_date_inf) 
                        <= isnull(pi_fecha_fin,@w_date_sup)
                   and 
                   isnull(@i_fechafin,@w_date_sup)
                        >= isnull(pi_fecha_fin,@w_date_sup)
                  ) 
                or
		  (
                   isnull(@i_fechaini,@w_date_inf)
                        >= isnull(pi_fecha_inicio,@w_date_inf)
                   and 
                   isnull(@i_fechafin,@w_date_sup) 
                        <= isnull(pi_fecha_fin,@w_date_sup)
                  )
                )
	    and (  
                 (
                  isnull(@i_rango_desde,@w_rango_inf) 
                        <= isnull(pi_rango_desde,@w_rango_inf)
                  and 
                  isnull(@i_rango_hasta,@w_rango_sup) 
                        >= isnull(pi_rango_desde,@w_rango_inf)
                  ) 
                or
		  (
                   isnull(@i_rango_desde,@w_rango_inf) 
                        <= isnull(pi_rango_hasta,@w_rango_sup)
                   and 
                   isnull(@i_rango_hasta,@w_rango_sup)
                        >= isnull(pi_rango_hasta,@w_rango_sup)
                  ) 
                or
		  (
                   isnull(@i_rango_desde,@w_rango_inf)
                        >= isnull(pi_rango_desde,@w_rango_inf)
                   and 
                   isnull(@i_rango_hasta,@w_rango_sup) 
                        <= isnull(pi_rango_hasta,@w_rango_sup)
                  )
                )
          and   pi_referencia = @w_referencia
          and   pi_periodo = @w_periodo
          and   pi_modalidad = @w_modalidad
	  and   pi_tipo_tasa = @w_tipotasa
	  and   pi_moneda = @w_moneda
          and   pi_cod_pizarra <> @i_codpizarra)
     begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151105
        return 1
     end
  end  

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_pizarra 
	      where isnull(@i_fechafin,@w_date_sup) 
                    < isnull(pi_fecha_inicio,@w_date_inf)
                and pi_referencia = @w_referencia
                and pi_periodo = @w_periodo
                and pi_modalidad = @w_modalidad
	        and pi_tipo_tasa = @w_tipotasa
	        and pi_moneda = @w_moneda
                and pi_cod_pizarra <> @i_codpizarra)
   begin
     print "ALERTA: Los datos para modificar tienen un rango de fecha anterior a otro, sin embargo los datos seran modificados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @i_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas modificado es menor a la fecha de proceso" + convert(varchar(10), @w_date, 101) +", sin embargo los datos seran modificados"
  end
    
  begin tran
  update te_pizarra          
       set pi_valor = @i_valor,                              
           pi_fecha_inicio = @i_fechaini,
           pi_fecha_fin = @i_fechafin,      
           pi_tipo_valor = @i_tipovalor,
           pi_tipo_tasa = @i_tipotasa,
           pi_rango_desde = @i_rango_desde,
           pi_rango_hasta = @i_rango_hasta
       where pi_cod_pizarra = @i_codpizarra

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 155048        /* colocar el numero de error correcto*/
    return 1
  end

  -- Insertar transacciones de servicio
  -- Si existe error al insertar las transacciones de servicio error y salir
  insert into ts_pizarra (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         cod_pizarra, moneda, valor, fecha_fin,
         fecha_inicio, referencia, periodo, modalidad, 
         tipo_valor, tipo_tasa, rango_desde, rango_hasta)
  values (@s_ssn, 15196, 'P', @s_date,
	  @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
          @i_codpizarra, @w_moneda, @w_valor, @w_fechafin,
          @w_fechaini, @w_referencia, @w_periodo, @w_modalidad,
          @w_tipovalor, @w_tipotasa, @w_rango_desde, @w_rango_hasta)

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
   insert into ts_pizarra (
          secuencia, tipo_transaccion, clase, fecha,
          oficina_s, usuario, terminal_s, srv, lsrv,
          cod_pizarra, moneda, valor, fecha_fin,
          fecha_inicio, referencia, periodo, modalidad, 
          tipo_valor, tipo_tasa, rango_desde, rango_hasta)
   values (@s_ssn, 15196, 'A', @s_date,
	   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
           @i_codpizarra, @w_moneda, @i_valor, @i_fechafin,
           @i_fechaini, @w_referencia, @w_periodo, @w_modalidad,
           @i_tipovalor, @i_tipotasa, @i_rango_desde, @i_rango_hasta)

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


-- Si se trata de una eliminacion de otras referencias
if @i_operacion = "D"
begin

  if not exists(select *
         from te_pizarra           
         where pi_cod_pizarra = @i_codpizarra)  
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 151106         
    return 1
  end

  -- Tomar los datos de la referencia a borrar
  select @w_referencia = pi_referencia,
         @w_periodo = pi_periodo,
         @w_modalidad = pi_modalidad,
         @w_valor = pi_valor,
         @w_fechaini = pi_fecha_inicio,
         @w_fechafin = pi_fecha_fin,      
         @w_tipovalor = pi_tipo_valor,
         @w_tipotasa = pi_tipo_tasa,
         @w_rango_desde = pi_rango_desde,
         @w_rango_hasta = pi_rango_hasta,
         @w_moneda = pi_moneda
    from te_pizarra
    where pi_cod_pizarra = @i_codpizarra


  -- Alertar que el rango de fechas esta caducado
  if @w_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas a borrar es menor a la fecha de proceso" + convert(varchar(10), @w_date, 101) +", sin embargo los datos seran borrados"
  end

  begin tran
    delete te_pizarra          
     where pi_cod_pizarra = @i_codpizarra

    if @@rowcount = 0
    begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 157073      
      return 1 
    end

   -- Ingresar transaccion de servicio
   insert into ts_pizarra (
          secuencia, tipo_transaccion, clase, fecha,
          oficina_s, usuario, terminal_s, srv, lsrv,
          cod_pizarra, moneda, valor, fecha_fin,
          fecha_inicio, referencia, periodo, modalidad, 
          tipo_valor, tipo_tasa, rango_desde, rango_hasta)
   values (@s_ssn, 15197, 'B', @s_date,
	   @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
           @i_codpizarra, @w_moneda, @w_valor, @w_fechafin,
           @w_fechaini, @w_referencia, @w_periodo, @w_modalidad,
           @w_tipovalor, @w_tipotasa, @w_rango_desde, @w_rango_hasta)

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

-- Si se trata de una busqueda de otras referencias
if @i_operacion = "S"
begin
  set rowcount 40

  if @i_cond = "T"
  begin
	select	"COD. SEC" = pi_cod_pizarra,
		"COD. MON" = pi_moneda,           
		"REFERENCIA" = pi_referencia,    
                "NOMBRE" = tr_descripcion,
                "PERIODO" = pi_periodo,
                "MODALIDAD" = pi_modalidad,
                "DESDE" = pi_rango_desde,
                "HASTA" = pi_rango_hasta,
		"MONTO O TASA" = pi_valor,
		"FECHA INI" = convert(varchar(10),pi_fecha_inicio,@i_formato_fecha),
		"FECHA FIN" = convert(varchar(10),pi_fecha_fin,@i_formato_fecha),   
		"TIPO REF" = pi_tipo_valor,
		"TIPO TASA" = pi_tipo_tasa
	from	te_pizarra, te_tasas_referenciales        
	where	pi_referencia = tr_tasa
        and     pi_referencia like @i_tipo_ref
	and	pi_cod_pizarra > @i_codpizarra
	and	(pi_moneda = @i_moneda or @i_moneda = null)
	and	pi_fecha_fin <= (select max(pi_fecha_fin)
				from te_pizarra
				where (pi_moneda = @i_moneda or @i_moneda = null)
				and pi_referencia like @i_tipo_ref)
  end
  else
  begin
	select	"COD. SEC" = pi_cod_pizarra,
		"COD. MON" = pi_moneda,           
		"REFERENCIA" = pi_referencia,    
                "NOMBRE" = tr_descripcion,
                "PERIODO" = pi_periodo,
                "MODALIDAD" = pi_modalidad,
                "DESDE" = pi_rango_desde,
                "HASTA" = pi_rango_hasta,
		"MONTO O TASA" = pi_valor,
		"FECHA INI" = convert(varchar(10),pi_fecha_inicio,@i_formato_fecha),
		"FECHA FIN" = convert(varchar(10),pi_fecha_fin,@i_formato_fecha),   
		"TIPO REF" = pi_tipo_valor,
		"TIPO TASA" = pi_tipo_tasa
	from	te_pizarra, te_tasas_referenciales        
	where	pi_referencia = tr_tasa
	and     pi_cod_pizarra > @i_codpizarra
  end

  /* En caso de que no existan registros en la tabla */
  if @@rowcount = 0
  begin
	/*  No existen registros */           
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file  = @t_file,
		@t_from  = @w_sp_name,
		@i_num   = 151104
	return 1
  end

  select 40
  set rowcount 0
  return 0
end

-- Si se trata de una busqueda de una referencia en especial
if @i_operacion = "Q"
begin
  if @i_destino = "F"
  begin
    select "COD PIZARRA" = pi_cod_pizarra,
           "MONEDA"  = pi_moneda,           
           "REFERENCIA" = pi_referencia,    
           "PERIODO" = pi_periodo,
           "MODALIDAD" = pi_modalidad,
           "DESDE" = pi_rango_desde,
           "HASTA" = pi_rango_hasta,
           "VALOR" = pi_valor,
           "FECHA INI" = pi_fecha_inicio,
           "FECHA FIN" = pi_fecha_fin,
           "TIPO VALOR" = pi_tipo_valor,
           "TIPO TASA" = pi_tipo_tasa
      from te_pizarra        
     where pi_referencia = @i_referencia
       and pi_moneda = @i_moneda
       and pi_periodo = @i_periodo
       and pi_modalidad = @i_modalidad
       and isnull(@i_dias,@w_rango_inf) between isnull(pi_rango_desde,@w_rango_inf) 
           and isnull(pi_rango_hasta,@w_rango_sup)
       and isnull(@i_fecha_proceso,@s_date) 
           between isnull(pi_fecha_inicio,@w_date_inf) 
           and isnull(pi_fecha_fin,@w_date_sup)
       and pi_tipo_tasa = @i_tipotasa
  end
  else
  begin
    select @o_codpizarra = pi_cod_pizarra,
           @o_moneda  = pi_moneda,           
           @o_referencia = pi_referencia,    
           @o_periodo = pi_periodo,
           @o_modalidad = pi_modalidad,
           @o_rango_desde = pi_rango_desde,
           @o_rango_hasta = pi_rango_hasta,
           @o_valor = pi_valor,
           @o_fechaini = pi_fecha_inicio,
           @o_fechafin = pi_fecha_fin,
           @o_tipovalor = pi_tipo_valor,
           @o_tipotasa = pi_tipo_tasa
      from te_pizarra        
     where pi_referencia = @i_referencia
       and pi_moneda = @i_moneda
       and pi_periodo = @i_periodo
       and pi_modalidad = @i_modalidad
       and isnull(@i_dias,@w_rango_inf) between isnull(pi_rango_desde,@w_rango_inf) 
           and isnull(pi_rango_hasta,@w_rango_sup)
       and isnull(@i_fecha_proceso,@s_date) 
           between isnull(pi_fecha_inicio,@w_date_inf) 
           and isnull(pi_fecha_fin,@w_date_sup)
       and pi_tipo_tasa = @i_tipotasa
  end
  if @@rowcount = 0
  begin
	return 1
  end
  return 0
end

-- Si se trata de una busqueda especial de otras referencias
if @i_operacion = "H"
begin

   set rowcount 40

  select "COD. SEC" = pi_cod_pizarra,
         "COD. MON"  = pi_moneda,           
         "REFERENCIA" = pi_referencia,    
         "NOMBRE" = tr_descripcion,
         "PERIODO" = pi_periodo,
         "MODALIDAD" = pi_modalidad,
         "DESDE" = pi_rango_desde,
         "HASTA" = pi_rango_hasta,
         "MONTO O TASA"      = pi_valor,
         "FECHA INI"      = convert(varchar(10),pi_fecha_inicio,@i_formato_fecha),
         "FECHA FIN"       = convert(varchar(10),pi_fecha_fin,@i_formato_fecha),  
         "TIPO REF"     = pi_tipo_valor,
         "TIPO TASA"      = pi_tipo_tasa
   from te_pizarra, te_tasas_referenciales        
  where pi_referencia = tr_tasa
  and pi_referencia like @i_tipo_ref
  and (pi_moneda = @i_moneda or @i_moneda = null)
  and @i_fechaini <= pi_fecha_inicio
  and @i_fechafin >= pi_fecha_fin
  and pi_cod_pizarra > @i_codpizarra

  if @@rowcount = 0
  begin
	/*  No existen registros en pizarra */                     
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
        @t_from  = @w_sp_name,
	@i_num   = 151106
	return 1
  end
  else
    select 40
 set rowcount 0
 return 0
end
go





