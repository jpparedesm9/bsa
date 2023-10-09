USE cobis
GO

declare 
@w_tabla           int 

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_plazo_grp')
DELETE cl_tabla WHERE tabla = 'cr_plazo_grp'

select @w_tabla = isnull(max(codigo),0) + 1
from cl_tabla

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cr_plazo_grp', 'PLAZO GRUPAL')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '16', '16', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '20', '20', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '24', '24', 'V', NULL, NULL, NULL)

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_gracia_grp')
DELETE cl_tabla WHERE tabla = 'cr_gracia_grp'

select @w_tabla = @w_tabla + 1

INSERT INTO cl_tabla (codigo, tabla, descripcion) VALUES (@w_tabla, 'cr_gracia_grp', 'GRACIA GRUPAL')

INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '0', '0', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '2', '2', 'V', NULL, NULL, NULL)
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_tabla, '4', '4', 'V', NULL, NULL, NULL)

go