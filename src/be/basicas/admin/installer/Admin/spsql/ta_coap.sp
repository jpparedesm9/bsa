/************************************************************************/
/*	Archivo: 		ta_coap.sp	                        */
/*	Stored procedure: 	sp_tare_coap                  	        */
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
/*    Mantenimiento y consulta de la tabla de activas y pasivas         */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		 AUTOR		       RAZON			*/
/*    20/Mayo/1996   Nidia Elena Silva     Emision inicial              */
/*    16/Mayo/2000   Roberth Minga Vallejo RMI16May00: Adaptacion       */
/*                                         tasas referenciales ADMIN    */
/************************************************************************/
use cobis
go


if exists (select * from sysobjects where name = 'sp_tare_coap')
        drop proc sp_tare_coap
go


create proc sp_tare_coap(
        @s_ssn          int = null,
        @s_srv          varchar(30) = null,
        @s_lsrv         varchar(30) = null,
        @s_user         varchar(30) = null,
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
        @i_cond         char(1) = null,
        @i_numtasa      int = null,
        @i_tiposerv     int = null,
        @i_moneda       tinyint = null,    
        @i_montoini     money = null,   
        @i_montofin     money = null,
        @i_tasanom      float = null,    
        @i_tasaefec     float = null,      
        @i_fechaini     datetime = null,
        @i_fechafin     datetime = null,     
        @i_rginidias    smallint = null,
        @i_rgfindias    smallint = null,
        @i_dias         smallint = null,
        @i_monto        money = null,
        @i_fecha_proceso datetime = null,
        @i_formato_fecha int = 103,
        @i_destino      char(1) = "F",
        @o_numtasa      int = null out,
        @o_tiposerv     int = null out,
        @o_moneda       tinyint = null out,    
        @o_montoini     money = null out,   
        @o_montofin     money = null out,
        @o_tasanom      float = null out,    
        @o_tasaefec     float = null out,      
        @o_fechaini     datetime = null out,
        @o_fechafin     datetime = null out,     
        @o_rginidias    smallint = null out,
        @o_rgfindias    smallint = null out
)
as

declare  @w_return      smallint,
         @w_numtasa     int,
         @w_tiposerv    int,
         @w_sp_name     varchar(30),
         @w_moneda      tinyint,
         @w_montoini    money,
         @w_montofin    money,
         @w_tasanom     float,
         @w_tasaefec    float,
         @w_fechaini    datetime,
         @w_fechafin    datetime,
         @w_rginidias   smallint,
         @w_rgfindias   smallint,
         @w_date_inf    datetime,
         @w_date_sup    datetime,
         @w_rango_inf   smallint,
         @w_rango_sup   smallint,
         @w_monto_inf   money,
         @w_monto_sup   money,
         @w_date        char(10)



select @w_sp_name='sp_tare_coap'

if (@t_trn <> 15200 and @i_operacion = "I") or
   (@t_trn <> 15201 and @i_operacion = "U") or
   (@t_trn <> 15202 and @i_operacion = "D") or
   (@t_trn <> 15203 and @i_operacion in ("S","H")) or
   (@t_trn <> 15204 and @i_operacion = "Q") 
  begin
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
       @w_rango_sup = 32767,
       @w_monto_inf = 0,
       @w_monto_sup = 922337203685477.5807

-- Si se inserta una tasa coap
if @i_operacion = "I"
begin
  if exists(select * 
              from te_tasa_coap
             where (
                    isnull(@i_fechaini,@w_date_inf) = isnull(lc_fecha_inicio,@w_date_inf)   
                   )

	       and 
                   (
                    (
                     isnull(@i_montoini,@w_monto_inf)
                           <= isnull(lc_monto_inicial,@w_monto_inf)
                     and 
                     isnull(@i_montofin,@w_monto_sup)
                           >= isnull(lc_monto_inicial,@w_monto_inf)
                    )
                    or
	            (
                     isnull(@i_montoini,@w_monto_inf)
                           <= isnull(lc_monto_final,@w_monto_sup)
                     and 
                     isnull(@i_montofin,@w_monto_sup)
                           >= isnull(lc_monto_final,@w_monto_sup)
                    ) 
                    or
	            (
                     isnull(@i_montoini,@w_monto_inf)
                           >= isnull(lc_monto_inicial,@w_monto_inf)
                     and 
                     isnull(@i_montofin,@w_monto_sup)
                           <= isnull(lc_monto_final,@w_monto_sup)
                    )
                   )
	      and  
                  (
                   (
                    isnull(@i_rginidias,@w_rango_inf)
                         <= isnull(lc_rango_inicial,@w_rango_inf)
                    and 
                    isnull(@i_rgfindias,@w_rango_sup)
                        >= isnull(lc_rango_inicial,@w_rango_inf)
                   ) 
                   or
	           (
                    isnull(@i_rginidias,@w_rango_inf)
                        <= isnull(lc_rango_final,@w_rango_sup)
                    and 
                    isnull(@i_rgfindias,@w_rango_sup)
                        >= isnull(lc_rango_final,@w_rango_sup)
                   ) 
                   or
	           (
                    isnull(@i_rginidias,@w_rango_inf)
                        >= isnull(lc_rango_inicial,@w_rango_inf)
                    and 
                    isnull(@i_rgfindias,@w_rango_sup)
                        <= isnull(lc_rango_final,@w_rango_sup)
                   )
                  )
            
              and lc_cod_tipo_servicio = @i_tiposerv
              and lc_moneda = @i_moneda
          )

   begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151108
      return 1
   end

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_tasa_coap
	      where isnull(@i_fechaini,@w_date_inf) 
                    < isnull(lc_fecha_inicio,@w_date_inf)
              and lc_cod_tipo_servicio = @i_tiposerv
              and lc_moneda = @i_moneda)
   begin
     print "ALERTA: Los datos ingresados tienen una fecha anterior a otra ya ingresada, sin embargo los datos seran ingresados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @i_fechaini < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: La fecha a ingresar es menor a la fecha de proceso"+ convert (varchar(10), @w_date, 101) +", sin embargo los datos seran ingresados"
  end

  begin tran
  exec cobis..sp_cseqnos
        @t_debug     = null,
        @t_file      = null,
        @t_from      = @w_sp_name,
        @i_tabla     = 'te_tasa_coap',
        @o_siguiente = @w_numtasa out

  insert into te_tasa_coap
	(lc_num_tasa, lc_cod_tipo_servicio, lc_moneda, lc_monto_inicial,
	 lc_monto_final, lc_tasa_nominal, lc_tasa_efectiva, lc_fecha_inicio,
	 lc_fecha_final, lc_rango_inicial, lc_rango_final)                            
  values (@w_numtasa, @i_tiposerv, @i_moneda, @i_montoini,
	 @i_montofin, @i_tasanom, @i_tasaefec, @i_fechaini,    
	 @i_fechafin, @i_rginidias, @i_rgfindias)

  if @@error <> 0
  begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 153047
        rollback
        return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_coap (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
	 num_tasa, cod_tipo_servicio, moneda, monto_inicial,
	 monto_final, tasa_nominal, tasa_efectiva, fecha_inicio,
	 fecha_final, rango_inicial, rango_final)                            
  values (@s_ssn, 15200, 'N', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	 @w_numtasa, @i_tiposerv, @i_moneda, @i_montoini,
	 @i_montofin, @i_tasanom, @i_tasaefec, @i_fechaini,    
	 @i_fechafin, @i_rginidias, @i_rgfindias)

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

  
  select @w_numtasa
  commit tran
  return 0 
end


-- Si se modifica una tasa coap
if @i_operacion = "U"
begin
  if not exists(select *
                  from te_tasa_coap         
                  where lc_num_tasa = @i_numtasa)
  begin
      exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151109
      return 1
  end


  select @w_tiposerv = lc_cod_tipo_servicio,
         @w_moneda = lc_moneda, 
         @w_montoini = lc_monto_inicial,
         @w_montofin = lc_monto_final,
         @w_tasanom = lc_tasa_nominal,
         @w_tasaefec = lc_tasa_efectiva,
         @w_fechaini = lc_fecha_inicio,
         @w_fechafin = lc_fecha_final,
         @w_rginidias = lc_rango_inicial,
         @w_rgfindias = lc_rango_final
    from te_tasa_coap
  where lc_num_tasa = @i_numtasa

  if exists(select * 
              from te_tasa_coap
             where (
                    isnull(@i_fechaini,@w_date_inf) = isnull(lc_fecha_inicio,@w_date_inf)   
                   )
	       and 
                   (
                    (
                     isnull(@i_montoini,@w_monto_inf)
                           <= isnull(lc_monto_inicial,@w_monto_inf)
                     and 
                     isnull(@i_montofin,@w_monto_sup)
                           >= isnull(lc_monto_inicial,@w_monto_inf)
                    )
                    or
	            (
                     isnull(@i_montoini,@w_monto_inf)
                           <= isnull(lc_monto_final,@w_monto_sup)
                     and 
                     isnull(@i_montofin,@w_monto_sup)
                           >= isnull(lc_monto_final,@w_monto_sup)
                    ) 
                    or
	            (
                     isnull(@i_montoini,@w_monto_inf)
                           >= isnull(lc_monto_inicial,@w_monto_inf)
                     and 
                     isnull(@i_montofin,@w_monto_sup)
                           <= isnull(lc_monto_final,@w_monto_sup)
                    )
                   )
	      and  
                  (
                   (
                    isnull(@i_rginidias,@w_rango_inf)
                         <= isnull(lc_rango_inicial,@w_rango_inf)
                    and 
                    isnull(@i_rgfindias,@w_rango_sup)
                        >= isnull(lc_rango_inicial,@w_rango_inf)
                   ) 
                   or
	           (
                    isnull(@i_rginidias,@w_rango_inf)
                        <= isnull(lc_rango_final,@w_rango_sup)
                    and 
                    isnull(@i_rgfindias,@w_rango_sup)
                        >= isnull(lc_rango_final,@w_rango_sup)
                   ) 
                   or
	           (
                    isnull(@i_rginidias,@w_rango_inf)
                        >= isnull(lc_rango_inicial,@w_rango_inf)
                    and 
                    isnull(@i_rgfindias,@w_rango_sup)
                        <= isnull(lc_rango_final,@w_rango_sup)
                   )
                  )            
              and lc_cod_tipo_servicio = @w_tiposerv
              and lc_moneda = @w_moneda
              and lc_num_tasa <> @i_numtasa
          )

   begin
	exec cobis..sp_cerror
		@t_debug = @t_debug,
		@t_file	 = @t_file,
		@t_from	 = @w_sp_name,
		@i_num	 = 151108
      return 1
   end

   -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_tasa_coap
	      where isnull(@i_fechaini,@w_date_inf) 
                    < isnull(lc_fecha_inicio,@w_date_inf)
                and lc_cod_tipo_servicio = @w_tiposerv
                and lc_moneda = @w_moneda
                and lc_num_tasa <> @i_numtasa)
   begin
     print "ALERTA: Los datos para modificar tienen una fecha anterior a otra, sin embargo los datos seran modificados"
   end


  -- Alertar que el rango de fechas esta caducado
  if @i_fechaini < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: La fecha a modificar es menor a la fecha de proceso"+ convert (varchar(10), @w_date, 101)+", sin embargo los datos seran modificados"
  end

  begin tran
  update te_tasa_coap        
     set lc_monto_inicial = @i_montoini,
         lc_monto_final = @i_montofin, 
         lc_tasa_nominal = @i_tasanom,
         lc_tasa_efectiva = @i_tasaefec,
         lc_fecha_inicio = @i_fechaini,
         lc_fecha_final = @i_fechafin,
         lc_rango_inicial = @i_rginidias,
         lc_rango_final = @i_rgfindias,
         lc_moneda = @i_moneda
   where lc_num_tasa = @i_numtasa     

  if @@error<>0
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 155049      
    return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_coap (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
	 num_tasa, cod_tipo_servicio, moneda, monto_inicial,
	 monto_final, tasa_nominal, tasa_efectiva, fecha_inicio,
	 fecha_final, rango_inicial, rango_final)                            
  values (@s_ssn, 15201, 'P', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	 @i_numtasa, @w_tiposerv, @w_moneda, @w_montoini,
	 @w_montofin, @w_tasanom, @w_tasaefec, @w_fechaini,    
	 @w_fechafin, @w_rginidias, @w_rgfindias)

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
  insert into ts_coap (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
	 num_tasa, cod_tipo_servicio, moneda, monto_inicial,
	 monto_final, tasa_nominal, tasa_efectiva, fecha_inicio,
	 fecha_final, rango_inicial, rango_final)                            
  values (@s_ssn, 15201, 'A', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	 @i_numtasa, @i_tiposerv, @i_moneda, @i_montoini,
	 @i_montofin, @i_tasanom, @i_tasaefec, @i_fechaini,    
	 @i_fechafin, @i_rginidias, @i_rgfindias)

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

-- Si se elimina una tasa coap
if @i_operacion = "D"
begin

  if not exists(select *
                  from te_tasa_coap         
                 where lc_num_tasa = @i_numtasa)
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 151109
    return 1
  end

  select @w_tiposerv = lc_cod_tipo_servicio,
         @w_moneda = lc_moneda, 
         @w_montoini = lc_monto_inicial,
         @w_montofin = lc_monto_final,
         @w_tasanom = lc_tasa_nominal,
         @w_tasaefec = lc_tasa_efectiva,
         @w_fechaini = lc_fecha_inicio,
         @w_fechafin = lc_fecha_final,
         @w_rginidias = lc_rango_inicial,
         @w_rgfindias = lc_rango_final
    from te_tasa_coap
  where lc_num_tasa = @i_numtasa

  -- Alertar que el rango de fechas esta caducado
  if @w_fechaini < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: La fecha a borrar es menor a la fecha de proceso" + convert(varchar(10), @w_date, 101) + ", sin embargo los datos seran borrados"
  end

  begin tran
  delete  te_tasa_coap        
   where lc_num_tasa = @i_numtasa

  if @@rowcount = 0
  begin
    exec cobis..sp_cerror
      @t_debug = @t_debug,
      @t_file  = @t_file,
      @t_from  = @w_sp_name,
      @i_num   = 157074
    return 1
  end

  -- Ingresar transaccion de servicio
  insert into ts_coap (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
	 num_tasa, cod_tipo_servicio, moneda, monto_inicial,
	 monto_final, tasa_nominal, tasa_efectiva, fecha_inicio,
	 fecha_final, rango_inicial, rango_final)                            
  values (@s_ssn, 15202, 'B', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
	 @i_numtasa, @w_tiposerv, @w_moneda, @w_montoini,
	 @w_montofin, @w_tasanom, @w_tasaefec, @w_fechaini,    
	 @w_fechafin, @w_rginidias, @w_rgfindias)

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

-- Si se busca una tasa especifica de tasas coap
if @i_operacion = "Q"
begin
 -- Seleccionar la tasa mas reciente ya que solo se usa la fecha inicial y no la fecha final
 -- La fecha final siempre tiene un valor por defecto
 if @i_destino = "F"
 begin
   select "NUM TASA"      = lc_num_tasa,
          "TIPO SERV"     = lc_cod_tipo_servicio,
          "MONEDA"        = lc_moneda,    
          "MONTO INI"     = lc_monto_inicial,   
          "MONTO FIN"     = lc_monto_final,
          "TASA NOM"      = lc_tasa_nominal,    
          "TASA EFE"      = lc_tasa_efectiva,     
          "FECHA INI"     = lc_fecha_inicio,
          "FECHA FINAL"   = lc_fecha_final,     
          "RANGO INICI"   = lc_rango_inicial,
          "RANGO FIN"     = lc_rango_final
     from te_tasa_coap        
    where lc_cod_tipo_servicio = @i_tiposerv
      and lc_moneda = @i_moneda
    and isnull(@i_dias,@w_rango_inf) between isnull(lc_rango_inicial,@w_rango_inf) 
         and isnull(lc_rango_final,@w_rango_sup)
    and isnull(@i_monto,@w_monto_inf) between isnull(lc_monto_inicial,@w_monto_inf) 
         and isnull(lc_monto_final,@w_monto_sup)
    and isnull(lc_fecha_inicio,@w_date_inf)
                        = (select isnull(max(lc_fecha_inicio),@w_date_inf) 
                             from te_tasa_coap
                            where lc_cod_tipo_servicio = @i_tiposerv
                              and lc_moneda = @i_moneda
                              and isnull(@i_dias,@w_rango_inf) 
                                  between isnull(lc_rango_inicial,@w_rango_inf) 
                                  and isnull(lc_rango_final,@w_rango_sup)
                              and isnull(@i_monto,@w_monto_inf) 
                                  between isnull(lc_monto_inicial,@w_monto_inf) 
                                  and isnull(lc_monto_final,@w_monto_sup)
                              and isnull(lc_fecha_inicio,@w_date_inf)
                                  <= isnull(@i_fecha_proceso,@s_date)
                           )
  end
  else
  begin
 select @o_numtasa      = lc_num_tasa,
        @o_tiposerv     = lc_cod_tipo_servicio,
        @o_moneda       = lc_moneda,    
        @o_montoini     = lc_monto_inicial,   
        @o_montofin     = lc_monto_final,
        @o_tasanom      = lc_tasa_nominal,    
        @o_tasaefec     = lc_tasa_efectiva,     
        @o_fechaini     = lc_fecha_inicio,
        @o_fechafin     = lc_fecha_final,     
        @o_rginidias    = lc_rango_inicial,
        @o_rgfindias    = lc_rango_final
   from te_tasa_coap        
  where lc_cod_tipo_servicio = @i_tiposerv
    and lc_moneda = @i_moneda
    and isnull(@i_dias,@w_rango_inf) between isnull(lc_rango_inicial,@w_rango_inf) 
         and isnull(lc_rango_final,@w_rango_sup)
    and isnull(@i_monto,@w_monto_inf) between isnull(lc_monto_inicial,@w_monto_inf) 
         and isnull(lc_monto_final,@w_monto_sup)
    and isnull(lc_fecha_inicio,@w_date_inf)
                        = (select isnull(max(lc_fecha_inicio),@w_date_inf) 
                             from te_tasa_coap
                            where lc_cod_tipo_servicio = @i_tiposerv
                              and lc_moneda = @i_moneda
                              and isnull(@i_dias,@w_rango_inf) 
                                  between isnull(lc_rango_inicial,@w_rango_inf) 
                                  and isnull(lc_rango_final,@w_rango_sup)
                              and isnull(@i_monto,@w_monto_inf) 
                                  between isnull(lc_monto_inicial,@w_monto_inf) 
                                  and isnull(lc_monto_final,@w_monto_sup)
                              and isnull(lc_fecha_inicio,@w_date_inf)
                                  <= isnull(@i_fecha_proceso,@s_date)
                           )

  end
  if @@rowcount = 0
  begin
    return 1
  end
  return 0
end

-- Si se buscan las tasas coap
if @i_operacion = "S"
begin
 set rowcount 30
 select "COD. SEC" = lc_num_tasa,
	  "TIPO SERV."  = lc_cod_tipo_servicio,
  	  "MONTO INICIAL" = lc_monto_inicial,
	  "MONTO FINAL" = lc_monto_final,
	  "TASA NOM." = lc_tasa_nominal,
	  "TASA EFEC." = lc_tasa_efectiva,
	  "FECHA INI" = convert(varchar(10),lc_fecha_inicio,@i_formato_fecha),
  	  "FECHA FIN" = convert(varchar(10),lc_fecha_final,@i_formato_fecha),
        "RG. INI. DIA" = lc_rango_inicial,
	  "RG. FIN. DIA" = lc_rango_final,
	  "MONEDA" = lc_moneda 
   from te_tasa_coap     
  where lc_num_tasa > @i_numtasa  
    and ((lc_cod_tipo_servicio = @i_tiposerv and @i_cond = 'T')
     or (@i_tiposerv = 0 and @i_cond = 'F'))
    and lc_fecha_inicio >= @i_fechaini
    and lc_fecha_final <= @i_fechafin 
    and (lc_moneda = @i_moneda or @i_moneda is null)

  if @@rowcount = 0
  begin
	/*No existen registros en lineamientos del ALCO con esas caracter¡sticas espec¡ficas */           
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
        @t_from  = @w_sp_name,
	@i_num   = 151110
	return 1
  end
  else
  begin
       select 30
  end
return 0
end

-- Si se buscan las tasas coap
if @i_operacion = "H"
begin
  set rowcount 40
	select	"COD. SEC" = lc_num_tasa,
		"TIPO SERV."  = lc_cod_tipo_servicio,
		"MONTO INICIAL" = lc_monto_inicial,
		"MONTO FINAL" = lc_monto_final,
		"TASA NOM." = lc_tasa_nominal,
		"TASA EFEC." = lc_tasa_efectiva,
		"FECHA INI" = convert(varchar(10),lc_fecha_inicio,@i_formato_fecha),
		"FECHA FIN" = convert(varchar(10),lc_fecha_final,@i_formato_fecha),
		"RG. INI. DIA" = lc_rango_inicial,
		"RG. FIN. DIA" = lc_rango_final,
		"MONEDA" = lc_moneda 
	from te_tasa_coap     
	where lc_num_tasa > @i_numtasa  
	and (lc_cod_tipo_servicio = @i_tiposerv or @i_tiposerv = 0)
	and (lc_moneda = @i_moneda or @i_moneda is null)
	and (lc_fecha_inicio = @i_fechaini or @i_fechaini is null)
	and (lc_fecha_final = @i_fechafin or @i_fechafin is null)

	/* En caso de que no existan registros en la tabla */
	if @@rowcount = 0
	begin
		/*  No existen registros en lineamientos del ALCO con esas caracter¡sticas espec¡ficas */           
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file,
			@t_from  = @w_sp_name,
			@i_num   = 151110
		return 1
	end
  select 40
  return 0
end
go