/************************************************************************/
/*      Archivo:                b2c_msgcons.sp                          */
/*      Stored procedure:       sp_b2c_msg_consultar                    */
/*      Base de datos:          cob_bvirtual                            */
/*      Producto:               Cartera                                 */
/*      Disenado por:           TBA                                     */
/*      Fecha de escritura:     Dic/2018                                */
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
/*      Consulta los mensajes pendientes a enviar de un Cliente         */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    05/Dic/2018           TBA              Emision Inicial            */
/*    10/Jul/2019           SMO              Req 118629                 */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_msg_consultar')
    drop proc sp_b2c_msg_consultar
go

create proc sp_b2c_msg_consultar(
@s_ssn          int           = null,
@s_sesn         int           = null,
@s_date         datetime      = null,
@s_user         varchar(14)   = null,
@s_term         varchar(30)   = null,
@s_ofi          int           = null,
@s_srv          varchar(30)   = null,
@s_lsrv         varchar(30)   = null,
@s_rol          int           = null,
@s_org          varchar(15)   = null,
@s_culture      varchar(15)   = null,
@t_show_version bit           = 0,
@t_rty          char(1)       = null,
@t_debug        char(1)       = 'N',
@t_file         varchar(14)   = null,
@t_trn          int           = null,  
@i_cliente      int,
@o_msg          varchar(1000) = null output
)
as
declare
@w_sp_name   varchar(24),
@w_fecha_real datetime,
@w_error            int ,
@w_fecha_proceso    datetime 

select @w_sp_name = 'sp_b2c_msg_consultar'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso 


-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + '1.0.0.0'
   return 0
end



select @w_fecha_real = getdate()
 
update bv_b2c_msg set 
ms_fecha_ven   = dateadd(dd, tm_dias_vigencia,@w_fecha_proceso)
from bv_b2c_tipo_msg
where ms_cliente     = @i_cliente
and   tm_tipo_msg    = ms_tipo_msg
and   ms_fecha_envio is null


if @@error <> 0
begin
   select @w_error = 1890006
   goto ERROR
end

update bv_b2c_msg set 
ms_fecha_envio   = @w_fecha_real
where ms_cliente = @i_cliente
and ms_respuesta is null
and ms_fecha_ven >= @w_fecha_proceso

if @@error <> 0
begin
   select @w_error = 710002
   goto ERROR
end

select 
ms_msg_id,    
ms_texto,
ms_fecha_ven,
ms_trespuesta,
ms_otp,
tm_mostrar_resp,
tm_pos_boton,
tm_neg_boton
from bv_b2c_msg,bv_b2c_tipo_msg
where ms_cliente   = @i_cliente
and ms_fecha_envio = @w_fecha_real
and ms_tipo_msg    = tm_tipo_msg
and ms_respuesta is null

return 0

ERROR:
select @o_msg = mensaje
from cobis..cl_errores 
where numero = @w_error

return @w_error


GO

