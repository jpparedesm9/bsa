/************************************************************************/
/*      Archivo:                b2c_pr_rfc.sp                           */
/*      Stored procedure:       sp_b2c_pr02_rfc                         */
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
/*      Genera preguntas de verificacion para recuperacion de clave    */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    16/Nov/2018           TBA              Emision Inicial            */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_pr02_rfc')
    drop proc sp_b2c_pr02_rfc
go

create proc sp_b2c_pr02_rfc(
@i_cliente   int,
@i_respuesta varchar(30),
@o_resultado char(1)      = null output,
@o_msg       varchar(250) = null output

)
as
declare
@w_sp_name            varchar(25),
@w_error              int,
@w_respuesta_correcta varchar(100),
@w_rfc                varchar(30),
@w_msg                varchar(200)

select  @w_sp_name = 'sp_b2c_pr02_rfc'

select @o_resultado = 'N'

select 
@w_respuesta_correcta = substring(en_rfc, 1, 10)
from cobis..cl_ente
where en_ente = @i_cliente

if @@error <> 0 or @w_respuesta_correcta is null begin
   select 
   @w_error = 70123,
   @w_msg = 'ERROR AL OBTENER RFC SIN HOMOCLAVE'
   goto ERROR
end


if @i_respuesta = @w_respuesta_correcta
    select @o_resultado = 'S'
else 
    select @o_resultado = 'N'

return 0

ERROR:
	
select 
@o_msg       = @w_msg

return @w_error

go
