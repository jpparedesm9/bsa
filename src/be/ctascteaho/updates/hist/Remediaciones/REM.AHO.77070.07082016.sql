/******************************************************/
--Fecha Creación del Script: 2016/07/08               */
--Insertar Error         autorizadas 351092           */
--Modulo : AHORROS                                    */
/******************************************************/
use cobis
go
-- ---------------------------------------------------------------------------------------------------------

if exists ( SELECT 1 FROM cl_errores WHERE numero = 351092)
begin

DELETE FROM cl_errores
WHERE numero = 351092 

end

INSERT INTO cl_errores (numero, severidad, mensaje)
VALUES (351092, 0, 'NO EXISTEN CARTAS REMESAS INGRESADAS HOY')
GO
