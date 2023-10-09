--Antes
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cl_tipos_aceptacion')


------------------------------------------------------------------
-- CATALOGO DE TIPOS DE ACEPTACION - R193221 - B2B Grupal Digital
------------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CLIENTES'

select @w_nom_tabla = 'cl_tipos_aceptacion'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'TIPOS DE ACEPTACION')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'AVPRI','AVISO DE PRIVACIDAD','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'REDCD','RESPONSABILIDAD DE DOCUMENTOS - COMPROBANTE DOMICILIARIO','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'REDAR','RESPONSABILIDAD DE DOCUMENTOS - ANVERSO Y REVERSO','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


--Despues
select *from cobis..cl_catalogo 
where tabla = (select codigo from cobis..cl_tabla where tabla like 'cl_tipos_aceptacion')

go
