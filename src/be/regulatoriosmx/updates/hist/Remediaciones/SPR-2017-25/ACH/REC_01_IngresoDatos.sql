use cobis
go

delete cobis..cl_parametro where pa_producto = 'REC' and pa_nemonico = 'NRBRCD'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)values('RPT BURO CREDITO - NOMBRE REPORTE','NRBRCD','C','Santander_Inclusion','REC')
go

delete cobis..cl_parametro where pa_producto = 'REC' and pa_nemonico = 'DRBCD1'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - DIRECCION P1 REPORTE','DRBCD1','C','VASCO DE QUIROGA 3900 TORRE A','REC')
go

delete cobis..cl_parametro where pa_producto = 'REC' and pa_nemonico = 'DRBCD2'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - DIRECCION P2 REPORTE','DRBCD2','C','PISO 19 LOMAS DE SANTA FE ','REC')
go

delete cobis..cl_parametro where pa_producto = 'REC' and pa_nemonico = 'DRBCD3'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - DIRECCION P3 REPORTE','DRBCD3','C','CONTADERO 05300','REC')
go
