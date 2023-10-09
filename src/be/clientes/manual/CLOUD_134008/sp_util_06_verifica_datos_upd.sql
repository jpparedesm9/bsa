/********************************************************************************/
/* Archivo:             sp_util_06_verifica_datos_upd.sql                        */
/* Stored procedure:    sp_util_06_verifica_datos_upd                            */
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
/* Este es un fuente auxiliar para el equipo correctivo, debido a que por el    */
/* momento no se puede modificar la respuesta y el resultado el cuestionario en */
/* base el tramite y num cliente.                                               */
/********************************************************************************/
/*                                MODIFICACIONES                                */
/* FECHA         AUTOR      RAZON                                               */
/********************************************************************************/

use cob_externos
go
 
if exists (select 1 from sysobjects where name = 'sp_util_06_verifica_datos_upd')
   drop proc sp_util_06_verifica_datos_upd
go

CREATE proc sp_util_06_verifica_datos_upd
@i_param1   int = null,  --tramite
@i_param2   int = null,  --cliente
@i_param3   varchar(200) = null,  --respuesta
@i_param4   int = null  --calificacion

as declare
@w_sp_name              varchar(64)

select @w_sp_name = 'sp_util_06_verifica_datos_upd'

update cob_credito..cr_verifica_datos
set    vd_resultado = @i_param4,
       vd_respuesta = @i_param3
where  vd_tramite   = @i_param1
and    vd_cliente   = @i_param2

return 0

go
