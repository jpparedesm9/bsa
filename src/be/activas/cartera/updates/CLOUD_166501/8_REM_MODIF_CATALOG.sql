use cobis
go
declare @w_cod_tabla int

SELECT @w_cod_tabla = codigo FROM cl_tabla WHERE tabla = 'cl_socio_comercial'

delete from cl_catalogo WHERE tabla = @w_cod_tabla and codigo = 'SODI'

if not exists (select 1 from cl_catalogo_pro where cp_producto = 'ADM' and cp_tabla = @w_cod_tabla)
begin
	insert into cl_catalogo_pro (cp_producto, cp_tabla)
	values ('ADM', @w_cod_tabla)
end
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_tabla, 'SODI', 'SODIMAC', 'V', NULL, NULL, NULL)
go

-- ===============================================================================
declare @w_cod_tabla int
SELECT @w_cod_tabla = codigo FROM cl_tabla WHERE tabla = 'cl_tipo_mercado'

delete from cl_catalogo WHERE tabla = @w_cod_tabla and codigo = 'SODI'

if not exists (select 1 from cl_catalogo_pro where cp_producto = 'ADM' and cp_tabla = @w_cod_tabla)
begin
	insert into cl_catalogo_pro (cp_producto, cp_tabla)
	values ('ADM', @w_cod_tabla)
end
INSERT INTO cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type)
VALUES (@w_cod_tabla, 'SODI', 'SODIMAC', 'V', NULL, NULL, NULL)

go

