/************************************************************************/
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               B2C                                     */
/*      Disenado por:           DFu                                     */
/*      archivo:                b2c_pr07nac.sp                          */
/*      Fecha de escritura:     15/11/2018                              */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'MACOSA'.                                                       */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de MACOSA o su representante.             */
/************************************************************************/  
/*                         PROPOSITO                                    */
/*      Valida las respuesta del cliente a la pregunta: "Diga la fecha  */
/*      de su cumpleaños".                                              */
/*                        MOFICIACIONES                                 */
/* 15/11/2018         DFU                  Emision inicial              */
/************************************************************************/  
use cob_bvirtual
go

IF OBJECT_ID ('dbo.sp_b2c_pr07_nacimiento') IS NOT NULL
    DROP PROCEDURE dbo.sp_b2c_pr07_nacimiento
GO

create proc sp_b2c_pr07_nacimiento
(
@i_cliente       int,
@i_respuesta     varchar(255),
@o_msg           varchar(255) = null OUT,
@o_resultado     char(1) = 'N' OUT
)
as 

declare 
@w_error              int,
@w_sp_name            varchar(30),
@w_respuesta_correcta varchar(10)

select @w_sp_name  = 'sp_b2c_pr07_nacimiento'

select @w_respuesta_correcta = convert(varchar(10),p_fecha_nac,101) 
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


