use cobis
go

delete cl_catalogo where tabla in (select codigo from cl_tabla where  tabla in ('cr_hab_upload_por_rol'))
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where  tabla in ('cr_hab_upload_por_rol'))
delete cl_tabla where  tabla in ('cr_hab_upload_por_rol')
go
