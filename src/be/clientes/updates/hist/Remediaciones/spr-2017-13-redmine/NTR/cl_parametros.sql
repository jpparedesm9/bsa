/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : CGS-S120038 Interface STD - Clientes
--Fecha                      : 06/07/2017
--Descripción del Problema   : Agregar parametros consulta interface buró
--Descripción de la Solución : Agregar parametros consulta interface buró
--Autor                      : Nelson Trujillo
--Instalador                 : 1_add_campos.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/

USE cobis
GO

SET NOCOUNT ON
GO


PRINT '<<<<< TABLE "BURO DE CREDITO VERSION" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCVR' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO VERSION','BCVR','C','1.0.0', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '1.0.0'
    WHERE pa_nemonico = 'BCVR' and pa_producto = 'CRE'
	
	
PRINT '<<<<< TABLE "BURO DE CREDITO NUMERO DE REFERENCIA OPERDADOR" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCNO' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO NUMERO DE REFERENCIA OPERDADOR','BCNO','C','1111', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '1111'
    WHERE pa_nemonico = 'BCNO' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO PRODUCTO REQUERIDO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPR' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO PRODUCTO REQUERIDO','BCPR','C','R', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'R'
    WHERE pa_nemonico = 'BCPR' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO CLAVE PAIS" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCCP' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO CLAVE PAIS','BCCP','C','587', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '587'
    WHERE pa_nemonico = 'BCCP' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO CLAVE USUARIO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCCU' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO CLAVE USUARIO','BCCU','C','785', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '785'
    WHERE pa_nemonico = 'BCCU' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO PASSWORD" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPW' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO PASSWORD','BCPW','C','****', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = '****'
    WHERE pa_nemonico = 'BCPW' and pa_producto = 'CRE'
	
	
PRINT '<<<<< TABLE "BURO DE CREDITO TIPO CONSULTA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCTQ' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO TIPO CONSULTA','BCTQ','C','I', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'I'
    WHERE pa_nemonico = 'BCTQ' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO TIPO CONTRATO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCTC' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO TIPO CONTRATO','BCTC','C','L', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'L'
    WHERE pa_nemonico = 'BCTC' and pa_producto = 'CRE'
	
	
PRINT '<<<<< TABLE "BURO DE CREDITO CLAVE UNIDAD MONETARIA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCUM' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO CLAVE UNIDAD MONETARIA','BCUM','C','PSO', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'PSO'
    WHERE pa_nemonico = 'BCUM' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO IMPORTE CONTRATO" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCIC' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO IMPORTE CONTRATO','BCIC','C','ICO', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'ICO'
    WHERE pa_nemonico = 'BCIC' and pa_producto = 'CRE'
	
	
PRINT '<<<<< TABLE "BURO DE CREDITO IDIOMA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCID' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO IDIOMA','BCID','C','ES', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'ES'
    WHERE pa_nemonico = 'BCID' and pa_producto = 'CRE'
	
PRINT '<<<<< TABLE "BURO DE CREDITO TIPO SALIDA" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCTS' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_producto)
    values ('BURO DE CREDITO TIPO SALIDA','BCTS','C','OIO', 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'C', pa_char = 'OIO'
    WHERE pa_nemonico = 'BCTS' and pa_producto = 'CRE'
	
		
PRINT '<<<<< TABLE "BURO DE CREDITO PARAMETRO CADUCIDAD" >>>>>'
if not exists (select * from cobis..cl_parametro WHERE pa_nemonico = 'BCPC' and pa_producto = 'CRE')
    INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_int, pa_producto)
    values ('BURO DE CREDITO PARAMETRO CADUCIDAD','BCPC','I',60, 'CRE')
else 
    UPDATE cobis..cl_parametro SET pa_tipo = 'I', pa_int = 60
    WHERE pa_nemonico = 'BCPC' and pa_producto = 'CRE'

SET NOCOUNT OFF
GO
