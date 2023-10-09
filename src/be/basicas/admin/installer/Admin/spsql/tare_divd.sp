/************************************************************************/
/*   Archivo           : b_tasdiv.sp                                    */
/*   Stored procedure  : sp_buscar_tasas_divisas                        */
/*   Base de datos     : cob_tesoreria                                  */
/*   Producto          : Tesoreria                                      */
/*   Disenado por      : Nidia Elena Silva                              */
/*   Fecha de escritura: 1996-05-13                                     */
/************************************************************************/
/*                       IMPORTANTE                                     */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   "MACOSA", representantes exclusivos para el Ecuador de la          */
/*   "NCR CORPORATION".                                                 */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de MACOSA o su representante.                */
/************************************************************************/
/*                       PROPOSITO                                      */
/*   Este SP busca las tasas interbancarias dados unos criterios de     */
/*   b-£squeda, pero en los cuales no se han incluido la fecha inicial  */
/*   ni la fecha final. Esto lo hace para la pantalla de Pizarra        */      
/*   en la pesta-¤a de Tasas de Divisas                                 */
/************************************************************************/
/*                    PERSONALIZACION BANCO DE PRESTAMOS                */
/*   13-May-1996   N. Silva          Emision inicial                    */
/*   28/Mar/2017   MB. Arias         Adaptacion ADMIN Referencias       */
/************************************************************************/

use cobis
go

if exists (select * from sysobjects where name = 'sp_tare_divd')
        drop proc sp_tare_divd
go


create proc sp_tare_divd (
        @s_ssn            int = null,
        @s_srv            varchar(30)      = null,
        @s_lsrv           varchar(30)      = null,
        @s_user           varchar(30)      = null,
        @s_sesn           int              = null,
        @s_ofi            smallint         = null,   
        @s_term           varchar(32)      = null,
        @s_date           datetime         = null,
        @s_rol            smallint         = null,
        @s_org            char(1)          = null,
        @t_corr           char(1)          = null,
        @t_debug          char(1)          = 'N',
        @t_file           varchar(14)      = null, 
        @t_from           varchar(32)      = null,  
        @t_rty            char(1)          = 'N',
        @t_trn            smallint,
        @i_operacion      char(1),
        @i_moneda         tinyint          = null, 
        @i_mercado        tinyint          = null,    
        @i_tasacomp       money            = null,   
        @i_tasaventa      money            = null,    
        @i_tascoch        money            = null, 
        @i_tasvech        money            = null,
        @i_cosint         money            = null,
        @i_numtasa        int              = null,
        @i_cond           char(1)          = null,
        @i_fechaini       datetime         = null,
        @i_fechafin       datetime         = null,
        @i_fecha_proceso  datetime         = null,
        @i_destino        char(1)          = "F",
        @i_formato_fecha  int              = 103,
        @i_fingreso       datetime         = null,
        @i_tran           char(1)          = 'Q',
        @o_moneda         tinyint          = null out, 
        @o_mercado        tinyint          = null out,    
        @o_tasacomp       money            = null out,   
        @o_tasaventa      money            = null out,    
        @o_tascoch        money            = null out, 
        @o_tasvech        money            = null out,
        @o_cosint         money            = null out,
        @o_numtasa        int              = null out,
        @o_fecha          datetime         = null out,
        @o_hora           datetime         = null out
)
as

declare @w_sp_name       varchar(20),
        @w_return        smallint,
        @w_fecha_char    varchar(10),
        @w_hora          varchar(8),  
        @w_maxfecha      datetime,
        @w_maxhora       datetime,
        @w_numtasa       int,
        @w_actu          char(1),
        @w_borro         char(1),
        @w_fecha         varchar(10), --datetime,
        @w_moneda        tinyint, 
        @w_mercado       tinyint,    
        @w_tasacomp      money,   
        @w_tasaventa     money,    
        @w_tascoch       money, 
        @w_tasvech       money,
        @w_cosint        money,
        @w_cdolar        tinyint,
        @w_cmnac         tinyint,
        @w_mercmx        tinyint,
        @w_maxdias       tinyint,
        @w_date          datetime,
        @w_costo_interno float,
        @w_sybformat     smallint

          


select @w_sp_name='sp_tare_divd',
       @w_sybformat  = 103

select @w_date = convert(datetime, @i_fingreso, @w_sybformat)

if (@t_trn != 15205 and @i_operacion  = 'I') or
   (@t_trn != 15206 and @i_operacion in ('U','A')) or
   (@t_trn != 15207 and @i_operacion  = 'D') or
   (@t_trn != 15208 and @i_operacion in ('S','H')) or
   (@t_trn != 15209 and @i_operacion  = 'Q') 
  begin
    exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file,
         @t_from  = @w_sp_name,
         @i_num   = 151051
    return 1
end

-- Se determina el codigo de mercado MONEX 
select  @w_mercmx = pa_tinyint
  from cobis..cl_parametro
 where pa_producto = 'TES'
   and pa_nemonico = 'CMERMX'
   
-- Si se trata de una insercion
if @i_operacion = 'I'
begin
   
   -- Determinar el rango de d+­as maximo para el ingreso
   select @w_maxdias = pa_tinyint
     from cobis..cl_parametro
    where pa_nemonico = 'MDIC'
      and pa_producto = 'TES'
   
   if (datediff(dd,@s_date, @w_date) > isnull(@w_maxdias,99999))
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1647253
      rollback tran
      return 1
   end
   
   -------------------------------
   -- Obtener Cotizacion contable
   -------------------------------
   -- busco la cotizacion de contabilidad si existiese para la fecha futura
   select @w_costo_interno = null
   if exists(select ct_valor
               from cob_conta..cb_cotizacion
              where ct_fecha = @i_fingreso
                and ct_moneda = @i_moneda)
   begin
      select @w_costo_interno = ct_valor
        from cob_conta..cb_cotizacion
       where ct_fecha  = @i_fingreso
         and ct_moneda = @i_moneda
   end
   else
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1641222   /*colocar el numero de error */
       return 1   
   end
   
   if @w_costo_interno = null
   begin
      /* 'Costo interno de la moneda no existe' */
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1647123   /*colocar el numero de error */
      return 1
   end
   
   -------------------------------
   -- Obtener valor de mercado
   -------------------------------
   select @w_mercado = 1
   select @w_hora = convert(varchar(8),getdate(),108)
   select @w_fecha = convert(varchar(10),@i_fingreso,@i_formato_fecha)
   
   begin tran
      /* obtener un nuevo secuencial */
      if @i_numtasa is null
      begin
         exec cobis..sp_cseqnos
              @t_debug     = @t_debug,
              @t_file      = @t_file,
              @t_from      = @w_sp_name,
              @i_tabla     = 'te_tasa_divisas',
              @o_siguiente = @w_numtasa     out
      end
      else
         select @w_numtasa = @i_numtasa
   
      ----------------------------------------
      -- Insercion de nuevas tasas de Divisas
      ----------------------------------------
      if isnull(@i_tascoch,0) = 0
         select @i_tascoch = @i_tasacomp 
      if isnull(@i_tasvech,0) = 0
         select @i_tasvech = @i_tasaventa
         
      insert into te_tasa_divisas
                  (td_num_tasa           ,   td_moneda             , td_cod_mercado,   td_fecha,
                   td_hora               ,                                             
                   td_tasa_compra_billete,   td_tasa_venta_billete , td_tasa_compra,   td_tasa_venta, 
                   td_costo_interno)                                                   
           values (@w_numtasa            ,   @i_moneda             , @i_mercado    ,   @w_date,
                   convert(varchar(10),@s_date,101)+ ' ' + convert(varchar(10),getdate(),108),
                   @i_tasacomp           ,   @i_tasaventa          , @i_tascoch    ,   @i_tasvech,
                   @w_costo_interno)
   
      if @@error != 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 1643010
         rollback tran
         return 1
      end
   
   commit tran
   
   select @w_hora
   select @w_fecha
   select @w_numtasa
   select @w_costo_interno
   
end

-- Autorizacion de Cotizaciones ingresadas por el estado de la divisa
 if (@i_operacion = 'A')   --GAP 600
 begin
    begin tran
       update te_tasa_divisas
          set td_autorizado = 'A'
        where td_num_tasa = @i_numtasa

      if @@error != 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file = @t_file,
              @t_from = @w_sp_name,
              @i_num = 1645025
         rollback
         return 1
      end

      delete te_tasa_divisas
       where  td_fecha = @w_date
         and  td_num_tasa < @i_numtasa
         and  td_moneda   = @i_moneda
         and isnull(td_autorizado, 'N') = 'N'

      if @@error != 0
      begin
         exec cobis..sp_cerror
              @t_debug = @t_debug,
              @t_file  = @t_file,
              @t_from  = @w_sp_name,
              @i_num   = 1645025
         return 1
       end
    commit tran
    return 0
end

-- Si se trata de una modificacion
if @i_operacion = 'U'
begin
  
   -- Se determina el codigo de mercado MONEX    
   if @i_mercado = @w_mercmx
      and not exists (select 1
                      from te_tasa_divisas
                      where td_moneda      = @i_moneda
                        and td_cod_mercado = @w_mercmx
                        and td_fecha       = @w_date)
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1643010
      return 1
   end
   
   if @w_mercmx = @i_mercado
   and  exists (select 1
                from te_tasa_divisas
                where td_moneda      = @i_moneda
                  and td_cod_mercado = @w_mercmx
                  and td_fecha       = @w_date
                  and td_autorizado  = 'A')
   begin
      print 'SE VA A MODIFICAR LA COTIZACION MONEX,SE DEBERA VOLVER A APROBARLA'
      update te_tasa_divisas
         set td_autorizado = null
       where td_num_tasa   = @i_numtasa
         and td_moneda     = @i_moneda
   end
   
   if not exists(select *
                 from te_tasa_divisas
                 where td_num_tasa = @i_numtasa)
   begin
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1641073
      return 1
   end


begin tran


   --------------------------------------
   -- Actualizacion de tasa de Divisas --
   --------------------------------------
   update te_tasa_divisas
   set    td_fecha               = @w_date,
          td_hora                = getdate(),
          td_tasa_compra_billete = @i_tasacomp,
          td_tasa_venta_billete  = @i_tasaventa,
          td_tasa_compra         = @i_tascoch,
          td_tasa_venta          = @i_tasvech,
          td_costo_interno       = @i_cosint
   where td_num_tasa = @i_numtasa 
     and td_fecha    = @w_date
     and td_hora     = (select max(td_hora)
                         from te_tasa_divisas
                        where td_num_tasa = @i_numtasa
                          and td_fecha    = @w_date)

   ----------------------------------------------------
   -- Toma el numero total de registros actualizados --
   ----------------------------------------------------
   if @@rowcount = 0
      select @w_actu = 'N'
   else
      select @w_actu = 'S'

   if @@error!=0
   begin
      rollback
      exec cobis..sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 1645025
      return 1
   end

   select @w_actu
   
    -- Ingresar transaccion de servicio
  insert into ts_divd (
                       secuencia          ,     tipo_transaccion  ,       clase      ,       fecha    ,
                       oficina_s          ,     usuario           ,       terminal_s ,       srv      ,    lsrv  ,
                       num_tasa           ,     moneda            ,       cod_mercado,       fecha_ing,         
                       hora               ,                                                                
                       tasa_compra_billete,     tasa_venta_billete,                                       
                       tasa_compra        ,     tasa_venta        ,     costo_interno)                    
               values (@s_ssn             ,     15206             ,     'P'          ,       @s_date ,    
                       @s_ofi             ,     @s_user           ,     @s_term      ,       @s_srv  ,     @s_lsrv,
                       @w_numtasa         ,     @w_moneda         ,     @w_mercado   ,       @w_fecha,           
                       @w_hora            ,                                                           
                       @w_tasacomp        ,     @w_tasaventa      ,                       
                       @w_tascoch         ,     @w_tasvech        ,         @w_cosint)    
                                                                              
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
                       secuencia,                tipo_transaccion,            clase,          fecha,
                       oficina_s,                usuario,                     terminal_s,     srv,        lsrv,
                       num_tasa,                 moneda,                      cod_mercado,    fecha_ing,      
                       hora,                          
                       tasa_compra_billete,      tasa_venta_billete,      
                       tasa_compra,              tasa_venta,                  costo_interno)
               values (@s_ssn,                   15206,                       'A',           @s_date,
                       @s_ofi,                   @s_user,                     @s_term,       @s_srv,     @s_lsrv,
                       @w_numtasa,               @w_moneda,                   @w_mercado,    getdate(),         
                       getdate(),                                             
                       @i_tasacomp,              @i_tasaventa,                
                       @i_tascoch,               @i_tasvech,                  @i_cosint)

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
if @i_operacion = 'D'
begin
   
   select @w_moneda     = td_moneda,           
          @w_mercado    = td_cod_mercado,
          @w_fecha      = td_fecha,      
          @w_hora       = td_hora,        
          @w_tasacomp   = td_tasa_compra_billete,  
          @w_tasaventa  = td_tasa_venta_billete,    
          @w_tascoch    = td_tasa_compra, 
          @w_tasvech    = td_tasa_venta,
          @w_cosint     = td_costo_interno
    from  te_tasa_divisas
   where  td_num_tasa = @i_numtasa
  
   begin tran
      delete te_tasa_divisas    
       where td_num_tasa = @i_numtasa  
         and td_fecha = @w_date --@s_date

        if @@rowcount = 0
          select @w_borro = 'N'
        else
          select @w_borro = 'S'
        
        select @w_borro
  
        -- Ingresar transaccion de servicio
        insert into ts_divd (
                             secuencia          ,    tipo_transaccion,      clase      ,     fecha    ,
                             oficina_s          ,    usuario         ,      terminal_s ,     srv      ,     lsrv,
                             num_tasa           ,    moneda          ,      cod_mercado,     fecha_ing,        
                             hora               ,                                                            
                             tasa_compra_billete,    tasa_venta_billete,                                     
                             tasa_compra        ,    tasa_venta,            costo_interno)                  
                    values ( @s_ssn             ,    15207,                 'B',             @s_date,    
                             @s_ofi             ,    @s_user,               @s_term,         @s_srv,     @s_lsrv,
                             @w_numtasa         ,    @w_moneda,             @w_mercado,      @s_date,         
                             @w_hora            ,                                              
                             @w_tasacomp        ,    @w_tasaventa,                       
                             @w_tascoch         ,    @w_tasvech,            @w_cosint)    

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
if @i_operacion = 'Q'
begin
   if @i_tran = 'Q'
   begin
     /* buscar fecha max en tabla cotizaciones */
     select @w_maxfecha = max(td_fecha)
       from te_tasa_divisas
      where td_moneda      = @i_moneda
        and td_cod_mercado = isnull(@i_mercado,1)
        and datediff(dd,td_fecha,isnull(@i_fecha_proceso, @s_date)) >= 0
        
    select @w_maxhora = max(td_hora)
      from te_tasa_divisas
     where td_moneda      = @i_moneda
       and td_cod_mercado = isnull(@i_mercado,1)
       and datediff(dd,td_fecha,@w_maxfecha) = 0
       and datediff(ss,td_fecha,isnull(@i_fecha_proceso, @s_date)) >= 0
   end
   else 
   begin
   print '1'   
   end
   
end

---------------------------------------------------------
-- Si se trata de una busqueda de un bloque de registros
---------------------------------------------------------
if @i_operacion = 'S'
begin
  
   /* Se determina el codigo del dolar */
   select @w_cdolar = pa_tinyint 
     from cobis..cl_parametro
    where pa_producto = 'ADM'
      and pa_nemonico = 'CDOLAR'
   
   /* Se determina el codigo de la moneda nacional */
   select @w_cmnac = pa_tinyint
     from cobis..cl_parametro
    where pa_producto = 'ADM'
      and pa_nemonico = 'MLO'
      
   select distinct 
          'COD. SEC.'         = td_num_tasa,
          'COD. MON.'         = td_moneda,           
          'COD. MERC.'        = td_cod_mercado,  
          'FECHA'             = convert(varchar(10),td_fecha,@i_formato_fecha),
          'HORA'              = convert(varchar(10),td_hora,108),
          'COTZ. BILL. COMP.' = td_tasa_compra_billete,
          'COTZ. BILL. VENT.' = td_tasa_venta_billete,
          'COTZ. CHE. COMP.'  = td_tasa_compra,
          'COTZ. CHE. VENT.'  = td_tasa_venta,
          'TIPO CAMBIO CONT.' = td_costo_interno,
          'AUTORIZADO'        = td_autorizado,
          'COTZ. DOL. COMP.'  = (select case when rd_operador = '*' then round(1/rd_valor,6)
                                                                    else rd_valor end
                                 from  cobis..te_relacion_dolar
                                 where rd_secuencial = td.td_num_tasa),
          'COTZ. DOL. VENTA'  = (select case when rd_operador = '*' then round(1/rd_valor_v,6)
                                                                    else rd_valor_v end
                                 from  cobis..te_relacion_dolar
                                 where rd_secuencial = td.td_num_tasa),
          'FECHA INGRESO'     = convert(varchar(10),td_hora,@i_formato_fecha)
     from te_tasa_divisas td
    where td_num_tasa > @i_numtasa
    order by td_num_tasa

end

-- Si se trata de una busqueda por fechas
if @i_operacion = 'H'
begin

   set rowcount 20
   
   select distinct 
          'COD. SEC.'         = td_num_tasa,
          'COD. MON.'         = td_moneda,
          'COD. MERC.'        = td_cod_mercado,  
          'FECHA'             = convert(varchar(10),td_fecha,@i_formato_fecha),
          'HORA'              = convert(varchar(10),td_hora,108),
          'COTZ. BILL. COMP.' = td_tasa_compra_billete,
          'COTZ. BILL. VENT.' = td_tasa_venta_billete,
          'COTZ. CHE. COMP.'  = td_tasa_compra,
          'COTZ. CHE. VENT.'  = td_tasa_venta,
          'TIPO CAMBIO CONT.' = td_costo_interno,
          'AUTORIZADO'        = td_autorizado,
          'COTZ. DOL. COMP.'  = (select case when rd_operador = '*' then round(1/rd_valor,6)
                                        else rd_valor end
                                  from cob_tesoreria..te_relacion_dolar
                                 where rd_secuencial = td.td_num_tasa),
          'COTZ. DOL. VENTA'  = (select case when rd_operador = '*' then round(1/rd_valor_v,6)
                                        else rd_valor_v end
                                   from cob_tesoreria..te_relacion_dolar
                                  where rd_secuencial = td.td_num_tasa)
     from te_tasa_divisas td
    where td_num_tasa  >  @i_numtasa      
      and (td_fecha    >= @i_fechaini    or @i_fechaini = null) 
      and (td_fecha    <= @i_fechafin    or @i_fechafin = null)
      and (@i_moneda   =  td_moneda      or @i_moneda   = null) 
      and (@i_mercado  =  td_cod_mercado or @i_mercado  = null)
    order by td_num_tasa
   
   /* En caso de que no existan registros en la tabla */
   if @@rowcount = 0
   begin
      /*  No existen registros en lineamientos del COAP */           
      exec sp_cerror
           @t_debug = @t_debug,
           @t_file  = @t_file,
           @t_from  = @w_sp_name,
           @i_num   = 151112
      return 1
   end
   else
      select 20
   
   set rowcount 0
   
   return 0
 
end
go
