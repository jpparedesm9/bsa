use cobis
go

delete from cl_parametro where pa_nemonico in ('MBSTO','TLSC','MTDS') and pa_producto = 'BVI'
go

insert into cl_parametro 
values('B2C - TIMEOUT SESSION','MBSTO','T',NULL,5,NULL,NULL,NULL,NULL,NULL,'BVI')


insert into cobis..cl_parametro 
values('B2C - TELEFONO SERVICIO TUIIO','TLSC','C','',NULL,NULL,NULL,NULL,NULL,NULL,'BVI')

insert into cl_parametro 
values('B2C - TIEMPO DE SESION','MTDS','T',NULL,59,NULL,NULL,NULL,NULL,NULL,'BVI')
go

update cl_parametro
set pa_int = 6
where pa_nemonico = 'TAMT'
      and pa_producto   = 'BVI'

go
