/**********************************************************************************************************************/
/*No Bug                     :                                                                                        */
/*Título de la Historia      : REQ 101026 – ANULACIÓN DE PAGOS                                                        */
/*Fecha                      : 25/07/2018                                                                             */
/*Descripción del Problema   : Rollback columnas de la tabla ca_corresponsal_trn para registrar la referencia host    */
/*                             to host y el indicador                                                                 */
/*Descripción de la Solución : Rollback modificación de la tabla                                                      */
/*Autor                      : Sonia Rojas                                                                            */
/**********************************************************************************************************************/


use cob_cartera
go

SET STATISTICS TIME ON
SET STATISTICS IO ON
GO
      
if exists (SELECT 1
                 FROM sys.indexes 
                WHERE Name = N'ca_corresponsal_trn_1'
                  AND object_id = OBJECT_ID(N'ca_corresponsal_trn')) begin
   DROP INDEX ca_corresponsal_trn.ca_corresponsal_trn_1;
end
if exists (SELECT 1
                 FROM sys.indexes 
                WHERE Name = N'ca_corresponsal_trn_2'
                  AND object_id = OBJECT_ID(N'ca_corresponsal_trn')) begin
   DROP INDEX ca_corresponsal_trn.ca_corresponsal_trn_2;
end

GO
   CREATE CLUSTERED INDEX ca_corresponsal_trn_1 ON ca_corresponsal_trn(co_corresponsal,co_tipo,co_codigo_interno,co_fecha_proceso);
GO



SET STATISTICS TIME OFF
SET STATISTICS IO OFF
go

if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'co_trn_id_corresp'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn'))
begin
   ALTER TABLE ca_corresponsal_trn
   drop column co_trn_id_corresp
end


if exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'co_accion'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn'))
begin
   ALTER TABLE ca_corresponsal_trn
   drop column co_accion 
end



if exists ( select 1 from cobis..cl_errores where numero = 70202 and mensaje= 'ERROR: ACCION NO PERMITIDA')
begin
   delete cobis..cl_errores  
   where numero = 70202
end

go