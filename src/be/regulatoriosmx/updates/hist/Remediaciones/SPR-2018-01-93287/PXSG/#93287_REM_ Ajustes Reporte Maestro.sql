--Archivo de remediacion 
USE cobis
GO
DECLARE
@w_codigo1 INT,
@w_codigo2 INT,
@w_codigo3 INT

SELECT @w_codigo1=count(ac_codigo) FROM cobis..cl_actividad_ec WHERE ac_codigo = 6132047
SELECT @w_codigo2=count(ac_codigo) FROM cobis..cl_actividad_ec WHERE ac_codigo = 6231021
SELECT @w_codigo3=count(ac_codigo) FROM cobis..cl_actividad_ec WHERE ac_codigo = 6325030
---
IF(@w_codigo1>1)
BEGIN
DELETE TOP (1) cobis..cl_actividad_ec WHERE ac_codigo = 6132047
END
  
IF(@w_codigo2>1)
BEGIN
DELETE TOP (1) cobis..cl_actividad_ec WHERE ac_codigo = 6231021
END

IF(@w_codigo3>1)
BEGIN
DELETE TOP (1) cobis..cl_actividad_ec WHERE ac_codigo = 6325030
END


