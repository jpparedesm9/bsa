use cobis
go

delete cl_parametro where pa_nemonico in ('RSCGRE', 'RSCGPI', 'RSCRFR', 'RSCRFP') and pa_producto='CCA' 

go
