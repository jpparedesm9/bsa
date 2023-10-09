-----------------------------------------------------
--Creacion de tablas para el reporte diario de pagos
-----------------------------------------------------

use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reporte_pago_tmp') IS NOT NULL
   DROP TABLE ca_reporte_pago_tmp
GO

CREATE TABLE ca_reporte_pago_tmp(
rp_grupo          varchar(40),
rp_nombre_grupo   VARCHAR(40),
rp_cliente        varchar(40),
rp_nombre_cliente VARCHAR(40),
rp_banco          VARCHAR(40),
rp_monto          VARCHAR(40),
rp_cuota          VARCHAR(40),
rp_estado         VARCHAR(40) 
)
go


