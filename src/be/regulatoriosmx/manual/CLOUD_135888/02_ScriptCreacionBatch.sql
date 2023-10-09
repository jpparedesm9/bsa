use cobis
go

if not exists(select 1 from cobis..ba_batch where ba_batch = 75222)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (75222, 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTJ', 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTJ', 'SP', '2018-01-19 05:08:09', 36, 'P', 1, 'REGULATORIOS', 'BMXP_NODS_VAL_ACT_D', 'cob_conta_super..sp_ods_balance_activos_ttj', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end

if not exists(select * from cobis..ba_parametro where pa_batch = 75222 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 75222, 0, 1, 'FECHA PROCESO', 'D', '01/01/2020')
end


if not exists(select 1 from cobis..ba_batch where ba_batch = 75232)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (75232, 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTJ', 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTJ', 'SP', '2018-01-19 05:08:09', 36, 'P', 1, 'REGULATORIOS', 'BMXP_NODS_MOV_RES_D', 'cob_conta_super..sp_ods_mov_resultados_ttj', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end

if not exists(select * from cobis..ba_parametro where pa_batch = 75232 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 75232, 0, 1, 'FECHA PROCESO', 'D', '01/01/2020')
end

if not exists(select 1 from cobis..ba_batch where ba_batch = 7536)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (7536, 'ARCHIVO ODS-6 PLAN DE CUENTAS TTJ', 'ARCHIVO ODS-6 PLAN DE CUENTAS TTJ', 'SP', '2018-01-19 17:08:09.01', 36, 'P', 1, 'REGULATORIOS', 'BMXP_NODS_PLN_CTA_D', 'cob_conta_super..sp_ods_plan_cuentas_ttj', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end

if not exists(select * from cobis..ba_parametro where pa_batch = 7536 and pa_sarta = 0)
begin
    insert into ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
    values (0, 7536, 0, 1, 'FECHA PROCESO', 'D', '01/01/2020')
end


if not exists(select 1 from cobis..ba_batch where ba_batch = 7538)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (7538, 'ARCHIVO ODS-8 SALDOS CONTABLES MENSUALES TTJ', 'ARCHIVO ODS-8 SALDOS CONTABLES MENSUALES TTJ', 'SP', '2018-01-19 17:08:09.013', 36, 'P', 1, 'REGULATORIOS', 'BMXP_NODS_SAL_MEN_M', 'cob_conta_super..sp_ods_saldos_cont_ttj', 1, NULL, 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end

if not exists(select 1 from cobis..ba_parametro where pa_batch = 7538 and pa_sarta = 0 and pa_parametro = 1)
begin
   insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 7538, 0, 1, 'TIPO_REPORTE', 'C', 'M')
end

if not exists(select 1 from cobis..ba_parametro where pa_batch = 7538 and pa_sarta = 0 and pa_parametro = 2)
begin
   insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 7538, 0, 2, 'FECHA PROCESO', 'D', '01/01/2020')
end


if not exists(select 1 from cobis..ba_batch where ba_batch = 36435)
begin
   insert into ba_batch (ba_batch, ba_nombre, ba_descripcion, ba_lenguaje, ba_fecha_creacion, ba_producto, ba_tipo_batch, ba_sec_corrida, ba_ente_procesado, ba_arch_resultado, ba_arch_fuente, ba_frec_reg_proc, ba_impresora, ba_serv_destino, ba_reproceso, ba_path_fuente, ba_path_destino)
   values (36435, 'GENERACION ARCHIVO 07 (HRC GLB) TTJ', 'GENERACION ARCHIVO 07 (HRC GLB) TTJ', 'SP', '2019-08-26', 36, 'R', 1, 'REGULATORIOS', 'COBIS_NODS_HRC', 'cob_conta_super..sp_riesgo_hrc_glb_ttj', 1, 'lp', 'CTSSRV', 'S', 'C:\Cobis\VBatch\Regulatorios\Objetos\', 'C:\Cobis\VBatch\Regulatorios\listados\')
end 

if not exists(select 1 from cobis..ba_parametro where pa_batch = 36435 and pa_sarta = 0 )
begin
   insert into cobis..ba_parametro (pa_sarta, pa_batch, pa_ejecucion, pa_parametro, pa_nombre, pa_tipo, pa_valor)
   values (0, 36435, 0, 1, 'FECHA PROCESO', 'D', '01/01/2020')
end


--select * from cobis..ba_batch where ba_batch = 36435
