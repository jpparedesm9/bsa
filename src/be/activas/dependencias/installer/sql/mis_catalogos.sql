use cobis
go
delete cl_catalogo_pro
from cl_tabla
where tabla in ('cl_estado_ser')
  and codigo = cp_tabla
go

delete cl_catalogo
from cl_tabla
where cl_tabla.tabla in ('cl_estado_ser')
  and cl_tabla.codigo = cl_catalogo.tabla
go

delete cl_tabla
where cl_tabla.tabla in ('cl_estado_ser')
go


declare @w_tabla smallint
select @w_tabla = max(codigo) + 1 from cl_tabla

insert into cl_tabla values (@w_tabla, 'cl_estado_ser', 'ESTADO DE DATOS') 
insert into cl_catalogo_pro values ('MIS', @w_tabla) 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'B', 'BLOQUEADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'C', 'CANCELADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'E', 'ELIMINADO', 'V')
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, 'V', 'VIGENTE', 'V')
go

