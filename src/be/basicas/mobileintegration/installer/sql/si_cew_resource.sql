
use cobis
go

declare @w_rol            int,
        @w_maximo       int = 0,
		@w_resource       int = 0

 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MENU POR PROCESOS'

---Creación Recursos Contenedor 

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/MBILE/.*')
 begin
    select @w_resource = max(re_id) + 1 from cew_resource
    insert into cew_resource (re_id, re_pattern)
    values (@w_resource, '/cobis/web/views/MBILE/.*')
 end
 
 --Autorización recursos al rol Menú por procesos


if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/MBILE/.*'))
begin
    insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
    select @w_rol, re_id 
      from cew_resource 
     where re_pattern ='/cobis/web/views/MBILE/.*'
end

go