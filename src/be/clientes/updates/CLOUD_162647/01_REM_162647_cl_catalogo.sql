use cobis
go

declare @w_id_tabla int,
        @w_nom_tabla varchar(30),
        @w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_hab_func_consulta_cuenta'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'HABILITAR BOTON CONSULTA CUENTA')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)

insert cl_catalogo
select @w_id_tabla ,ro_rol ,ro_descripcion ,'V' ,null ,null ,null 
from cobis..ad_rol
where ro_descripcion in ('FUNCIONARIO OFICINA', 'MESA DE OPERACIONES')
  
go
