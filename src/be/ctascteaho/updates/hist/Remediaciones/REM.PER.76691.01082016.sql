/******************************************************/
--Fecha Creaci�n del Script: 2016/Jul/27              */
--Actualizacion Error                                 */
--Modulo :MIS CTA_AHO                                 */
/* pe_pro_final */
use cobis
go

update cobis..cl_errores set mensaje = 'Ya existe el tipo de capitalizaci�n para el producto final' where numero = 351566
go