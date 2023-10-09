use cobis
go

declare @w_rol  int

select @w_rol = 19 -->19 PERFIL DE OPERACIONES 

select 'cew_resource_rol Antes' = count(1)
from cobis..cew_resource_rol
where rro_id_rol = @w_rol

insert into cobis..cew_resource_rol
select rro_id_resource, @w_rol
from cobis..cew_resource_rol
where rro_id_rol = 3
and rro_id_resource not in (select rro_id_resource from cew_resource_rol where rro_id_rol = @w_rol)  

select 'cew_resource_rol Despues' = count(1)
from cobis..cew_resource_rol
where rro_id_rol = @w_rol


select 'ad_servicio_autorizado Antes',count(1)
from cobis..ad_servicio_autorizado
where ts_rol = @w_rol

insert into cobis..ad_servicio_autorizado
select sa.ts_servicio, @w_rol, sa.ts_producto, sa.ts_tipo, sa.ts_moneda, sa.ts_fecha_aut, sa.ts_estado, sa.ts_fecha_ult_mod 
from cobis..ad_servicio_autorizado sa
where ts_rol = 3 
and ts_servicio not in (select ts_servicio
                        from cobis..ad_servicio_autorizado
                        where ts_rol = @w_rol)


select 'ad_servicio_autorizado Despues',count(1)
from cobis..ad_servicio_autorizado
where ts_rol = @w_rol


select 'ad_tr_autorizada Antes',count(1)
from cobis..ad_tr_autorizada  
where ta_rol = @w_rol
                           
insert into cobis..ad_tr_autorizada 
select ta.ta_producto, ta.ta_tipo, ta.ta_moneda, ta.ta_transaccion,  @w_rol, ta.ta_fecha_aut, ta.ta_autorizante, ta_estado, ta_fecha_ult_mod
from cobis..ad_tr_autorizada ta
where ta_rol      = @w_rol
and ta_transaccion not in (select ta_transaccion
                           from cobis..ad_tr_autorizada  
                           where ta_rol = @w_rol )

select 'ad_tr_autorizada Despues',count(1)
from cobis..ad_tr_autorizada  
where ta_rol = @w_rol
                           
                        
                        

  



