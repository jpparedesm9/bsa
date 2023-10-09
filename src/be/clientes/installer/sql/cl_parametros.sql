use cobis
go


/***************************************/
--CREACION PARAMETROS GENERALES
/***************************************/
delete cobis..cl_parametro
where pa_nemonico in('CDA','VDA','MED','EVPR','NAJUHO','NAJUHE','VGTPNA','FDVP','FDVD','MAXIGR','MINIGR','MV','MESREX','SVEREX','CNFREX','CREREX','CANREX','CA3CCC',
                     'CA3BLO','CLICON','URLGXM','EDADMA','RE','ESTVIG','EMAX','PAD','HIJ','CONY','UNL','FVDI','EMRCLI','TDRE','TDNE','FCSALD','TPERDS','ELACOM',
					 'ELABRN','ELACON','ELAUSR','ELAPWD','ELAURL','ELAEMA','ELAMCP','ELAM3M','ELAM6M','ELAENV','PAGNC','EXTVDC')
and pa_producto = 'CLI'
go
  
delete cobis..cl_parametro
where pa_nemonico = 'PAIS'
  and pa_producto = 'CEX'
go

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('CODIGO DEL PAIS', 'PAIS', 'S', null, null, 68, null, null, null, null, 'CEX')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('ESTADO CIVIL CASADO(A)','CDA','C','CA', null, null, null, null, null, null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('ESTADO VALIDACION PAISES RESTRINGIDOS', 'EVPR', 'C', 'M',  null, null, null, null, null, null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('ESTADO CIVIL MENOR DE EDAD','MED','C','MED',null,null,null,null,null,null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('Naturaleza Juridica Hogar Extranjero','NAJUHE','C','A52_2',null,null,null,null,null,null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('Naturaleza Juridica Hogar','NAJUHO', 'C', 'A52_1', null,     null,      null,      null,  null, null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('ESTADO CIVIL VIUDO(A)', 'VDA', 'C', 'VI', null,     null,      null,      null,  null, null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('TIPO DE PERSONA NATURAL', 'VGTPNA', 'C', '1',null,     null,      null,      null,  null, null,'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Fecha de vigencia de datos personale', 'FDVP', 'I', NULL, NULL, NULL, 12, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Fecha de vigencia de direcciones', 'FDVD', 'I', NULL, NULL, NULL,6, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO MAXIMO DE INTEGRANTES', 'MAXIGR', 'I', NULL, NULL, NULL, 40, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('NUMERO MINIMO DE INTEGRANTES', 'MINIGR', 'I', NULL, NULL, NULL,8, NULL, NULL, NULL, 'CLI')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MESES VIGENTES INFORMACION', 'MV', 'I', 'MV', NULL, NULL, 6, NULL, NULL, NULL, 'CLI')	
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('TIPO DE DIRECCION PARA FACTURA', 'RE'       , 'C'    ,    'RE',       null,        null,   null,     null,        null,     null,       'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values('ESTADO VIGENTE', 'ESTVIG', 'C', 'V', null, null, null, null, null, null, 'CLI')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('MAYORIA DE EDAD MAX', 'EMAX', 'T', NULL, 98, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION PADRE', 'PAD', 'T', NULL, 211 , NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION HIJO', 'HIJ', 'T', NULL, 210, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('RELACION CONYUGUE', 'CONY', 'T', NULL, 209, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ESTADO CIVIL UNION LIBRE', 'UNL', 'C', 'UN', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FECHA DE VENCIMIENTO DE DOCUMENTO DE IDENTIDAD', 'FVDI', 'D', NULL, NULL, NULL, NULL, NULL, '2100-12-31', NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('EDAD MINIMA PARA EL REGISTRO DE UN CLIENTE', 'EMRCLI', 'I', NULL, NULL, NULL, 0, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE DIRECCION DOMICILIO', 'TDRE', 'C', 'RE', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('TIPO DE DIRECCION PARA EL NEGOCIO', 'TDNE', 'C', 'AE', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLIENTE CON A3 CCC', 'CA3CCC', 'C', 'A3 CCC', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLIENTE CON A3 BLOQUEANTE', 'CA3BLO', 'C', 'A3 Bloqueante', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('CLIENTE CONDICIONADO', 'CLICON', 'C', 'Cliente Condicionado', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('FECHA SALIDA ALERTAS', 'FCSALD', 'D', NULL, NULL, NULL, NULL, NULL, '01/04/2019', NULL, 'CLI')
INSERT INTO cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) 
VALUES ('TIEMPO PARA ELIMINAR REGISTROS DE SINCRONIZACION','TPERDS','S',NULL, NULL,3,NULL,NULL,NULL,NULL,'ADM')
--ELAVON
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON COMPANY','ELACOM', 'C', '9249', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON BRANCH', 'ELABRN', 'C', '00746', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON COUNTRY','ELACON', 'C', 'MEX', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON USER',   'ELAUSR', 'C', '9249ITUS8', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON PASSWORD','ELAPWD', 'C', 'DTIX652SCU', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON URL','ELAURL', 'C', 'https://qa10.mitec.com.mx/', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON BUSINESS EMAIL','ELAEMA', 'C', 'test@test.com', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON MERCHANT CASH PAYMENT','ELAMCP', 'C', '184541', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON MERCHANT 3 MONTH WITHOUT INT','ELAM3M', 'C', '157490', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON MERCHANT 6 MONTH WITHOUT INTT','ELAM6M', 'C', '157491', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ELAVON ENVIROMENT','ELAENV', 'C', 'QA', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PAGINACION CLIENTES', 'PAGNC', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'ADM')

--WEBPAY PLUS
delete cobis..cl_parametro where pa_nemonico  in ('WPPCOM', 'WPPBRN', 'WPPUSR', 'WPPPWD', 'WPPDAT', 'WPPCAN', 'WPPEVN', 'WPPSOC', 'WPPENA',
                                                  'WPPSIM', 'WPPPRO', 'WPPDOM', 'WPPPRT', 'WPPUBO', 'WPPKE1', 'WPPKE2')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS COMPANY', 'WPPCOM', 'C', '849A', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS BRANCH', 'WPPBRN', 'C', '0003', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS USER', 'WPPUSR', 'C', '849ASIUS1', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS PASSWORD', 'WPPPWD', 'C', '0D7IHKFH9Z', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS DATA0', 'WPPDAT', 'C', '9265655290', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS CANAL', 'WPPCAN', 'C', 'W', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS ENVIAR NOTIFICACION', 'WPPEVN', 'T', null, 0, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS SOLICITAR CORREO', 'WPPSOC', 'T', null, 1, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS ENROLAMIENTO AUTOMATICO', 'WPPENA', 'C', 'M', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS SIMULACION NO PRESENTE', 'WPPSIM', 'T', null, 0, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS PROTOCOLO', 'WPPPRO', 'C', 'https://', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS DOMINIO', 'WPPDOM', 'C', 'bc.mitec.com.mx:', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS PUERTO', 'WPPPRT', 'I', null, null, null, 6545, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS URL BODY', 'WPPUBO', 'C', '/p/gen', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS KEY', 'WPPKE1', 'C', '77DA0C7448A84C0B48290D68C0FB1', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto) 
values ('WEB PAY PLUS KEY', 'WPPKE2', 'C', '6B3', null, null, null, null, null, null, 'CLI')

delete cobis..cl_parametro where pa_nemonico  in ('DIAREX', 'DIACRE', 'DIACAE', 'DIACME', 'POCOGR','PAISGE','DISGEO','RADGEO',
                                                  'URLGEO','PRTGEO','SERGEO')
and pa_producto = 'CLI'

insert into cobis..cl_parametro values ('MESES EVALUACION RIESGO EXTERNO', 'MESREX', 'S', null, null, 24, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('SALDO VENCIDO RIESGO EXTERNO', 'SVEREX', 'M', null, null, null, null, 500, null, null, 'CLI')
insert into cobis..cl_parametro values ('SALDO CUENTAS NO FINANCIERAS RIESGO EXTERNO', 'CNFREX', 'M', null, null, null, null, 2000, null, null, 'CLI')
insert into cobis..cl_parametro values ('CUENTA RECIENTE RIESGO EXTERNO', 'CREREX', 'S', null, null, 3, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('CUENTA ANTIGUA RIESGO EXTERNO', 'CANREX', 'S', null, null, 12, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('FECHA ULTIMO REPORTE LCR', 'FURLCR', 'C', '', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS RETRASO LCR', 'DRELCR', 'I', null, null, null, 1, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIA SEMANA EJECUCION CANDIDATOS LCR', 'DECLCR', 'I', null, null, null, 6, null, null, null,'CLI')
insert into cobis..cl_parametro values ('CORREO POR DEFECTO SANTANDER', 'CPDSAN', 'C', 'ejprado@santander.com.mx', null, null, null, null, null, null,'CLI')
insert into cobis..cl_parametro values ('DIAS EVALUACION RIESGO EXTERNO', 'DIAREX', 'S', null, null, 365, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS CUENTA RECIENTE RIESGO EXTERNO', 'DIACRE', 'S', null, null, 90, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS CUENTA ANTIGUA RIESGO EXTERNO', 'DIACAE', 'S', null, null, 365, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DIAS CUENTA MITIGADORA RIESGO EXTERNO', 'DIACME', 'S', null, null, 90, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('POLITICA CONFORMACION GRUPAL', 'POCOGR', 'C', 'NO', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('PAIS DE GEOLOCALIZACION', 'PAISGE', 'C', 'MX', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('DISTANCIA PERMITIDA GEOLOCALIZACION (METROS)', 'DISGEO', 'I', null, null, null, 10, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('RADIO MAXIMO GEOLOCALIZACION (KILOMETROS)', 'RADGEO', 'I', null, null, null, 50, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('URL GEOLOCALIZACION', 'URLGEO', 'C', 'https://maps.googleapis.com:', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('PUERTO GEOLOCALIZACION', 'PRTGEO', 'I', null, null, null, 8080, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('URL GEOLOCALIZACION', 'SERGEO', 'C', '/maps/api/geocode/json?', null, null, null, null, null, null, 'CLI')
insert into cobis..cl_parametro values ('EDAD DE ADULTOS MAYORES', 'EDADMA', 'T', null, 70, null, null, null, null, null, 'CLI')

delete from cl_parametro where pa_nemonico='PAGNC'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('PAGINACION CLIENTES', 'PAGNC', 'I', NULL, NULL, NULL, 20, NULL, NULL, NULL, 'ADM')

---------------------------------------
--------  BIOMETRICOS -----------------
---------------------------------------

delete from cl_parametro where pa_nemonico in 
('RENAPO', 'PSOLCR', 'PCRLCR', 'VIGANI', 'VIGREI', 
'VIGCOD', 'VIGSOC', 'RENBRN', 'RENCHN', 'RENTTP',
'RENTI1','RENTI2','RENLON','RENLAT','VBIO','ENVBIO') 
and pa_producto='CLI'

insert into cl_parametro( pa_parametro, pa_nemonico, pa_char, pa_tipo,pa_producto) values('NUMERO PIE DE PAGINA SOL LCR','PSOLCR','IF-034','C','CRE')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_char, pa_tipo,pa_producto) values('NUMERO PIE DE CONTRATO LCR','PCRLCR','JUR-914','C','CRE')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('BANDERA PARA HABILITAR RENAPO','RENAPO','C','N','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('BRANCH RENAPO','RENBRN','C','0000','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('CHANNEL RENAPO','RENCHN','C','002','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('TRANSACTION TYPE RENAPO','RENTTP','C','7001','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('TRANSACTION ID PT 1 RENAPO','RENTI1','C','12345123451234512','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('TRANSACTION ID PT 2 RENAPO','RENTI2','C','34512374','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('LONGITUDE RENAPO','RENLON','C','1','CLI') 
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('LATITUDE RENAPO','RENLAT','C','1','CLI')
insert into cl_parametro( pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto) values('RESPUESTA RENAPO OK002','RENOK2','C','OK0002','CLI')


insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto) values ('VIGENCIA ANVERSO IDENTIFICACION','VIGANI','S',30,'CLI')
insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto) values ('VIGENCIA REVERSO IDENTIFICACION','VIGREI','S',30,'CLI') 
insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto) values ('VIGENCIA COMPROBANTE DOMICILIO','VIGCOD','S',30,'CLI')
insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_smallint,pa_producto) values ('VIGENCIA SOLICITUD CORTA','VIGSOC','S',90,'CLI')

insert into cl_parametro ( pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values('BANDERA PARA HABILITAR VALIDACION BIOMETRICA EN FLUJO','VBIO','C','N','CLI')

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('AMBIENTE SERVICIOS BIOMETRICOS', 'ENVBIO', 'C', 'pro', 'CLI')

insert into cl_parametro(pa_parametro,pa_nemonico,pa_char,pa_tipo,pa_producto)
values('NUMERO PIE DE CONTRATO LCR','PCRLCR','JUR-914','C','CRE')

insert into cobis..cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_money,pa_producto)
values ('MONTO MAXIMO A EVALUAR','MONEVA','M',21500,'CRE')
go


delete cobis..cl_parametro where pa_nemonico in ('VENMIN','VENMAX')

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VENTAS MENSUALES MINIMAS COLECTIVO', 'VENMIN', 'M', NULL, NULL, NULL, NULL, 1000, NULL, NULL, 'CLI')


insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VENTAS MENSUALES MAXIMA COLECTIVO', 'VENMAX', 'M', NULL, NULL, NULL, NULL, 300000, NULL, NULL, 'CLI')

GO

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('URL GEOLOCALIZACION XML', 'URLGXM', 'C', '/maps/api/geocode/xml?', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go

delete cobis..cl_parametro where pa_nemonico  in ('EDADMA')
insert into cobis..cl_parametro values ('EDAD DE ADULTOS MAYORES', 'EDADMA', 'T', null, 70, null, null, null, null, null, 'CLI')
go

----------   PARAMETROS DE LIMITE INFERIOR Y LIMITE SUPERIOR

delete from cobis..cl_parametro where pa_nemonico = 'LIMINF'
delete from cobis..cl_parametro where pa_nemonico = 'LIMSUP'

insert into cobis..cl_parametro values('Limite Inferior','LIMINF','M',null,null,null,null,1000,null,null,'CLI')
insert into cobis..cl_parametro values('Limite Superior','LIMSUP','M',null,null,null,null,300000,null,null,'CLI')

----------   PARAMETROS DE PORCENTAJE

delete from cobis..cl_parametro where pa_nemonico = 'PGM'
delete from cobis..cl_parametro where pa_nemonico = 'PUM'

insert into cobis..cl_parametro values('Porcentaje de Gastos Mensuales','PGM','M',null,null,null,20,null,null,null,'CLI')
insert into cobis..cl_parametro values('Porcentaje de Utilidad Mensual','PUM','M',null,null,null,35,null,null,null,'CLI')

----------   PARAMETROS DE MULTIPLO DE 100

delete from cobis..cl_parametro where pa_nemonico = 'MCIEN'

insert into cobis..cl_parametro values('Multiplo de 100','MCIEN','M',null,null,null,100,null,null,null,'CLI')
go

----------   PARAMETRO DE ACTIVAR DUPLICADOS PARA TELEFONO CELULAR
delete from cobis..cl_parametro where pa_producto = 'CLI' and pa_nemonico in ('ACTEDU')

insert into cobis..cl_parametro values ('ACTIVAR CELULAR DUPLICADO', 'ACCEDU', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go

------------- PARAMETRO ROL PARA EDITAR CAMPOS PARA CURP Y RFC
delete from cl_parametro where pa_nemonico = 'RMCRF' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
values ('ROL MODIFICA DATOS PARA CURP Y RFC','RMCRF','I',29,'CLI')

go

delete from cobis..cl_parametro where pa_nemonico in ('ESCB','ECCB','NDCB')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENVIO SMS CONTRATACION BIOMETRICO', 'ESCB', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('ENVIO CORREO CONTRATACION BIOMETRICO', 'ECCB', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('NUMERO DE CONTACTO BIOMETRICO', 'NDCB', 'C', '5551694363', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')

delete from cobis..cl_parametro where pa_nemonico in ('CLCR')
INSERT INTO cobis.cl_parametro (pa_parametro,pa_nemonico,pa_tipo,pa_char,pa_tinyint,pa_smallint,pa_int,pa_money,pa_datetime,pa_float,pa_producto) VALUES
	 ('ENVIA CORREO LCR','CLCR','C','S',NULL,NULL,NULL,NULL,NULL,NULL,'CLI');

GO
------------- PARAMETRO CODIGO POR DEFECTO COLECTIVO
delete from cl_parametro where pa_nemonico = 'CDDFCL' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('CODIGO POR DEFECTO COLECTIVO','CDDFCL','C','I','CLI')
go

------------- PARAMETRO CODIGO POR DEFECTO COLECTIVO
delete from cl_parametro where pa_nemonico = 'CDDFNC' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('CODIGO POR DEFECTO NIVEL COLECTIVO','CDDFNC','C','O','CLI')

------------- PARAMETRO CODIGO POR DEFECTO COLECTIVO
delete from cl_parametro where pa_nemonico = 'NIRICL' and pa_producto = 'CLI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
values ('NIVEL DE RIESGO DEL CLIENTE','NIRICL','C','B','CLI')

go


use cobis
go

delete cl_parametro where pa_nemonico = 'VAMOBI'

insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_money, pa_producto) 
values('PARAMETRO PARA VALIDAR MONTOS PARA BIOMETRICO ','VAMOBI','M',18000,'CLI')
go


-- PARAMETRO TIPO CALIFICACION -- Requerimiento #203112 OT Modelo AceptaciOn Grupal, BC
delete cl_parametro where pa_nemonico = 'TIPCAL'
insert into cl_parametro values('TIPO CALIFICACION PARA EVALUACION CLIENTE', 'TIPCAL', 'C', 'S', null, null, null, null, null, null, 'CLI')
go


-- PARAMETRO VIGENCIA REGISTROS EVALUACION CLIENTE -- Requerimiento #205892 OT Reporte Riesgo individual nva evaluacion
use cobis
go

delete cl_parametro where pa_nemonico = 'TMBUCO'

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('VIGENCIA REGISTROS EVALUACION CLIENTE EN017', 'VREC17', 'I', null, null, null, 3, null, null, null, 'CLI')

go


use cobis
go

delete cl_parametro where pa_nemonico = 'TMBUCO'

insert into dbo.cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('LONGITUD  MAX BUC ONBO ', 'TMBUCO', 'I', NULL, NULL, NULL, 8, NULL, NULL, NULL, 'CLI')

go

use cobis
go

delete cl_parametro where pa_nemonico in ('VAMAIL','VASMS')

insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('VALIDACION DE MAIL','VAMAIL','C','S','CLI')
insert into cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto) values ('VALIDACION DE MOVIL SMS','VASMS','C','S','CLI')

go

----------------------------------------------------------------------------------
-- Se realiza el caso 203621 en 193221 RENAPO POR CURP
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('ACTIVAR CONSULTA RENAPO POR CURP', 'ACRXCR', 'C', 'S', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go

--Caso#208303 Privada Control de extenciones de archivo en carga
insert into cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
values ('Extensiones válidas para Documentos', 'EXTVDC', 'C', 'PDF;PNG;JPG', NULL, NULL, NULL, NULL, NULL, NULL, 'CLI')
go
