USE cob_cartera
GO


/****************TABLA NUEVOS SEGUROS TMP**********/
/**Para guardar los datos necesarios para generar el reporte de nuevos seguros***/



/**** AGREGADO EN EL SCRIPT :$/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sqlca_table.sql****/


IF OBJECT_ID ('nuevos_seguros_tmp') IS NOT NULL
	DROP TABLE nuevos_seguros_tmp
GO

CREATE TABLE nuevos_seguros_tmp
	(
	w_nro_poliza          VARCHAR (30) NULL,
	w_anio_poliza         INT NULL,
	w_producto            VARCHAR (30) NULL,
	w_ente                INT NULL,
	w_sucursal            VARCHAR (30) NULL,
	w_nro_prestamo        VARCHAR (36) NULL,
	w_nro_certificado     VARCHAR (36) NULL,
	w_mes_emision         VARCHAR (2) NULL,
	w_fecha_endoso        VARCHAR (10) NULL,
	w_fecha_efectiva      VARCHAR (10) NULL,
	w_fecha_expiracion    VARCHAR (10) NULL,
	w_long_cobertura      INT NULL,
	w_pais                VARCHAR (10) NULL,
	w_moneda              VARCHAR (10) NULL,
	w_vendedor            VARCHAR (10) NULL,
	w_nombre_asegurado    VARCHAR (40) NULL,
	w_apellido_paterno    VARCHAR (16) NULL,
	w_apellido_materno    VARCHAR (16) NULL,
	w_direccion1          VARCHAR (100) NULL,
	w_direccion2          VARCHAR (50) NULL,
	w_ciudad              VARCHAR (64) NULL,
	w_estado              VARCHAR (64) NULL,
	w_cod_postal          VARCHAR (30) NULL,
	w_telefono            VARCHAR (16) NULL,
	w_email               VARCHAR (254) NULL,
	w_genero              CHAR (1) NULL,
	w_rfc                 VARCHAR (30) NULL,
	w_edad                INT NULL,
	w_fecha_nac           VARCHAR (10) NULL,
	w_seguro_vida         MONEY NULL,
	w_seguro_infarto_cer  MONEY NULL,
	w_seguro_infarto_mioc MONEY NULL,
	w_seguro_cancer       MONEY NULL,
	w_monto_prima         MONEY NULL,
	w_comision            MONEY NULL
	)
GO

/**PARA AGREGAR LA FECHA EN LA QUE SE GENERA EL REPORTE**/
ALTER TABLE ca_seguro_externo
add  se_fecha_reporte DATETIME
go


/*************AGREGADO EN EL SCRIPT $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/ca_parametros.sql**********/
/**PARAMETROS**/


INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('NO POLIZA', 'NROPOL', 'C', '00987', 'CCA')
GO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
VALUES ('ANIO POLIZA', 'ANIPOL', 'I', 2018, 'CCA')
GO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
VALUES ('SEGURO PRODUCTO', 'SEGPRO', 'C', 'CNSF', 'CCA')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_money, pa_producto)
VALUES ('SUMA ASEGURADA VIDA', 'SVIDA', 'M', 20000, 'CCA')
GO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_money, pa_producto)
VALUES ('SUMA ASEGURADA INFARTO CEREBRAL', 'SINFCE', 'M', 5000, 'CCA')
GO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_money, pa_producto)
VALUES ('SUMA ASEGURADA INFARTO AL MIOCARIO', 'SINFMI', 'M', 5000, 'CCA')
GO
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_money, pa_producto)
VALUES ('SUMA ASEGURADA CANCER	', 'SCAN', 'M', 5000, 'CCA')
GO

INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_float, pa_producto)
VALUES ('COMISION POR SEGURO', 'COMSEG', 'M', 35, 'CCA')
GO



/**** AGREGADO EN EL SCRIPT :$/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/ca_error.sql****/
/***errores**********/
INSERT INTO cobis..cl_errores (numero, severidad, mensaje) VALUES (724679, 0, 'Error generando Archivo de Nuevos Seguros')



