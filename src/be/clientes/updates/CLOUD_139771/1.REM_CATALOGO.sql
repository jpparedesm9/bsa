USE cobis
GO

DECLARE
@w_tabla          int,
@w_codigo         int

SELECT @w_tabla = codigo
FROM cobis..cl_tabla 
WHERE tabla = 'cl_tipo_mercado'


IF @w_tabla IS NOT NULL BEGIN

   DELETE cl_catalogo WHERE tabla = @w_tabla AND codigo IN ( 'SR')

   INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
   VALUES (@w_tabla, 'SR', 'SUPER RED', 'V', NULL, NULL, NULL)
 
end