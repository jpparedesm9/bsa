use cobis
go

declare @w_tabla int

delete cl_catalogo_pro from cl_tabla where cp_producto = 'CRE' and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
and cl_tabla.tabla = 'cr_parentesco_micro' and codigo = cp_tabla
delete cl_catalogo from cl_tabla where cl_tabla.tabla = 'cr_parentesco_micro' and cl_tabla.codigo = cl_catalogo.tabla
delete cl_tabla where cl_tabla.tabla = 'cr_parentesco_micro'


-- Insert
select @w_tabla = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cr_parentesco_micro', 'PARENTESCO MICROSEGUROS')
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CRE', @w_tabla)
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '1', 'PROGENITOR                                                       ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '2', 'COMPAÑERO PERMANENTE                                             ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '3', 'HIJO(A)                                                          ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '4', 'ESPOSO(A)                                                        ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '5', 'FAMILIAR                                                         ', 'V') 
insert into cl_catalogo (tabla, codigo, valor, estado) values (@w_tabla, '6', 'AMIGO                                                            ', 'V') 

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'


go

