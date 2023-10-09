/************************************************************************/
/*      Archivo:                ta_reldo.sp                             */
/*      Stored procedure:       sp_tare_reldo                           */
/*      Producto:               Admin                                   */
/*      Disenado por:  Fernanda Lopez R.                                */
/*      Fecha de escritura: 1996-07-29                                  */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "MACOSA", representantes exclusivos para el Ecuador de la       */
/*      "NCR CORPORATION".                                              */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Mantenimiento y consulta de las tablas de relacion con el dolar */
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA            AUTOR                 RAZON                    */
/*      29/Jul/1996   F. LOPEZ              Emision inicial             */
/*      16/May/2000   R. Minga              RMI16May00: Adaptacion      */
/*                                          tasas referenciales ADMIN   */
/************************************************************************/
use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_reldo')
	drop proc sp_tare_reldo
go


create proc sp_tare_reldo(
	@s_ssn          int= null,
	@s_srv          varchar(30)= null,
	@s_lsrv         varchar(30)= null,
	@s_user         varchar(30)= null,
	@s_sesn         int=null,
	@s_term         varchar(10)= null,
	@s_date         datetime = null,
	@s_ofi          smallint = null,    
	@s_rol          smallint = null,
	@s_org          char(1) = null,
	@t_corr         char(1) = null,
	@t_debug        char(1) = 'N',
	@t_file         varchar(14) = null, 
	@t_from         varchar(32) = null,  
	@t_rty          char(1) = 'N',
      @t_trn          smallint = null,
      @i_operacion    char(1),
      @i_moneda       tinyint = null,
      @i_valor        float = null,
      @i_fechaini     datetime = null,
      @i_fechafin     datetime = null,
      @i_mercado      tinyint = null,
      @i_secuencial   int = null,
      @i_fecha_proceso datetime = null,
      @i_destino      char(1) = "F",
      @o_moneda       tinyint = null out,
        @o_valor        float = null out,
        @o_fechaini     datetime = null out,
        @o_fechafin     datetime = null out,
	@o_mercado      tinyint = null out,
        @o_secuencial   int = null out,
        @i_formato_fecha int = 103
       )
as

 declare @w_sp_name           varchar(30),
         @w_return            tinyint,
         @w_siguiente         int,
         @w_valor             float,
         @w_fechaini          datetime,
         @w_fechafin          datetime,
         @w_moneda            tinyint,
	 @w_paso	      char(1),
         @w_date              char(10)

select @w_sp_name = 'sp_tare_reldo'
       
if (@t_trn <> 15216 and @i_operacion = "I") or
   (@t_trn <> 15217 and @i_operacion = "U") or
   (@t_trn <> 15218 and @i_operacion = "D") or
   (@t_trn <> 15219 and @i_operacion = "S") or
   (@t_trn <> 15220 and @i_operacion = "Q") 
  begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file	 = @t_file,
	@t_from	 = @w_sp_name,
	@i_num	 = 151051
	return 1
end
     
-- Si se trata de inserci¢n
if @i_operacion = "I"
begin
   -- Verificar que no existan datos para una misma fecha
   if exists (select * 
                from te_relacion_dolar
               where (  
                        (@i_fechaini <= rd_fecha_inicial
                         and 
                         @i_fechafin >= rd_fecha_inicial
                        ) 
                      or
		        (@i_fechaini <= rd_fecha_final
                         and 
                         @i_fechafin >= rd_fecha_final
                        ) 
                      or
		        (
                         @i_fechaini >= rd_fecha_inicial
                         and 
                         @i_fechafin <= rd_fecha_final
                        )
                     )
                  and rd_cod_moneda = @i_moneda
             )
  begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
        @i_num   = 151117 
	return 1
  end

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_relacion_dolar
	      where @i_fechafin < rd_fecha_inicial
                and rd_cod_moneda = @i_moneda)
   begin
     print "ALERTA: Los datos ingresados tienen un rango de fecha anterior a otro ya ingresado, sin embargo los datos seran ingresados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @i_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas a ingresar es menor a la fecha de proceso"+ convert(varchar(10), @w_date, 101) + ", sin embargo los datos seran ingresados"
  end

  begin tran
  /*Llamar a stored procedure de asignacion de numeros secuenciales */
   exec @w_return = cobis..sp_cseqnos
        @t_debug    =@t_debug,
        @t_file     =@t_file,
        @t_from     =@w_sp_name,
	@i_tabla    ='te_relacion_dolar',
        @o_siguiente= @w_siguiente out
  if @w_return <> 0 
  begin
	rollback tran
        return 1
  end

  /*si se asigno adecuadamente el numero secuencial, ingresar los datos*/
  insert into te_relacion_dolar  (rd_cod_moneda, rd_fecha_inicial, rd_fecha_final,
         rd_valor, rd_secuencial)
  values (@i_moneda,  @i_fechaini,  @i_fechafin,
         @i_valor,  @w_siguiente)

  if @@error != 0 
  begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
        @i_num   = 153050
        rollback tran
    	return 1

  end

  select @w_siguiente

  -- Ingresar transaccion de servicio
  insert into ts_reldo (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         cod_moneda, fecha_inicial, fecha_final,
         valor, secuencial)
  values (@s_ssn, 15216, 'N', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @i_moneda,  @i_fechaini,  @i_fechafin,
       @i_valor,  @w_siguiente)

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

-- Si se trata de modificacion
if @i_operacion = "U"
begin


  if not exists(select *
                  from te_relacion_dolar
                 where rd_secuencial = @i_secuencial)
  begin
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file,
    @t_from  = @w_sp_name,
    @i_num   = 151118  
    return 1
  end

  select @w_fechaini = rd_fecha_inicial,
         @w_fechafin = rd_fecha_final,
         @w_valor = rd_valor,
         @w_moneda = rd_cod_moneda
    from te_relacion_dolar  
   where rd_secuencial = @i_secuencial

   -- Verificar que no existan datos para una misma fecha
   if exists (select * 
                from te_relacion_dolar
               where (  
                        (@i_fechaini <= rd_fecha_inicial
                         and 
                         @i_fechafin >= rd_fecha_inicial
                        ) 
                      or
		        (@i_fechaini <= rd_fecha_final
                         and 
                         @i_fechafin >= rd_fecha_final
                        ) 
                      or
		        (
                         @i_fechaini >= rd_fecha_inicial
                         and 
                         @i_fechafin <= rd_fecha_final
                        )
                     )
                  and rd_cod_moneda = @i_moneda
                  and rd_secuencial <> @i_secuencial
             )
  begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
        @i_num   = 151117 
	return 1

  end

  -- Si se esta ingresando un rango de fechas anterior a un rango de
  -- fechas ya ingresado alertar
  if exists (select * 
	       from te_relacion_dolar
	      where @w_fechafin < rd_fecha_inicial
                and rd_cod_moneda = @w_moneda)
   begin
     print "ALERTA: Los datos ingresados tienen un rango de fecha anterior a otro ya ingresado, sin embargo los datos seran ingresados"
   end

  -- Alertar que el rango de fechas esta caducado
  if @i_fechafin < @s_date
  begin
    select @w_date = convert(char(10),@s_date,@i_formato_fecha)
    print "ALERTA: El rango de fechas a ingresar es menor a la fecha de proceso"+ convert(varchar(10), @w_date, 101) +", sin embargo los datos seran ingresados"
  end


 begin tran

 	Update te_relacion_dolar
	set 	rd_fecha_inicial= @i_fechaini,
     		rd_fecha_final 	= @i_fechafin, 
	     	rd_valor	= @i_valor	
	where 	rd_secuencial   = @i_secuencial


 if @@error != 0 
 begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
      @i_num   = 155052
	return 1

 end

 -- Ingresar transaccion de servicio
  insert into ts_reldo (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         cod_moneda, fecha_inicial, fecha_final,
         valor, secuencial)
  values (@s_ssn, 15217, 'P', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_moneda,  @w_fechaini,  @w_fechafin,
       @w_valor,  @i_secuencial)

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
  insert into ts_reldo (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         cod_moneda, fecha_inicial, fecha_final,
         valor, secuencial)
  values (@s_ssn, 15217, 'A', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_moneda,  @i_fechaini,  @i_fechafin,
       @i_valor,  @i_secuencial)

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

-- Si se trata de eliminacion
if @i_operacion = "D"
begin
  select @w_fechaini = rd_fecha_inicial,
         @w_fechafin = rd_fecha_final,
         @w_valor = rd_valor,
         @w_moneda = rd_cod_moneda
    from te_relacion_dolar  
   where rd_secuencial = @i_secuencial

 begin tran
   delete te_relacion_dolar
     where rd_secuencial = @i_secuencial

   if @@error != 0 
   begin
	exec cobis..sp_cerror
	@t_debug = @t_debug,
	@t_file  = @t_file,
	@t_from  = @w_sp_name,
        @i_num   = 157076
        return 1

   end

 -- Ingresar transaccion de servicio
  insert into ts_reldo (
         secuencia, tipo_transaccion, clase, fecha,
         oficina_s, usuario, terminal_s, srv, lsrv,
         cod_moneda, fecha_inicial, fecha_final,
         valor, secuencial)
  values (@s_ssn, 15218, 'B', @s_date,
	 @s_ofi, @s_user, @s_term, @s_srv, @s_lsrv,
       @w_moneda,  @w_fechaini,  @w_fechafin,
       @w_valor,  @i_secuencial)

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
  if @i_destino = "F"
  begin
   select "MONEDA"  = rd_cod_moneda, 
          "FEC INI" = rd_fecha_inicial, 
          "FEC FIN" = rd_fecha_final,
          "VALOR  " = rd_valor, 
          "SEC   "  = rd_secuencial
     from te_relacion_dolar
    where rd_cod_moneda = @i_moneda
      and isnull(@i_fecha_proceso,@s_date) 
         between rd_fecha_inicial
         and rd_fecha_final
  end
  else
  begin
   select @o_moneda = rd_cod_moneda, 
          @o_fechaini = rd_fecha_inicial, 
          @o_fechafin = rd_fecha_final,
          @o_valor = rd_valor, 
          @o_secuencial = rd_secuencial
     from te_relacion_dolar
    where rd_cod_moneda = @i_moneda
      and isnull(@i_fecha_proceso,@s_date) 
         between rd_fecha_inicial
         and rd_fecha_final
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
  set rowcount 106  

  select "SECUENCIAL" = rd_secuencial,
         "COD MDA" = rd_cod_moneda,
         "FECHA INI" = convert(varchar(10),rd_fecha_inicial,@i_formato_fecha),
         "FECHA FIN" = convert(varchar(10),rd_fecha_final, @i_formato_fecha),
         "VALOR" = rd_valor
  from te_relacion_dolar
  where rd_secuencial >= @i_secuencial
  and	(@i_moneda = rd_cod_moneda or @i_moneda is null)
  and (rd_fecha_inicial >= @i_fechaini or @i_fechaini = null) 
  and (rd_fecha_final <= @i_fechafin or @i_fechafin = null)

  if @@rowcount = 0
  begin
	exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 151118
  end    
 select 106

 return 0
end

go


