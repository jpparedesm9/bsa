use
cobis
go

declare @w_id_rol      int,
		@w_id_resource int

select @w_id_rol = ro_rol from ad_rol where ro_descripcion = 'COORDINADOR'

if exists (select * from  cobis..cew_resource where re_pattern='/cobis/web/views//customer/.*')
begin
    select @w_id_resource = re_id from cobis..cew_resource where re_pattern='/cobis/web/views//customer/.*'
    delete from dbo.cew_resource_rol 
	where rro_id_resource = @w_id_resource and rro_id_rol = @w_id_rol
end

go
