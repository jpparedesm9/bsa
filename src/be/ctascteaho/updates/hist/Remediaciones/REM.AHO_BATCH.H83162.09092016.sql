use cobis
go


DELETE  FROM cobis..ba_batch where  ba_batch = 4389
DELETE  FROM cobis..ba_parametro WHERE pa_sarta = 4007 and pa_batch = 4389
DELETE  FROM cobis..ba_parametro WHERE pa_batch = 4389 and pa_sarta = 0 
DELETE  FROM cobis..ba_sarta_batch WHERE sb_sarta = 4007
DELETE  FROM cobis..ba_enlace WHERE en_sarta = 4007
DELETE  FROM cobis..ba_sarta WHERE sa_sarta = 4007

declare @w_servidor   varchar(30), @w_path_fuente varchar(50), @w_path_destino  varchar(50)

select @w_servidor = pa_char
from cobis..cl_parametro
where pa_producto = 'ADM'
and pa_nemonico = 'SRVR'

select   
@w_path_destino = pp_path_destino
from ba_path_pro
where pp_producto = 4

select @w_path_destino = isnull(@w_path_destino, 'C:/Cobis/vbatch/ahorros/listados/')

select   
@w_path_fuente = pp_path_fuente
from ba_path_pro
where pp_producto = 4

select @w_path_fuente = isnull(@w_path_fuente, 'C:/Cobis/vbatch/data/objetos')


declare @w_usuario varchar(64)       

select @w_usuario = 'admuser'

print 'Ingresando --ba_SARTA'
INSERT INTO cobis..ba_sarta (sa_sarta, sa_nombre, sa_descripcion, sa_fecha_creacion, sa_creador, sa_producto, sa_dependencia, sa_autorizacion)
VALUES (4007, 'GENERACION REPORTES OPERATIVOS AHO', 'GENERACION REPORTES OPERATIVOS AHO', getdate(), @w_usuario, 4, NULL, NULL)

print 'Ingresando --ba_batch'
INSERT INTO cobis..ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (4389, 'GENERACION DE REPORTE OPERATIVO CTAS AHORROS', 'GENERACION DE REPORTE OPERATIVO CTAS AHORROS', 'SP', getdate(), 4, 'P', 1, 'REPORTE DE CTAS AHORROS', NULL, 'cob_ahorros..sp_reporte_cuenta_ah', 30, NULL, @w_servidor, 'S', @w_path_fuente,@w_path_destino)


print 'Ingresando --ba_parametro'

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4389, 0, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 4389, 0, 2, 'FECHA_PROCESO', 'D', '01/01/2016')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4007, 4389, 1, 1, 'FILIAL', 'I', '1')

INSERT INTO cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (4007, 4389, 1, 2, 'FECHA_PROCESO', 'D', '01/01/2016')

print 'Ingresando --ba_sarta_batch'

INSERT INTO cobis..ba_sarta_batch (sb_sarta, sb_batch, sb_secuencial, sb_dependencia, sb_repeticion, sb_critico, sb_left, sb_top, sb_lote_inicio, sb_habilitado)
VALUES (4007, 4389, 1, NULL, 'S', 'N', 500, 550, 4007, 'S')

print 'Ingresando --ba_enlace'

INSERT INTO cobis..ba_enlace (en_sarta, en_batch_inicio, en_secuencial_inicio, en_batch_fin, en_secuencial_fin, en_tipo_enlace, en_puntos, en_entre_lotes)
VALUES (4007, 4389, 1, 0, 0, 'S', NULL, 'N')
go


use cob_ahorros
go

IF OBJECT_ID ('dbo.ah_report_ctas') IS NOT NULL
	DROP TABLE dbo.ah_report_ctas
GO

CREATE TABLE ah_report_ctas
	(
	w_ah_cuenta          CHAR(12),
	w_ah_cta_banco       CHAR(20),
	w_ah_oficina         CHAR(6),
	w_nomb_oficina       CHAR(40),
	w_ah_moneda          CHAR(5),
	w_descp_moneda       CHAR(35),
	w_ah_prod_banc       CHAR(5),
	w_descp_prod         CHAR(50),
	w_ah_origen          CHAR(5),
	w_desc_origen        CHAR(50),
	w_ah_categoria       CHAR(1),
	w_desc_categoria     CHAR(50),
	w_ah_titularidad     CHAR(1),
	w_desc_titularidad   CHAR(50),
	w_ah_oficial         CHAR(5),
	w_nomb_oficial       CHAR(64),
	w_ah_cliente         CHAR(10),
	w_ah_nombre          CHAR(80),
	w_ah_ced_ruc         CHAR(20),
	w_ah_descripcion_dv  CHAR(64),
	w_ah_fecha_ult_mov   CHAR(10),
	w_ah_fecha_prx_capita CHAR(10),
	w_ah_numsol          CHAR(10),
	w_ah_plazo           CHAR(10),
    w_perfil             CHAR(10),
	w_ca_cta_banco_mig   CHAR(16),
	w_ah_disponible      CHAR(18),
	w_ah_12h             CHAR(18),
	w_ah_24h             CHAR(18),
	w_slado_contable     CHAR(18),
	w_ah_saldo_interes   CHAR(18),
	w_ah_tasa_hoy        CHAR(6),
	w_ah_creditos_hoy    CHAR(18),
	w_ah_debitos_hoy     CHAR(18),
	w_ah_num_deb_mes     CHAR(6),
	w_ah_num_cred_mes    CHAR(6),
	w_ah_prom_disponible CHAR(18),
	w_ah_promedio1       CHAR(18),
	w_ah_promedio2       CHAR(18),
	w_ah_promedio3       CHAR(18),
	w_ah_promedio4       CHAR(18),
	w_ah_promedio5       CHAR(18),
	w_ah_promedio6       CHAR(18),
	w_ah_monto_bloq      CHAR(18),
	w_monto_bloq1        CHAR(18),
	w_fecha_bloq1        CHAR(10),
	w_monto_bloq2        CHAR(18),
	w_fecha_bloq2        CHAR(10),
	w_monto_bloq3        CHAR(18),
	w_fecha_bloq3        CHAR(10),
	w_existe_bloq1       CHAR(1),
	w_fecha_bloqm1       CHAR(10),
	w_existe_bloq2       CHAR(1),
	w_fecha_bloqm2       CHAR(10),
	w_existe_bloq3       CHAR(1),
	w_fecha_bloqm3       CHAR(10),
	w_ah_estado          CHAR(6),
	w_descip_estado      CHAR(50),
	w_ah_fecha_aper      CHAR(10),
	w_ah_fecha_inacti    CHAR(10),
	w_ah_fecha_cierre    CHAR(10),
    w_ah_fecha_reacti    CHAR(10)
	)

CREATE UNIQUE NONCLUSTERED INDEX ah_report_ctas_key
	ON dbo.ah_report_ctas (w_ah_cuenta,w_ah_cta_banco)
GO


