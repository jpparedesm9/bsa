/**********************************************************************************************************************/
--No Bug                     : NA
--T�tulo de la Historia      : N/A
--Fecha                      : 14/07/2017
--Descripci�n del Problema   : ELIMAR REGISTROS DEL CATALOGO cl_ttelefono
--Descripci�n de la Soluci�n : ELIMAR REGISTROS DEL CATALOGO cl_ttelefono
--Autor                      : PATRICIO SAMUEZA
--INSTALDOR					 :4_sta_catalogo.sql  
--RUTA						 :$/COB/Desarrollos/DEV_SaaSMX/Clientes/Backend/sql
/**********************************************************************************************************************/
USE cobis
GO

DECLARE @w_tabla AS INT
SELECT @w_tabla= codigo FROM cobis..cl_tabla WHERE tabla='cl_ttelefono' --5163

delete cobis..cl_catalogo WHERE tabla=@w_tabla AND codigo NOT IN ('C','D')

GO


