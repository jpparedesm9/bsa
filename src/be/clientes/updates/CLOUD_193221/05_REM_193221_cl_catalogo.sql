use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_tipo_aut'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1


insert into cobis..cl_tabla values(@w_id_tabla,'cl_tipo_aut','Tipo de autorizacion')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo values (@w_id_tabla,'C','CELULAR','V',null,null,null)
insert into cl_catalogo values (@w_id_tabla,'M','CORREO','V',null,null,null)

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 

go

