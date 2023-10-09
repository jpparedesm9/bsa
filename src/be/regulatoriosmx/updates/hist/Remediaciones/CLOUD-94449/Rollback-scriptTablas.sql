-----------------------------------------------------
--Rollback del reporte diario de pagos
-----------------------------------------------------

--------
--TABLA
--------
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reporte_pago_tmp') IS NOT NULL
   DROP TABLE ca_reporte_pago_tmp
GO
