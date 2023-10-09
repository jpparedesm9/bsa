-- Creación de tablas para conectores y monitoreo y zipeado de xml

-- tabla conectores
use cob_credito
go

IF OBJECT_ID ('dbo.cr_conector_timbrado') IS NOT NULL
	DROP table dbo.cr_conector_timbrado
go

-- tabla de logs
use cob_conta_super
go

if object_id ('sb_factura_paquete') IS NOT NULL
	drop table sb_factura_paquete
go

if object_id ('sb_complemento_paquete') IS NOT NULL
	drop table sb_complemento_paquete
go

IF object_id ('sb_log_factuacion') IS NOT NULL
	drop table sb_log_factuacion
go
   
IF object_id ('sb_log_complemento') IS NOT NULL
	drop table sb_log_complemento
go
