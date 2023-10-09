use cob_cartera
go

-- Caso 1 -> Operacion Canceladas con garantias sin devolver

select gl_id              ,
       'grupo'     = gl_grupo           ,
       'cliente'   = gl_cliente         ,
       'tramite'   = gl_tramite         ,
       'monto_ind' = gl_monto_individual,
       'monto_gar' = gl_monto_garantia  ,
       'fecha_ven' = gl_fecha_vencimiento,
       'pag_estado'= gl_pag_estado,
       'pag_fecha' = gl_pag_fecha,
       'pag_valor' = gl_pag_valor,
       'dev_estado'= gl_dev_estado,
       'dev_fecha' = gl_dev_fecha,
       'dev_valor' = gl_dev_valor
into #r_caso1      
from  borrar_ca_garantia_liquida_C1_106058 

update ca_garantia_liquida 
set gl_pag_estado  = pag_estado,
    gl_dev_estado  = dev_estado,
    gl_pag_fecha   = pag_fecha , 
    gl_pag_valor   = pag_valor
from #r_caso1
where gl_tramite    = tramite
and   gl_cliente    = cliente   
-- Caso 2 -> Operacion canceladas con garantias no marcadas por devolver PD.

select gl_id              ,
       'grupo'     = gl_grupo           ,
       'cliente'   = gl_cliente         ,
       'tramite'   = gl_tramite         ,
       'monto_ind' = gl_monto_individual,
       'monto_gar' = gl_monto_garantia  ,
       'fecha_ven' = gl_fecha_vencimiento,
       'pag_estado'= gl_pag_estado,
       'pag_fecha' = gl_pag_fecha,
       'pag_valor' = gl_pag_valor,
       'dev_estado'= gl_dev_estado,
       'dev_fecha' = gl_dev_fecha,
       'dev_valor' = gl_dev_valor
into #r_caso2      
from  borrar_ca_garantia_liquida_C2_106058 

update cob_cartera..ca_garantia_liquida  set
gl_dev_estado  = dev_estado,             
gl_pag_fecha   = pag_fecha , 
gl_pag_valor   = pag_valor
from  #r_caso2 t    
where tramite    = gl_tramite
and   cliente    = gl_cliente  


-- Caso 3 -> Operacion vigentes con garantias cobradas duplicado el pago
select gl_id              ,
       'grupo'     = gl_grupo           ,
       'cliente'   = gl_cliente         ,
       'tramite'   = gl_tramite         ,
       'monto_ind' = gl_monto_individual,
       'monto_gar' = gl_monto_garantia  ,
       'fecha_ven' = gl_fecha_vencimiento,
       'pag_estado'= gl_pag_estado,
       'pag_fecha' = gl_pag_fecha,
       'pag_valor' = gl_pag_valor,
       'dev_estado'= gl_dev_estado,
       'dev_fecha' = gl_dev_fecha,
       'dev_valor' = gl_dev_valor
into #r_caso3      
from  borrar_ca_garantia_liquida_C3_106058



update cob_cartera..ca_garantia_liquida  set
gl_pag_valor   = pag_valor
from  #r_caso3      
where gl_tramite    = tramite
and   gl_cliente    = cliente 

-- Caso 4 -> Operacion vigentes con garantias  en estado dferente a cobrado
select gl_id              ,
       'grupo'     = gl_grupo           ,
       'cliente'   = gl_cliente         ,
       'tramite'   = gl_tramite         ,
       'monto_ind' = gl_monto_individual,
       'monto_gar' = gl_monto_garantia  ,
       'fecha_ven' = gl_fecha_vencimiento,
       'pag_estado'= gl_pag_estado,
       'pag_fecha' = gl_pag_fecha,
       'pag_valor' = gl_pag_valor,
       'dev_estado'= gl_dev_estado,
       'dev_fecha' = gl_dev_fecha,
       'dev_valor' = gl_dev_valor
into #r_caso4      
from  borrar_ca_garantia_liquida_C4_106058



update cob_cartera..ca_garantia_liquida  set
gl_pag_estado       = pag_estado,
gl_pag_valor        = pag_valor ,
gl_pag_fecha        = pag_fecha 
from  #r_caso4 t
where gl_tramite    = tramite
and   gl_cliente    = cliente 

go

