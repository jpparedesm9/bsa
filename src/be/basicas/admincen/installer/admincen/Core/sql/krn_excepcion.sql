use cobis
go

if exists (select 1 from cl_parametro where pa_nemonico = 'SCVL' and pa_producto = 'ADM')
    delete from cl_parametro where pa_nemonico = 'SCVL' and pa_producto = 'ADM'

insert into cl_parametro (pa_nemonico, pa_parametro, pa_tipo, pa_char, pa_producto)
values ('SCVL', 'SERVIDOR CENTRAL PARA VALIDACION DE LOGIN', 'C', 'CTSSRV' , 'ADM')

go
