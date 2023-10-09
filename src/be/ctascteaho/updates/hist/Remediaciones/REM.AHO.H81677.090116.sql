/*************************************************/
-- No Bug: Historia AHO-H81677
-- Título de la Historia: ELIMINAR CONTROLES Y FUNCIONALIDADES APLICADOS A COLOMBIA
-- Fecha: 17/08/2016
-- Descripción del la Historia:  Como usuario del modulo de Ahorros, no de tener funcionalidades de Remesas, 
--                              Impuesto GMF, consignacion por oficina.
-- Descripción de la Solución: Se inserta el parametro de la moneda
-- Autor: Walther Toledo
/*************************************************/


USE cobis
GO
DECLARE @w_pais 	  SMALLINT,
	    @w_tbl_moneda SMALLINT
SELECT @w_pais = pa_smallint 
  FROM cobis..cl_parametro
 WHERE pa_nemonico = 'CP' 
   AND pa_producto = 'ADM'

SELECT @w_tbl_moneda = codigo 
  FROM cobis..cl_tabla
 WHERE tabla ='cl_moneda'

-- > ah_catlgo.sql
DELETE from cl_catalogo WHERE tabla = @w_tbl_moneda AND codigo = '0'
INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_tbl_moneda, '0', 'PESOS MEXICANOS', 'V')

-- > ah_datosini.sql
DELETE FROM cl_moneda WHERE mo_moneda = 0
INSERT INTO cl_moneda (mo_moneda, mo_descripcion, mo_pais, mo_estado, mo_decimales, mo_simbolo, mo_nemonico)
VALUES (0, 'PESOS MEXICANOS', @w_pais, 'V', 'S', 'MX', 'MXN')
GO

---------------------------------------------------------------------------------------------------------

