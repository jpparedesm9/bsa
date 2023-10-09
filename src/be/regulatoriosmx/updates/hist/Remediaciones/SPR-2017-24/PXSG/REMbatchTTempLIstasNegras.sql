/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S146493 Proceso Batch Listas Negras
--Descripción del Problema   : Crear de la tabla temporal para listas negras
--Responsable                : Patricio Samueza
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql/cl_table.sql
--Nombre Archivo             : cl_table.sql
/*----------------------------------------------------------------------------------------------------------------*/
USE cobis
go

IF OBJECT_ID ('cobis..cl_listas_negras_tmp') IS NOT NULL
	DROP TABLE cobis..cl_listas_negras_tmp
GO

CREATE TABLE cobis..cl_listas_negras_tmp
	(
	fecha_proceso     VARCHAR (10) NULL,
	nombres_completos VARCHAR (300)NULL,
	fecha_nac         VARCHAR (10) NULL,
	tipo_lista        VARCHAR (10) NULL
	)
GO

/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Incidencia 83007
--Fecha                      : 18/07/2017
--Descripción del Problema   : Agregar parametros para validacion de emprendedores integrantes
--Descripción de la Solución : Agregar parametros para validacion de emprendedores integrantes
--Autor                      : PATRICIO SAMUEZA
--Ruta de Instalador		 :$/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql/cr_errores.sql
--Archivo					 : cr_errores.sql	
/**********************************************************************************************************************/
USE cobis 
GO


delete from cobis..cl_errores 
where numero in (2108046,2108048,2108049)


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2108046, 0, 'Error generando Reporte de Provisiones')


INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2108048, 0, 'Error generando Archivo de Cabeceras')

INSERT INTO cobis..cl_errores (numero, severidad, mensaje)
VALUES (2108049, 0, 'Error generando Archivo de Lineas mas cabeceras')
go

   


