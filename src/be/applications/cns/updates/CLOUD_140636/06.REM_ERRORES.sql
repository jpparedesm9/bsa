use cobis
GO

delete cobis..cl_errores where numero = 70011018
INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(70011018,1,'Error: No existe plantilla para envío de sms.')
GO