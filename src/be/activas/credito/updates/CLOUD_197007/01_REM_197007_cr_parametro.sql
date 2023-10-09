------------->>>>>>>>>>>>>script 
use cobis
go

select * from cobis..cl_parametro
where pa_nemonico         in ('NRSPN1','NRSPN2')
and   pa_producto         = 'CRE'

delete cl_parametro where pa_nemonico = 'NRSPN1'
insert into cl_parametro values('REPORTE SOLIC PRELLENADA NOMBRE 1', 'NRSPN1', 'C', 'Hugo Suastegui Cervantes', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

delete cl_parametro where pa_nemonico = 'NRSPN2'
insert into cl_parametro values('REPORTE SOLIC PRELLENADA NOMBRE 2', 'NRSPN2', 'C', 'Norma Angélica Castro Reyes', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

select * from cobis..cl_parametro
where pa_nemonico         in ('NRSPN1','NRSPN2')
and   pa_producto         = 'CRE'

go
