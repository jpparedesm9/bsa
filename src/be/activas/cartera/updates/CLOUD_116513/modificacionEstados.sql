use cob_cartera
go

update ca_estados_man
set em_dias_cont = 90
where em_toperacion = 'GRUPAL' 
and em_tipo_cambio = 'A' 
and em_estado_ini = 1 
and em_estado_fin = 2 
go


update ca_estados_man
set em_dias_cont = 60
where em_toperacion = 'REVOLVENTE' 
and em_tipo_cambio = 'A' 
and em_estado_ini = 1 
and em_estado_fin = 2 
go

update ca_estados_man
set em_dias_cont = 90
where em_toperacion = 'INDIVIDUAL' 
and em_tipo_cambio = 'A' 
and em_estado_ini = 1 
and em_estado_fin = 2 
go

update ca_estados_man
set em_dias_cont = 90
where em_toperacion = 'INTERCICLO' 
and em_tipo_cambio = 'A' 
and em_estado_ini = 1 
and em_estado_fin = 2 
go

