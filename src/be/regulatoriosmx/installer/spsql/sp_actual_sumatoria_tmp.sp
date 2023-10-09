
/* ********************************************************************* */
/*      Archivo:                sp_actual_sumatoria_tmp.sp               */
/*      Stored procedure:       sp_actual_sumatoria_tmp                  */
/*      Base de datos:          cob_conta_super                          */
/*      Producto:               Regulatorios                             */
/*      Disenado por:           Darío Cumbal                             */
/*      Fecha de escritura:     03-Mar-2020                              */
/* ********************************************************************* */
/*                              IMPORTANTE                               */
/*      Este programa es parte de los paquetes bancarios propiedad de    */
/*      "MACOSA", representantes exclusivos para el Ecuador de la        */
/*      "NCR CORPORATION".                                               */
/*      Su uso no autorizado queda expresamente prohibido asi como       */
/*      cualquier alteracion o agregado hecho por alguno de sus          */
/*      usuarios sin el debido consentimiento por escrito de la          */
/*      Presidencia Ejecutiva de MACOSA o su representante.              */
/* ********************************************************************* */
/*                              PROPOSITO                                */
/*      Programa temporal para sumatoria de contabilidad                 */
/* ********************************************************************* */
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    03/Mar/2020           DCU              emision inicial, solucion   */
/*                                           temporal                    */
/* ********************************************************************* */


use cob_conta
go
if exists (select 1 from sysobjects where name = 'sp_actual_sumatoria_tmp')
    drop proc sp_actual_sumatoria_tmp
go
create proc sp_actual_sumatoria_tmp
	@i_param1   datetime
as

declare @w_nivel         int,
        @w_ejecucion     varchar(1),
        @w_corte         int,
        @w_periodo       int,
        @w_corte_fin     int,
        @w_fecha_proceso datetime,
        @w_fecha_ini     datetime

if @i_param1 is null        
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso       
else 
   select @w_fecha_proceso = @i_param1

select @w_fecha_proceso = dateadd(dd,-1,@w_fecha_proceso)
select @w_fecha_ini = dateadd(month, datediff(month, 0, @w_fecha_proceso), 0)   
  
select @w_corte   = co_corte,
       @w_periodo = co_periodo
from  cob_conta..cb_corte
where co_fecha_ini = @w_fecha_ini

select @w_corte, @w_periodo, @w_fecha_ini

select @w_ejecucion = 'N'
select @w_nivel = 7

select *
into #saldo
from cob_conta..cb_saldo
where 1 = 2

while @w_nivel > 1
begin
   
   truncate table #saldo
   
   insert into #saldo
   select sa_empresa, cu_cuenta_padre, sa_oficina, sa_area, sa_corte, sa_periodo, 
   sum(sa_saldo), 
   sum(sa_saldo_me), 
   sum(sa_debito),  
   sum(sa_credito), 
   sum(sa_debito_me), 
   sum(sa_credito_me)
   from cob_conta..cb_saldo,
        cob_conta..cb_cuenta
   where sa_cuenta       = cu_cuenta  
   and   cu_nivel_cuenta = @w_nivel
   group by sa_empresa, cu_cuenta_padre, sa_oficina, sa_area, sa_corte, sa_periodo
    
   if exists (select
              s.sa_saldo  , t.sa_saldo,
              s.sa_debito , t.sa_debito,
              s.sa_credito, t.sa_credito
              from cob_conta..cb_saldo s, #saldo t
              where s.sa_empresa = t.sa_empresa
              and s.sa_cuenta    = t.sa_cuenta
              and s.sa_oficina   = t.sa_oficina
              and s.sa_area      = t.sa_area
              and s.sa_corte     = t.sa_corte
              and s.sa_periodo   = t.sa_periodo
              and (s.sa_saldo     <> t.sa_saldo or s.sa_debito <> t.sa_debito or s.sa_credito <> t.sa_credito))
   begin
      select @w_ejecucion  = 'S'
   end            
    
   
   delete #saldo
   from cob_conta..cb_saldo s, #saldo t
   where s.sa_empresa = t.sa_empresa
   and s.sa_cuenta    = t.sa_cuenta
   and s.sa_oficina   = t.sa_oficina
   and s.sa_area      = t.sa_area
   and s.sa_corte     = t.sa_corte
   and s.sa_periodo   = t.sa_periodo
   

   if exists(select 1 from #saldo )
   begin
      select @w_ejecucion = 'S'
   end
       
   select '1.@w_nivel' = @w_nivel  
   select @w_nivel = @w_nivel - 1
end

select 'EJECUCIO' = @w_ejecucion


if @w_ejecucion = 'S'
begin
    
   if exists(select 1 from sysobjects where name = 'cb_saldo_respaldo_suma') 
   drop table cb_saldo_respaldo_suma
   
   select * into cb_saldo_respaldo_suma from cob_conta..cb_saldo
   
   if exists(select 1 from sysobjects where name = 'cb_hist_respaldo_suma') 
   drop table cb_hist_respaldo_suma
   
   select * 
   into cb_hist_respaldo_suma 
   from cob_conta_his..cb_hist_saldo
   where hi_empresa = 1
   and   hi_periodo = @w_periodo
   and   hi_corte   >= @w_corte
   
   /************************************************************************/
   /* Saldo Actual                                                         */
   /************************************************************************/
   select @w_nivel = 7
   truncate table #saldo

   while @w_nivel > 1
   begin
        
        truncate table #saldo
        
        insert into #saldo
        select sa_empresa, cu_cuenta_padre, sa_oficina, sa_area, sa_corte, sa_periodo, 
        sum(sa_saldo), 
        sum(sa_saldo_me), 
        sum(sa_debito),  
        sum(sa_credito), 
        sum(sa_debito_me), 
        sum(sa_credito_me)
        from cb_saldo,
             cb_cuenta
        where sa_cuenta       = cu_cuenta  
        and   cu_nivel_cuenta = @w_nivel
        group by sa_empresa, cu_cuenta_padre, sa_oficina, sa_area, sa_corte, sa_periodo
        
        update cb_saldo set
        sa_saldo  = t.sa_saldo,
        sa_debito = t.sa_debito,
        sa_credito= t.sa_credito
        from cb_saldo s, #saldo t
        where s.sa_empresa = t.sa_empresa
        and   s.sa_cuenta  = t.sa_cuenta
        and   s.sa_oficina = t.sa_oficina
        and s.sa_area      = t.sa_area
        and s.sa_corte     = t.sa_corte
        and s.sa_periodo   = t.sa_periodo
        and (s.sa_saldo     <> t.sa_saldo or s.sa_debito <> t.sa_debito or s.sa_credito <> t.sa_credito)
        
            
        delete #saldo
        from cb_saldo s, #saldo t
        where s.sa_empresa = t.sa_empresa
        and s.sa_cuenta    = t.sa_cuenta
        and s.sa_oficina   = t.sa_oficina
        and s.sa_area      = t.sa_area
        and s.sa_corte     = t.sa_corte
        and s.sa_periodo   = t.sa_periodo
        
        insert into cb_saldo
        select * from #saldo 
         
        select @w_nivel  
        select @w_nivel = @w_nivel - 1
   end
   
   /************************************************************************/
   /* Saldo Actual Historico                                               */
   /************************************************************************/
   select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso
   select @w_corte_fin     = max(hi_corte) from cob_conta_his..cb_hist_saldo where hi_periodo = @w_periodo
   
   truncate table #saldo
   
   while @w_corte <= @w_corte_fin
   begin
      select @w_nivel = 7
      
      while @w_nivel > 1
      begin
         truncate table #saldo
         
         insert into #saldo
         select hi_empresa, cu_cuenta_padre, hi_oficina, hi_area, hi_corte, hi_periodo,
         sum(hi_saldo),
         sum(hi_saldo_me),
         sum(hi_debito),
         sum(hi_credito),
         sum(hi_debito_me),
         sum(hi_credito_me)
         from cob_conta_his..cb_hist_saldo,
              cob_conta..cb_cuenta
         where hi_empresa      = 1
	     and   hi_periodo      = @w_periodo
	     and   hi_corte        = @w_corte
	     and   hi_cuenta       = cu_cuenta
         and   cu_nivel_cuenta = @w_nivel
         group by hi_empresa, cu_cuenta_padre, hi_oficina, hi_area, hi_corte, hi_periodo
         
         update cob_conta_his..cb_hist_saldo set
         hi_saldo  = t.sa_saldo,
         hi_debito = t.sa_debito,
         hi_credito= t.sa_credito
         from cob_conta_his..cb_hist_saldo s, #saldo t
         where s.hi_empresa = 1
	     and s.hi_periodo   = @w_periodo
	     and s.hi_corte     = @w_corte
	     and s.hi_empresa   = t.sa_empresa
         and s.hi_cuenta    = t.sa_cuenta
         and s.hi_oficina   = t.sa_oficina
         and s.hi_area      = t.sa_area
         and s.hi_corte     = t.sa_corte
         and s.hi_periodo   = t.sa_periodo
         and (s.hi_saldo     <> t.sa_saldo or s.hi_debito <> t.sa_debito or s.hi_credito <> t.sa_credito)
          
         
         delete #saldo
         from cob_conta_his..cb_hist_saldo s, #saldo t
         where s.hi_empresa = t.sa_empresa
         and s.hi_cuenta    = t.sa_cuenta
         and s.hi_oficina   = t.sa_oficina
         and s.hi_area      = t.sa_area
         and s.hi_corte     = t.sa_corte
         and s.hi_periodo   = t.sa_periodo
         
         insert into cob_conta_his..cb_hist_saldo
         select * from #saldo
         
         select @w_nivel
         select @w_nivel = @w_nivel - 1
      end
      select @w_corte = @w_corte + 1
   end   
end


drop table #saldo

RETURN 0

GO 

