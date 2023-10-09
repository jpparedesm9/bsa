/**********************************************************************************************************************/
--No Bug                     : NA
--Título de la Historia      : N/A
--Fecha                      : 21/09/2017
--Descripción del Problema   : Actualizar las cuentas de las operaciones vigentes
--Descripción de la Solución : Actualizar las cuentas de las operaciones vigentes
--Autor                      : Maria Jose Taco
--Instalador                 : 
--Ruta Instalador            : N/A
/**********************************************************************************************************************/

USE cobis
go

UPDATE cob_cartera..ca_operacion
SET op_cuenta = ea_cta_banco
FROM cob_cartera..ca_operacion, cobis..cl_ente_aux 
WHERE op_cuenta IS NULL 
AND op_cliente = ea_ente
AND op_estado= 1
