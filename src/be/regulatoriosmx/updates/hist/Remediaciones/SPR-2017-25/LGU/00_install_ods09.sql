/* ********************************************************************* */
/*                              MODIFICACIONES                           */
/*      FECHA           AUTOR                RAZON                       */
/*      12/Dic/2017     LGU                  Version Inicial             */
/*                                                                       */
/* ********************************************************************* */


----*********************************************************************************
--                              ODS 09
----*********************************************************************************

USE cob_conta_super
go

DELETE from cob_conta..cb_listado_reportes_reg WHERE lr_reporte = 'ODS09'
go
-- aqui se parametriza el archivo
INSERT INTO cob_conta..cb_listado_reportes_reg (lr_reporte, lr_descripcion, 	lr_estado, 	lr_depende_pro)
VALUES (
'ODS09', 	'ODS09-CUBO CONTABLE', 'V', 'N')
go
select * from cob_conta..cb_listado_reportes_reg WHERE lr_reporte = 'ODS09'
go

-- aqui se ingresa para ejecucion eventual
DELETE from cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'ODS09'
GO
INSERT INTO cob_conta..cb_solicitud_reportes_reg (
sr_fecha, sr_reporte, sr_mes, sr_anio, sr_status )
VALUES(
'', 'ODS09', 6, 2017, 'I')
go
select * from cob_conta..cb_solicitud_reportes_reg where sr_reporte = 'ODS09'
GO


--/////////////////////////
print '---CREACION TABLA sb_ods09_tmp'

IF OBJECT_ID ('dbo.sb_ods09_tmp') IS NOT NULL
	DROP TABLE dbo.sb_ods09_tmp
GO

CREATE TABLE dbo.sb_ods09_tmp
	(
	cadena1 VARCHAR (1500) NULL
	)
GO

