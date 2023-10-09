use cob_cartera
go

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ca_cobro_seg_res_archivo')
	DROP TABLE ca_cobro_seg_res_archivo
GO
CREATE TABLE ca_cobro_seg_res_archivo (
cs_secuencial	int IDENTITY(1,1), 
cs_banco	    cuenta    not null, 
cs_cliente		int		  not null,
cs_cuotas		int		  not null,
cs_fecha		datetime  null,
cs_archivo      varchar(255) null,
cs_seguro		varchar(5)		null,
cs_estado	    char(1)    null ,
cs_mensaje      varchar(255) null,
)
create index idx1 on ca_cobro_seg_res_archivo(cs_banco) 
go

IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'ca_cobro_seg_res_archivo_tmp')
	DROP TABLE ca_cobro_seg_res_archivo_tmp
GO
CREATE TABLE ca_cobro_seg_res_archivo_tmp (
cs_banco_tmp	    varchar(30)    not null, 
cs_cliente_tmp		varchar(30)		  not null,
cs_estado_tmp	    varchar(30)    null ,
cs_mensaje_tmp      varchar(255) null,
)
create index idx1 on ca_cobro_seg_res_archivo_tmp(cs_banco_tmp) 
go
declare @w_id int

delete from ca_rubro where ru_concepto = 'SEGAD' and ru_toperacion = 'GRUPAL'

INSERT INTO ca_rubro (ru_toperacion, ru_moneda, ru_concepto, ru_prioridad, ru_tipo_rubro, ru_paga_mora, ru_provisiona, ru_fpago, ru_crear_siempre, ru_tperiodo, ru_periodo, ru_referencial, ru_reajuste, ru_banco, ru_estado, ru_concepto_asociado, ru_redescuento, ru_intermediacion, ru_principal, ru_saldo_op, ru_saldo_por_desem, ru_pit, ru_limite, ru_mora_interes, ru_iva_siempre, ru_monto_aprobado, ru_porcentaje_cobrar, ru_tipo_garantia, ru_valor_garantia, ru_porcentaje_cobertura, ru_tabla, ru_saldo_insoluto, ru_calcular_devolucion, ru_tasa_aplicar, ru_valor_max, ru_valor_min, ru_afectacion, ru_diferir, ru_tipo_seguro, ru_tasa_efectiva)
VALUES ('GRUPAL', 0, 'SEGAD', 12, 'O', 'N', 'N', 'M', 'N', NULL, NULL, NULL, NULL, 'N', 'V', NULL, 0, 0, 'N', NULL, NULL, NULL, 'N', 'N', NULL, 'N', NULL, NULL, NULL, NULL, NULL, NULL, 'N', 'S', 0, 0, NULL, 'N', NULL, NULL)

delete from cob_cartera..ca_concepto where co_concepto = 'SEGAD'

select @w_id = max(co_codigo) + 1
from ca_concepto

insert into ca_concepto (co_concepto, co_descripcion, co_codigo, co_categoria)
values ('SEGAD','SEGURO ADICIONAL', @w_id, 'S')
GO

DELETE FROM cob_cartera..ca_tipo_trn WHERE tt_codigo='RES'


INSERT INTO ca_tipo_trn (tt_codigo, tt_descripcion, tt_reversa, tt_contable)
VALUES ('RES', 'REESTRUCCTURACION', 'S', 'S')
GO

use cobis
go

delete from cobis..cl_parametro where pa_nemonico = 'SEGAD' and pa_producto='CCA'

insert into cobis..cl_parametro (pa_parametro,pa_nemonico, pa_tipo,pa_money, pa_producto)
values('VALOR SEGURO ADICIONAL','SEGAD','M',48.00,'CCA')

delete from ba_parametro where pa_batch = 7095
delete from ba_batch where ba_batch = 7095

INSERT INTO dbo.ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (7095, 'APLICACION DE SEGURO ADICIONAL REESTRUCTURACIONES', 'APLICACION DE SEGURO ADICIONAL REESTRUCTURACIONES', 'SP', getDate(), 7, 'P', 1, NULL, 'DSP_.txt', 'cob_cartera..sp_reestructuracion_cobro_seg', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Cartera\Objetos\', 'C:\Cobis\VBatch\Cartera\listados\Reestructuracion\')


INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7095, 0, 1, 'FECHA PROCESO', 'D', '10/09/2019')

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (0, 7095, 0, 2, 'ARCHIVO', 'C', 'Reestructuracion_17042020_V2.txt')

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (99, 7095, 19, 1, 'FECHA PROCESO', 'D', '04/06/2020')

INSERT INTO dbo.ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
VALUES (99, 7095, 19, 2, 'ARCHIVO', 'C', 'Reestructuracion_17042020_V2.txt')

go

