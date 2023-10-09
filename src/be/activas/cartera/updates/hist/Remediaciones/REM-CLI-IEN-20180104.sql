/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : Modificacion check desembolso
--Descripción del Problema   : Cambio validacion rd_motivo_devolucion aumento column rd_causa_rechazo
--Responsable                : Nelson Trujillo
--Ruta TFS                   : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Remediaciones
--Nombre Archivo             : REM-CLI-IEN-20180104.sql
/*----------------------------------------------------------------------------------------------------------------*/

USE cob_cartera
GO

print '-- Alter table cob_cartera..ca_santander_resultado_desembolso modify column rd_motivo_devolucion allow null'
ALTER TABLE ca_santander_resultado_desembolso ALTER COLUMN rd_motivo_devolucion VARCHAR(2) NULL 
GO

print '-- Alter table cob_cartera..ca_santander_resultado_desembolso add column rd_causa_rechazo'
IF NOT EXISTS (SELECT 1
          FROM   INFORMATION_SCHEMA.COLUMNS
          WHERE  TABLE_NAME = 'ca_santander_resultado_desembolso'
          AND COLUMN_NAME = 'rd_causa_rechazo')
BEGIN
ALTER TABLE ca_santander_resultado_desembolso ADD rd_causa_rechazo VARCHAR(2)
END
GO


