use cob_cartera
go


IF OBJECT_ID ('borrar_ca_garantia_liquida_C1_106058') IS NOT NULL
	DROP TABLE borrar_ca_garantia_liquida_C1_106058
GO

IF OBJECT_ID ('borrar_ca_garantia_liquida_C2_106058') IS NOT NULL
	DROP TABLE borrar_ca_garantia_liquida_C2_106058
GO

IF OBJECT_ID ('borrar_ca_garantia_liquida_C3_106058') IS NOT NULL
	DROP TABLE borrar_ca_garantia_liquida_C3_106058
GO

IF OBJECT_ID ('borrar_ca_garantia_liquida_C4_106058') IS NOT NULL
	DROP TABLE borrar_ca_garantia_liquida_C4_106058
GO


IF OBJECT_ID ('borrar_ca_garantia_liquida_106058') IS NOT NULL
	DROP TABLE borrar_ca_garantia_liquida_106058
GO


select *
into borrar_ca_garantia_liquida_106058
from ca_garantia_liquida

-- Caso 1 -> Operacion Canceladas con garantias sin devolver
select  op_banco, op_fecha_ini, op_estado, tg_tramite, tg_cliente, gl_pag_estado, gl_pag_valor, gl_pag_fecha, gl_dev_estado
into #caso1
from  ca_operacion,
      cob_credito..cr_tramite_grupal,
      ca_garantia_liquida
where op_estado     = 3 
and   tg_operacion  = op_operacion
and   tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente
and   gl_pag_estado = 'PC'
and   gl_dev_estado is null

select 'ANTES DE ACTUALIZACION CASO1', * from #caso1


select l.*
into borrar_ca_garantia_liquida_C1_106058
from ca_garantia_liquida l, #caso1
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado  = 'CB',
gl_dev_estado  = 'PD',
gl_pag_fecha   = op_fecha_ini     , 
gl_pag_valor   = gl_monto_garantia
from  #caso1      
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 


select 'DESPUES DE ACTUALIZACION CASO1', op_banco, op_fecha_ini, op_estado, tg_tramite, tg_cliente, d.gl_pag_estado, d.gl_pag_valor, d.gl_pag_fecha, d.gl_dev_estado
from  #caso1, 
      ca_garantia_liquida d
where tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente

-- Caso 2 -> Operacion canceladas con garantias no marcadas por devolver PD.

select  op_banco, op_fecha_ini, op_estado, tg_tramite, tg_cliente, gl_pag_estado, gl_pag_valor, gl_pag_fecha, gl_dev_estado
into #caso2
from  ca_operacion,
      cob_credito..cr_tramite_grupal,
      ca_garantia_liquida
where op_estado     = 3 
and   tg_operacion  = op_operacion
and   tg_tramite    = gl_tramite
and   tg_cliente        = gl_cliente
and   gl_pag_estado     = 'CB'
and   gl_dev_estado     is null
and   gl_monto_garantia > 0

select 'ANTES DE ACTUALIZACION CASO2', * from #caso2

select l.*
into borrar_ca_garantia_liquida_C2_106058
from ca_garantia_liquida l, #caso2
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 


update cob_cartera..ca_garantia_liquida  set
gl_dev_estado  = 'D',             
gl_pag_fecha   = isnull(t.gl_pag_fecha,op_fecha_ini), 
gl_pag_valor   = gl_monto_garantia
from  #caso2 t    
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente  

select 'DESPUES DE ACTUALIZACION CASO2', op_banco, op_fecha_ini, op_estado, tg_tramite, tg_cliente, d.gl_pag_estado, d.gl_pag_valor, d.gl_pag_fecha, d.gl_dev_estado
from  #caso2, 
      ca_garantia_liquida d
where tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente


-- Caso 3 -> Operacion vigentes con garantias cobradas duplicado el pago
select  op_banco, op_estado, tg_tramite, tg_cliente,  gl_pag_valor, gl_pag_fecha, gl_monto_garantia
into #caso3
from  ca_operacion,
      cob_credito..cr_tramite_grupal,
      ca_garantia_liquida
where op_estado     in (1, 2)
and   tg_operacion  = op_operacion
and   tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente
and   gl_pag_estado = 'CB'
AND   gl_pag_valor <> gl_monto_garantia

select 'ANTES DE ACTUALIZACION CASO3', *
from #caso3

select l.*
into borrar_ca_garantia_liquida_C3_106058
from ca_garantia_liquida l, #caso3
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 


update cob_cartera..ca_garantia_liquida  set
gl_pag_valor   = t.gl_monto_garantia
from  #caso3  t    
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 


select 'DESPUES DE ACTUALIZACION CASO3', op_banco, op_estado, tg_tramite, tg_cliente,  d.gl_pag_valor, d.gl_pag_fecha, d.gl_monto_garantia
from  #caso3,
      ca_garantia_liquida d
where tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente


-- Caso 4 -> Operacion vigentes con garantias  en estado dferente a cobrado
select op_banco, op_fecha_ini, op_estado, tg_tramite, tg_cliente, gl_pag_estado, gl_pag_valor, gl_pag_fecha, gl_dev_estado, gl_monto_garantia
into #caso4
from  ca_operacion,
      cob_credito..cr_tramite_grupal,
      ca_garantia_liquida
where op_estado     in (1, 2)
and   tg_operacion  = op_operacion
and   tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente
and   gl_pag_estado <> 'CB'

select 'ANTES DE ACTUALIZACION CASO4', *
from #caso4

select l.*
into borrar_ca_garantia_liquida_C4_106058
from ca_garantia_liquida l, #caso4
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 

update cob_cartera..ca_garantia_liquida  set
gl_pag_estado       = 'CB'             ,
gl_pag_valor        = t.gl_monto_garantia,
gl_pag_fecha        = isnull(t.gl_pag_fecha,op_fecha_ini)
from  #caso4 t
where gl_tramite    = tg_tramite
and   gl_cliente    = tg_cliente 

select 'DESPUES DE ACTUALIZACION CASO4',op_banco, op_fecha_ini, op_estado, tg_tramite, tg_cliente, d.gl_pag_estado, d.gl_pag_valor, d.gl_pag_fecha, d.gl_dev_estado, d.gl_monto_garantia
from  #caso4,
      ca_garantia_liquida d
where tg_tramite    = gl_tramite
and   tg_cliente    = gl_cliente
