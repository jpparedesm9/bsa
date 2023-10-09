/*************************************************************************************/
--No Historia                : 93835
--Titulo de la Historia      : Interfaz Cobis - Riesgos parte 2
--Fecha                      : 22/01/2018
--Descripcion del Problema   : Interfaz Riesgos
--Descripcion de la Solucion : Cambios en sartas:
--                             36426: GENERACION ARCHIVO 06 (MORAS - DIARIO)
--                             36427: GENERACION ARCHIVO 07 (HRC)
--Autor                      : Jorge Salazar Andrade
--Instalador                 : cb_batch.sql
--Ruta Instalador            : $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/Param_Conta_MX
/*************************************************************************************/
use cobis
go

DELETE ba_sarta_batch WHERE sb_sarta = 22 AND sb_batch = 36428

DELETE ba_enlace WHERE en_sarta = 22 AND en_batch_inicio = 36428

DELETE ba_batch WHERE ba_batch = 36428

DELETE ba_login_batch WHERE lb_sarta = 22 AND lb_batch = 36428
GO

DELETE ba_sarta_batch_exec WHERE sb_sarta = 22 AND sb_batch = 36428
GO

