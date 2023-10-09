use cobis
go
-------------------
/***********************************************************************/
/*Validar este script para un proximo envio                            */
/***********************************************************************/

SELECT cp_estado_rep = cp_estado_h, 
       cp_municipio_rep = cp_municipio_h, 
       cp_colonia_rep = cp_colonia_h, 'registro_rep' = count(*)
INTO #repetidos
FROM cobis..cl_codigo_postal
GROUP BY cp_estado_h, cp_municipio_h, cp_colonia_h HAVING count(*) > 1

SELECT '#repetidos'='#repetidos',* FROM #repetidos

SELECT C.* 
INTO #consulta
FROM cobis..cl_codigo_postal C, #repetidos R
WHERE cp_estado_rep = cp_estado_h
AND cp_municipio_rep = cp_municipio_h
AND cp_colonia_rep = cp_colonia_h

SELECT '#consulta'='#consulta',* FROM #consulta

DECLARE @w_max_parroquia INT
SELECT @w_max_parroquia = max(pq_parroquia) FROM cobis..cl_parroquia_resp_159331

SELECT 'cp_codigo_eli'	= cp_codigo,
       'cp_estado_eli'	= cp_estado,
       'cp_municipio_eli'	= cp_municipio,
       'cp_colonia_eli'	= cp_colonia,
       'cp_pais_eli'	    = cp_pais,
       'cp_estado_h_eli'	= cp_estado_h,
       'cp_municipio_h_eli' = cp_municipio_h,
       'cp_colonia_h_eli'	= cp_colonia_h    
INTO #para_eliminar_info
FROM cobis..cl_parroquia P, #consulta C
WHERE pq_parroquia > @w_max_parroquia
AND pq_parroquia = cp_colonia

SELECT '#para_eliminar_info'='#para_eliminar_info', * FROM #para_eliminar_info

SELECT 'antes_eli_cod_post' = 'antes_eli_cod_post', *
FROM cobis..cl_codigo_postal, #para_eliminar_info
WHERE cp_codigo_eli	=	cp_codigo
and cp_estado_eli	=	cp_estado
and cp_municipio_eli	=	cp_municipio
and cp_colonia_eli	=	cp_colonia
and cp_pais_eli	=	    cp_pais
and cp_estado_h_eli	=	cp_estado_h
and cp_municipio_h_eli = cp_municipio_h
and cp_colonia_h_eli	=	cp_colonia_h

DELETE cobis..cl_codigo_postal
FROM #para_eliminar_info
WHERE cp_codigo_eli	=	cp_codigo
and cp_estado_eli	=	cp_estado
and cp_municipio_eli = cp_municipio
and cp_colonia_eli	=	cp_colonia
and cp_pais_eli	=	    cp_pais
and cp_estado_h_eli	=	cp_estado_h
and cp_municipio_h_eli = cp_municipio_h
and cp_colonia_h_eli =	cp_colonia_h

SELECT 'antes_parroquia' = 'antes_parroquia', * FROM cobis..cl_parroquia WHERE pq_parroquia IN (SELECT cp_colonia_eli FROM #para_eliminar_info)
DELETE cobis..cl_parroquia WHERE pq_parroquia IN (SELECT cp_colonia_eli FROM #para_eliminar_info)

SELECT 'sb_equivalencias'='sb_equivalencias',*
FROM cob_conta_super..sb_equivalencias 
WHERE eq_catalogo   = 'ENT_PARROQ'
AND eq_valor_cat IN (SELECT cp_colonia_eli FROM #para_eliminar_info)

DELETE FROM cob_conta_super..sb_equivalencias 
WHERE eq_catalogo   = 'ENT_PARROQ'
AND eq_valor_cat IN (SELECT cp_colonia_eli FROM #para_eliminar_info)

DROP TABLE #repetidos
DROP TABLE #consulta
GO

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

