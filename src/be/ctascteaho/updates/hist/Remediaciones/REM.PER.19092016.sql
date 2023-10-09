/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 19/09/2016 
--Descripción del Problema	: Actualización de Parametro Ciudad Matriz
--Descripción de la Solución: Remediación
--Autor						: Juan Tagle
/***********************************************************************************************************/

-- cc_param.sql

use cobis
go

if exists (select 1 from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CMA')
	delete from cl_parametro where pa_producto = 'CTE' and pa_nemonico='CMA'

GO

INSERT INTO dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
VALUES ('CIUDAD DE MATRIZ', 'CMA', 'I', NULL, NULL, NULL, 9999, NULL, NULL, NULL, 'CTE') 

GO


-- pe_parametria.sql
use cob_remesas
go

print 'insercion pe_tipo_rango'
if exists (select 1 from sysobjects where name = 'pe_tipo_rango' )
  delete pe_tipo_rango 
go

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (1, 'RUBRO SOBRE SALDO DISPONIBLE', 'A', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (2, 'SOBRE PROMEDIO DISPONIBLE', 'E', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (3, 'SALDO PROMEDIO', 'B', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (4, 'SALDO CONTABLE', 'C', 0, 'V')

INSERT INTO cob_remesas..pe_tipo_rango (tr_tipo_rango, tr_descripcion, tr_tipo_atributo, tr_moneda, tr_estado)
VALUES (5, 'SALDO MINIMO MENSUAL', 'D', 0, 'V')
GO

UPDATE cobis..cl_seqnos 
SET siguiente = 5
WHERE tabla = 'pe_tipo_rango'
GO		