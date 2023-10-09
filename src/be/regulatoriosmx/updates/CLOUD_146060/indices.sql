/************************************************************************/
/*      Archivo:                indices.sql                             */
/*      Base de datos:          cob_conta_super                         */
/*      Producto:		        Contabilidad                            */
/*      Disenado por:           Juan Sarzosa                            */
/*      Fecha de escritura:	    09/09/2020                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      "COBISCORP", representantes exclusivos para el Ecuador de la    */
/*      "COBISCORP CORPORATION".                                        */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*	    Indices tablas sb_dato_operacion_abono, sb_dato_cuota_pry,      */
/*      sb_riesgo_provision, sb_dato_verificacion, sb_dato_transaccion  */  
/*      y sb_dato_transaccion_det                                       */  
/************************************************************************/
/*                              MODIFICACIONES                          */
/*      FECHA           AUTOR           RAZON                           */
/*      09/09/2020      J Sarzosa       Optimizacion Batch              */
/************************************************************************/
USE cob_conta_super
go

PRINT 'Creación de indices en BDD cob_conta_super'
PRINT 'Indices tabla sb_dato_operacion_abono'
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_operacion_abono'
           AND O.id = I.id
           AND I.name = 'idx_1')
BEGIN
   EXEC ('DROP INDEX sb_dato_operacion_abono.idx_1')
END
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_operacion_abono'
           AND O.id = I.id
           AND I.name = 'idx_2')
BEGIN
   EXEC ('DROP INDEX sb_dato_operacion_abono.idx_2')
END
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_operacion_abono'
           AND O.id = I.id
           AND I.name = 'idx_3')
BEGIN
   EXEC ('DROP INDEX sb_dato_operacion_abono.idx_3')
END

GO
CREATE CLUSTERED INDEX idx_1 ON sb_dato_operacion_abono (doa_fecha, doa_aplicativo, doa_banco, doa_sec_pag)
GO

PRINT 'Indices tabla sb_dato_cuota_pry'
go
IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_cuota_pry'
           AND O.id = I.id
           AND I.name = 'idx1')
BEGIN
   EXEC ('DROP INDEX sb_dato_cuota_pry.idx1')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_cuota_pry'
           AND O.id = I.id
           AND I.name = 'idx2')
BEGIN
   EXEC ('DROP INDEX sb_dato_cuota_pry.idx2')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_cuota_pry'
           AND O.id = I.id
           AND I.name = 'idx3')
BEGIN
   EXEC ('DROP INDEX sb_dato_cuota_pry.idx3')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_cuota_pry'
           AND O.id = I.id
           AND I.name = 'idx4')
BEGIN
   EXEC ('DROP INDEX sb_dato_cuota_pry.idx4')
END 
GO

CREATE CLUSTERED INDEX idx1 ON sb_dato_cuota_pry (dc_fecha, dc_aplicativo, dc_banco, dc_num_cuota)
GO

PRINT 'Indices tabla sb_riesgo_provision'
go

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_riesgo_provision'
           AND O.id = I.id
           AND I.name = 'idx1')
BEGIN
   EXEC ('DROP INDEX sb_riesgo_provision.idx1')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_riesgo_provision'
           AND O.id = I.id
           AND I.name = 'idx2')
BEGIN
   EXEC ('DROP INDEX sb_riesgo_provision.idx2')
END 
GO

CREATE CLUSTERED INDEX idx1 ON sb_riesgo_provision (Num_cred)
GO


PRINT 'Indices tabla sb_dato_verificacion'
go

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_verificacion'
           AND O.id = I.id
           AND I.name = 'sb_dato_encuesta1')
BEGIN
   EXEC ('DROP INDEX sb_dato_verificacion.sb_dato_encuesta1')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_verificacion'
           AND O.id = I.id
           AND I.name = 'sb_dato_encuesta2')
BEGIN
   EXEC ('DROP INDEX sb_dato_verificacion.sb_dato_encuesta2')
END 

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_verificacion'
           AND O.id = I.id
           AND I.name = 'sb_dato_encuesta3')
BEGIN
   EXEC ('DROP INDEX sb_dato_verificacion.sb_dato_encuesta3')
END 


CREATE CLUSTERED INDEX sb_dato_encuesta1 ON sb_dato_verificacion (dv_fecha, dv_cliente)
GO

PRINT 'Indices tabla sb_dato_transaccion'
GO
  
IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_transaccion'
           AND O.id = I.id
           AND I.name = 'idx1')
BEGIN
   EXEC ('DROP INDEX sb_dato_transaccion.idx1')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_transaccion'
           AND O.id = I.id
           AND I.name = 'idx2')
BEGIN
   EXEC ('DROP INDEX sb_dato_transaccion.idx2')
END
GO

CREATE CLUSTERED INDEX idx1 ON sb_dato_transaccion (dt_fecha, dt_banco, dt_secuencial)
GO

CREATE INDEX idx2
	ON dbo.sb_dato_transaccion (dt_banco, dt_fecha_trans)
GO

PRINT 'Indices tabla sb_dato_transaccion_det'
go

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_transaccion_det'
           AND O.id = I.id
           AND I.name = 'idx1')
BEGIN
   EXEC ('DROP INDEX sb_dato_transaccion_det.idx1')
END 
GO

IF EXISTS (SELECT 1 FROM sysobjects O, sysindexes I
           WHERE O.name = 'sb_dato_transaccion_det'
           AND O.id = I.id
           AND I.name = 'idx2')
BEGIN
   EXEC ('DROP INDEX sb_dato_transaccion_det.idx2')
END 
GO

CREATE CLUSTERED INDEX idx1
	ON dbo.sb_dato_transaccion_det (dd_fecha, dd_banco, dd_secuencial)
GO

CREATE INDEX idx2
	ON dbo.sb_dato_transaccion_det (dd_banco, dd_secuencial)
GO

PRINT 'Proceso Finalizado con Exito'
GO

