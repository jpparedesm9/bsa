use cob_conta_super
go
IF OBJECT_ID ('sb_reporte_castigados') IS NOT NULL
	DROP table sb_reporte_castigados
go

create table sb_reporte_castigados(
ENTIDAD            						varchar(30) null,
CARTERA            						varchar(32) null,
SEGMENTO            					varchar(50) null,
SUCURSAL_O_CENTRO_DE_ALTA            	varchar(4) null,
CONTRATO            					varchar(16) null,
REGION            						varchar(30) null,
MONEDA            						varchar(3) null,
VALOR_DIVISA 							tinyint	null,
MES 									varchar(8) null,
FECHA_CONTABLE 							varchar(8) null,
FECHA_DE_OPERACION 						varchar(8) null,
BUC            							varchar(8) null,
NUM_CREDITO           					varchar(16) null,
NOMBRE            						varchar(80) null,
TOTAL_QUITAS							varchar(20) null,
TOTAL_CASTIGOS							varchar(8) null,
TOTAL_RECUPERACIONES_CONTABLE			varchar(8) null,
TOTAL_RECUPERACIONES_GESTION			varchar(8) null,
TOTAL_RECUPERACIONES_SECORSE			varchar(8) null,
TOTAL_GASTOS							varchar(8) null,
TOTAL_QUITAS_MO							varchar(8) null,
TOTAL_CASTIGOS_MO 						varchar(8) null,
PRODUCTO            					varchar(2) null,
SUBPRODUCTO            					varchar(4) null,
PAN_O_CUENTA            				varchar(16) null,
ORIGEN            						varchar(11) null,
OBSERVACIONES            				varchar(50) null,
FECHA_DE_CASTIGO 						varchar(8) null,
TIPO_DE_PAGO            				varchar(34) null,
GESTION_CONTABLE            			varchar(8) null,
IDENTIFICADOR_DE_OPERACION            	varchar(20) null,
DIAS_MOROSOS							smallint null,
BANDERA_BASILEA            				varchar(1) null,
desc_segmento_loc_1            			varchar(50) null,
desc_segmento_loc_2            			varchar(50) null,
desc_segmento_loc_3            			varchar(50) null,
desc_segmento_loc_4            			varchar(50) null,
desc_segmento_loc_5            			varchar(50) null,
FECHA_VENTA								varchar(8) null,
fecha_pago								varchar(8) null
)
go

use cobis
go

delete from cl_parametro where pa_nemonico = 'BTOPE' and pa_producto='REC'

INSERT INTO cl_parametro(pa_parametro, pa_nemonico,pa_tipo,pa_char,pa_producto)
VALUES('PRESENTAR TODOS LOS CASTIGADOS EN REPRORTE','BTOPE','C','S','REC')


delete from ba_batch where ba_batch= 287934
INSERT INTO ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (287934, 'REPORTE CASTIGOS Y CONDONACIONES', 'REPORTE CASTIGOS Y CONDONACIONES', 'SP', getDATE(), 36, 'P', 1, NULL, 'Integracion_COBIS_', 'cob_conta_super..sp_reporte_castigos_condonaciones', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 287934 and pa_nombre = 'FECHA PROCESO' )
INSERT INTO ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) VALUES (0, 287934, 0, 1, 'FECHA PROCESO', 'D', '12/01/2020')

go
