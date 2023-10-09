--------------
--CASO 112171
--------------

use cobis
go

select p_depa_nac, * from cobis..cl_ente where en_ente = 78206

DECLARE @w_tabla INT,
@w_codigo INT

SELECT @w_tabla = codigo  
FROM cobis..cl_tabla
WHERE tabla = 'cl_provincia'

SELECT @w_codigo = codigo
FROM cobis..cl_catalogo 
WHERE tabla=@w_tabla
AND valor = 'Hidalgo'

update cobis..cl_ente 
set p_depa_nac = @w_codigo
where en_ente = 78206

select p_depa_nac, * from cobis..cl_ente where en_ente = 78206
go

