/***********************************************************************************************************/
---No Bug					: 
---Título del Bug			: 
---Fecha					: 08/15/2016 
--Descripción del Problema	: Bug 81325:Bug : Relación en Perfiles Contables
--Descripción de la Solución: Remediación de Historia
--Autor						: Juan Tagle
/***********************************************************************************************************/

-- re_datosini.sql

use cobis
go

DECLARE @w_sec INT
SELECT @w_sec = max(tp_secuencial)+1 from cob_remesas..re_trn_perfil
UPDATE cobis..cl_seqnos
SET
siguiente = @w_sec
WHERE tabla = 're_trn_perfil'

go