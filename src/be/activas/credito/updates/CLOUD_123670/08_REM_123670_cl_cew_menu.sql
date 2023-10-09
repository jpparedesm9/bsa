use
cobis
go

declare @w_maximo      int = 0, 
        @w_id_rol      int,
		@w_id_resource int

select @w_maximo = max(re_id)+1 from cew_resource
select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'COORDINADOR'

if exists (select * from  cobis..cew_resource where re_pattern='/cobis/web/views//customer/.*')
begin
    select @w_id_resource = re_id from cobis..cew_resource where re_pattern='/cobis/web/views//customer/.*'
    insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
	values (@w_id_resource, @w_id_rol)
end
else
begin
    insert into dbo.cew_resource (re_id, re_pattern)
    values (@w_maximo, '/cobis/web/views//customer/.*')
    
    insert into dbo.cew_resource_rol (rro_id_resource, rro_id_rol)
	values (@w_maximo, @w_id_rol)
end

go
