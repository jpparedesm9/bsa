USE cobis
GO

SELECT *
FROM ba_batch
WHERE ba_batch IN(7511, 7512)

update ba_batch
SET ba_arch_resultado = 'BMXP_SAL_CAR_TTI',
    ba_tipo_batch = 'R',
    ba_frec_reg_proc = 10000,
    ba_impresora = 'lp'
WHERE ba_batch = 7511

update ba_batch
SET ba_arch_resultado = 'BMXP_SAL_CAR',
    ba_tipo_batch = 'R',
    ba_frec_reg_proc = 10000,
    ba_impresora = 'lp'
WHERE ba_batch = 7512


SELECT *
FROM ba_batch
WHERE ba_batch IN(7511, 7512)
