----------------------------------------------------------------
-- CATALOGO VARIABLE BURO
----------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_buro'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'BURO')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'V','V','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'W','W','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'K','K','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'M','M','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go


----------------------------------------------------------------
-- CATALOGO VARIABLE NUMERO DE PAGOS
----------------------------------------------------------------
use cobis
go

declare 
@w_id_tabla int,
@w_nom_tabla varchar(30),
@w_producto varchar(30)

select @w_producto = pd_abreviatura from cobis..cl_producto
where pd_descripcion = 'CREDITO'

select @w_nom_tabla = 'cr_numero_pagos'

delete cl_catalogo where tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_catalogo_pro where cp_tabla in (select codigo from cl_tabla where tabla = @w_nom_tabla)
delete cl_tabla where tabla = @w_nom_tabla

select @w_id_tabla = max(codigo) from cl_tabla
select @w_id_tabla = @w_id_tabla + 1

insert into cl_tabla (codigo, tabla, descripcion) values(@w_id_tabla, @w_nom_tabla,'NUMERO DE PAGOS')
insert into cl_catalogo_pro(cp_producto, cp_tabla) values (@w_producto,@w_id_tabla)
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'8','8','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'12','12','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'16','16','V')
insert into cl_catalogo(tabla, codigo, valor, estado) values(@w_id_tabla,'24','24','V')

-- Actualizacion secuencial tabla de catalogos
update cobis..cl_seqnos 
set siguiente = @w_id_tabla 
where tabla  = 'cl_tabla' 
go
