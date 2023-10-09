/***********************************************************************************************************/

---Fecha					: 13/10/2016 
--Descripción               : script para BUG 87116
--Descripción de la Solución: se crea script de remediación
--Autor						: Ignacio Yupa
/***********************************************************************************************************/

--ELIMINACION DE DATOS 

delete cob_conta..cb_cuenta_proceso WHERE cp_proceso=6004
go


--Cambio de tipo de dato a la tabla cco_error_conaut
use cob_ccontable
go

ALTER TABLE cco_error_conaut ALTER COLUMN ec_mensaje varchar(255)
go