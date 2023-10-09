use cobis
go

declare @w_tabla int

DELETE cl_catalogo_pro from cl_tabla where cp_producto = 'CRE' and cl_tabla.codigo = cl_catalogo_pro.cp_tabla
and cl_tabla.tabla = 'cr_parentesco_micro' and codigo = cp_tabla
delete cl_catalogo from cl_tabla where cl_tabla.tabla = 'cr_parentesco_micro' and cl_tabla.codigo = cl_catalogo.tabla
delete cl_tabla where cl_tabla.tabla = 'cr_parentesco_micro'

-- Insert
select @w_tabla = isnull(max(codigo), 0) + 1 from cl_tabla

insert into cobis..cl_tabla (codigo, tabla, descripcion) values (@w_tabla, 'cr_parentesco_micro', 'PARENTESCO MICROSEGUROS')
insert into cl_catalogo_pro (cp_producto, cp_tabla) values ('CRE', @w_tabla)
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, N'1', N'PADRE', N'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, N'2', N'MADRE', N'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, N'3', N'ESPOSO(A)', N'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, N'4', N'HIJO(A)', N'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, N'5', N'FAMILIAR', N'V')
INSERT INTO cl_catalogo(tabla, codigo, valor, estado) VALUES(@w_tabla, N'6', N'AMIGO(A)', N'V')

update cobis..cl_seqnos set siguiente = @w_tabla where tabla = 'cl_tabla'


go


