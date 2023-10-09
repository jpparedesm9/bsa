use cobis
go



delete from ba_batch where ba_batch= 287935

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (287935, 'ARCHIVO ODS-7 SALDOS CONTABLES DIARIOS NV', 'ARCHIVO ODS-7 SALDOS CONTABLES DIARIOS NV', 'SP', getDATE(), 36, 'P', 1, NULL, 'BMXP_SAL_DIA_N_', 'cob_conta_super..sp_ods_saldos_cont_nv', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 287935 and pa_nombre = 'TIPO_REPORTE' )
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
values (0, 287935, 0, 1, 'TIPO_REPORTE', 'C', 'D')


delete from ba_batch where ba_batch= 287936

insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
values (287936, 'ARCHIVO ODS-8 SALDOS CONTABLES MENSUALES NV', 'ARCHIVO ODS-8 SALDOS CONTABLES MENSUALES NV', 'SP', getDATE(), 36, 'P', 1, NULL, 'BMXP_SAL_MEN_N', 'cob_conta_super..sp_ods_saldos_cont_nv', 10000, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')

if not exists (select 1 from ba_parametro where pa_batch = 287936 and pa_nombre = 'TIPO_REPORTE' )
insert into ba_parametro(pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor) 
values (0, 287936, 0, 1, 'TIPO_REPORTE', 'C', 'M')


go