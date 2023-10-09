use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30),
@w_codigo_rol varchar(10), 
@w_nombre_rol varchar(64)

SELECT @w_producto = pd_abreviatura FROM cobis..cl_producto 
WHERE pd_descripcion = 'CREDITO'

delete cl_catalogo where tabla in (select codigo from cl_tabla where  tabla in ('cr_hab_upload_por_rol'))
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where  tabla in ('cr_hab_upload_por_rol'))
delete cl_tabla where  tabla in ('cr_hab_upload_por_rol')

select @w_nom_tabla = 'cr_hab_upload_por_rol'
select @w_id_tabla =  max(codigo) from cobis..cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion)     values(@w_id_tabla, @w_nom_tabla,'ROLES PARA ACTIVAR CARGA ARCHIVOS')
insert into cl_catalogo_pro(cp_producto, cp_tabla)    values(@w_producto, @w_id_tabla  )

select @w_codigo_rol = convert(varchar,ro_rol),
       @w_nombre_rol = ro_descripcion
from   cobis..ad_rol where ro_descripcion = 'MESA DE OPERACIONES'

insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla, @w_codigo_rol, @w_nombre_rol, 'V')

select  * from cobis..cl_tabla where codigo = @w_id_tabla
select  * from cobis..cl_catalogo where tabla = @w_id_tabla

update cobis..cl_seqnos 
set siguiente = @w_id_tabla + 1
where tabla   = 'cl_tabla'

select * from cobis..cl_seqnos where tabla = 'cl_tabla'
go

