/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : N/A
--Fecha                      : 13/10/2017
--Descripci�n del Problema   : Crear codigo de error
--Descripci�n de la Soluci�n : Crear codigo de error
--Autor                      : MARIA JOSE TACO
/**********************************************************************************************************************/

use cobis
go

delete cl_errores where numero = 70011016
go

INSERT INTO cobis..cl_errores (numero, severidad, mensaje) VALUES(70011016,0,'Error: No se puede crear una solicitud de un grupo con solicitud previa rechazada')

GO