use cobis
go
declare @w_sgt int=0, @w_rol_desc varchar(20) = 'SOCIO COMERCIAL'
delete from cobis..ad_rol where ltrim(rtrim(ro_descripcion)) = @w_rol_desc
go
