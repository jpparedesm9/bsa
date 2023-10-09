----equiva    -> cobis     -> doc
--------------------------------------------------------
--estado    -> provincia -> d_estado-c_estado
--municipio -> ciudad    -> D_mnpio-c_mnpio
--colonia   -> parroquia -> d_asenta-id_asenta_cpcons
--SELECT count(*) FROM documento_caso_135304--84276--94711
------------------------------------------------------UPDATE PROVINCIA----------------
print 'Inicio script 06 act_nombres:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)

use cobis
go

SELECT DISTINCT cp_estado, cp_nombre_estado
INTO #estado
FROM cl_codigo_postal_tmp

SELECT 'est_equiv_vs_prov' = 'est_equiv_vs_prov', pv_descripcion, eq_descripcion, eq_valor_cat, eq_valor_arch 
FROM cob_conta_super..sb_equivalencias, cobis..cl_provincia
WHERE  eq_catalogo   ='ENT_FED'
AND    eq_valor_cat = pv_provincia
AND    pv_descripcion <> eq_descripcion

SELECT 'est_equiv_vs_codPos_tmp' = 'est_equiv_vs_codPos_tmp', eq_descripcion, cp_nombre_estado, eq_valor_cat, eq_valor_arch
FROM   cob_conta_super..sb_equivalencias, #estado
WHERE  eq_catalogo   ='ENT_FED'
AND    eq_valor_arch = cp_estado
AND    eq_descripcion <> cp_nombre_estado

SELECT 'est_prov_equi' = 'est_prov_equi', pv_descripcion, eq_descripcion, eq_valor_cat, eq_valor_arch
FROM cobis..cl_provincia, cob_conta_super..sb_equivalencias
WHERE  eq_catalogo   = 'ENT_FED'
AND    eq_valor_cat  = pv_provincia
AND    pv_descripcion <> eq_descripcion

UPDATE cob_conta_super..sb_equivalencias
SET    eq_descripcion = cp_nombre_estado 
FROM   #estado
WHERE  eq_catalogo   ='ENT_FED'
AND    eq_valor_arch = cp_estado

UPDATE cobis..cl_provincia
SET    pv_descripcion = eq_descripcion
FROM   cob_conta_super..sb_equivalencias
WHERE  eq_catalogo   = 'ENT_FED'
AND    eq_valor_cat  = pv_provincia

drop table #estado

------------------------------------------------------UPDATE CIUDAD
SELECT DISTINCT cp_estado, cp_municipio, cp_nombre_municipio
INTO #ciudad_nuevo
FROM cl_codigo_postal_tmp

SELECT DISTINCT cp.cp_estado, cp.cp_municipio, c.cp_nombre_municipio
INTO #ciudad_act
FROM #ciudad_nuevo c, cl_codigo_postal cp
WHERE c.cp_estado = cp_estado_h
AND c.cp_municipio = cp_municipio_h

SELECT 'est_equiv_vs_ciud' = 'est_equiv_vs_ciud', ci_descripcion, eq_descripcion, eq_valor_cat, eq_valor_arch
FROM cob_conta_super..sb_equivalencias, cobis..cl_ciudad
WHERE  eq_catalogo   ='ENT_MUN'
AND    eq_valor_cat = ci_ciudad
AND    ci_descripcion <> eq_descripcion

SELECT 'est_ciud_ciud_tmp' = 'est_ciud_ciud_tmp', ci_descripcion, cp_nombre_municipio 
FROM cobis..cl_ciudad, #ciudad_act
WHERE ci_ciudad = cp_municipio
AND ci_provincia = cp_estado
AND  ci_descripcion <> cp_nombre_municipio

SELECT 'est_equiv_ciud_tmp' = 'est_equiv_ciud_tmp', eq_descripcion, cp_nombre_municipio, eq_valor_cat, eq_valor_arch
FROM cob_conta_super..sb_equivalencias, #ciudad_act
WHERE  eq_catalogo   ='ENT_MUN'
AND    eq_valor_cat = cp_municipio 
AND    eq_descripcion <> cp_nombre_municipio

UPDATE cobis..cl_ciudad
SET  ci_descripcion = cp_nombre_municipio
FROM #ciudad_act
WHERE ci_ciudad = cp_municipio
AND ci_provincia = cp_estado

UPDATE cob_conta_super..sb_equivalencias
SET eq_descripcion = cp_nombre_municipio
FROM #ciudad_act
WHERE  eq_catalogo   ='ENT_MUN'
AND    eq_valor_cat = cp_municipio

drop table #ciudad_nuevo
drop table #ciudad_act

------------------------------------------------------UPDATE PARROQUIA
SELECT DISTINCT cp_estado, cp_municipio, cp_colonia, cp_nombre_col
INTO #parroquia_nuevo
FROM cl_codigo_postal_tmp

SELECT DISTINCT cp.cp_estado, cp.cp_municipio, cp.cp_colonia,  c.cp_nombre_col
INTO #parroquia_act
FROM #parroquia_nuevo c, cl_codigo_postal cp
WHERE c.cp_estado = cp.cp_estado_h
AND c.cp_municipio = cp.cp_municipio_h
AND c.cp_colonia = cp.cp_colonia_h

SELECT 'parrq_equiv_vs_parroq' = 'est_equiv_vs_parroq', pq_descripcion, eq_descripcion, eq_valor_cat, eq_valor_arch
FROM cob_conta_super..sb_equivalencias, cobis..cl_parroquia
WHERE  eq_catalogo   ='ENT_PARROQ'
AND    eq_valor_cat = pq_parroquia
AND    pq_descripcion <> eq_descripcion

SELECT 'parrq_parroqTmp_parroq_ciud' = 'est_parroqTmp_parroq_ciud', pq_descripcion, cp_nombre_col
FROM #parroquia_act, cobis..cl_parroquia, cobis..cl_ciudad
WHERE cp_estado = ci_provincia
AND   cp_municipio = pq_ciudad
AND cp_colonia = pq_parroquia
AND pq_ciudad = ci_ciudad
AND pq_descripcion <> cp_nombre_col

SELECT 'parrq_equiv_vs_parroq_tmp' = 'parrq_equiv_vs_parroq_tmp', eq_descripcion, cp_nombre_col, eq_valor_cat, eq_valor_arch
FROM cob_conta_super..sb_equivalencias, #parroquia_act
WHERE  eq_catalogo   ='ENT_PARROQ'
AND    eq_valor_cat = cp_colonia
AND    eq_descripcion <> cp_nombre_col

UPDATE cobis..cl_parroquia
SET pq_descripcion = cp_nombre_col
FROM #parroquia_act, cobis..cl_ciudad
WHERE cp_estado = ci_provincia
AND   cp_municipio = pq_ciudad
AND cp_colonia = pq_parroquia
AND pq_ciudad = ci_ciudad

UPDATE cob_conta_super..sb_equivalencias
SET    eq_descripcion = pq_descripcion
FROM   cobis..cl_parroquia
WHERE  eq_catalogo   ='ENT_PARROQ'
AND    eq_valor_cat = pq_parroquia
GO

drop table #parroquia_nuevo
drop table #parroquia_act

print 'Fin script 06 act_nombres:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--
--6s
GO
