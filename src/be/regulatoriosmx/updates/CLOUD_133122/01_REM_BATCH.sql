use cobis
go

declare
@w_producto          int

select @w_producto = pd_producto
from cl_producto
where pd_descripcion = 'CONTABILIDAD'

delete ba_batch where ba_batch in (28796, 28797, 28798)

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28796, 'REPORTE CLIENTES EN MOROSIDAD', 'REPORTE CLIENTES EN MOROSIDAD', 'SP', getdate(), @w_producto, 'P', 1, NULL, 'ASIGNA_DESP', 'cob_conta_super..sp_reporte_morosidad', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\Asignaciones\')

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28797, 'REPORTE DETALLE TELEFONO DOMICILIO', 'REPORTE DETALLE TELEFONO DOMICILIO', 'SP', getdate(), @w_producto, 'P', 1, NULL, 'TEL_ASIGNA', 'cob_conta_super..sp_reporte_telf_domicilio', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\Asignaciones\')

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
VALUES (28798, 'REPORTE DE ASIGNACIONES, SEGUNDA PARTE', 'REPORTE DE ASIGNACIONES, SEGUNDA PARTE', 'SP', getdate(), @w_producto, 'P', 1, NULL, 'ASIGNAMORA_DESP', 'cob_conta_super..sp_reporte_asigna_mora', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\Asignaciones\')


GO