/************************************************************************/
/*      Archivo:                b2c_pr_nom2.sp                          */
/*      Stored procedure:       sp_b2c_pr04_nombre2                     */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Nov/2018                                */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Valida si el segundo nombre del cliente es correcto.            */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    16/Nov/2018           TBA              Emision Inicial            */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_pr04_nombre2')
    drop proc sp_b2c_pr04_nombre2
go

create proc sp_b2c_pr04_nombre2(
@i_cliente       int,
@i_respuesta     varchar(100),
@o_resultado     char(1)      = null output,
@o_msg           varchar(250) = null output
)
as
declare
@w_sp_name            varchar(25),
@w_error              int,
@w_respuesta_correcta varchar(100)

select  @w_sp_name = 'sp_b2c_pr04_nombre2'

select @o_resultado = 'N'

select @w_respuesta_correcta = isnull(LTRIM(RTRIM(upper(p_s_nombre))),'')
from cobis..cl_ente
where en_ente = @i_cliente

if @i_respuesta = @w_respuesta_correcta
    select @o_resultado = 'S'
else 
    select @o_resultado = 'N'

return 0

ERROR:

		
return @w_error

go
