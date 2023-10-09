USE cobis
GO

DECLARE
@w_tabla          int

SELECT @w_tabla = codigo
FROM cobis..cl_tabla 
WHERE tabla = 'cl_tipo_mercado'
DELETE cl_catalogo WHERE tabla = @w_tabla AND codigo IN ( 'ID', 'AV')

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_nivel_cliente_colectivo')
DELETE cl_tabla WHERE tabla = 'cl_nivel_cliente_colectivo'

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cl_cuenta_dispersion_lcr')
DELETE cl_tabla WHERE tabla = 'cl_cuenta_dispersion_lcr'

DELETE cl_catalogo WHERE tabla = (SELECT codigo FROM cl_tabla WHERE tabla = 'cr_doc_digitaliza_flujo_colect')
DELETE cl_tabla WHERE tabla = 'cr_doc_digitaliza_flujo_colect'

select @w_tabla = codigo from cobis..cl_tabla where tabla = 'si_sincroniza'
delete  cl_catalogo where tabla = @w_tabla and valor = 'FIRMAS Y CUESTIONARIO COLECTIVO'


-- Pantalla Rol Asesor Colectivo
if exists (SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cl_rol_asesor_colectivo')
begin
	SELECT @w_tabla = codigo
	FROM cobis..cl_tabla 
	WHERE tabla = 'cl_rol_asesor_colectivo'
	
	if exists (select 1 from cl_catalogo where tabla = @w_tabla and  codigo = 'ASE')
	begin
		DELETE cl_catalogo WHERE tabla = @w_tabla AND = 'ASE'
	end
	
	if exists (select 1 from cl_catalogo where tabla = @w_tabla and  codigo = 'GOF')
	begin
		DELETE cl_catalogo WHERE tabla = @w_tabla AND = 'GOF'
	end
	
	if exists (select 1 from cl_catalogo where tabla = @w_tabla and  codigo = 'COO')
	begin
		DELETE cl_catalogo WHERE tabla = @w_tabla AND = 'COO'
	end
	
	if exists (select 1 from cl_catalogo where tabla = @w_tabla and  codigo = 'AAD')
	begin
		DELETE cl_catalogo WHERE tabla = @w_tabla AND = 'AAD'
	end
	
	delete from cl_tabla where codigo = @w_tabla
end
  
go