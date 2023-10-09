USE cob_remesas
go

DELETE  FROM cob_remesas..re_contrato_producto

SELECT * FROM cob_remesas..re_contrato_producto
DECLARE  @w_cp_prod_banc INT

IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PAHCT')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PAHCT'
  
      
INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'AHPROP.RPT', 'CONTRATO AHORROS CONTRACTUAL PERSONA', 'SI')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'AHPROJ.RPT', 'CONTRATO AHORROS CONTRACTUAL JURIDICO', 'NO')


END

IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCANOR')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCANOR'
  
  
INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CONAHO.RPT', 'CONTRATO AHORROS PERSONA', 'SI')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'CONAHJ.RPT', 'CONTRATO AHORROS JURIDICO', 'NO')



END



IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCAME')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCAME'
  
  

INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CONAHO.RPT', 'CONTRATO AHORROS PERSONA', 'SI')


END




IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCAASO')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCAASO'
  
  

INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'CERASJ.RPT', 'CERTIFICADO APORTACION JURIDICO', 'NO')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CERASA.RPT', 'CERTIFICADO APORTACION PERSONA', 'SI')


END



IF EXISTS ( select 1 from  cobis..cl_parametro	where pa_producto = 'AHO' and pa_nemonico ='PCAASA')
BEGIN
      
select @w_cp_prod_banc = pa_int from  cobis..cl_parametro where pa_producto = 'AHO' and pa_nemonico ='PCAASA'
  

INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'C', NULL, 'V', 'CERASJ.RPT', 'CERTIFICADO APORTACION JURIDICO', 'NO')


INSERT INTO cob_remesas..re_contrato_producto (cp_producto, cp_prod_banc, cp_tipo_persona, cp_titularidad, cp_estado, cp_plantilla, cp_descripcion, cp_es_especial)
VALUES (4, @w_cp_prod_banc, 'P', 'I', 'V', 'CERASA.RPT', 'CERTIFICADO APORTACION PERSONA', 'SI')


END

go