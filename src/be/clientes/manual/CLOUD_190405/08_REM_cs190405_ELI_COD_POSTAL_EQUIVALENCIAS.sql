use cobis
go
print 'Inicio script 08 cod_postal_equivalencias:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--------------------
/*****************************************************************************************/
/* ELIMINAR ESTADOS - PROVINCIA                                                          */
/*****************************************************************************************/
SELECT 'munic_equiv_no_prov' = 'munic_equiv_no_prov', * from cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_FED'
AND eq_valor_cat NOT IN (SELECT pv_provincia FROM cobis..cl_provincia)

SELECT 'prov_no_munic_equiv' = 'prov_no_munic_equiv', * FROM cobis..cl_provincia 
WHERE pv_provincia NOT IN (SELECT eq_valor_cat FROM cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_FED')

SELECT '#prov_equi' = count(*) from cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_FED'

SELECT '#provincia' = count(*) FROM cobis..cl_provincia
DELETE cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_FED'
AND eq_valor_cat NOT IN (SELECT pv_provincia FROM cobis..cl_provincia)

/****************************************************************************************/
/* ELIMINAR MUNICIPIOS - CIUDAD                                                         */
/****************************************************************************************/
SELECT 'munic_equiv_no_ciudad' = 'munic_equiv', * from cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_MUN'
AND eq_valor_cat NOT IN (SELECT ci_ciudad FROM cobis..cl_ciudad)

SELECT 'ciudad_no_munic_equiv' = 'ciudad_no_munic_equiv', * FROM cobis..cl_ciudad 
WHERE ci_ciudad NOT IN (SELECT eq_valor_cat from cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_MUN')

SELECT '#munic_equival' = count(*) from cob_conta_super..sb_equivalencias---Ini: 2463-------------Fin: 2463
WHERE eq_catalogo   = 'ENT_MUN'

SELECT '#ciudad' = count(*) FROM cobis..cl_ciudad---Ini: 2465-------------Fin: 2463

DELETE cobis..cl_ciudad
WHERE ci_ciudad NOT IN (SELECT eq_valor_cat from cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_MUN')


/****************************************************************************************/
/* ELIMINAR DUPLICADOS                                                                  */
/****************************************************************************************/

SELECT '#2_codPostal_ant' = count(*) FROM cobis..cl_codigo_postal---Ini: 144050

SELECT cp_codigo, cp_estado, cp_municipio, cp_colonia, cp_pais, cp_estado_h, cp_municipio_h, cp_colonia_h,
       'num' = count(*)
INTO #repetidos
FROM cobis..cl_codigo_postal
GROUP BY cp_codigo, cp_estado, cp_municipio, cp_colonia, cp_pais, cp_estado_h, cp_municipio_h, cp_colonia_h
HAVING count(*) > 1
/*

select * from cobis..cl_codigo_postal
where cp_estado_h = '01'
and cp_municipio_h = '011'
and cp_colonia_h = '0363'

select * from cobis..cl_codigo_postal_tmp
where cp_estado = '01'
and cp_municipio = '011'
and cp_colonia = '0363'

select * from cobis..cl_codigo_postal_tmp where cp_codigo = '86774'
select * from cobis..cl_codigo_postal where cp_codigo = '86774'
where not exist (select 1 from cobis..cl_codigo_postal)
*/

SELECT '#repetidos' = count(*) FROM #repetidos
--SELECT * FROM #repetidos--168
--SELECT * FROM ingresar_cp

SELECT DISTINCT cp.cp_codigo, cp.cp_estado, cp.cp_municipio, 
                cp.cp_colonia, cp.cp_pais, cp.cp_estado_h, cp.cp_municipio_h, cp.cp_colonia_h
INTO para_ingresar
FROM cobis..cl_codigo_postal cp, #repetidos rp
WHERE cp.cp_estado_h = rp.cp_estado_h
AND cp.cp_municipio_h = rp.cp_municipio_h
AND cp.cp_colonia_h = rp.cp_colonia_h
AND cp.cp_codigo = rp.cp_codigo

SELECT 'a_para_ingresar'= count(*) FROM para_ingresar

DELETE cobis..cl_codigo_postal
FROM  para_ingresar ing , cobis..cl_codigo_postal cp
WHERE ing.cp_estado_h = cp.cp_estado_h
AND ing.cp_municipio_h = cp.cp_municipio_h
AND ing.cp_colonia_h = cp.cp_colonia_h
AND ing.cp_codigo   = cp.cp_codigo

SELECT '2_#codPostal_desp_eli' = count(*) FROM cobis..cl_codigo_postal--143714

insert cobis..cl_codigo_postal
SELECT *
FROM para_ingresar

SELECT '2_#codPostal_desp_ing' = count(*) FROM cobis..cl_codigo_postal--143882
SELECT '2_#codPostal_tmp_desp_ing' = count(*) FROM cobis..cl_codigo_postal_tmp--143882

SELECT '2_para_ingresar', * FROM para_ingresar--SELECT '2_parte_a_eli', * FROM para_ingresar

--------------------------------------------------------------------------------------------------------------
------------------------------ hasta aca , si se ejecuta luego no habrá información
--------------------------------------------------------------------------------------------------------------
/****************************************************************************************/
/* BORRADO LOS QUE YA NO EXISTEN                                                        */
/****************************************************************************************/

SELECT '#1_codPostal_ant' = count(*) FROM cobis..cl_codigo_postal---Ini: 147892
SELECT '#1_codPostal_tmp_ant' = count(*) FROM cobis..cl_codigo_postal_tmp---Ini: 143882
--se debe eliminar 4.012

SELECT * 
into #codigo_postal_eli
FROM cobis..cl_codigo_postal cp
where not exists (select 1 from cobis..cl_codigo_postal_tmp cpt
                  where cp.cp_estado_h = cpt.cp_estado
                  AND cp.cp_municipio_h = cpt.cp_municipio
                  AND cp.cp_colonia_h = cpt.cp_colonia
                  and cp.cp_codigo  = cpt.cp_codigo)
                  
select 'a_eliminar' = count(*) from #codigo_postal_eli---Ini: 
/****************************************************************************************/
/* SELECTS PARROQUIAS                                                                   */
/****************************************************************************************/

SELECT '#parroq_a_borrar' = count(*)---Ini: -----------------Fin:
FROM cobis..cl_parroquia 
WHERE pq_parroquia IN (SELECT cp_colonia FROM #codigo_postal_eli)

SELECT '#equiv_a_borrar' = count(*)---Ini: -----------------Fin:
FROM cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_PARROQ'
AND eq_valor_cat IN (SELECT cp_colonia FROM #codigo_postal_eli)

SELECT 'select_para_eliminar' = count(*) from --- Al borrar esto aparece ya el #codigo de las parroquias, las que se quitaron del codigo postal
 cobis..cl_codigo_postal cp,  #codigo_postal_eli cpt
WHERE cp.cp_estado_h = cpt.cp_estado_h
AND cp.cp_municipio_h = cpt.cp_municipio_h
AND cp.cp_colonia_h = cpt.cp_colonia_h
AND cp.cp_codigo  = cpt.cp_codigo

/****************************************************************************************/
/* ELIMINANDO CODIGOS POSTALES - PARROQUIAS - EQUIVALENCIAS                             */
/****************************************************************************************/
DELETE cob_conta_super..sb_equivalencias
WHERE eq_catalogo   = 'ENT_PARROQ' 
AND eq_valor_cat IN (SELECT cp_colonia FROM #codigo_postal_eli)

DELETE cobis..cl_parroquia
WHERE pq_parroquia IN (SELECT cp_colonia FROM #codigo_postal_eli)

DELETE cl_codigo_postal--- Al borrar esto aparece ya el #codigo de las parroquias, las que se quitaron del codigo postal
FROM cobis..cl_codigo_postal cp,  #codigo_postal_eli cpt
WHERE cp.cp_estado_h = cpt.cp_estado_h
AND cp.cp_municipio_h = cpt.cp_municipio_h
AND cp.cp_colonia_h = cpt.cp_colonia_h
AND cp.cp_codigo  = cpt.cp_codigo

SELECT '1_#codPostal_desp' = count(*) FROM cobis..cl_codigo_postal
SELECT '1_#codPostal_tmp_desp' = count(*) FROM cobis..cl_codigo_postal_tmp
--falta eliminar 168 son registros que tiene otro codigo postal(336)

SELECT '#repetidos', * FROM #repetidos
SELECT '#para_ingresar', * FROM para_ingresar

DROP TABLE #repetidos
DROP TABLE para_ingresar
DROP TABLE #codigo_postal_eli

print 'Fin script 08 cod_postal_equivalencias:'+convert(varchar(30),getdate(),103)+'--'+convert(varchar(30),getdate(),108)
--1s
GO
