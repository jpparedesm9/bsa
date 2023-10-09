use cobis

go

delete cobis..cl_catalogo_pro where cp_tabla in (select codigo from cobis..cl_tabla where tabla in ('cl_ciudad','cl_provincia','cl_parroquia','cl_oficina'))
insert into cobis..cl_catalogo_pro 
select 'ADM', codigo 
 from cobis..cl_tabla
where tabla in ('cl_ciudad','cl_provincia','cl_parroquia','cl_oficina')

select * from cobis..cl_catalogo_pro where cp_tabla in (select codigo from cobis..cl_tabla where tabla in ('cl_ciudad','cl_provincia','cl_parroquia','cl_oficina'))

go



