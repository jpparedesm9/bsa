delete from cobis..cl_errores where numero in (109006,109007,109008)

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(109006,0,'El Código Santander ya se encuentra registrado')

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(109007,0,'La cuenta ya se encuentra registrada')

INSERT INTO cobis..cl_errores (numero,severidad,mensaje) 
VALUES(109008,0,'Ingresar solo números para la Cuenta y el Código Santander')
go
