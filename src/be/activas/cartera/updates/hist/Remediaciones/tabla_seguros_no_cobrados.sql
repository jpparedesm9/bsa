USE cob_cartera
GO


/****************TABLA SEGUROS NO COBRADOS TMP**********/
/**Para guardar los datos necesarios para generar el reporte de seguros no cobrados***/



/**** AGREGADO EN EL SCRIPT :$/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sqlca_table.sql****/
IF OBJECT_ID ('seguros_no_cobrados_tmp') IS NOT NULL
	DROP TABLE seguros_no_cobrados_tmp
GO

CREATE TABLE seguros_no_cobrados_tmp
	(
	w_ciudad           VARCHAR (64) NULL,
	w_region           VARCHAR (64) NULL,
	w_sucursal         VARCHAR (36) NULL,
	w_id_grupo         INT NULL,
	w_nombre_grupo     VARCHAR (64) NULL,
	w_id_prestamo      VARCHAR (36) NULL,
	w_nombre_cliente   VARCHAR (64) NULL,
	w_fecha_inicio VARCHAR (10) NULL,
	w_fecha_fin    VARCHAR (10) NULL,
	w_valor_seguro     MONEY NULL
	)
GO


/**** AGREGADO EN EL SCRIPT :$/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/ca_error.sql****/
DELETE FROM cobis..cl_errores WHERE numero IN (724676,724677,724678)

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (724676, 0, 'Error generando Archivo de lineas de Reporte de Seguros no Cobrados')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (724677, 0, 'Error generando Archivo de Cabeceras Seguros no Cobrados')
INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (724678, 0, 'Error generando Archivo Completo de Seguros no Cobrados')

