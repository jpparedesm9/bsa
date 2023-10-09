Use cob_conta
go

IF OBJECT_ID ('dbo.cb_conc_retencion') IS NOT NULL
	DROP TABLE dbo.cb_conc_retencion
GO

CREATE TABLE dbo.cb_conc_retencion
	(
	cr_empresa     TINYINT NOT NULL,
	cr_codigo      CHAR (4) COLLATE Latin1_General_BIN NOT NULL,
	cr_descripcion VARCHAR (30) COLLATE Latin1_General_BIN NOT NULL,
	cr_base        MONEY NULL,
	cr_porcentaje  FLOAT NULL,
	cr_debcred     CHAR (1) COLLATE Latin1_General_BIN NOT NULL,
	cr_tipo        CHAR (1) COLLATE Latin1_General_BIN NOT NULL
	)
GO

CREATE UNIQUE CLUSTERED INDEX cb_conc_retencion_Key
	ON dbo.cb_conc_retencion (cr_empresa,cr_codigo,cr_tipo,cr_debcred)
GO



INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0001', 'SERVICIOS GENERALES', 107000, 6, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0001', 'PAGO CHEQUE', 1500000, 1, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0002', 'SERVICIOS GENERALES', 107000, 6, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0002', 'RETENCION PAGOS', 700000, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0015', 'FTE FTE ACTIVA PRACTICADA.AL B', 0, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0015', 'RTE FTE ACTIVA PRACTICADA AL B', 0, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0025', 'AUTORETENCION RENDIMIENTOS FIN', 0, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0025', 'AUTORETENCION RENDIMIENTOS FIN', 0, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0030', 'AUTORRETENCION COMISIONES', 0, 11, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0030', 'AUTORRETENCION COMISIONES', 0, 11, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0085', 'RETENCION RENDIMIENTOS FINANCI', 0, 7, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0085', 'RETENCION RENDIMIENTOS FINANCI', 0, 7, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0092', 'RETEFUENTE INDEMNIZACIONES', 0, 20, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0092', 'RETEFUENTE INDEMNIZACIONES', 0, 20, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0111', 'CR-CUENTACONTABLECORRESPONSAL', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0185', 'AUTORRETENCION SOBRETASA BOMBE', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0185', 'AUTORRETENCION SOBRETASA BOMBE', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0200', 'SALARIOSYDMASPAGOSLABORAL(CR)', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0200', 'SALARIOSY DMASPAGOSLABORAL(DB)', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0201', 'TRABAJADORES INDEPENDIENTES 2%', 2604900, 2, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0201', 'TRABAJADORES INDEPENDIENTES 2%', 2604900, 2, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0202', 'TRABAJADORES INDEPENDIENTES 4%', 3907350, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0202', 'TRABAJADORES INDEPENDIENTES 4%', 3907350, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0203', 'TRABAJADORES INDEPENDIENTES 6%', 5209800, 6, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0203', 'TRABAJADORES INDEPENDIENTES 6%', 5209800, 6, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0204', 'TRABAJADORES INDEPENDIENTES 8%', 6512250, 8, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0204', 'TRABAJADORES INDEPENDIENTES 8%', 6512250, 8, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0205', 'DIVIDEND Y PARTICIPAC(CR)', 0, 7, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0205', 'DIVIENDOS Y PARTICIPS(DB)', 0, 7, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0206', 'RETEFUENTE PERS NATURALES ASIM', 0, 1, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0206', 'RETEFUENTE PERS NATURALES ASIM', 0, 1, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0207', 'RETEFUENTE ARRENDANIENTOS DECL', 0, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0207', 'RETEFUENTE ARRENDANIENTOS DECL', 0, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0208', 'COMPRAS DECLARANTES 1.5%', 725000, 2.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0208', 'RETEFUENTE COMPRAS DECLARANTES', 725000, 2.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0209', 'OTROS INGRESOS TRIBUTARIOS DEC', 0, 1.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0209', 'OTROS INGRESOS TRIBUTARIOS DEC', 0, 1.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0210', 'RENDIMIENTOS-AHORROS(CR)', 1400, 7, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0210', 'IENTOS-AHORRO-DIARIO(DB)', 0, 0.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0211', 'RESTAURANTE Y HOTELES DECLARAN', 107000, 2.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0211', 'RESTAURANTE Y HOTELES DECLARAN', 107000, 2.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0212', 'TRANSPORTE PASAJEROS DECLARANT', 725000, 1.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0212', 'TRANSPORTE PASAJEROS DECLARANT', 725000, 1.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0215', 'RENDIM CDTS MENOS DE 5 AÑOS', 0, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0215', 'RENDIM CDTS MENOS DE 5 AÑOS', 0, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0216', 'RENDIM CDTS MAYORES DE 5 AÑOS', 0, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0216', 'RENDIM. CDTS MAYORES DE 5 AÑOS', 0, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0220', 'LOTERIAS,RIFAS,APUESTAS Y SIM', 1206000, 20, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0220', 'LOTERIAS,RIFAS,APUESTAS Y SIMI', 1206000, 20, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0225', 'HONORARIOS PERSONA JURIDICA11', 0, 11, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0225', 'HONORARIOS PERSONA JURIDICA 11', 0, 11, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0230', 'HONORARIOS PERSONA NATURAL10', 0, 10, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0230', 'HONORARIOS PERSONA NATURAL 10', 0, 10, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0235', 'COMISIONES PERSONA JURIDICA11', 0, 11, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0235', 'COMISIONES PERSONA JURIDICA 11', 0, 11, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0239', 'RF PERSONAS NAT CAT EMPLEADOS ', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0239', 'RF PERSONAS NAT CAT EMPLEADOS ', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0240', 'COMISIONES-PERSONA NATURAL 10', 0, 10, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0240', 'COMISIONES PERSONA NATURAL 10', 0, 10, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0245', 'SERVICIOS EN GENERAL 6', 107000, 6, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0245', 'SERVICIOS EN GENERAL 6', 107000, 6, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0250', ' SERVICIOS DE VIGILANCIA Y ASE', 107000, 2, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0250', 'SERVICIOS DE VIGILANCIA Y ASEO', 107000, 2, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0255', 'SERVICIOS DE EMPRESAS TEMPORAL', 107000, 1, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0255', 'SERVICIOS DE EMPRESAS TEMPORAL', 107000, 1, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0260', 'SERVICIOS DE TRANSPORTE DE CAR', 107000, 1, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0260', 'SERVICIOS DE TRANSPORTE DE CAR', 107000, 1, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0265', 'SERVICIO DE TRANSPORTE PASAJER', 725000, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0265', 'SERVICIO DE TRANSPORTE PASAJER', 725000, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0270', 'ARRENDAMIENTO DE BIENES MUEBLE', 0, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0270', 'ARRENDAMIENTO DE BIENES MUEBLE', 0, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0275', 'ARRENDAMIENTO DE BIENES INMUEB', 725000, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0275', 'ARRENDAMIENTO DE BIENES INMUEB', 725000, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0280', 'COMPRAS 3.5', 725000, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0280', 'COMPRAS 3.5', 725000, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0281', 'COMPRA DE COMBUSTIBLE', 0, 0.10000000000000001, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0281', 'COMPRA DE COMBUSTIBLE', 0, 0.10000000000000001, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0285', 'RESTAURANTE,HOTEL Y HOSPEDAJE', 107000, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0285', 'RESTAURANTE,HOTEL Y HOSPEDAJE', 107000, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0289', ' DEVOLUCION DE IMPUESTOS', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0289', 'DEVOLUCION DE IMPUESTOS', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0290', 'TARJETAS DE CREDITO', 0, 1.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0290', 'TARJETAS DE CREDITO', 0, 1.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0291', 'DEVOLUCION RETENCIONES AÑO VIG', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0291', 'DEVOLUCION RETENCIONES AÑO VIG', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0295', 'SOBRE PAGOS AL EXTERIOR RENTA', 0, 33, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0295', 'SOBRE PAGOS AL EXTERIOR RENTA', 0, 33, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0300', 'SOBRE PAGOS AL EXTERIOR REMESA', 0, 7, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0300', 'SOBRE PAGOS AL EXTERIOR REMESA', 0, 7, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0305', 'SOBRE INGRESOS DEL EXTERIOR (D', 0, 3, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0305', 'SOBRE INGRESOS DEL EXTERIOR (D', 0, 3, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0310', 'AUTORRETENCION REND,FINANC', 0, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0310', 'AUTORRETENCION REND.FINANCIERO', 0, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0315', 'AUTORRETENCION COMISIONES', 0, 11, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0315', 'AUTORRETENCION COMISIONES', 0, 11, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0320', 'RETENCION OTROS INGRESOS TRIBU', 0, 3.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0320', 'RETENCION OTROS INGRESOS TRIBU', 0, 3.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0325', 'CONTRATOS DE CONSTRUCCION Y UR', 0, 2, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0325', 'CONTRATOS DE CONSTRUCCION Y UR', 0, 2, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0326', 'RFTE FUENTE CONTRATOS CONSULTO', 0, 6, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0326', 'RFTE FUENTE CONTRATOS CONSULTO', 0, 6, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0327', 'RTE FUENTE CONTRATOS CONSULTOR', 0, 10, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0327', 'RTE FUENTE CONTRATOS CONSULTOR', 0, 10, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0328', 'PAGOS AL EXTERIOR RENTA 10%', 0, 10, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0328', ' PAGOS AL EXTERIOR RENTA 10%', 0, 10, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0330', 'DEVOLUCION RETENCION RENTA AÑO', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0330', 'DEVOLUCION RETENCION RENTA AÑO', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0345', 'TIMBRE TARIFA GENERAL', 150792000, 0, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0345', 'TIMBRE TARIFA GENERAL ', 150792000, 0, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0346', 'CR-50% TIMBRE A CARGO BANCAMIA', 0, 0.5, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0346', 'DB-50% TIMBRE A CARGO BANCAMIA', 0, 0.5, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0350', 'TIMBRE CUANTIA INDETERMINADA 1', 0, 0.5, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0350', 'IMPUESTO DE TIMBRE CUANTIA IND', 0, 0.5, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0355', 'TIMBRE OTRAS TARIFAS CHEQUERAS', 0, 0, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0355', 'TIMBRE OTRAS TARIFAS CHEQUERAS', 0, 0, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0360', 'RETENCION TIMBRES OTRAS TARIFA', 0, 0.5, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0360', 'RETENCION OTRAS OTRAS TARIFAS', 0, 0.5, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0430', 'CR-SERVICIOS EN GENERAL 4', 107000, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0430', 'DB-SERVICIOS EN GENERAL 4', 107000, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0435', 'RENDIMIENTOS FINANCIEROS BONOS', 0, 4, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0435', 'RENDIMIENTOS FINANCIEROS BONOS', 0, 4, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0440', 'RFTE CREE 1.5%', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0440', 'RFTE CREE 1.5%', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0445', 'RFTE CREE 0.3%', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0445', 'RFTE CREE 0.3%', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0450', 'RFTE CREE 0.60%', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0450', 'RFTE CREE 0.6%', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0501', 'AUTORETENCION CREE', 0, 0.59999999999999998, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0501', 'AUTORETENCION CREE', 0, 0.59999999999999998, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0502', 'RETENCION A FAVOR AUTO-CREE', 0, 0.59999999999999998, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0502', 'RETENCION A FAVOR AUTO-CREE', 0, 0.59999999999999998, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0503', 'AUTORRETENCION RENTA DECRETO 2', 0, 2.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0503', 'AUTORRETENCION RENTA DECRETO 2', 0, 2.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0504', 'AUTORRETENCION RENTA DECRETO 2', 0, 2.5, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0504', 'AUTORRETENCION RENTA DECRETO 2', 0, 2.5, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0700', 'GMF-CHEQUES DE GERENCIA TESORE', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0700', 'GMF-CHEQUES DE GERENCIA TESORE', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0705', 'GMF DB CTA CONTABLE PG INCENTI', 0, 0.40000000000000002, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0705', 'GMF DB CTA CONTABLE PG INCENTI', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0796', 'GMF-CANCELACION DE DEPOSITOS A', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0796', 'GMF-CANCELACION DE DEPOSITOS A', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0797', 'GMF-SOBRE OT.TRANS,CONT.P.FISC', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '0797', 'GMF-SOBRE OT.TRANS.CONT.P.FISC', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '1005', 'GMF-SOBRE CUENTAS DE AHORRO', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '1005', 'GMF-SOBRE CUENTAS DE AHORRO', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '1505', 'GMF-SOBRE ABONOS EN CTA CDTS', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '1505', 'GMF-SOBRE ABONOS EN CTA CDTS', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '2005', 'GMF-SOBRE EXPED.CHEQUES GERENC', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '2005', 'GMF-SOBRE EXPED.CHEQUES GERENC', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '2505', 'GMF-SOBRE RECOMPRA DE CARTERA', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '2505', 'GMF-SOBRE RECOMPRA DE CARTERA', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '3005', 'GMF-SOBRE PAGOS POR CREDITOS I', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '3005', 'GMF-SOBRE PAGOS PO CREDITOS IN', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '3505', 'GMF-AUTORR/RECURSOS CTAS DE DE', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '3505', 'GMF-AUTORR/RECURSOS CTAS DE DE', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4005', 'DESEMBOLSOS DE CREDITO EN EFEC', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4005', 'DESEMBOLSOS DE CREDITO EN EFEC', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4010', 'DB CUENTAS CONTABLES OPERACION', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4010', 'DB CUENTAS CONTABLES OPERACION', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4015', 'DB A CUENTAS CONTABLES POLIZAS', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4015', 'DB A CUENTAS CONTABLES POLIZAS', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4020', 'PAGO DE INTERESES POR PARTE DE', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4020', 'PAGO DE INTERESES POR PARTE DE', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4025', 'CHEQUES DE GERENCIA DESEMBOLSO', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '4025', 'CHEQUES DE GERENCIA DESEMBOLSO', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5005', 'GMF-SOBRE CUENTAS CORRIENTES', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5005', 'GMF-SOBRE CUENTAS CORRIENTES', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5505', 'GMF DB CTAS CONTABLES PAGO PRO', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5505', 'GMF DB CTAS CONTABLES PAGO PRO', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5510', 'GMF DB CTA CONTABLE PAGO INCEN', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5510', 'GMF DB CTA CONTABLE PAGO INCEN', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5790', 'DEVOLUCION GMF CUENTA DE AHORR', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5790', 'DEVOLUCION GMF CUENTA DE AHORR', 0, 0, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5795', 'GMF-SOBRE OTRAS TRANSACCIONES', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5795', 'GMF-SOBRE OTRAS TRANSACCIONES', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5800', 'DEVOLUCION GMF CUENTAS DE AHOR', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5800', 'DEVOLUCION GMF CUENTAS DE AHOR', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5820', 'GMF DB CTAS CONTABLES PAGO NOM', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '5820', 'GMF DB CTAS CONTABLES PAGO NOM', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '9005', 'GMF-CONSTRIBUCION DESCONTABLE', 0, 0.40000000000000002, 'C', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '9005', 'GMF-CONTRIBUCION DESCONTABLE', 0, 0.40000000000000002, 'D', 'T')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '9999', 'CR-PAGO DIAN RTE FTE', 0, 0, 'C', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '9999', 'PAGO DE IMPUESTO A LA DIAN POR', 0, 0, 'D', 'R')
GO

INSERT INTO dbo.cb_conc_retencion (cr_empresa, cr_codigo, cr_descripcion, cr_base, cr_porcentaje, cr_debcred, cr_tipo)
VALUES (1, '9999', 'PAGO DE IMPUESTO A LA DIAN POR', 0, 0, 'D', 'T')
GO
