USE cob_cartera
GO
IF EXISTS(SELECT 1 FROM sysobjects WHERE name = 'mta_111795_rev')
  DROP TABLE mta_111795_rev
GO
  
CREATE TABLE mta_111795_rev(
re_secuencial INT IDENTITY,
re_operacion INT,
re_banco     VARCHAR(32),
re_oficina   INT,
re_procesado VARCHAR(10),
re_ab_estado VARCHAR(10),
re_secuencial_pag INT,
re_secuencial_ing INT )
GO

TRUNCATE TABLE mta_111795_rev

INSERT INTO mta_111795_rev
SELECT op_operacion, op_banco, op_oficina , 'N', ab_estado, ab_secuencial_pag, ab_secuencial_ing
FROM ca_abono, ca_operacion
where ab_operacion = op_operacion
AND   ab_operacion IN (
SELECT tg_operacion FROM cob_credito..cr_tramite_grupal WHERE tg_grupo =1967)
AND ab_estado IN ('NA', 'A')
ORDER BY ab_operacion, ab_fecha_pag DESC, ab_secuencial_pag desc
--ORDER BY , ab_secuencial_pag DESC

SELECT * FROM  mta_111795_rev

  