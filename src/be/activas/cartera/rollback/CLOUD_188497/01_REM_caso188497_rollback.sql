-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Creacion de parametros
use cobis
go

select * from cobis..cl_parametro
WHERE pa_producto = 'CCA' AND pa_nemonico = 'DAVCOU'

DELETE cobis..cl_parametro
WHERE pa_producto = 'CCA' AND pa_nemonico = 'DAVCOU'

select * from cobis..cl_parametro
WHERE pa_producto = 'CCA' AND pa_nemonico = 'DAVCOU'
GO

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--Caso188497 tablas para proximo vencimiento de coutas
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_prox_vencimiento_cuotas_det') IS NOT NULL
	DROP TABLE dbo.ca_prox_vencimiento_cuotas_det
GO

IF OBJECT_ID ('dbo.ca_prox_vencimiento_cuotas') IS NOT NULL
	DROP TABLE dbo.ca_prox_vencimiento_cuotas
GO

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--REGISTRO DE REPORTE PARA NOTIFICADOR
use cobis
go

declare @w_tabla_cod int

select @w_tabla_cod = codigo from cl_tabla where tabla = 'ca_param_notif'

SELECT * FROM cl_catalogo WHERE tabla = @w_tabla_cod AND codigo IN ('PPCVE_NJAS', 'PPCVE_NPDF', 'PPCVE_NXML')

DELETE cl_catalogo WHERE tabla = @w_tabla_cod AND codigo IN ('PPCVE_NJAS', 'PPCVE_NPDF', 'PPCVE_NXML')

SELECT * FROM cl_catalogo WHERE tabla = @w_tabla_cod AND codigo IN ('PPCVE_NJAS', 'PPCVE_NPDF', 'PPCVE_NXML')
go

-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>-->>
--