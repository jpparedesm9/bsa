use cobis
go

declare @w_codigo_resource int 

if not exists(select 1 from cew_resource where re_pattern = '/resources/CSTMR/.*')
begin
      select @w_codigo_resource= max(isnull(re_id,0)) + 1 from cew_resource
      insert into cew_resource (re_id, re_pattern) values (@w_codigo_resource, '/resources/CSTMR/.*')

end  
else 
      select @w_codigo_resource = re_id from cew_resource where re_pattern = '/resources/CSTMR/.*'


insert into cew_resource_rol (rro_id_resource, rro_id_rol)
select @w_codigo_resource, ro_rol
from cobis..ad_rol 
where not exists (select 1 from cew_resource_rol where rro_id_resource = @w_codigo_resource and rro_id_rol =ro_rol )


