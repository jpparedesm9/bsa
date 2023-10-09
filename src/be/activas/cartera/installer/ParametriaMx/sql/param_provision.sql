USE cob_conta_super
GO

DELETE sb_provisiones
GO

DECLARE @w_clase 			catalogo, 
		@w_tipo 			catalogo, 
		@w_subtipo 			catalogo, 		
		@w_periodo_cuota 	varchar(30)

--**************************************************************************************
-- PROVISIONES COMERCIAL
--**************************************************************************************
select @w_clase = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'CCCOM'	and pa_producto = 'CCA'

SELECT @w_tipo = NULL
SELECT @w_subtipo = NULL

--CALIFICACION A
INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 0, 0, NULL, NULL, 0.5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 1, 30, NULL, NULL, 2.5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 31, 60, NULL, NULL, 15)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 61, 90, NULL, NULL, 35)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 91, 120, NULL, NULL, 40)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 121, 150, NULL, NULL, 60)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 151, 180, NULL, NULL, 75)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 181, 210, NULL, NULL, 85)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 211, 240, NULL, NULL, 95)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 241, 99999, NULL, NULL, 100)

--CALIFICACION B
INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 0, 0, NULL, NULL, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 1, 30, NULL, NULL, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 31, 60, NULL, NULL, 30)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 61, 90, NULL, NULL, 40)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B',91, 120, NULL, NULL, 50)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B',121, 150, NULL, NULL, 70)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B',151, 180, NULL, NULL, 95)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B',181, 210, NULL, NULL, 100)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B',211, 240, NULL, NULL, 100)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B',241, 99999, NULL, NULL, 100)


--**************************************************************************************
-- PROVISIONES COMERCIAL MICROCRÉDITO
--**************************************************************************************
select @w_clase = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'CCCOM'	and pa_producto = 'CCA'

SELECT @w_tipo = NULL

select @w_subtipo = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'CSMIC' and pa_producto = 'CCA'

--PERIODO SEMANAL
SELECT @w_periodo_cuota = td_tdividendo FROM cob_cartera..ca_tdividendo
WHERE td_descripcion = 'SEMANAL'

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 0, 6, 1, @w_periodo_cuota, 0.5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 7, 13, 2, @w_periodo_cuota, 1)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 14, 20, 3, @w_periodo_cuota, 3)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 21, 27, 4, @w_periodo_cuota, 4)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 28, 34, 5, @w_periodo_cuota, 5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 35, 41, 6, @w_periodo_cuota, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 42, 48, 7, @w_periodo_cuota, 15)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 49, 55, 8, @w_periodo_cuota, 20)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 56, 62, 9, @w_periodo_cuota, 25)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 63, 69, 10, @w_periodo_cuota, 30)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 70, 76, 11, @w_periodo_cuota, 35)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 77, 83, 12, @w_periodo_cuota, 40)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 84, 90, 13, @w_periodo_cuota, 45)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 91, 97, 14, @w_periodo_cuota, 50)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 98, 104, 15, @w_periodo_cuota, 60)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 105, 111, 16, @w_periodo_cuota, 70)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 112, 118, 17, @w_periodo_cuota, 80)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 119, 125, 18, @w_periodo_cuota, 85)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 126, 132, 19, @w_periodo_cuota, 90)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 133, 139, 20, @w_periodo_cuota, 95)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 140, 99999, 21, @w_periodo_cuota, 100)

--PERIODO QUINCENAL
SELECT @w_periodo_cuota = td_tdividendo FROM cob_cartera..ca_tdividendo
WHERE td_descripcion = 'QUINCENAL'

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 0, 14, 1, @w_periodo_cuota, 0.5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 15, 29, 2, @w_periodo_cuota, 3)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 30, 44, 3, @w_periodo_cuota, 5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 45, 59, 4, @w_periodo_cuota, 15)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 60, 74, 5, @w_periodo_cuota, 25)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 75, 89, 6, @w_periodo_cuota, 35)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 90, 104, 7, @w_periodo_cuota, 45)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 105, 119, 8, @w_periodo_cuota, 60)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 120, 134, 9, @w_periodo_cuota, 80)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 135, 149, 10, @w_periodo_cuota, 90)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 150, 99999, 11, @w_periodo_cuota, 100)

--PERIODO MENSUAL
SELECT @w_periodo_cuota = td_tdividendo FROM cob_cartera..ca_tdividendo
WHERE td_descripcion = 'MES(ES)'

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 0, 29, 1, @w_periodo_cuota, 0.5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 30, 59, 2, @w_periodo_cuota, 5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 60, 89, 3, @w_periodo_cuota, 25)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 90, 119, 4, @w_periodo_cuota, 45)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 120, 149, 5, @w_periodo_cuota, 80)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, NULL, 150, 99999, 6, @w_periodo_cuota, 100)

--**************************************************************************************
-- PROVISIONES CONSUMO
--**************************************************************************************
select @w_clase = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'CCCON'	and pa_producto = 'CCA'

SELECT @w_tipo = NULL
SELECT @w_subtipo = NULL

--CALIFICACION A
INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 0, 0, NULL, NULL, 1)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 1, 7, NULL, NULL, 2)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 8, 30, NULL, NULL, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 31, 60, NULL, NULL, 20)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 61, 90, NULL, NULL, 40)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 91, 120, NULL, NULL, 70)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 121, 180, NULL, NULL, 85)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 181, 99999, NULL, NULL, 100)

--CALIFICACION B
INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 0, 0, NULL, NULL, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 1, 7, NULL, NULL, 13)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 8, 30, NULL, NULL, 20)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 31, 60, NULL, NULL, 35)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 61, 90, NULL, NULL, 55)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 91, 120, NULL, NULL, 80)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 121, 180, NULL, NULL, 95)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 181, 99999, NULL, NULL, 100)

--**************************************************************************************
-- PROVISIONES VIVIENDA
--**************************************************************************************
select @w_clase = pa_char
from cobis..cl_parametro 
where pa_nemonico = 'CCVIV'	and pa_producto = 'CCA'

SELECT @w_tipo = NULL
SELECT @w_subtipo = NULL

--CALIFICACION A
INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 0, 0, NULL, NULL, 2)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 1, 30, NULL, NULL, 5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 31, 60, NULL, NULL, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 61, 90, NULL, NULL, 20)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 91, 120, NULL, NULL, 30)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 121, 150, NULL, NULL, 45)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 151, 180, NULL, NULL, 60)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 181, 1460, NULL, NULL, 80)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'A', 1461, 99999, NULL, NULL, 100)

--CALIFICACION B
INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 0, 0, NULL, NULL, 2)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 1, 30, NULL, NULL, 5)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 31, 60, NULL, NULL, 10)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 61, 90, NULL, NULL, 20)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 91, 120, NULL, NULL, 30)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 121, 150, NULL, NULL, 45)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 151, 180, NULL, NULL, 60)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 181, 1460, NULL, NULL, 80)

INSERT INTO sb_provisiones (pr_clase_cartera, pr_tipo_cartera, pr_subtipo_cartera, pr_calificacion, pr_dias_mora_ini, pr_dias_mora_fin, pr_periodo_mora, pr_periodo_cuota, pr_porcentaje)
VALUES(@w_clase, @w_tipo, @w_subtipo, 'B', 1461, 99999, NULL, NULL, 100)

GO