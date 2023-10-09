/************************************************************************/
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               B2C                                     */
/*      Disenado por:           DFu                                     */
/*      archivo:                b2c_pr05cel.sp                          */
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
/*      Valida  las respuesta del cliente a la pregunta: "Diga las tres */
/*      ultimas cifras de su telefono celular"                         */
/*                        MOFICIACIONES                                 */
/* 15/11/2018         DFU                  Emision inicial              */
/************************************************************************/  
use cob_bvirtual
go

IF OBJECT_ID ('dbo.sp_b2c_pr05_celular') IS NOT NULL
    DROP PROCEDURE dbo.sp_b2c_pr05_celular
GO

create proc sp_b2c_pr05_celular
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
@w_telefono           varchar(16),
@w_respuesta_correcta varchar(3),
@w_posini             smallint

select @w_sp_name  = 'sp_b2c_pr05_celular'

select top 1 
@w_telefono = te_valor
from cobis..cl_telefono  
where te_ente        = @i_cliente  
and te_tipo_telefono = 'C' 
order by te_direccion, te_secuencial

if @@rowcount = 0 begin
   select @w_respuesta_correcta = ''
end else begin
select @w_posini = len(@w_telefono) - 2
select @w_respuesta_correcta = substring(@w_telefono, @w_posini, 3)
end

if @i_respuesta = @w_respuesta_correcta 
   select @o_resultado = 'S'
else 
   select @o_resultado = 'N'

return 0

ERROR:

return @w_error

go


