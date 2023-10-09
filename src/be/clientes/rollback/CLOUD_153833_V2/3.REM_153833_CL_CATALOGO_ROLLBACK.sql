use cobis
go
declare @w_id_table int, @w_catalog_name varchar(64)
select @w_catalog_name = 'cl_respuesta_biometricos'
-- delete
delete cl_catalogo_pro from cl_tabla 
 where cp_producto = 'CLI' and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
   and cl_tabla.tabla = @w_catalog_name and codigo = cp_tabla
delete cl_catalogo from cl_tabla 
 where cl_tabla.tabla = @w_catalog_name 
   and cl_tabla.codigo = cl_catalogo.tabla
delete cl_tabla where cl_tabla.tabla = @w_catalog_name

go
