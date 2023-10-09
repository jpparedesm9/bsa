use cob_cartera
go

update ca_corresponsal_tipo_ref 
set ctr_convenio =9744
where ctr_tipo_cobis = 'CG'


update ca_corresponsal_tipo_ref 
set ctr_convenio =9744,
ctr_tipo = '20'
where ctr_tipo_cobis = 'PG'


delete from ca_corresponsal_err

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

go 
