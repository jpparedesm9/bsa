/*Corrección catálogo para producto CLIENTES e inserción en tabla cl_catalogo_pro*/
use cobis
go


declare 
@w_id_tabla  int,
@w_nom_tabla varchar(30),
@w_producto  varchar(30)

select @w_producto   = pd_abreviatura 
from cobis..cl_producto 
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_ofc_activa_gen_tkn'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla =  max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1
insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'OFICINAS ACTIVAS TOKEN CRE GRUPAL')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'2381','Oficina Ixtapaluca','V')

go
