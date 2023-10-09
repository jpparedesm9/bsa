--TIPO DE TRANSACCION  

delete cob_conta_super..sb_equivalencias  where   eq_catalogo='TIPTRNSREP'
INSERT INTO cob_conta_super..sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('TIPTRNSREP', '01', 'DEP', 'DEPOSITO', 'V')
GO
INSERT INTO cob_conta_super..sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('TIPTRNSREP', '02', 'RET', 'RETIRO', 'V')
GO

--INTRUMENTO DE MONETARIO
delete cob_conta_super..sb_equivalencias  where   eq_catalogo='INSTMONET'
INSERT INTO cob_conta_super..sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('INSTMONET', '01', 'EFEC', 'EFECTIVO', 'V')
GO

--CODIGO SUPERVISOR
delete cobis..cl_parametro where pa_nemonico='COS'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CODIGO ORGANO SUPERVISOR', 'COS', 'C', '40-002', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO
--CLAVE SUJETO
delete cobis..cl_parametro where pa_nemonico='CSO'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('CLAVE DEL SUJETO OBLIGADO', 'CSO', 'C', '40-003', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO


--TIPO DE PERSONA
delete cob_conta_super..sb_equivalencias  where   eq_catalogo='TPER' 
INSERT INTO cob_conta_super..sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('TPER', '1', 'P', 'PERSONA FÍSICA', 'V')
GO
INSERT INTO cob_conta_super..sb_equivalencias (eq_catalogo, eq_valor_cat, eq_valor_arch, eq_descripcion, eq_estado)
VALUES ('TPER', '2', 'C', 'PERSONA MORAL', 'V')
GO

--PARAMETRO PARA DETERMINAR EL AGENTE O APODERADO DE SEGURO
delete cobis..cl_parametro where pa_nemonico='ASF'
INSERT INTO cobis..cl_parametro (pa_parametro, pa_nemonico, pa_tipo, pa_char, pa_tinyint, pa_smallint, pa_int, pa_money, pa_datetime, pa_float, pa_producto)
VALUES ('AGENTE O APODERADO DE SEGUROS Y/O FIANZAS', 'ASF', 'C', 'F', NULL, NULL, NULL, NULL, NULL, NULL, 'REC')
GO




