use cobis
go
declare @w_cod_tabla int

SELECT @w_cod_tabla = codigo FROM cl_tabla WHERE tabla = 'cl_socio_comercial'

delete from cl_catalogo WHERE tabla = @w_cod_tabla and codigo = 'SODI'
go
-- ===============================================================================
declare @w_cod_tabla int
SELECT @w_cod_tabla = codigo FROM cl_tabla WHERE tabla = 'cl_tipo_mercado'

delete from cl_catalogo WHERE tabla = @w_cod_tabla and codigo = 'SODI'

go

