use cob_cartera
go


select *
from ca_santander_orden_deposito
where sod_fecha = '01/29/2019'
and   sod_consecutivo = 1


update  ca_santander_orden_deposito
set   sod_secuencial= sod_secuencial * (-1)
where sod_fecha = '01/29/2019'
and   sod_consecutivo = 1

select *
from ca_santander_orden_deposito
where sod_fecha = '01/29/2019'
and   sod_consecutivo = 1


create table #grupo (
grupo    int null,
tramite  int null)

insert into #grupo (grupo, tramite ) values (106  ,	19508)
insert into #grupo (grupo, tramite ) values (116  ,	19302)
insert into #grupo (grupo, tramite ) values (649,	19310)               
insert into #grupo (grupo, tramite ) values (1851,	21620)               

select *
from ca_garantia_liquida, #grupo 
where gl_tramite = tramite 
and   gl_grupo   = grupo


update ca_garantia_liquida
set gl_pag_valor  = gl_dev_valor,
    gl_dev_estado = 'PD'
from  #grupo 
where gl_tramite  = tramite 
and   gl_grupo    = grupo


update ca_garantia_liquida
set gl_dev_fecha = null,
    gl_dev_valor = null
from  #grupo 
where gl_tramite  = tramite 
and   gl_grupo    = grupo


select *
from ca_garantia_liquida, #grupo 
where gl_tramite = tramite 
and   gl_grupo   = grupo





