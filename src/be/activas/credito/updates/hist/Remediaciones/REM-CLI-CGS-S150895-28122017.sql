/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S150895 Modificacion formato archivo Interfactura
--Descripción del Problema   : Cambio nombre de archivo xml estado de cuenta
--Responsable                : Nelson Trujillo
--Ruta TFS                   : $/COB/Test/TEST_SaaSMX/Activas/Credito/Backend/Remediaciones
--Nombre Archivo             : REM-CLI-CGS-S150895-28122017.sql
/*----------------------------------------------------------------------------------------------------------------*/

use cobis
go
print '-- Update cobis..cl_parameter'
UPDATE cobis..cl_parametro SET pa_char = '0156454' WHERE pa_nemonico = 'RIEMIS' AND pa_producto = 'CRE'
go

use cob_credito
go
print '-- Alter table cob_credito..cr_resultado_xml'
IF NOT EXISTS (SELECT 1
          FROM   INFORMATION_SCHEMA.COLUMNS
          WHERE  TABLE_NAME = 'cr_resultado_xml'
          AND COLUMN_NAME = 'file_name')
BEGIN 
   ALTER TABLE cr_resultado_xml ADD file_name VARCHAR(18)
END
go