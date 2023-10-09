use cobis
go

delete cl_parametro where pa_nemonico = 'RNRECA' and pa_producto = 'CRE'
delete cl_parametro where pa_nemonico = 'PPREPR' and pa_producto = 'CRE'
--
delete cl_parametro where pa_nemonico = 'PPREPL' and pa_producto = 'CRE'

go
