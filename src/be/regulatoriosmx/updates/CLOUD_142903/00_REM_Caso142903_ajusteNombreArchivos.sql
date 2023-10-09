USE cobis
GO

UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'ARC_NODS_MOV_RES_M'
WHERE   ba_batch = 75232

/*UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'BMXP_NODS_MOV_RES'
WHERE   ba_batch = 75232*/

-- 75232  --'BMXP_NODS_MOV_RES_D'  -->   ARC_NODS_MOV_RES_M_AAAAMMDD.txt

UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'ARC_NODS_PLN_CTA_M'
WHERE   ba_batch = 7536

/*UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'BMXP_NODS_PLN_CTA'
WHERE   ba_batch = 7536*/

-- 7536   --'BMXP_NODS_PLN_CTA_D'  -->  ARC_NODS_PLN_CTA_M_AAAAMMDD.txt

UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'ARC_NODS_SAL_MEN_M'
WHERE   ba_batch = 7538

/*UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'BMXP_NODS_SAL_MEN'
WHERE   ba_batch = 7538*/

-- 7538   --'BMXP_NODS_SAL_MEN_M' -->  ARC_NODS_SAL_MEN_M_AAAAMMDD

UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'ARC_NODS_VAL_ACT_M'
WHERE   ba_batch = 75222

/*UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'BMXP_NODS_VAL_ACT'
WHERE   ba_batch = 75222*/

-- 75222  --'BMXP_NODS_VAL_ACT_D' -->  ARC_NODS_VAL_ACT_M_AAAAMMDD.txt

UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'ARC_NODS_HRC_M'
WHERE   ba_batch = 36435

/*UPDATE 	cobis..ba_batch
SET 	ba_arch_resultado = 'COBIS_NODS_HRC'
WHERE   ba_batch = 36435*/

-- 36435  -- COBIS_NODS_HRC  --> ARC_NODS_HRC_M_AAAAMMDD.txt
