 /*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S144449 CC Modificación a Formatos a Imprimir Contrato
--Descripción del Problema   : Crear el reporte de solicitud de credito de inclusion
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripción abajo
--Nombre Archivo             : Descripción abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE SERVICIOS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_parametro.sql

use cobis
go

DELETE cl_parametro WHERE pa_producto = 'CRE' 
and   pa_nemonico in ('NF1CCI', 'NF2CCI', 'NB1CCI','NB2CCI','NRGCCI','LPGCC1',
                      'LPGCC2','LPGCC3','LPGCC4','LPGCC5','LPGCC6','RDRECA',
                      'RCGASE','RCGSG1','RCGSG2')

insert into cl_parametro 
values('REPORTE SOLIC CREDITO INCLUSION NOMBRE FINANCIERA UNO', 'NF1CCI', 'C', 'Norma Angélica Castro Reyes', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro
values('REPORTE SOLIC CREDITO INCLUSION NOMBRE FINANCIERA DOS', 'NF2CCI', 'C', 'Hugo Suastegui Cervantes', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro
values('REPORTE SOLIC CREDITO INCLUSION NOMBRE BANCO DOS', 'NB1CCI', 'C', 'Didier Mena Campos', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro
values('REPORTE SOLIC CREDITO INCLUSION NOMBRE BANCO DOS', 'NB2CCI', 'C', 'Octavio Fraga Medina', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('NUMERO REGISTRO REPORT CONTRA CREDITO INCLUSION', 'NRGCCI', 'C', '14795-439-028351/01-06036-1117', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')

insert into cl_parametro 
values('LUGAR PAGO REPORT CONTRA CREDITO INCLUSION 1', 'LPGCC1', 'C', 'Avenida Prolongación Paseo', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('LUGAR PAGO REPORT CONTRA CREDITO INCLUSION 2', 'LPGCC2', 'C', 'de la Reforma No 500 PB,', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('LUGAR PAGO REPORT CONTRA CREDITO INCLUSION 3', 'LPGCC3', 'C', 'Col. Lomas de Santa Fe,', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('LUGAR PAGO REPORT CONTRA CREDITO INCLUSION 4', 'LPGCC4', 'C', 'Delegación Álvaro Obregón,', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('LUGAR PAGO REPORT CONTRA CREDITO INCLUSION 5', 'LPGCC5', 'C', 'C.P. 01219,', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('LUGAR PAGO REPORT CONTRA CREDITO INCLUSION 6', 'LPGCC6', 'C', 'Ciudad de México', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('REPORTE DATO RECA', 'RDRECA', 'C', '14795-439-028351/01-06036-1117', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('REPORTE CARATULA GRUPAL ASEGURADORA', 'RCGASE', 'C', 'ASSURANT VIDA MÉXICO, S.A.', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('REPORTE CARATULA GRUPAL SEGURO1', 'RCGSG1', 'C', 'Seguro de Vida + ', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go

insert into cl_parametro 
values('REPORTE CARATULA GRUPAL SEGURO2', 'RCGSG2', 'C', 'Enfermedades Graves', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
go
