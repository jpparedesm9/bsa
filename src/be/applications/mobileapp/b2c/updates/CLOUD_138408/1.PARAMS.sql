use cobis
go

delete from cl_parametro where pa_nemonico = 'VCLAN'

insert into cl_parametro(pa_parametro, pa_nemonico,pa_tipo , pa_char, pa_producto) values('VALIDA CLIENTES ANTIGUOS','VCLAN','C','S','ADM')
go

