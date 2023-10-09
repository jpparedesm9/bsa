
----segdeuven_tmp.sp V2
use cob_cartera
go

if exists(select 1 from sysobjects where name = 'sp_recal_seg_RES_tmp')
   drop proc sp_recal_seg_RES_tmp
go

create proc sp_recal_seg_RES_tmp


as
declare
@w_operacionca       int,
@w_div_vigente       smallint,
@w_valor_rubro       money,
@w_valor_rubro_antes money,
@w_fecha_hoy         datetime,
@w_fecha_des         datetime,
@w_saldo_cap         money,
@w_op_banco          cuenta,
@w_porcentaje_des    float,
@w_di_dividendo      smallint,
@w_am_acumulado      money,
@w_op_tdividendo     char(1),
@w_oficina_op        int


select @w_fecha_hoy = fc_fecha_cierre
from cobis..ba_fecha_cierre 
where fc_producto = 7




declare Cur_seg_RES_tmp cursor for
select op_fecha_ini,
       tr_operacion,
       op_banco,
       op_tdividendo
 from ca_transaccion with (nolock),
      ca_operacion with (nolock) 
where tr_operacion  in (821162,       1160501,      1245031,      1279727,      
                        535108,       994782,       1068050,      1100186,      1192473,      1209820,      
                        1370481,      1009057,      1121101,      1129864,      1148918,      1173436,      
                        743684,       971044,       1030489,      1117110,      1263880 )
and tr_operacion = op_operacion 
and tr_tran      = 'RES'
and tr_secuencial_ref >= 0
and tr_estado <>'RV'

for read only

open  Cur_seg_RES_tmp
fetch Cur_seg_RES_tmp into
@w_fecha_des,
@w_operacionca,
@w_op_banco,
@w_op_tdividendo

while @@fetch_status = 0
begin
        PRINT 'OBligacion:   ' + CAST (@w_op_banco as varchar)
        
        ---SEGUN LA FECHA DEL DESEMBOLSO SE PONE EL PROCENTAJE
        if @w_fecha_des <= '08/01/2010' 
          select @w_porcentaje_des = 0.03
        else
          select @w_porcentaje_des = 0.03075

        update ca_rubro_op
		set ro_porcentaje     =  @w_porcentaje_des,
		    ro_porcentaje_efa =  @w_porcentaje_des, 
		    ro_porcentaje_aux =  @w_porcentaje_des
		where ro_operacion   =  @w_operacionca
		and ro_concepto      =  'SEGDEUVEN'
	       
	    select @w_valor_rubro_antes = 0
	    select @w_valor_rubro_antes = am_acumulado  
	    from ca_amortizacion
	    where am_operacion = @w_operacionca                                 
	    and  am_concepto   =  'SEGDEUVEN'
        and  am_dividendo  = @w_div_vigente 

        select @w_div_vigente  = di_dividendo
        from ca_dividendo
        where di_operacion =  @w_operacionca
        and di_estado = 1

		declare Cur_dividendos cursor for 
		select di_dividendo
		from ca_dividendo
		where di_operacion = @w_operacionca
		and di_dividendo >= @w_div_vigente
		order by di_dividendo
		for read only
		
		open   Cur_dividendos
		
		fetch Cur_dividendos into
		@w_di_dividendo
		
		while @@fetch_status = 0
		begin
		     

		       select @w_saldo_cap = 0
       
				select @w_saldo_cap = sum(am_cuota)
				from ca_amortizacion,ca_dividendo
				where am_operacion = @w_operacionca
				and am_operacion = di_operacion
				and am_dividendo = di_dividendo
				and di_dividendo >= @w_di_dividendo
				and am_concepto = 'CAP'
	           
				
	           select @w_valor_rubro = round((@w_saldo_cap * @w_porcentaje_des/100),0)
	           
	           if @w_op_tdividendo = 'T'
	              select @w_valor_rubro = @w_valor_rubro  * 3
	              
	              
	           PRINT '  DIV:  ' + CAST (@w_di_dividendo as varchar) + ' VALORSEG: ' + CAST  (@w_valor_rubro as varchar) + ' % : ' + CAST (@w_porcentaje_des as varchar) + '  SALDOCAP: ' + CAST (@w_saldo_cap as varchar) + ' @w_op_tdividendo : ' + CAST ( @w_op_tdividendo as varchar)
	           
	           if @w_di_dividendo = @w_div_vigente
	           begin
		           update  ca_amortizacion                                          
	 		       set am_cuota     = @w_valor_rubro,
			           am_acumulado = @w_valor_rubro
			       where am_operacion = @w_operacionca                                 
			       and  am_concepto   =  'SEGDEUVEN'                           
			       and  am_cuota     > 0                                      
			       and  am_dividendo  = @w_di_dividendo  
		       end
		       ELSE
		       begin
	   	           update  ca_amortizacion                                          
	 		       set am_cuota     = @w_valor_rubro
			       where am_operacion = @w_operacionca                                 
			       and  am_concepto   =  'SEGDEUVEN'                           
			       and  am_cuota     > 0                                      
			       and  am_dividendo  = @w_di_dividendo  
               end
		
		 fetch   Cur_dividendos into
		          @w_di_dividendo
		
		end --WHILE CURSOR DIVIDENDOs
		close Cur_dividendos
		deallocate Cur_dividendos

		select @w_am_acumulado = 0
        select @w_am_acumulado = am_acumulado  
        from ca_amortizacion
        where am_operacion = @w_operacionca                                 
        and  am_concepto   =  'SEGDEUVEN'
        and  am_dividendo  = @w_div_vigente 
  
         if @w_valor_rubro_antes <> @w_am_acumulado
         begin
             ----se reversa el valor y e contabiliza el nuevo
			insert into ca_transaccion_prv with (rowlock)
			(
			tp_fecha_mov,        tp_operacion,        tp_fecha_ref,
			tp_secuencial_ref,   tp_estado,           tp_dividendo,
			tp_concepto,         tp_codvalor,         tp_monto,
			tp_secuencia,        tp_comprobante,      tp_ofi_oper)
			select 
			@w_fecha_hoy,        tp_operacion,        @w_fecha_hoy,
			-999,                'ING',               tp_dividendo,
			tp_concepto,         tp_codvalor,         tp_monto*-1,
			1,                   0,                   tp_ofi_oper
			from ca_transaccion_prv
			where tp_operacion = @w_operacionca
			and tp_concepto  = 'SEGDEUVEN'
			and tp_dividendo = @w_div_vigente
			and tp_estado = 'CON'
			and tp_secuencial_ref >= 0
			
	        ---se contabiliza el nuevo valor
			update  ca_transaccion_prv
			set tp_monto = @w_valor_rubro,
			    tp_estado = 'ING',
			    tp_fecha_mov  = @w_fecha_hoy,
			    tp_comprobante  = 0
			where tp_operacion = @w_operacionca
			and tp_concepto  = 'SEGDEUVEN'
			and tp_dividendo = @w_div_vigente
			and tp_estado = 'CON'
			and tp_secuencial_ref >= 0

        end --cambio el valor
             
	 fetch   Cur_seg_RES_tmp into
	          @w_fecha_des,
	          @w_operacionca,
	          @w_op_banco,
	          @w_op_tdividendo

end --WHILE CURSOR PRINCIPAL
close Cur_seg_RES_tmp
deallocate Cur_seg_RES_tmp

return 0
go

print ''
print ''
print ''
print 'Inicio Ejecucion sp para RES'
print ''
select getdate()
go
exec sp_recal_seg_RES_tmp
go
print ''
print ''
print ''
PRINT 'FINNN PROCESO'
print ''
select getdate()
go