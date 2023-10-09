use cob_cartera
go
select gl_grupo, 
       gl_tramite, 
       valor_pago =sum(gl_pag_valor),
       forma_pago = convert(varchar(16),null)
into #pagos_garantias
from cob_cartera..ca_garantia_liquida
where gl_pag_estado = 'CB'
and   gl_monto_garantia > 0
and   gl_pag_valor      > 0
and   gl_forma_pago   is null
group by gl_grupo, gl_tramite


select grupo = gl_grupo, secuencial = max(co_secuencial) 
into #secuencial_pago
from #pagos_garantias,
     cob_cartera..ca_corresponsal_trn
where co_codigo_interno = gl_grupo
and   co_monto          = valor_pago
and   co_tipo           in( 'GL','G')
group by gl_grupo

--update 
update #pagos_garantias set
forma_pago = co_corresponsal
from #secuencial_pago,
     cob_cartera..ca_corresponsal_trn
where  gl_grupo = grupo
and   secuencial = co_secuencial

update ca_garantia_liquida set
gl_forma_pago = forma_pago
from #pagos_garantias t,
     ca_garantia_liquida d
where t.gl_grupo   = d.gl_grupo
and   t.gl_tramite = d.gl_tramite

/****************************************************************/

select gl_grupo, 
       gl_tramite, 
       valor_pago =sum(gl_monto_individual * 0.10),
       forma_pago = convert(varchar(16),null)
into #pagos_garantias_calc
from cob_cartera..ca_garantia_liquida
where gl_pag_estado = 'CB'
and   gl_monto_garantia > 0
and   gl_pag_valor      > 0
and   gl_forma_pago   is null
group by gl_grupo, gl_tramite


select grupo = gl_grupo, secuencial = max(co_secuencial) 
into #secuencial_pago_calc
from #pagos_garantias_calc,
     cob_cartera..ca_corresponsal_trn
where co_codigo_interno = gl_grupo
and   co_monto          = valor_pago
and   co_tipo           in( 'GL','G')
group by gl_grupo

--update 
update #pagos_garantias_calc set
forma_pago = co_corresponsal
from #secuencial_pago_calc,
     cob_cartera..ca_corresponsal_trn
where  gl_grupo = grupo
and   secuencial = co_secuencial

update ca_garantia_liquida set
gl_forma_pago = forma_pago
from #pagos_garantias_calc t,
     ca_garantia_liquida d
where t.gl_grupo   = d.gl_grupo
and   t.gl_tramite = d.gl_tramite

-------------------

select  gl_grupo, gl_tramite
into #grupos_actualizar
from cob_cartera..ca_garantia_liquida
where gl_pag_estado = 'CB'
and   gl_pag_valor  > 0
and   gl_forma_pago is null
and  (gl_dev_estado is null or gl_dev_estado = 'PD')
and   gl_dev_valor is null
group by gl_grupo, gl_tramite

select grupo = gl_grupo, tramite = gl_tramite, secuencial = max(co_secuencial)
into #pagos_gar
from #grupos_actualizar,
     cob_cartera..ca_corresponsal_trn
where gl_grupo = co_codigo_interno
and   co_tipo  = 'GL'
group by gl_grupo, gl_tramite

update cob_cartera..ca_garantia_liquida set
gl_forma_pago = co_corresponsal
from #pagos_gar,
      cob_cartera..ca_corresponsal_trn
where  grupo      = gl_grupo
and    tramite    = gl_tramite
and    secuencial = co_secuencial
and    gl_forma_pago is null


update cob_cartera..ca_garantia_liquida set
gl_forma_pago = 'SANTANDER'
where gl_forma_pago is null
go


