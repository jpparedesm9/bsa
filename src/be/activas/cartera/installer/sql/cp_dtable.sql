use cob_palm
go

if object_id ('ca_detalle_dividendos_pda2') is not null
	drop table ca_detalle_dividendos_pda2
go

if object_id ('ca_detalle_ejecutivo_pda2') is not null
	drop table ca_detalle_ejecutivo_pda2
go

if object_id ('ca_resumen_aprobados_pda2') is not null
	drop table ca_resumen_aprobados_pda2
go

if object_id ('ca_resumen_cancelados_his_pda2') is not null
	drop table ca_resumen_cancelados_his_pda2
go

if object_id ('ca_resumen_cancelados_pda2') is not null
	drop table ca_resumen_cancelados_pda2
go

if object_id ('ca_resumen_ejecutivo_pda2') is not null
	drop table ca_resumen_ejecutivo_pda2
go

if object_id ('ca_resumen_renovaciones_his_pda2') is not null
	drop table ca_resumen_renovaciones_his_pda2
go

if object_id ('ca_resumen_renovaciones_pda2') is not null
	drop table ca_resumen_renovaciones_pda2
go

if object_id ('pda_control') is not null
	drop table pda_control
go

if object_id ('pda_rechazos') is not null
	drop table pda_rechazos
	
IF OBJECT_ID ('dbo.ca_archivo_conciliacion_tmp') IS NOT NULL
	DROP TABLE dbo.ca_archivo_conciliacion_tmp
go

