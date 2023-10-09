/*************************************************************************/
/*   Archivo:              REM_161141_ca_catalogos_LCR_fase2.sql         */
/*   Stored procedure:     REM_161141_ca_catalogos_LCR_fase2.sql         */
/*   Base de datos:        cobis		                               	 */
/*   Producto:             cartera                                  	 */
/*   Disenado por:         wcg                                           */
/*   Fecha de escritura:   Julio 2021                                  	 */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                                   PROPOSITO                           */
/*   	Script para la creacion de catalogos para el caso #107888        */
/*                              CAMBIOS                                  */
/*************************************************************************/
/*                             MODIFICACION                              */
/*    FECHA                 AUTOR                 RAZON                  */
/*    28/Julio/2021         Wismark Castro        Emision inicial        */
/*                                                                       */
/*************************************************************************/
use cobis
go

------------------------------------------------
-- catalogo ca_periodicidad_lcr_rl
------------------------------------------------
delete from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='ca_periodicidad_lcr_rl')
delete from cl_tabla where tabla ='ca_periodicidad_lcr_rl'

go
 
declare @w_id_catalogo int
 
select @w_id_catalogo = max(codigo) + 1 from cl_tabla
 
insert into cl_tabla (codigo, tabla, descripcion) 
values (@w_id_catalogo, 'ca_periodicidad_lcr_rl', ' Tabla ca_periodicidad_lcr_rl')

 
insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'BW', 'CATORCENAL', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'M', 'MENSUAL', 'V', NULL, NULL, NULL)

insert into cl_catalogo (tabla, codigo, valor, estado, culture, equiv_code, type) 
values (@w_id_catalogo, 'W', 'SEMANAL', 'V', NULL, NULL, NULL)

GO

------------------------------------------------
-- Actualización catalogo para regla
------------------------------------------------
use cob_workflow
go

UPDATE cob_workflow..wf_variable SET vb_catalogo = 'ca_periodicidad_lcr_rl'
WHERE vb_nombre_variable = 'Periodicidad LCR'

GO
