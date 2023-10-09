/********************************************************************************/
/* Archivo:             sp_util_05_del_mod_curp_rfc.sp                          */
/* Stored procedure:    sp_util_05_del_mod_curp_rfc                             */
/* Base de datos:       cob_externos                                            */
/* Producto:            Clientes                                                */
/* Disenado por:        ACH                                                     */
/* Fecha de escritura:  29/Ene/2020.                                            */
/********************************************************************************/
/*                                 IMPORTANTE                                   */
/* Este programa es parte de los paquetes bancarios propiedad de COBISCorp.     */
/* Su uso no autorizado queda expresamente prohibido asi como cualquier         */
/* alteracion o agregado hecho por alguno de usuarios sin el debido             */
/* consentimiento por escrito de la Presidencia Ejecutiva de COBISCorp          */
/* o su representante.                                                          */
/********************************************************************************/
/*                                PROPOSITO                                     */
/* Este es un fuente auxiliar para el equipo correctivo, tiene por objetivo     */ 
/* eliminar los datos de la tabla 'cl_modificacion_curp_rfc' que ya no son utiles*/
/* para detectar donde cambia la informacion                                     */
/********************************************************************************/
/*                                MODIFICACIONES                                */
/* FECHA         AUTOR      RAZON                                               */
/********************************************************************************/

use cob_externos
go
 
if exists (select 1 from sysobjects where name = 'sp_util_05_del_mod_curp_rfc')
   drop proc sp_util_05_del_mod_curp_rfc
go

CREATE proc sp_util_05_del_mod_curp_rfc
@i_param1   datetime = null --fecha para eliminar

as declare
@w_sp_name              varchar(64)

select @w_sp_name = 'sp_util_05_del_mod_curp_rfc'

delete cobis..cl_modificacion_curp_rfc
where mcr_fecha < @i_param1

return 0

go
