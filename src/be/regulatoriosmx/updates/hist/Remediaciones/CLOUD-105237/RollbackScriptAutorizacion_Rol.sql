use cobis
go

declare @w_rol  int

select @w_rol = 19 -->19 PERFIL DE OPERACIONES 

delete
from cobis..cew_resource_rol
where rro_id_rol = @w_rol


delete
from cobis..ad_servicio_autorizado 
where ts_rol = @w_rol

delete
from cobis..ad_tr_autorizada 
where ta_rol      = @w_rol
                        
                        

  



