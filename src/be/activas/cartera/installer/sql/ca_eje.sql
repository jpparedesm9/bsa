use cob_cartera
go

truncate table tasas_periodos 
go

insert into tasas_periodos values (7      ,51.43)
insert into tasas_periodos values (14     ,25.71)
insert into tasas_periodos values (15     ,24.00)
insert into tasas_periodos values (30     ,12.00)
insert into tasas_periodos values (90     ,4.00 )
insert into tasas_periodos values (180    ,2.00 )
insert into tasas_periodos values (360    ,1.00 )
insert into tasas_periodos values (28     ,12.86)

go



delete from ca_eje
 where ej_matriz in ('ASIG_AUTO','COMFAGANU','COMFAGUNI','COMFGAUNI','COMFNGANU','COMFNGAUT','COMGARCAL','COMGARNSA','COMGARTUM','COMGARUNI','COMUSASEM',
                     'DIASMAXNEG','GEN_CNTRAC','INSAPRMIR','MIPYMES','MIPYMESFX','MONTO_EMP','MONTO_MAX','MSGCONPRES','NUM_NORM','PLAZO_EMP','PLAZO_MAX',
                     'POL_CTROFE','PORMAXCOND','TASAS_MAX','TASAS_MIN','TASA_DEF','TASA_MN_LC','VAL_FNG','VAL_MATRIZ','VAL_NORM')
go

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_MATRIZ', 'LINEA', '2010-01-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_MATRIZ', 'MATRIZ', '2010-01-01', 2, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_EMP', 'LINEA', '2009-08-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_EMP', 'SMV', '2009-08-01', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFGAUNI', 'MONTO CREDITO', '2009-08-01', 1, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFNGAUT', 'SMV', '2009-08-01', 1, 'M', 'S', '1.5')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_NORM', 'GRUPO', '2015-10-15', 2, 'I', 'N', '0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFNGANU', 'SMV', '2009-08-01', 1, 'M', 'S', '1.5')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('INSAPRMIR', 'BANCA', '2011-11-15', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('INSAPRMIR', 'CUMPLIMIENTO DE POLITICAS', '2011-11-15', 2, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('INSAPRMIR', 'DECISION DE SCORE', '2011-11-15', 3, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('INSAPRMIR', 'MONTO EN SMMLV', '2011-11-15', 4, 'F', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'ALIANZA', '2010-01-01', 10, 'I', 'N', '0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'CREDITO NUEVO/RENOVADO', '2010-01-01', 1, 'C', 'N', 'R')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'LINEA DE CREDITO', '2010-01-01', 2, 'C', 'N', 'SINCO')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'MERCADO SUBTIPO', '2010-01-01', 3, 'C', 'N', 'U')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'MERCADO OBJETIVO', '2010-01-01', 4, 'C', 'N', '001')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'CLASE CARTERA', '2010-01-01', 5, 'C', 'N', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'NIVEL DE RIESGO', '2010-01-01', 6, 'F', 'N', '0.0534')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'MONTO SOLICITADO', '2010-01-01', 7, 'M', 'S', '4.507042')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MIN', 'PLAZO EN MESES', '2010-01-01', 8, 'I', 'S', '23')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMGARCAL', 'MONTO CREDITO', '2013-08-31', 1, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMGARUNI', 'TIPO GARANTIA', '2013-08-31', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMGARUNI', 'MONTO CREDITO', '2013-08-31', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('ASIG_AUTO', 'CAMPANA', '2013-04-01', 1, 'I', 'N', '6')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('ASIG_AUTO', 'SEGMENTO', '2013-04-01', 2, 'C', 'N', '01')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PORMAXCOND', 'ACUERDOS', '2013-01-12', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PORMAXCOND', 'ROLES', '2013-01-12', 2, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PORMAXCOND', 'RUBROS', '2013-01-12', 3, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('ASIG_AUTO', 'MERCADO', '2013-04-01', 3, 'C', 'N', 'U')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('POL_CTROFE', 'TIPOS DE BANCA', '2013-04-01', 1, 'I', 'N', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('POL_CTROFE', 'TIPOS DE SEGMENTOS', '2013-04-01', 2, 'F', 'N', '01')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('POL_CTROFE', 'TIPOS DE EVENTOS', '2013-04-01', 3, 'C', 'N', 'CON')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('POL_CTROFE', 'TIPOS DE CALIFICACION', '2013-04-01', 4, 'I', 'N', '5')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('POL_CTROFE', 'PORCENTAJE DE DESEMBOLSO', '2013-04-01', 5, 'F', 'S', '50.0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('POL_CTROFE', 'PORCENTAJE DE CUOTAS PAGADAS', '2013-04-01', 6, 'F', 'S', '85.0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MSGCONPRES', 'BANCA', '2013-04-01', 1, 'I', 'N', '4')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MSGCONPRES', 'EVENTO', '2013-04-01', 2, 'C', 'N', 'CON')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'LINEA DE CREDITO', '2013-04-01', 1, 'C', 'N', 'SINCO')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'CAMPANA', '2013-04-01', 2, 'I', 'N', '8')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'RUBRO', '2013-04-01', 3, 'C', 'N', 'INT')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'ROL', '2013-04-01', 4, 'I', 'N', '47')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'CLASE DE CARTERA', '2013-04-01', 5, 'I', 'N', '4')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'DESTINO DE CREDITO', '2013-04-01', 6, 'C', 'N', '01')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_MN_LC', 'NUMERO DE CREDITOS CANCELADOS', '2013-04-01', 7, 'I', 'S', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PLAZO_MAX', 'LINEA', '2009-08-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PLAZO_MAX', 'SMV', '2009-08-01', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'CREDITO NUEVO/RENOVADO', '2010-01-01', 1, 'C', 'N', 'R')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'LINEA DE CREDITO', '2010-01-01', 2, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'MERCADO SUBTIPO', '2010-01-01', 3, 'C', 'N', 'U')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('NUM_NORM', 'TIPO_NORM', '2013-08-31', 1, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('NUM_NORM', 'NUM_POR HERRAMIENTA', '2013-08-31', 2, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('NUM_NORM', 'COMPARTIDA CON HERRAMIENTA', '2013-08-31', 3, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMGARNSA', 'MONTO CREDITO', '2014-05-29', 1, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('NUM_NORM', 'GRUPO NORMALIZACION', '2013-08-31', 4, 'I', 'N', '0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MIPYMES', 'OFICINA', '2009-08-01', 1, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MIPYMES', 'SMV', '2009-08-01', 2, 'M', 'S', '4')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MIPYMES', 'CLIENTE', '2009-08-01', 3, 'C', 'N', 'R')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'MERCADO OBJETIVO', '2010-01-01', 4, 'C', 'N', '001')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'CLASE CARTERA', '2010-01-01', 5, 'C', 'N', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'NIVEL DE RIESGO', '2010-01-01', 6, 'F', 'S', '0.0534')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'MONTO SOLICITADO', '2010-01-01', 7, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'PLAZO EN MESES', '2010-01-01', 8, 'I', 'S', '11')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASAS_MAX', 'NOTA INTERNA', '2010-01-01', 9, 'I', 'S', '3')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_MAX', 'TIPO TRAMITE', '2010-10-09', 1, 'C', 'N', 'NU')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_MAX', 'CODEUDOR', '2010-10-09', 2, 'C', 'N', 'SC')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_MAX', 'CONDICIONES DEUDOR', '2010-10-09', 3, 'C', 'N', 'DCP')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_MAX', 'TIPO EMPLEO CODEUDOR', '2010-10-09', 4, 'C', 'N', 'CD')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MONTO_MAX', 'CONDICIONES CODEUDOR', '2010-10-09', 5, 'C', 'N', 'CSP')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PLAZO_EMP', 'LINEA', '2009-08-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PLAZO_EMP', 'SMV', '2009-08-01', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PLAZO_EMP', 'APLICA SALARIO_EMPLEADO', '2009-08-01', 3, 'C', 'N', 'N')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('PLAZO_EMP', 'SALARIO_EMPLEADO', '2009-08-01', 4, 'M', 'N', '20')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('DIASMAXNEG', 'ACUERDOS', '2013-01-12', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('DIASMAXNEG', 'ROLES', '2013-01-12', 2, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGANU', 'TIPO DE PRODUCTOR', '2009-08-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGANU', 'MONTO CREDITO', '2009-08-01', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMGARTUM', 'MONTO CREDITO', '2013-08-31', 1, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_FNG', 'TIPO_GAR', '2009-08-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGANU', 'TIPO DE GARANTIA', '2009-08-01', 3, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGANU', 'COBERTURA', '2009-08-01', 4, 'F', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGANU', 'PERIODICIDAD DE COBRO', '2009-08-01', 5, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_FNG', 'SMV', '2009-08-01', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MIPYMESFX', 'OFICINA', '2009-08-01', 1, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MIPYMESFX', 'SMV', '2009-08-01', 2, 'M', 'S', '4')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('MIPYMESFX', 'CLIENTE', '2009-08-01', 3, 'C', 'N', 'R')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_FNG', 'DESTINO', '2009-08-01', 3, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_NORM', 'TIPO NORMALIZACION', '2015-10-15', 1, 'I', 'N', '0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('VAL_NORM', 'CLASE DE CARTERA', '2015-10-15', 3, 'I', 'N', '0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('GEN_CNTRAC', 'CAMPANA', '2012-04-05', 1, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('GEN_CNTRAC', 'TIPO DE TRAMITE', '2012-04-05', 2, 'C', 'N', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('GEN_CNTRAC', 'CUPO ROTATIVO SI/NO', '2012-04-05', 3, 'C', 'N', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('GEN_CNTRAC', 'TIPO DE DOCUMENTO', '2012-04-05', 4, 'C', 'N', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'LINEA DE CREDITO', '2013-04-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'CAMPANA', '2013-04-01', 2, 'I', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'RUBROS', '2013-04-01', 3, 'C', 'N', 'INT')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'CLASES DE CARTERA', '2013-04-01', 4, 'I', 'N', '4')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'DESTINOS DE CREDITO', '2013-04-01', 5, 'C', 'N', '01')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'NUMERO DE CREDITOS CANCELADOS', '2013-04-01', 6, 'I', 'S', '0')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'MONTO SOLICITADO', '2013-04-01', 7, 'M', 'S', '1')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'CREDITO NUEVO/RENOVADO', '2013-04-01', 8, 'C', 'N', 'R')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('TASA_DEF', 'TIPO DE TRAMITE', '2013-04-01', 9, 'C', 'N', 'O')

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGUNI', 'TIPO DE PRODUCTOR', '2009-08-01', 1, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGUNI', 'MONTO CREDITO', '2009-08-01', 2, 'M', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGUNI', 'TIPO DE GARANTIA', '2009-08-01', 3, 'C', 'N', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGUNI', 'COBERTURA', '2009-08-01', 4, 'F', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMFAGUNI', 'PLAZO', '2009-08-01', 5, 'I', 'S', NULL)

insert into ca_eje (ej_matriz, ej_descripcion, ej_fecha_vig, ej_eje, ej_tipo_dato, ej_rango, ej_valor_default)
values ('COMUSASEM', 'SMV', '2009-08-01', 1, 'M', 'S', 'N')
go

