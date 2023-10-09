/*
*  REQUERIMIENTO: 138837 - Desplazamiento Fase 2
*  AUTOR: Walther Toledo Q.
*  FECHA: 14/Mayo/2020
*  
*/

-- ==============================================================================
use cob_cartera
go

IF OBJECT_ID ('dbo.ca_reestructuracion_archivo') IS NOT NULL
	DROP table dbo.ca_reestructuracion_archivo
go
create table ca_reestructuracion_archivo(
ra_secuencial int identity(1,1) not null,
ra_banco   varchar(24),
ra_cliente int,
ra_cuotas  int,
ra_seguro  varchar(2),
ra_archivo varchar(255),
ra_fecha   datetime,
ra_estado  char(1),
ra_mensaje varchar(255)
)
create index idx1 on ca_reestructuracion_archivo(ra_banco) 
go
-- =====

IF OBJECT_ID ('dbo.ca_reestructuracion_archivo_tmp') IS NOT NULL
	DROP table dbo.ca_reestructuracion_archivo_tmp
go
create table ca_reestructuracion_archivo_tmp(
ra_banco_tmp    varchar(24),
ra_cliente_tmp  varchar(24),
ra_cuotas_tmp   varchar(24),
ra_seguro_tmp   varchar(20),
ra_mensaje_tmp  varchar(255)
)
create index idx1 on ca_reestructuracion_archivo_tmp(ra_banco_tmp) 
go


-- ==============================================================================
use cobis
go
delete from ba_parametro where pa_batch = 7094
delete from ba_batch where ba_batch = 7094

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (7094, 'REESTRUCTURACION OPERACIONES DESPLAZADAS', 'REESTRUCTURACION OPERACIONES DESPLAZADAS', 'SP', getdate(), 36, 'P', 1, NULL, 'DSP_.txt', 'cob_cartera..sp_reestructuracion_carga', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\Reestructuracion\')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7094, 0, 1, 'FECHA PROCESO', 'D', '11/05/2020')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7094, 0, 2, 'ARCHIVO', 'C', 'Reestructuracion_20052020.txt')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (99, 7094, 18, 1, 'FECHA PROCESO', 'D', '11/05/2020')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (99, 7094, 18, 2, 'ARCHIVO', 'C', 'Reestructuracion_20052020.txt')

go

-- ==============================================================================
use cobis
go
delete from ba_parametro where pa_batch = 7096
delete from ba_batch where ba_batch = 7096

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (7096, 'DEVENGAMIENTO REESTRUCTURA', 'DEVENGAMIENTO REESTRUCTURA', 'SP', getdate(), 7, 'P', 1, NULL, 'DSP_.txt', 'cob_cartera..sp_devenga_reest_carga', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\Reestructuracion\')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7096, 0, 1, 'FECHA PROCESO', 'D', '11/05/2020')

INSERT INTO ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7096, 0, 2, 'ARCHIVO', 'C', 'Reestructuracion_20052020.txt')

go
-- ==============================================================================




