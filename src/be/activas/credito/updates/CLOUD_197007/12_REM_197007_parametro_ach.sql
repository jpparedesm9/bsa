--------->>>>>>>>>--------->>>>>>>>>--------->>>>>>>>>
USE cobis
go

select * from cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'CDOGEN'

delete cl_parametro where pa_producto = 'CRE' and pa_nemonico = 'CDOGEN'

INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES('CANTIDAD DOCUMENTOS GENERADOS','CDOGEN','T',null,6,null,null,null,null,null,'CRE')

go
