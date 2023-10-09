use cobis
go

delete from cl_parametro where pa_nemonico in ('PSOLCR','PCRLCR','RDADHR')

insert into cl_parametro(pa_parametro,pa_nemonico,pa_char,pa_tipo,pa_producto)
values('NUMERO PIE DE PAGINA SOL LCR','PSOLCR','IF-034','C','CRE')

insert into cl_parametro(pa_parametro,pa_nemonico,pa_char,pa_tipo,pa_producto)
values('NUMERO PIE DE CONTRATO LCR','PCRLCR','JUR-914','C','CRE')

insert into cl_parametro(pa_parametro,pa_nemonico,pa_char,pa_tipo,pa_producto)
values('REPORTE DATO ADHESION RAYAS','RDADHR','14795-440-030864/03-04067-0919','C','CRE')
go
