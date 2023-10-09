use cobis
go
declare @w_id_resource smallint,@w_id_resource1 smallint, @w_id_rol smallint
SELECT @w_id_rol = ro_rol FROM cobis..ad_rol WHERE ro_descripcion = 'SOCIO COMERCIAL'
select @w_id_resource =re_id from cew_resource where re_pattern='/cobis/web/views/CSTMR/.*'
select @w_id_resource1=re_id from cew_resource where re_pattern='/resources/CSTMR/.*'

if not exists (select 1 from cew_resource_rol where rro_id_rol=@w_id_rol and rro_id_resource = @w_id_resource) and @w_id_resource is not null
	insert into cew_resource_rol (rro_id_resource,rro_id_rol) values (@w_id_resource,@w_id_rol)

if not exists (select 1 from cew_resource_rol where rro_id_rol=@w_id_rol and rro_id_resource = @w_id_resource1) and @w_id_resource1 is not null
	insert into cew_resource_rol (rro_id_resource,rro_id_rol) values (@w_id_resource1,@w_id_rol)

select * from cew_resource_rol where rro_id_rol=@w_id_rol and rro_id_resource in (@w_id_resource, @w_id_resource1)
go

