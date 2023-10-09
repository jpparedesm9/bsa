/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 14/09/2016 
--Descripción del Problema	: Actualización de RUBRO para pago de INTERES
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

/*
-- pe_carlgo.sql
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '17', 'INTERES SOBRE EL CONTABLE','B')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '18', 'INTERES','V')
insert into cl_catalogo(tabla,codigo,valor,estado) values (@w_codigo, '23', 'INTERES SOBRE EL PROM DISPONIBLE','B')
*/

use cobis
go

DECLARE @w_codigo INTEGER

SELECT @w_codigo = codigo FROM cobis..cl_tabla WHERE tabla = 'pe_rubro' AND descripcion = 'Rubro del servicio'

IF EXISTS (SELECT 1 FROM cobis..cl_catalogo WHERE tabla = @w_codigo AND codigo = '17' AND valor = 'INTERES SOBRE EL CONTABLE')
BEGIN
	PRINT 'Se Deshabilita INTERES SOBRE EL CONTABLE'	
	UPDATE cobis..cl_catalogo
	SET estado = 'B'
	WHERE tabla = @w_codigo AND codigo = '17' AND valor = 'INTERES SOBRE EL CONTABLE'
END

IF EXISTS (SELECT 1 FROM cobis..cl_catalogo WHERE tabla = @w_codigo AND codigo = '18' AND valor = 'INTERES SOBRE EL DISPONIBLE')
BEGIN
	PRINT 'Se Actualiza INTERES SOBRE EL DISPONIBLE'	
	UPDATE cobis..cl_catalogo
	SET estado = 'V',
	valor = 'INTERES'
	WHERE tabla = @w_codigo AND codigo = '18' AND valor = 'INTERES SOBRE EL DISPONIBLE'
END

IF EXISTS (SELECT 1 FROM cobis..cl_catalogo WHERE tabla = @w_codigo AND codigo = '23' AND valor = 'INTERES SOBRE EL PROM DISPONIBLE')
BEGIN
	PRINT 'Se Deshabilita INTERES SOBRE EL PROM DISPONIBLE'	
	UPDATE cobis..cl_catalogo
	SET estado = 'B'
	WHERE tabla = @w_codigo AND codigo = '23' AND valor = 'INTERES SOBRE EL PROM DISPONIBLE'
END

go

