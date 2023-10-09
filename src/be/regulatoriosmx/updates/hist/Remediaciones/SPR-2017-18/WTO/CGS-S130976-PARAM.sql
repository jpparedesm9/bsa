/*----------------------------------------------------------------------------------------------------------------*/
--Historia                   : CGS-S130976 ENCRIPTACON ARCHIVO ESTADO DE CUENTA
--Descripción del Problema   : creacion de objetos, errores, parametros para la historia
--Responsable                : Walther Toledo
--Ruta TFS                   : En cada seccion
--Nombre Archivo             : En cada seccion
/*----------------------------------------------------------------------------------------------------------------*/

use cobis
go
-- $/COB/Desarrollos/DEV_SaaSMX/ParamMX/sql/parametria_mexico.sql
delete from cl_parametro where pa_nemonico = 'MNBRCD' and pa_producto = 'REC'
insert into cl_parametro(pa_parametro, pa_nemonico, pa_tipo, pa_char,pa_producto)
values('RPT BURO CREDITO - MEMBER CODE','MNBRCD','C','ZZ99990001','REC')
go

-- $/COB/Desarrollos/DEV_SaaSMX/Activas/Cartera/Backend/sql/ca_error.sql
delete from cl_errores where numero = 724675
insert into cl_errores values(724675, 0, 'ERROR AL INSERTAR/ACTUALIZAR DATOS EN LA TABLA CR_ESTADO_CTA_ENVIADO')
go

