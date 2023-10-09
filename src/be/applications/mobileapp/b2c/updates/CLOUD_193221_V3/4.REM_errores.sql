
-- CLOUD_191122_707383_vulnerabilidades\src\be\applications\mobileapp\b2c\updates\CLOUD_191122_688882\04.REM_ERRORES.sql
-- 1890020	0	El cliente no tiene operaciones activas
use cobis
go

select * from cobis..cl_errores where numero in (1890020,1890021,1890022,1890023,1890024,1890025)

delete from cobis..cl_errores where numero in (1890020,1890021,1890022,1890023,1890024,1890025)

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(1890020,0,'ERROR: El número de celular ya se encuentra registrado para este proceso')
GO

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(1890021,0,'ERROR: No se pueden registrar los datos')
GO

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(1890022,0,'ERROR: No se puede enviar el código OTP')
GO

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(1890023,0,'ERROR: Tipo de envío no es admitido')
GO

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(1890024,0,'ERROR: El codigo OTP no existe')
GO

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(1890025,0,'ERROR: EL codigo OTP ha caducado')
GO

select * from cobis..cl_errores where numero in (1890020,1890021,1890022,1890023,1890024,1890025)

go


delete from cl_errores where numero = 70011019
insert into cl_errores values (70011019, 0, 'El número celular capturado ya existe, por favor ingrese uno nuevo')
go
