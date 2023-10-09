use cob_cartera
go

---seleccionar los datos para el historico V.2 AGO-24-2011
IF exists (SELECT  1 FROM sysobjects WHERE name = 'ca_RES_HISTORICOS_tmp')
   drop table ca_RES_HISTORICOS_tmp 
go

CREATE TABLE dbo.ca_RES_HISTORICOS_tmp 
(
    res_secuencial_res int   NOT NULL,
    res_operacion      int   NOT NULL,
)
go
---CARGAR LOS DATOS DE LAS OPEACIONES PARA CORREGIRLOS
insert into ca_RES_HISTORICOS_tmp values (275,535108 )
insert into ca_RES_HISTORICOS_tmp values (98 ,743684 )
insert into ca_RES_HISTORICOS_tmp values (228,821162 )
insert into ca_RES_HISTORICOS_tmp values (117,971044 )
insert into ca_RES_HISTORICOS_tmp values (123,994782 )
insert into ca_RES_HISTORICOS_tmp values (100,1009057)
insert into ca_RES_HISTORICOS_tmp values (123,1030489)
insert into ca_RES_HISTORICOS_tmp values (100,1068050)
insert into ca_RES_HISTORICOS_tmp values (88 ,1100186)
insert into ca_RES_HISTORICOS_tmp values (82 ,1117110)
insert into ca_RES_HISTORICOS_tmp values (92 ,1121101)
insert into ca_RES_HISTORICOS_tmp values (93 ,1129864)
insert into ca_RES_HISTORICOS_tmp values (86 ,1148918)
insert into ca_RES_HISTORICOS_tmp values (80 ,1160501)
insert into ca_RES_HISTORICOS_tmp values (69 ,1173436)
insert into ca_RES_HISTORICOS_tmp values (80 ,1192473)
insert into ca_RES_HISTORICOS_tmp values (31 ,1209820)
insert into ca_RES_HISTORICOS_tmp values (66 ,1245031)
insert into ca_RES_HISTORICOS_tmp values (106,1263880)
insert into ca_RES_HISTORICOS_tmp values (87 ,1279727)
insert into ca_RES_HISTORICOS_tmp values (61 ,1370481)
go

if exists(select 1 from sysobjects where name = 'sp_RES_historicos_tmp')
   drop proc sp_RES_historicos_tmp
go

create proc sp_RES_historicos_tmp


as
declare
@w_res_operacion       int,
@w_div_vigente       smallint,
@w_valor_rubro       money,
@w_fecha_des         datetime,
@w_saldo_cap         money,
@w_op_banco          cuenta,
@w_porcentaje_inicial    float,
@w_di_dividendo      smallint,
@w_am_acumulado       money,
@w_secuencial_res     int,
@w_sec_inicial        int,
@w_res_secuencial_res int,
@w_dih_secuencial     int

declare Cur_RES_HIS_tmp cursor for
select res_secuencial_res,
       res_operacion 
 from ca_RES_HISTORICOS_tmp

for read only

open  Cur_RES_HIS_tmp
fetch Cur_RES_HIS_tmp into
@w_res_secuencial_res,
@w_res_operacion 
while @@fetch_status = 0
begin
         select @w_sec_inicial = 0
         select @w_sec_inicial = isnull(min(roh_secuencial),0)
         from ca_rubro_op_his
         where roh_operacion = @w_res_operacion
         and roh_secuencial > @w_res_secuencial_res
         
         PRINT '@w_sec_inicial:  ' + CAST (@w_sec_inicial as varchar) + ' Sec RES:  ' +  CAST  (@w_res_secuencial_res as varchar) + '  @w_res_operacion:   ' + CAST (@w_res_operacion as varchar) 
         
        if @w_sec_inicial > 0  
        begin
		        select @w_div_vigente  = min(dih_dividendo)
		        from ca_dividendo_his
		        where dih_operacion =  @w_res_operacion
		        and dih_estado  in(0,1)
		        and dih_secuencial = @w_sec_inicial
		        
		        select @w_am_acumulado = 0
		        select @w_am_acumulado = amh_acumulado  
		        from ca_amortizacion_his
		        where amh_operacion = @w_res_operacion                                 
		        and  amh_concepto   =  'SEGDEUVEN'
		        and  amh_dividendo  = @w_div_vigente 
		        and  amh_secuencial  = @w_sec_inicial
		        
		        select @w_porcentaje_inicial = 0
		        select  @w_porcentaje_inicial = isnull(min(roh_porcentaje),0)
		        from ca_rubro_op_his
		        where roh_operacion = @w_res_operacion
		        and roh_concepto = 'SEGDEUVEN'
		         
		        if  @w_porcentaje_inicial  = 0
		            select  @w_porcentaje_inicial= 0.03075
		                
               ---PRINT '@w_porcentaje_inicial ' + CAST (@w_porcentaje_inicial as varchar) + '@w_res_operacion:  ' + CAST (@w_res_operacion as varchar)
		
		        update ca_rubro_op_his
				set roh_porcentaje     =  @w_porcentaje_inicial,
				    roh_porcentaje_efa =  @w_porcentaje_inicial, 
				    roh_porcentaje_aux =  @w_porcentaje_inicial
				where roh_operacion   =  @w_res_operacion
				and roh_concepto      =  'SEGDEUVEN'
				and roh_secuencial > @w_res_secuencial_res
		
				declare Cur_dividendos_his cursor for 
				select dih_dividendo,
				       dih_secuencial
				from ca_dividendo_his
				where dih_operacion = @w_res_operacion
				and dih_dividendo >= @w_div_vigente
				and dih_secuencial > @w_res_secuencial_res
				order by dih_dividendo
				for read only
				
				open   Cur_dividendos_his
				
				fetch Cur_dividendos_his into
				@w_di_dividendo,
				@w_dih_secuencial
				
				while @@fetch_status = 0
				begin
			        select @w_saldo_cap = 0
					select @w_saldo_cap = isnull(sum(amh_cuota),0)
					from ca_amortizacion_his,ca_dividendo_his
					where amh_operacion = @w_res_operacion
					and amh_operacion = dih_operacion
					and amh_dividendo = dih_dividendo
					and dih_dividendo >= @w_di_dividendo
					and dih_secuencial = amh_secuencial
					and amh_secuencial = @w_dih_secuencial
					and dih_secuencial = @w_dih_secuencial
					and amh_concepto = 'CAP'
		           
		            select @w_valor_rubro = round((@w_saldo_cap * @w_porcentaje_inicial/100),0)

		                                           		            
		            if @w_res_operacion in (743684,1209820)  ---Estos son trimestrales
		               select @w_valor_rubro = @w_valor_rubro  * 3
		               
		               
		            if @w_am_acumulado > 0 and @w_di_dividendo = @w_div_vigente
		            begin
			           update  ca_amortizacion_his                                          
		 		       set amh_cuota     = @w_valor_rubro,
				           amh_acumulado = @w_valor_rubro
				       where amh_operacion = @w_res_operacion                                 
				       and  amh_concepto   =  'SEGDEUVEN'                           
				       and  amh_cuota     > 0                                      
				       and  amh_dividendo  = @w_di_dividendo  
				       and  amh_secuencial = @w_dih_secuencial
			        end
			        ELSE
			        begin
			           update  ca_amortizacion_his                                          
		 		       set amh_cuota      = @w_valor_rubro,
		 		           amh_acumulado  = 0
				       where amh_operacion = @w_res_operacion                                 
				       and  amh_concepto   =  'SEGDEUVEN'                           
				       and  amh_cuota     > 0                                      
				       and  amh_dividendo  = @w_di_dividendo  
				       and  amh_secuencial = @w_dih_secuencial
				       and  amh_acumulado  = 0
	                end

		
				   fetch   Cur_dividendos_his into
			           @w_di_dividendo,
			           @w_dih_secuencial

		
				end --WHILE CURSOR DIVIDENDOs
				close Cur_dividendos_his
				deallocate Cur_dividendos_his

	    end ----si haysecuencial para actaulizar		          
             
	 fetch Cur_RES_HIS_tmp into
		   @w_res_secuencial_res,
		  @w_res_operacion 
end --WHILE CURSOR PRINCIPAL
close Cur_RES_HIS_tmp
deallocate Cur_RES_HIS_tmp

return 0
go
PRINT 'INICIO EJECUCION sp_RES_historicos_tmp HISTORICOS 21 OPERACIONES'
PRINT ''
exec sp_RES_historicos_tmp
PRINT ''
PRINT 'FINNNNN PROCSEO'
go
