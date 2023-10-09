/************************************************************************/
/*      Archivo:                b2c_pr_postal.sp                        */
/*      Stored procedure:       sp_b2c_pr06_postal                      */
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

if exists (select 1 from sysobjects where name = 'sp_b2c_pr06_postal')
    drop proc sp_b2c_pr06_postal
go

create proc sp_b2c_pr06_postal(
@i_cliente       int,
@i_respuesta     varchar(30),
@o_resultado     char(1) = null output,
@o_msg     varchar(250) = null output
)
as
declare
@w_sp_name            varchar(25),
@w_error              int,
@w_respuesta_correcta varchar(100)

select  @w_sp_name = 'sp_b2c_pr06_postal'

select @o_resultado = 'N'

select top 1 
@w_respuesta_correcta = isnull(di_codpostal,'')
from cobis..cl_ente, cobis..cl_direccion
where en_ente = @i_cliente
and   en_ente = di_ente
and di_tipo != 'CE'
order by di_direccion

if @@rowcount = 0 select @w_respuesta_correcta = ''

if @i_respuesta = @w_respuesta_correcta
    select @o_resultado =  'S'
else 
    select @o_resultado = 'N'

return 0

ERROR:
		
return @w_error

go
