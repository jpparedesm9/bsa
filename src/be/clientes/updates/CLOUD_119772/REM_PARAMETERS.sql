use cobis
go


delete from cl_parametro where pa_nemonico in 
('ETACCB','ETABLN','ETACRL','ETACFC','ETAFCC',
'QESCOL','NICBS','NDCBS','ESASEX',
'COMLCR','MINDES','MAXINC', 'ETAVDA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA CONSULTAR CUENTA Y BUC', 'ETACCB', 'C', 'CONSULTAR CUENTA Y BUC', null, null, null, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA CONSULTAR BURO LN Y NF', 'ETABLN', 'C', 'CONSULTAR BURO LN Y NF', null, null, null, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA CALCULAR CALIFICACION RIESGO Y', 'ETACRL', 'C', 'CALCULAR CALIFICACION RIESGO Y', null, null, null, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA CAPTURAR FIRMAS Y CUESTIONARIO', 'ETACFC', 'C', 'CAPTURAR FIRMAS Y CUESTIONARIO', null, null, null, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA FIRMAS Y CUESTIONARIO COLECTIVOS', 'ETAFCC', 'C', 'FIRMAS Y CUESTIONARIO', null, null, null, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DE PREGUNTAS ETAPA FIRMAS Y CUESTIONARIO', 'QESCOL', 'I', null, 23, null, null, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO INTENTOS CUENTA BUC SANTANDER', 'NICBS', 'I', null, null, null, 4, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO DIAS INTENTOS CUENTA BUC SANTANDER', 'NDCBS', 'I', null, null, null, 4, null, null, null, 'CRE')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ESPERA DE ASIGNACION DE ASESOR EXTERNO', 'ESASEX', 'C', 'ESPERAR ASIGNACIÓN DE ASESOR E', null, null, null, null, null, null, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('COMISION POR DEFECTO LCR', 'COMLCR', 'F', null, null, null, null, null, null, 0.3, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO MINIMO DE DESEMBOLSO POR DEFECTO LCR', 'MINDES', 'M', null, null, null, null, 300, null, null, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('MONTO INCREMENTO MAXIMO POR DEFECTO LCR', 'MAXINC', 'M', null, null, null, null, 0, null, null, 'CCA')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NOMBRE DE LA ETAPA VERIFICAR DATOS', 'ETAVDA', 'C', 'VERIFICAR DATOS', null, null, null, 0, null, null, 'CRE')
go