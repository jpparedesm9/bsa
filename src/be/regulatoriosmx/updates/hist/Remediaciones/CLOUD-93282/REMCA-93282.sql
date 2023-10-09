
/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : Mejora 93282: Reporte Control Mensual
--Fecha                      : 09/01/2018
--Descripción del Problema   : No existen cregistros ni campos
--Descripción de la Solución : Crear scripts de instalación
--Autor                      : Paul Ortiz Vera
/**********************************************************************************************************************/

--------------------------------------------------------------------------------------------
-- ALTER TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93282/Activas/Cartera/Backend/sql
--Nombre Archivo             : ca_table.sql

use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reporte_control_tmp') IS NOT NULL
	DROP TABLE dbo.ca_reporte_control_tmp
GO

create table ca_reporte_control_tmp
	(
	rc_pregunta          varchar (60) NULL,
	rc_respuesta         varchar (40) NULL
	)
GO


--------------------------------------------------------------------------------------------
-- ALTER TABLA
--------------------------------------------------------------------------------------------
--Ruta TFS                   : $/ASP/CLOUD/Iss/CLOUD-93282/Activas/Cartera/Backend/sql/Param_Conta_MX
--Nombre Archivo             : cb_batch.sql

use cobis
go

DECLARE @w_server VARCHAR(24) = NULL,
@w_path_fuente_CCA VARCHAR(255) = NULL,
@w_path_destino_CCA VARCHAR(255) = null

select @w_server = pa_char
from cl_parametro 
where pa_producto = 'ADM'
and   pa_nemonico = 'SRVR'

SELECT @w_path_fuente_CCA = 'C:/Cobis/vbatch/cartera/objetos/'
SELECT @w_path_destino_CCA = 'C:/Cobis/vbatch/cartera/listados/'
------
--BA_BATCH
DELETE cobis..ba_batch WHERE ba_batch= 7084
insert into cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values(7084,  'REPORTE MENSUAL DE CONTROL', 'REPORTE MENSUAL DE CONTROL','SP', getdate(), 7, 'P', 1, 'CARTERA',null,'cob_cartera..sp_reporte_control', 1,   null, @w_server, 'S', @w_path_fuente_CCA, @w_path_destino_CCA)

--BA_PARAMETRO
DELETE ba_parametro WHERE pa_batch = 7084 
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
VALUES (0, 7084, 39, 1, 'FECHA_PROCESO', 'D', '09/19/2017')
INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
VALUES (13, 7084, 39, 1, 'FECHA_PROCESO', 'D', '09/19/2017')

--BA_SARTA_BATCH
DELETE ba_sarta_batch WHERE sb_batch = 7084 AND sb_sarta = 13
INSERT INTO ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado) 
VALUES (13, 7084 , 39, null,'S', 'N', 5760, 4500, 13, 'S') 

--BA_ENLACE
DELETE ba_enlace WHERE en_batch_inicio = 7080 AND en_batch_fin = 7084
INSERT INTO ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (13, 7080, 19, 7084, 39, 'S', NULL, 'N')

