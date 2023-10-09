--Crea tabla para manejo de secuenciales para la creación de Operaciones

USE cob_cartera
GO
IF OBJECT_ID ('ca_sec_no_truncar') IS NOT NULL
	DROP TABLE ca_sec_no_truncar
GO

DECLARE @w_sec INT,
@w_cmd VARCHAR(255)

SELECT @w_sec = se_secuencial
FROM ca_secuenciales WHERE se_operacion = -1

SELECT @w_sec = @w_sec + 1

SELECT @w_cmd = 'CREATE TABLE ca_sec_no_truncar (sec INT IDENTITY (' + convert(VARCHAR, @w_sec) + ',1), randomico INT)'
EXEC (@w_cmd)
GO

CREATE UNIQUE INDEX idx_ca_sec_no_truncar_1 ON ca_sec_no_truncar (randomico)
GO



