USE cob_cartera
GO


  
delete  ca_devoluciones  where de_grupo in  ( 2587,472,2497)

GO


use cob_cartera
go


select *
from ca_devoluciones
where de_operacion is null
and   de_fecha = '04/09/2019'

delete
from ca_devoluciones
where de_operacion is null
and   de_fecha = '04/09/2019'

select  *
from ca_devoluciones
where de_operacion is null
and   de_fecha = '04/09/2019'


--Eliminar orden deposito
select  *
from cob_cartera..ca_santander_orden_deposito
where sod_fecha = '04/09/2019'

delete
from cob_cartera..ca_santander_orden_deposito
where sod_fecha = '04/09/2019'

select  *
from cob_cartera..ca_santander_orden_deposito
where sod_fecha = '04/09/2019'


--Actualizacion Garantias

select  *
from  cob_cartera..ca_garantia_liquida
where  gl_id in (33186, 33187, 33188, 33189, 33190, 33191, 33192, 33193, 33194,          
                 35229, 35230, 35231, 35232, 35233, 35234, 35235, 35236) 


update cob_cartera..ca_garantia_liquida
set  gl_pag_valor  = gl_dev_valor ,
     gl_dev_estado = 'PD',
     gl_dev_fecha  = null
where  gl_id in (33186, 33187, 33188, 33189, 33190, 33191, 33192, 33193, 33194,          
                 35229, 35230, 35231, 35232, 35233, 35234, 35235, 35236) 


update cob_cartera..ca_garantia_liquida
set  gl_dev_valor = null
where  gl_id in (33186, 33187, 33188, 33189, 33190, 33191, 33192, 33193, 33194,          
                 35229, 35230, 35231, 35232, 35233, 35234, 35235, 35236)


select  *
from  cob_cartera..ca_garantia_liquida
where  gl_id in (33186, 33187, 33188, 33189, 33190, 33191, 33192, 33193, 33194,          
                 35229, 35230, 35231, 35232, 35233, 35234, 35235, 35236) 

GO

