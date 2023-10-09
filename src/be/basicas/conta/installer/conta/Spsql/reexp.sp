/************************************************************************/
/*	Archivo: 		    reexp.sp                                        */
/*	Stored procedure: 	sp_reexpresion                                  */
/*	Base de datos:  	cob_conta                                       */
/*	Producto:           contabilidad                		            */
/*	Disenado por:                                               	    */
/*	Fecha de escritura:     agosto-2008 				                */
/************************************************************************/
/*				IMPORTANTE				                                */
/*	Este programa es parte de los paquetes bancarios propiedad de	    */
/*	"MACOSA", representantes exclusivos para el Ecuador de la 	        */
/*	"NCR CORPORATION".						                            */
/*	Su uso no autorizado queda expresamente prohibido asi como	        */
/*	cualquier alteracion o agregado hecho por alguno de sus		        */
/*	usuarios sin el debido consentimiento por escrito de la 	        */
/*	Presidencia Ejecutiva de MACOSA o su representante.		            */
/*				    PROPOSITO				                            */
/*	Este programa reexpresa en moneda local el valor en moneda          */
/*  extranjera                                                          */
/*	                                                                    */
/*				MODIFICACIONES				                            */
/*	FECHA		AUTOR		RAZON				                        */
/************************************************************************/

use cob_conta
go
if exists (select 1 from sysobjects where name = 'sp_reexpresion' and xtype = 'P')
    drop procedure sp_reexpresion
go
create procedure sp_reexpresion
(
@i_monbase1   tinyint,
@i_empresa    tinyint,
@i_periodo    smallint,
@i_corte      smallint,
@i_cuenta     cuenta_contable,
@i_fecha      datetime,
@i_operacion  char(1),
@i_username   login

)
as
declare
@w_trm            money,
@w_oficina        smallint,
@w_area           smallint,
@w_saldo          money,
@w_saldo_1        money,
@w_saldo_me       money,
@w_oficina_orig   smallint,
@w_area_orig      smallint,
@w_oficina_dest   smallint,
@w_diferencia     money,
@w_numcom         int,
@w_comprobante    int,
@w_condicion      smallint,
@w_decre          char(1),
@w_asiento        int,
@w_descripcion    varchar(100),
@w_ca_cta_asoc    cuenta_contable,
@w_cuentaaux      cuenta_contable,
@w_cuenta         cuenta_contable,
@w_suma_activo    money,
@w_inserto        smallint,
@w_credito        money,
@w_debito         money,
@w_creditoaux     money,
@w_cotiza         smallint,
@w_detalles       int,
@w_flag           tinyint

Select @w_trm = ct_valor
from cb_cotizacion
where ct_moneda = @i_monbase1
and   ct_fecha = @i_fecha

select @w_descripcion = 'PROCESO DE REEXPRESION MONETARIA'
select @w_flag = 0

truncate table cob_conta..reexpresion_saldo

if @i_operacion = 'A'
begin
   insert into reexpresion_saldo
   Select 
   sa_oficina,
   sa_area,
   sa_saldo,
   sa_saldo_me
   from cb_saldo
   where sa_empresa = @i_empresa
   and   sa_periodo = @i_periodo
   and   sa_corte   = @i_corte
   and   sa_oficina >= 0
   and   sa_area >= 0
   and   sa_cuenta  = @i_cuenta
end
if @i_operacion = 'N'
begin

print 'reexpresion_saldo'

   insert into reexpresion_saldo
   Select 
   hi_oficina,
   hi_area,
   hi_saldo,
   hi_saldo_me
   from cob_conta_his..cb_hist_saldo
   where hi_empresa = @i_empresa
   and   hi_periodo = @i_periodo
   and   hi_corte   = @i_corte
   and   hi_cuenta  = @i_cuenta
   and   hi_oficina >= 0
   and   hi_area >= 0
end

--begin tran

while 1 = 1
begin
   print '1'
   set rowcount 1

   select @w_asiento = 0
   select @w_numcom = 0
   select @w_comprobante = 0
   
   select @w_oficina  = sa_oficina,
          @w_area     = sa_area,
          @w_saldo    = sa_saldo,
          @w_saldo_me = sa_saldo_me
   from reexpresion_saldo
   order by sa_oficina, sa_area
   
   if @@rowcount = 0
       break
   print '2'
   delete from reexpresion_saldo
   where sa_oficina  = @w_oficina 
   and   sa_area     = @w_area   
   and   sa_saldo    = @w_saldo   
   and   sa_saldo_me = @w_saldo_me 

   set rowcount 0
   
   select @w_oficina_orig = @w_oficina
   select @w_area_orig    = @w_area
   select @w_oficina_dest = @w_oficina
   select @w_saldo_1        = @w_saldo_me  * @w_trm
   select @w_diferencia   = @w_saldo_1 - @w_saldo
   select @w_diferencia   = round(@w_diferencia,2)
   
   print '@w_saldo_me: ' + cast(@w_saldo_me as varchar)
   print '@w_saldo: ' + cast(@w_saldo as varchar)
   print '@w_diferencia: ' + cast(@w_diferencia as varchar)
   print '@w_trm: ' + cast(@w_trm as varchar)
    
   if  round(@w_diferencia,2) <> 0 begin

      print '@w_comprobante0: ' + cast(@w_numcom as varchar)
         
         print 'entra en nulo'
         execute sp_comprobt
      	 @t_trn          = 6111,
      	 @i_automatico   = 6031,
      	 @i_operacion    = 'I',
      	 @i_modo         = 0,
      	 @i_empresa      = @i_empresa,
      	 @i_oficina_orig = @w_oficina_orig,
      	 @i_area_orig    = @w_area_orig,
      	 @i_fecha_tran   = @i_fecha,
      	 @i_fecha_dig    = @i_fecha,
      	 @i_fecha_mod    = @i_fecha,
      	 @i_digitador    = @i_username,
      	 @i_descripcion  = @w_descripcion,
      	 @i_mayorizado   = 'N',
      	 @i_mayoriza     = 'N',
      	 @i_autorizado   = 'S',
      	 @i_autorizante  = @i_username,
      	 @i_reversado    = 'N',
         @o_tcomprobante = @w_numcom out

      	 if @@error <> 0
            return 1

      print '@w_comprobante1: ' + cast(@w_numcom as varchar)
      
      select @w_condicion = 1
      print '4'        

      Select 
      @w_ca_cta_asoc = ca_cta_asoc,
      @w_decre       = cu_categoria 
      from cb_cuenta_asociada,cb_cuenta
      where ca_empresa    = @i_empresa
      and   ca_proceso    = 6031
      and   ca_cuenta     = @i_cuenta
      and   ca_oficina    >= 0
      and   ca_area       >= 0
      and   ca_secuencial >= 0
      and   ca_condicion  = @w_condicion   -- Se toma condición 1 cuando existe incremento y 2 cuando existe decremento
      and   cu_empresa    = ca_empresa
      and   cu_cuenta     = ca_cuenta

      if @@rowcount = 0
      begin
         return 0
      end
      else
      begin
         if @w_decre = 'C'
            select @w_diferencia = @w_diferencia * -1
              
         if ((@w_decre = 'D') and (@w_diferencia < 0))  or ((@w_decre = 'C') and (@w_diferencia > 0))
         begin
         print 'aso 1'
  	        select @w_credito    = abs(@w_diferencia)
  	        select @w_debito     = 0
  	        select @w_cotiza     = 0
  	        if @w_decre = 'D'
  	            select @w_condicion = 2
  	        if @w_decre = 'C'
  	            select @w_condicion = 1
         end
         else
         begin
            if ((@w_decre = 'D' AND @w_diferencia > 0) OR (@w_decre = 'C' AND @w_diferencia < 0))
            begin
            print 'aso 2'
               select @w_credito    = 0
               select @w_debito     = abs(@w_diferencia)
               select @w_cotiza     = 0     
  	           if @w_decre = 'D'
  	               select @w_condicion = 1
  	           if @w_decre = 'C'
  	               select @w_condicion = 2
              
            end
         end        
         Select
         max(ta_asiento)
         from cb_tasiento
         where ta_empresa    = @i_empresa
         and ta_fecha_tran   = @i_fecha
         and ta_comprobante  = @w_numcom
         and ta_asiento      >= 0
         and ta_oficina_orig >= 0
           
         if @w_asiento is null 
         begin
            select @w_asiento = 1
         end
         else
         begin
            select @w_asiento = @w_asiento
            select @w_asiento = @w_asiento+1
         end
         print '5' 
         print '@w_comprobante: ' + cast(@w_numcom as varchar)   
         print '@w_asiento: '+ cast (@w_asiento as varchar)  
         print '@i_cuenta  : '+ cast (@i_cuenta as varchar) 
         print '@w_credito : '+cast (@w_credito as varchar) 
         print '@w_debito : '+cast (@w_debito as varchar)
         print '@w_asiento: ' + cast(@w_asiento as varchar)

         execute sp_asientot
         @t_trn          = 6341,
         @i_operacion    = 'I',
         @i_modo         = 0,
         @i_empresa      = @i_empresa,
         @i_fecha_tran   = @i_fecha,
         @i_comprobante  = @w_numcom,
         @i_asiento      = @w_asiento,
         @i_oficina_orig = @w_oficina_orig,
         @i_cuenta       = @i_cuenta,
         @i_oficina_dest = @w_oficina_dest,
         @i_area_dest    = @w_area_orig,
         @i_credito      = @w_credito,
         @i_debito       = @w_debito,
         @i_concepto     = @w_descripcion,
         @i_credito_me   = 0,
         @i_debito_me    = 0,
         @i_cotizacion   = @w_cotiza,
         @i_tipo_doc     = 'N',
         @i_mayorizado   = 'N',
         @i_tipo_tran    = 'C'
         	
         if @@error <> 0
            return 1
            
         Select 
         @w_ca_cta_asoc = ca_cta_asoc,
         @w_decre       = cu_categoria 
         from cb_cuenta_asociada,cb_cuenta
         where ca_empresa    = @i_empresa
         and   ca_proceso    = 6031
         and   ca_cuenta     = @w_cuenta
         and   ca_oficina    >= 0
         and   ca_area       >= 0
         and   ca_secuencial >= 0
         and   ca_condicion  = @w_condicion   -- Se toma condición 1 cuando existe incremento y 2 cuando existe decremento
         and   cu_empresa    = ca_empresa
         and   cu_cuenta     = ca_cuenta            
         
         if @@rowcount = 0 begin
            select @w_condicion = 1
            
            Select 
            @w_ca_cta_asoc = ca_cta_asoc,
            @w_decre       = cu_categoria 
            from cb_cuenta_asociada,cb_cuenta
            where ca_empresa    = @i_empresa
            and   ca_proceso    = 6031
            and   ca_cuenta     = @w_cuenta
            and   ca_oficina    >= 0
            and   ca_area       >= 0
            and   ca_secuencial >= 0
            and   ca_condicion  = @w_condicion   -- Se toma condición 1 cuando existe incremento y 2 cuando existe decremento
            and   cu_empresa    = ca_empresa
            and   cu_cuenta     = ca_cuenta 
         end                   
            
         select @w_cuentaaux  = @w_cuenta
         select @w_cuenta     = @w_ca_cta_asoc
         select @w_creditoaux = @w_credito
         select @w_credito    = @w_debito
         select @w_debito     = @w_creditoaux
          
         print '@w_ca_cta_asoc  : '+ cast (@w_ca_cta_asoc as varchar) 
         print '@w_credito1 : '+cast (@w_credito as varchar) 
         print '@w_debito2 : '+cast (@w_debito as varchar)                   
          
         select @w_asiento = @w_asiento + 1
         print '@w_asiento2: ' + cast(@w_asiento as varchar)
         execute sp_asientot
         @t_trn          = 6341,
         @i_operacion    = 'I',
         @i_modo         = 0,
         @i_empresa      = @i_empresa,
         @i_fecha_tran   = @i_fecha,
         @i_comprobante  = @w_numcom,
         @i_asiento      = @w_asiento,
         @i_oficina_orig = @w_oficina_orig,
         @i_cuenta       = @w_ca_cta_asoc,
         @i_oficina_dest = @w_oficina_dest,
         @i_area_dest    = @w_area_orig,
         @i_credito      = @w_credito,
         @i_debito       = @w_debito,
         @i_concepto     = @w_descripcion,
         @i_credito_me   = 0,
         @i_debito_me    = 0,
         @i_cotizacion   = @w_cotiza,
         @i_tipo_doc     = 'N',
         @i_mayorizado   = 'N',
         @i_tipo_tran    = 'C'
         
         select @w_cuenta = @w_cuentaaux
         select @w_inserto  = 1
      end
      select @w_suma_activo = @w_suma_activo + @w_diferencia
      select @w_saldo = 0
      select @w_diferencia = 0
      select @w_flag = 1
        
   end
end 

print 'sale while 1'

SET ROWCOUNT 0

if @w_flag = 1
begin

   select distinct ct_comprobante
   into #comprobante_tmp
   from cob_conta..cb_tcomprobante
   where ct_fecha_tran  = @i_fecha
   and   ct_automatico  = 6031
   and   ct_comprobante  > 0
   and   ct_oficina_orig > 0

   select * from #comprobante_tmp
   
   while 1 = 1 begin
      select top 1 @w_comprobante = ct_comprobante
      from #comprobante_tmp
      
      if @@rowcount = 0 break
      
      delete #comprobante_tmp
      where ct_comprobante = @w_comprobante
      
      print 'entra definitivo'
      Select distinct 
      @w_comprobante  = ct_comprobante,
      @w_oficina_orig = ct_oficina_orig
      from cb_tcomprobante, cb_tasiento
      where ta_empresa     = ct_empresa
      and   ta_fecha_tran  = @i_fecha
      and   ta_comprobante = ct_comprobante
      and   ta_asiento >= 0
      and   ta_oficina_orig >= 0
      and   ct_empresa     = convert(tinyint,@i_empresa)
      and   ct_fecha_tran  = @i_fecha
      and   ct_comprobante = @w_comprobante
      and   ct_oficina_orig = ta_oficina_orig
      and   ct_automatico  = 6031
      
      Select 
      @w_detalles = max(ta_asiento),
      @w_debito   = sum(ta_debito),
      @w_credito  = sum(ta_credito)
      from cb_tasiento
      where ta_empresa     = convert(tinyint,@i_empresa)
      and   ta_fecha_tran  = @i_fecha
      and   ta_comprobante = convert(int,@w_comprobante)
      and   ta_asiento     >= 0
      and   ta_oficina_orig = @w_oficina_orig
        
      print 'detalles: ' + cast(@w_detalles as varchar)
      
      execute sp_compmig
      @t_trn            = 6342,
      @i_operacion      = 'I',
      @i_empresa        = @i_empresa,
      @i_fecha_tran     = @i_fecha,
      @i_comprobante    = @w_comprobante,
      @i_oficina_orig   = @w_oficina_orig,
      @i_tot_debito     = @w_debito,
      @i_tot_credito    = @w_credito,
      @i_tot_debito_me  = 0,
      @i_tot_credito_me = 0,
      @i_detalles       = @w_detalles
      	
      if @@error <> 0
      begin
         insert into cob_conta..cb_erreres_batch
         values('reexp', getdate())        
         return 1
      end
   end
        
   print '@w_comprobante'    	
end	

--commit tran
return 0 
go
