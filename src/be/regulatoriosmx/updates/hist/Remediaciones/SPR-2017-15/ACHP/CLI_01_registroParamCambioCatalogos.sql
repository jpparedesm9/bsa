/*----------------------------------------------------------------------------------------------------------------*/
--Historia / Bug             : CGS-B126554 No actualiz� plazo ni frecuencia en cabecera Ingresar Solicitud (Individual)
--Descripci�n del Problema   : Cambios a la pantalla de ingreso de datos individual
--Responsable                : Adriana Chiluisa
--Ruta TFS                   : Descripci�n abajo
--Nombre Archivo             : Descripci�n abajo
/*----------------------------------------------------------------------------------------------------------------*/

--------------------------------------------------------------------------------------------
-- REGISTRO DE PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_parametro.sql

USE cobis
GO

PRINT 'Ingreso de parametro'
DELETE cl_parametro WHERE pa_nemonico = 'PFRMES' AND pa_producto = 'CRE'

INSERT INTO cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('FRECUENCIA EN MESES', 'PFRMES', 'C', 'M', NULL, NULL, NULL, NULL, NULL, NULL, 'CRE')
GO


--------------------------------------------------------------------------------------------
-- REGISTRO DE PARAMETROS
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Credito/Backend/sql
--Nombre Archivo             : cr_catalogos.sql
USE cobis
GO
PRINT 'Modificaci�n de Catalogos'

IF EXISTS (SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cr_plazo_ind')
BEGIN 
    DECLARE @w_cod_plazo INT 
    SELECT @w_cod_plazo = codigo FROM cobis..cl_tabla WHERE tabla = 'cr_plazo_ind'
    
    DELETE FROM cobis..cl_catalogo WHERE tabla = @w_cod_plazo   
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_plazo, '1', '1', 'V' )
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_plazo, '3', '3', 'V' )
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_plazo, '6', '6', 'V' )
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_plazo, '12', '12', 'V' )
END

IF EXISTS (SELECT 1 FROM cobis..cl_tabla WHERE tabla = 'cr_tplazo_ind')
BEGIN

    DECLARE @w_cod_tplazo INT 
    SELECT @w_cod_tplazo = codigo FROM cobis..cl_tabla WHERE tabla = 'cr_tplazo_ind'
    
    DELETE FROM cobis..cl_catalogo WHERE tabla = @w_cod_tplazo
    
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_tplazo, 'W', 'SEMANAL', 'V' )
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_tplazo, 'M', 'MES(ES)', 'V' )
    INSERT INTO cl_catalogo (tabla, codigo, valor, estado) VALUES (@w_cod_tplazo, 'Q', 'QUINCENAL', 'V' ) 
    
END
go

--SELECT * FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cr_plazo_ind')
--SELECT * FROM cobis..cl_catalogo WHERE tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cr_tplazo_ind')
--SELECT * FROM cob_cartera..ca_tdividendo WHERE td_tdividendo IN ('W','Q','M')


 