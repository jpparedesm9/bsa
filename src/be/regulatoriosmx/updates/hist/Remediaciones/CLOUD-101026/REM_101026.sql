/**********************************************************************************************************************/
/*No Bug                     :                                                                                        */
/*Título de la Historia      : REQ 101026 – ANULACIÓN DE PAGOS                                                        */
/*Fecha                      : 25/07/2018                                                                             */
/*Descripción del Problema   : Se debe agregar columnas a tabla ca_corresponsal_trn para registrar la referencia host */
/*                             to host y el indicador                                                                 */
/*Descripción de la Solución : Crear modificación de la tabla                                                         */
/*Autor                      : Sonia Rojas                                                                            */
/**********************************************************************************************************************/


use cob_cartera
GO

set identity_insert ca_corresponsal_trn off

if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'co_trn_id_corresp'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn'))
begin
   ALTER TABLE ca_corresponsal_trn
   ADD co_trn_id_corresp              varchar(8) NULL
end


if not exists (SELECT 1 
                 FROM sys.columns 
                WHERE Name = N'co_accion'
                  AND Object_ID = Object_ID(N'cob_cartera..ca_corresponsal_trn'))
begin
   ALTER TABLE ca_corresponsal_trn
   ADD  co_accion                     char(1) NULL	
end



--Actualización masiva tabla: ca_corresponsal_trn
update ca_corresponsal_trn
   set co_accion = 'I'
 where co_trn_id_corresp is NULL


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
   
CREATE  INDEX ca_corresponsal_trn_1
	ON dbo.ca_corresponsal_trn (co_referencia)
GO

CREATE  INDEX ca_corresponsal_trn_2
	ON dbo.ca_corresponsal_trn (co_trn_id_corresp)
GO


 
if not exists ( select 1 from cobis..cl_errores where numero = 70202)
begin
   insert into cobis..cl_errores  (numero, severidad, mensaje)values (70202, 0, 'ERROR: ACCION NO PERMITIDA')
end

go