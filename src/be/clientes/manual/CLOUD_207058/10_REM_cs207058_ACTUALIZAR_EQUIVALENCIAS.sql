use cobis
go
print 'Ini script 10_REM_cs204415_ACTUALIZAR_EQUIVALENCIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
----------------

/*****************************************************************/
/* Se obtienen las equivalencias de colonias que difieren con el */ 
/* valor de archivo de codigo postal 							 */
/*****************************************************************/

SELECT DISTINCT 'codpost' = cp.cp_codigo, 
				cp.cp_estado,
				cp.cp_municipio, 
				'estado_arch' = cp.cp_municipio_h,
				p.pq_parroquia,
				'colonia_arch' = cp.cp_colonia_h, 
				'equivalencia' = e.eq_valor_arch
INTO #para_actualizar_equivalencia
FROM cobis..cl_codigo_postal cp 
JOIN cobis..cl_parroquia p 
	ON cp.cp_colonia = p.pq_parroquia
JOIN cob_conta_super..sb_equivalencias e 
	ON  e.eq_valor_cat = convert(VARCHAR(64), p.pq_parroquia)
WHERE cp.cp_colonia_h <> e.eq_valor_arch
AND e.eq_catalogo = 'ENT_PARROQ'

SELECT 'Antes de actualizar equivalencias'
SELECT 'colonia_arch_VS_equivalencia', * FROM #para_actualizar_equivalencia

/*****************************************************************/
/* Update de equivalencias 										 */ 
/*****************************************************************/

UPDATE cob_conta_super..sb_equivalencias
SET eq_valor_arch = colonia_arch
FROM #para_actualizar_equivalencia
WHERE pq_parroquia = eq_valor_cat
  AND eq_catalogo = 'ENT_PARROQ'


SELECT DISTINCT 'codpost' = cp.cp_codigo, 
				cp.cp_estado,
				cp.cp_municipio, 
				'estado_arch' = cp.cp_municipio_h,
				p.pq_parroquia,
				'colonia_arch' = cp.cp_colonia_h, 
				'equivalencia' = e.eq_valor_arch
INTO #faltan_actualizar_equivalencias
FROM cobis..cl_codigo_postal cp 
JOIN cobis..cl_parroquia p 
	ON cp.cp_colonia = p.pq_parroquia
JOIN cob_conta_super..sb_equivalencias e 
	ON  e.eq_valor_cat = convert(VARCHAR(64), p.pq_parroquia)
WHERE cp.cp_colonia_h <> e.eq_valor_arch
AND e.eq_catalogo = 'ENT_PARROQ'


SELECT 'Antes de actualizar equivalencias'
SELECT 'colonia_arch_VS_equivalencia', * FROM #faltan_actualizar_equivalencias

drop table #para_actualizar_equivalencia
drop table #faltan_actualizar_equivalencias
--
print 'Fin script 10_REM_cs204415_ACTUALIZAR_EQUIVALENCIAS:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
go
