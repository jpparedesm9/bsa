USE cobis
GO

--ba_arch_resultado, ba_arch_fuente, ba_batch, ba_nombre
--'ARC_NODS_PLN_CTA _M', 'cob_conta_super..sp_ods_plan_cuentas_ttj', 7536, 'ARCHIVO ODS-6 PLAN DE CUENTAS TTJ'
SELECT ba_path_destino, ba_arch_resultado, ba_arch_fuente, * FROM cobis..ba_batch WHERE ba_batch = 7536
UPDATE cobis..ba_batch SET ba_arch_resultado = 'ARC_NODS_PLN_CTA' WHERE ba_batch = 7536

--ba_arch_resultado, ba_arch_fuente, ba_batch, ba_nombre
--'ARC_NODS_MOV_RES _M', 'cob_conta_super..sp_ods_mov_resultados_ttj', 75232, 'ARCHIVO ODS-3 DE MOVIMIENTOS-RESULTADOS TTJ'
SELECT ba_path_destino, ba_arch_resultado, ba_arch_fuente, * FROM cobis..ba_batch WHERE ba_batch = 75232
UPDATE cobis..ba_batch SET ba_arch_resultado = 'ARC_NODS_MOV_RES' WHERE ba_batch = 75232


--ba_arch_resultado, ba_arch_fuente, ba_batch, ba_nombre
--'ARC_NODS_VAL_ACT _M', 'cob_conta_super..sp_ods_balance_activos_ttj', 75222, 'ARCHIVO ODS-2 DE BALANCE DE ACTIVOS TTJ'
SELECT ba_path_destino, ba_arch_resultado, ba_arch_fuente, * FROM cobis..ba_batch WHERE ba_batch = 75222
UPDATE cobis..ba_batch SET ba_arch_resultado = 'ARC_NODS_VAL_ACT' WHERE ba_batch = 75222

--ba_arch_resultado, ba_arch_fuente, ba_batch, ba_nombre
--'ARC_NODS_HRC _M', 'cob_conta_super..sp_riesgo_hrc_glb_ttj', 36435, 'GENERACION ARCHIVO 07 (HRC GLB) TTJ'
SELECT ba_path_destino, ba_arch_resultado, ba_arch_fuente, * FROM cobis..ba_batch WHERE ba_batch = 36435
UPDATE cobis..ba_batch SET ba_arch_resultado = 'ARC_NODS_HRC' WHERE ba_batch = 36435
GO
