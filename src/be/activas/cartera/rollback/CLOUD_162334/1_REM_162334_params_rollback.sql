--Disposiciones B2C -- Caso #162334
use cobis
go

delete cl_parametro where pa_nemonico in ('MSCCTA', 'CHRSEP')

go