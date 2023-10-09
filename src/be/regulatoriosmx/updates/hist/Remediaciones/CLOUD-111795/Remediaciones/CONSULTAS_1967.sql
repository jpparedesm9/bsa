


declare @w_grupo int 

select @w_grupo = 1967

select 'cl_grupo'             = 'cl_grupo'                 ,* from cobis..cl_grupo                  where gr_grupo = @w_grupo
select 'cl_cliente_grupo'     = 'cl_cliente_grupo'         ,* from cobis..cl_cliente_grupo          where cg_grupo = @w_grupo
select 'cr_tramite_grupal'    = 'cr_tramite_grupal'        ,* from cob_credito..cr_tramite_grupal   where tg_grupo = @w_grupo
select 'ca_ciclo'	          = 'ca_ciclo'                 ,* from cob_cartera..ca_ciclo    	    where ci_grupo = @w_grupo
select 'ca_det_ciclo'         = 'ca_det_ciclo'     	       ,* from cob_cartera..ca_det_ciclo	    where dc_grupo = @w_grupo
select 'ca_operacion' 	      = 'ca_operacion'             ,* from cob_cartera..ca_operacion 	    where op_operacion  in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
select 'ca_dividendo' 	      = 'ca_dividendo' 	     	   ,* from cob_cartera..ca_dividendo 	    where di_operacion  in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
select 'ca_amortizacion'      = 'ca_amortizacion'    	   ,* from cob_cartera..ca_amortizacion     where am_operacion  in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
select 'ca_otro_cargo'        =  'ca_otro_cargo'           ,* from cob_cartera..ca_otro_cargo       where oc_operacion  in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
select 'ca_rubro_op'          = 'ca_rubro_op'              ,* from cob_cartera..ca_rubro_op         where ro_operacion  in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
select 'ca_garantia_liquida'  = 'ca_garantia_liquida'      ,* from cob_cartera..ca_garantia_liquida where gl_grupo = @w_grupo

select 'ca_corresponsal_trn'  = 'ca_corresponsal_trn'      ,* from cob_cartera..ca_corresponsal_trn where co_referencia like '%00' + convert(varchar,@w_grupo) + '%'
union
select 'ca_corresponsal_trn'  = 'ca_corresponsal_trn'      ,* from cob_cartera..ca_corresponsal_trn where co_referencia in (select distinct  op_banco from cob_cartera..ca_operacion,cob_credito..cr_tramite_grupal where op_cliente = @w_grupo and   op_banco   = tg_referencia_grupal )


select 'ca_operacion_his'     =  'ca_operacion_his'    	   ,o.* from cob_cartera..ca_operacion_his o        where oph_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
union
select 'ca_operacion_his'     ='ca_operacion_his'          ,o.* from cob_cartera_his..ca_operacion_his o    where oph_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)

select 'ca_dividendo_his'     ='ca_dividendo_his'          ,d.* from cob_cartera..ca_dividendo_his d        where dih_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
union
select 'ca_dividendo_his'     ='ca_dividendo_his'          ,d.* from cob_cartera_his..ca_dividendo_his d    where dih_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)

select 'ca_amortizacion_his'  ='ca_amortizacion_his'       ,a.* from cob_cartera..ca_amortizacion_his a     where amh_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
union
select 'ca_amortizacion_his'  ='ca_amortizacion_his'       ,a.* from cob_cartera_his..ca_amortizacion_his a where amh_operacion in (select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)

select 'ca_transaccion+det'       = 'ca_transaccion+det' 	       ,* 
from cob_cartera..ca_transaccion , cob_cartera..ca_det_trn
   where tr_operacion  in( select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
	    and   tr_operacion = dtr_operacion
	    and   tr_secuencial = dtr_secuencial
	    

select 'ca_abono+det'             = 'ca_abono+det'    	     	   ,* 
from cob_cartera..ca_abono,  cob_cartera..ca_abono_det            
where ab_operacion  in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)
and   ab_operacion = abd_operacion
and   ab_secuencial_ing = abd_secuencial_ing
	    

select 'ca_corresponsal_det' = 'ca_corresponsal_det', * 
from cob_cartera..ca_corresponsal_det 
where cd_operacion in(select tg_operacion from cob_credito..cr_tramite_grupal where tg_grupo = @w_grupo)


select 'ca_transaccion+det_GAR'       = 'ca_transaccion+det_GAR' ,* 
from cob_cartera..ca_transaccion , cob_cartera..ca_det_trn
where tr_operacion   = dtr_operacion
and   tr_secuencial  = dtr_secuencial
and   tr_tran        = 'GAR'
and   (tr_banco not like '%G%' and tr_banco not like '%AHO%')
and   tr_banco in (select tg_cliente
                   from cob_credito..cr_tramite_grupal
                   where tg_grupo = @w_grupo
                   )
                   
SELECT 'cu_custodia' = 'cu_custodia',c.* 
	FROM cob_custodia..cu_custodia c, 
	     cob_credito..cr_gar_propuesta,
	     cob_cartera..ca_operacion, 
	     cob_credito..cr_tramite_grupal
	WHERE cu_codigo_externo = gp_garantia
	AND gp_tramite   = op_tramite
	AND tg_operacion = op_operacion
	AND tg_grupo     = @w_grupo
	ORDER BY cu_codigo_externo


	SELECT DISTINCT 'cu_transaccion' = 'cu_transaccion', t.* 
	FROM cob_custodia..cu_transaccion t, 
             cob_credito..cr_gar_propuesta,
	     cob_cartera..ca_operacion, 
             cob_credito..cr_tramite_grupal
	WHERE tr_codigo_externo = gp_garantia 
        AND  gp_tramite   = op_tramite
	AND  tg_operacion = op_operacion
	AND  tg_grupo     = @w_grupo
	AND  tr_tran <> 'EST'
	ORDER BY tr_codigo_externo, tr_secuencial
	


go

