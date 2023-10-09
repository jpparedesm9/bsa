/*************************************************/
-- No Bug: Historia UDIS
-- Título de la Historia: Mantenimiento de los UDIs
-- Fecha: 01/Sept/2016
-- Descripción del la Historia: 
-- Descripción de la Solución: Se inserta los errores no registrados
-- Autor: Walther Toledo
/*************************************************/
use cobis
go
--> /Ahorros/ah_error.sql
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111020, 1, 'ERROR EN PARAMETRO DE MAYORIA DE EDAD')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111021, 1, 'ERROR EN PARAMETRO DE PROXIMIDAD MAYORIA DE EDAD')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111022, 1, 'ERROR EN PARAMETRO PRODUCTO BANCARIO MAYORIA DE EDAD')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111023, 1, 'ERROR EN PARAMETRO CONVERSION UDIs')
go
INSERT INTO cl_errores (numero, severidad, mensaje) VALUES (111024, 1, 'ERROR EN PARAMETRO SALDO MAXIMO DISPONIBLE EN UDIs')
go


DECLARE @w_id_moneda tinyint
--> /ahorros/ah_datosini.sql
SELECT @w_id_moneda = mo_moneda 
  FROM cobis..cl_moneda 
 WHERE mo_nemonico='UDI'

INSERT INTO cob_conta..cb_cotizacion (ct_moneda, ct_fecha, ct_valor, ct_compra, ct_venta, ct_factor1, ct_factor2)
VALUES (@w_id_moneda, getdate(), 1, 1, 1, 5.42305400, 1)

go

