USE cobis
go
DECLARE @w_tabla int
SELECT @w_tabla = codigo FROM cobis..cl_tabla WHERE tabla = 'cl_hab_func_consulta_cuenta'

SELECT * FROM cobis..cl_catalogo_pro WHERE cp_tabla = @w_tabla

DELETE cl_catalogo_pro WHERE cp_producto = 'ADM' AND cp_tabla = @w_tabla
INSERT INTO cl_catalogo_pro (cp_producto, cp_tabla)
VALUES ('ADM', @w_tabla)
GO
