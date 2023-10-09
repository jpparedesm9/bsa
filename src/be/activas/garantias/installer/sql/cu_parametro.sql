use cobis
go

delete ba_parametro
 where pa_sarta = 0
   and pa_batch in (19057,19058,19059,19060)--,19064)
go

insert into ba_parametro values (0,     19057, 0, 1, 'FECHA DE PROCESO',                                  'D', '01/01/2009')
insert into ba_parametro values (0,     19057, 0, 2, 'NOMBRE ARCHIVO',                                    'C', 'carga.txt')
insert into ba_parametro values (0,     19057, 0, 3, 'SIMULACION (S/N)',                                  'C', 'N')
insert into ba_parametro values (0,     19058, 0, 1, 'FECHA DE PROCESO',                                  'D', '01/01/2009')
insert into ba_parametro values (0,     19058, 0, 2, 'REPORTE',                                           'C', '0')
insert into ba_parametro values (0,     19059, 0, 1, 'FECHA DE PROCESO',                                  'D', '01/01/2009')
insert into ba_parametro values (0,     19059, 0, 2, 'REPORTE',                                           'C', '0')
--insert into ba_parametro values (0,     19064, 0, 1, 'FECHA DE PROCESO',                                  'D', '06/01/2009')
insert into ba_parametro values (0,     19060, 0, 1, 'FECHA PROCESO',                                     'D', '02/01/2017')
go

delete ba_parametro
 where pa_sarta = 19201
   and pa_batch in (19057,19058,19059,19060)--,19064)
go

insert into ba_parametro values (19201, 19058, 1, 1, 'FECHA DE PROCESO',                                  'D', '01/01/2009')
insert into ba_parametro values (19201, 19058, 1, 2, 'REPORTE',                                           'C', '2200')
insert into ba_parametro values (19201, 19059, 2, 1, 'FECHA DE PROCESO',                                  'D', '01/01/2009')
insert into ba_parametro values (19201, 19059, 2, 2, 'REPORTE',                                           'C', '0')
insert into ba_parametro values (19201, 19057, 3, 1, 'FECHA DE PROCESO',                                  'D', '01/01/2009')
insert into ba_parametro values (19201, 19057, 3, 2, 'NOMBRE ARCHIVO',                                    'C', 'carga.txt')
insert into ba_parametro values (19201, 19057, 3, 3, 'SIMULACION (S/N)',                                  'C', 'N')
insert into ba_parametro values (19201, 19060, 4, 1, 'FECHA PROCESO',                                     'D', '02/01/2017')
go
