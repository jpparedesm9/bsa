use cobis
go

declare @w_me_id		int,
		@w_moneda 		int,
		@w_producto		int,
		@w_resource     int,
		@w_rol			int


select @w_moneda = pa_tinyint 
  from cobis..cl_parametro 
 where pa_nemonico = 'MLO'
   and pa_producto = 'ADM'
   
select @w_producto = pd_producto 
  from cl_producto 
 where pd_descripcion = 'ADMINISTRADOR DE PRODUCTOS FINANCIEROS'

  
 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MENU POR PROCESOS'
  
 ---Creación Recursos Contenedor 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/fpm/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/fpm/.*')
 end
 
 if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/FINPM/.*')
 begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/FINPM/.*')
 end
 

 
delete cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern in  ('/cobis/web/views/fpm/.*', '/cobis/web/views/FINPM/.*'))
 
 --Autorización recursos al rol Menú por procesos
if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/fpm/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/fpm/.*'
end

if not exists (select 1 from cew_resource_rol where rro_id_rol =@w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern =  '/cobis/web/views/FINPM/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/FINPM/.*'
end


--APF
select @w_me_id = me_id 
from cew_menu 
where me_name = 'MNU_APF'

if @w_me_id is not null
begin

	delete cew_menu_resource
     where mr_id_menu 		= @w_me_id
       and mr_id_resource   in (select re_id from cew_resource 
                                 where re_pattern in  ('/cobis/web/views/fpm/.*', '/cobis/web/views/FINPM/.*')) 
								 
	insert into cew_menu_resource
	select @w_me_id, re_id 
	  from cew_resource 
     where re_pattern in  ('/cobis/web/views/fpm/.*', '/cobis/web/views/FINPM/.*')
								 
end
go
