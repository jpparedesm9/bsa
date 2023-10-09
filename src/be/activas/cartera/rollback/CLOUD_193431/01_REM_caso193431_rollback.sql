--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
use cob_cartera
go

if OBJECT_ID ('dbo.ca_reporte_cobranza_linea') IS NOT NULL
    drop table dbo.ca_reporte_cobranza_linea
go

--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
USE cobis
go

select * from cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'RRCBLI'

delete cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'RRCBLI'

--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
select * from cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'HRCBLI'

delete cl_parametro where pa_producto = 'CCA' and pa_nemonico = 'HRCBLI'
go
