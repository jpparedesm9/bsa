use cob_cartera
go

delete from ca_pie_pagina_corresp
delete from ca_corresponsal_err
delete from ca_corresponsal_limites
delete from ca_corresponsal_tipo_ref
delete from ca_corresponsal

-- INSERCION CORRESPONSALES
insert into ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, 
co_tiempo_aplicacion_pag_rev)
values ('1', 'SANTANDER', 'BANCO SANTANDER', NULL, 'cob_cartera..sp_santander_gen_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)

insert into ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('2', 'OPENPAY', 'OPENPAY', NULL, 'cob_cartera..sp_openpay_gen_ref', 'cob_cartera..sp_openpay_val_ref', 'I', 5)

insert into ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('3', 'OXXO', 'OXXO', 'OXXO_DBe7nWGjlw', 'cob_cartera..sp_oxxo_gen_ref', 'cob_cartera..sp_oxxo_val_ref', 'A', 20)

insert into ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado) co_tiempo_aplicacion_pag_rev)
VALUES ('4' , 'ELAVON', 'ELAVON', NULL, 'cob_cartera..sp_santander_gen_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)

insert into  cob_cartera..ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('8', 'OBJETADO', 'OBJETADO', NULL, 'cob_cartera..sp_santander_val_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)

insert into  cob_cartera..ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('9', 'QUEBRANTO', 'OBJETADO', NULL, 'cob_cartera..sp_santander_val_ref', 'cob_cartera..sp_santander_val_ref', 'A', 5)

--REQ165501 SOCIO COMERCIAL CODIGO TEMPORAL 
insert into dbo.ca_corresponsal (co_id, co_nombre, co_descripcion, co_token_validacion, co_sp_generacion_ref, co_sp_validacion_ref, co_estado, co_tiempo_aplicacion_pag_rev)
values ('11', 'SOCIO', 'SOCIO COMERCIAL', NULL, 'cob_cartera..sp_lcr_gen_ref', 'cob_cartera..sp_lcr_gen_ref', 'I', 0)

--INSERCION TIPO DE REFERENCIAS PARA CADA CORRESPONSAL
insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (1, '00', 'GL', 'GARANTIA LIQUIDA', '1', '9742')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (2, '20', 'PG', 'PAGO DE CREDITO GRUPAL', '1', '9744')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (3, '02', 'CG', 'PAGO PARA CANCELACION DE CREDITO GRUPAL', '1', '9742')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (4, '03', 'PI', 'PAGO DE CREDITO INDIVIDUAL REVOLVENTE', '1', '9744')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (5, '04', 'CI', 'PAGO PARA CANCELACION DE CREDITO INDIVIDUAL REVOLVENTE', '1', '9742')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (6, '00', 'GL', 'GARANTIA LIQUIDA', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (7, '20', 'PG', 'PAGO DE CREDITO GRUPAL', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (8, '02', 'CG', 'PAGO PARA CANCELACION DE CREDITO GRUPAL', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (9, '03', 'PI', 'PAGO DE CREDITO INDIVIDUAL REVOLVENTE', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (10, '04', 'CI', 'PAGO PARA CANCELACION DE CREDITO INDIVIDUAL REVOLVENTE', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (11, '00', 'GL', 'GARANTIA LIQUIDA', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (12, '01', 'PG', 'PAGO DE CREDITO GRUPAL', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (13, '02', 'CG', 'PAGO PARA CANCELACION DE CREDITO GRUPAL', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (14, '03', 'PI', 'PAGO DE CREDITO INDIVIDUAL REVOLVENTE', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (15, '04', 'CI', 'PAGO PARA CANCELACION DE CREDITO INDIVIDUAL REVOLVENTE', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (16, '30', 'PI', 'REFERENCIA SOCIO COMERCIAL', '11', '9999')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (17, '70', 'PG', 'PAGO GENERICO GRUPAL SANTANDER', '1', '9744')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (18, '71', 'PI', 'PAGO GENERICO LCR SANTANDER', '1', '9744')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (19, '72', 'PI', 'PAGO GENERICO SIMPLE SANTANDER', '1', '9744')

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (20, '70', 'PG', 'PAGO GENERICO GRUPAL ELAVON', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (21, '71', 'PI', 'PAGO GENERICO LCR ELAVON', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (22, '72', 'PI', 'PAGO GENERICO SIMPLE ELAVON', '3', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (23, '70', 'PG', 'PAGO GENERICO GRUPAL OXXO', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (24, '71', 'PI', 'PAGO GENERICO LCR OXXO', '10', NULL)

insert into ca_corresponsal_tipo_ref (ctr_id, ctr_tipo, ctr_tipo_cobis, ctr_descripcion, ctr_co_id, ctr_convenio)
values (25, '72', 'PI', 'PAGO GENERICO SIMPLE OXXO', '10', NULL)
go

--INSERCION DE LÍMITES
insert into ca_corresponsal_limites values (10, 100,10000, 'GL')
insert into ca_corresponsal_limites values (10, 100,10000, 'PG')
insert into ca_corresponsal_limites values (10, 100,10000, 'PI')
insert into ca_corresponsal_limites values (10, 100,10000, 'CI')
insert into ca_corresponsal_limites values (10, 100,10000, 'CG')
insert into ca_corresponsal_limites values (10, 75, 10000, 'GI')


--INSERCION DE ERRORES
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70179, '13', 'EL PAGO TIENE MAS DE 60 DIAS DE ANTIGUEDAD.')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70178, '13', 'LA FECHA DE PAGO ES MAYOR A LA FECHA DE PROCESO.')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70180, '20', 'NO EXISTE EL PAGO A REVERSAR CON EL FOLIO PROPORCIONADO')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70184, '11', 'NO EXISTE TRAMITE GRUPAL EN CURSO.')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70210, '18', 'YA EXISTE UN PAGO REGISTRADO PARA EL FOLIO PROPORCIONADO')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70212, '23', 'EL TOKEN PROPORCIONADO NO ESTA REGISTRADO PARA EL CORRESPONSAL')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70213, '16', 'EL MONTO SUPERA EL LIMITE MAXIMO PERMITIDO PARA ESTE CORRESPONSAL')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70211, '25', 'REVERSA APLICADA ANTERIORMENTE')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70186, '11', 'NO EXISTE EL CRÉDITO RELACIONADO A LA REFERENCIA O NO ACEPTA PAGOS')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70214, '13', 'ERROR: PAGO REALIZADO FUERA DE TIEMPO (1 DIA O MENOS).')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70215, '20', 'ERROR: NO SE PUEDE REVERSAR DESDE EL SERVICIO, TRN YA APLICADA EN COBIS.')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 0, '00', 'TRANSACCION EXITOSA')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 1, '00', 'TRANSACCION EXITOSA')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70000, '17', 'ERROR AL APLICAR EL PAGO')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 80000, '20', 'REVERSA NO APLICADA')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 99, '99', 'ERROR AL CONSULTAR')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70301, '27', 'ERROR: NO EXISTE PRESTAMO GRUPAL')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70302, '27', 'ERROR: NO EXISTE PRESTAMO INDIVIDUAL')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70303, '27', 'ERROR: NO EXISTE CONFIGURACION PARA LIMITES DE PAGO')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70304, '27', 'ERROR: TOKEN NO COINCIDE')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70305, '27', 'ERROR: NO EXISTE EL CORREPONSAL PARAMETRIZADO')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70306, '27', 'ERROR: ERROR AL CONSULTAR ESTADOS DE CARTERA')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70307, '20', 'ERROR: EXISTE MAS DE UN REGISTRO A REVERSAR CON EL FOLIO INGRESADO.')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70214, '20', 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL GRUPO NO ACEPTA PAGOS DE OXXO')
INSERT INTO dbo.ca_corresponsal_err (ce_corresponsal_id, ce_error_cobis, ce_error_codigo, ce_error_descripcion)
VALUES ('3', 70215, '20', 'ERROR: LA SUCURSAL A LA QUE PERTENECE EL CLIENTE NO ACEPTA PAGOS DE OXXO')
go

--INSERCION PIE DE PÁGINA
insert into dbo.ca_pie_pagina_corresp (cp_id, cp_pie_pagina, co_id)
values ('1', 'SANTANDER: Horarios de atención 9:00 a 16:30 horas.', '1')

insert into dbo.ca_pie_pagina_corresp (cp_id, cp_pie_pagina, co_id)
values ('2', 'OXXO: Horarios de atención de 8:00 a 16:30 hrs, se cobrará una comisión de $10.00 (IVA incluido) por evento. Las operaciones no podrán exceder el importe individual de $4,500.00 ni del monto acumulado diario de $9,000.00. En caso de no cumplir con tu pago, se cobrará una comisión por atraso de $200.00 más IVA.', '10')


--INSERCION DE OFICINAS
--OFICINAS OXXO
insert into ca_corresponsal_oficina 
select of_oficina, of_nombre, '4'
from cobis..cl_oficina
where upper(of_nombre) = 'OFICINA CUERNAVACA'

--OFICINAS PERTENECIENTES A REGIONALES OXXO
insert into ca_corresponsal_oficina 
select of_oficina, of_nombre, '4'
from cobis..cl_oficina 
where of_regional in (select of_oficina 
                     from cobis..cl_oficina 
					    where upper(of_nombre) in ('REGION HIDALGO', 'REGION CHIAPAS','REGIONAL TOLUCA','REGION COATZACOALCOS',
                     'REGION CDMX',  'REGION CHIAPAS SOCONUSCO','REGION MERIDA','REGION CANCUN','REGION VERACRUZ PUERTO',
                    'REGION OAXACA ISTMO','REGION MORELIA','REGION QUERETARO','REGION GUADALAJARA'))
AND upper(of_nombre) LIKE '%OFICINA%'
ORDER BY of_regional
go