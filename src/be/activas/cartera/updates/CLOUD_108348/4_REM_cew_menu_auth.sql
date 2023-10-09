--------------------
-- PAGOS OBJETADOS #108348
--------------------
use cobis
go

declare @w_resource     int,
		@w_rol			int

   
 select @w_rol = ro_rol 
   from ad_rol 
  where ro_descripcion = 'MESA DE OPERACIONES'


if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views//PAOBJ/.*')
begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views//PAOBJ/.*')
end

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/PAOBJ/PAOBJ/.*')
begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/PAOBJ/PAOBJ/.*')
end

if not exists (select 1 from cew_resource where re_pattern = '/cobis/web/views/PAOBJ/assets/.*')
begin
	select @w_resource = max(re_id) + 1 from cew_resource
	insert into dbo.cew_resource (re_id, re_pattern)
	values (@w_resource, '/cobis/web/views/PAOBJ/assets/.*')
end


if not exists (select 1 from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views//PAOBJ/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views//PAOBJ/.*'
END


if not exists (select 1 from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views/PAOBJ/PAOBJ/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/PAOBJ/PAOBJ/.*'
END



if not exists (select 1 from cew_resource_rol where rro_id_rol = @w_rol and rro_id_resource in (select re_id from cew_resource 
 where re_pattern ='/cobis/web/views/PAOBJ/assets/.*'))
begin
	insert into cobis..cew_resource_rol(rro_id_rol, rro_id_resource)
	select @w_rol, re_id 
	  from cew_resource 
	 where re_pattern ='/cobis/web/views/PAOBJ/assets/.*'
END

go

