/************************************************************************/
/*      Archivo:                b2c_msging.sp                          */
/*      Stored procedure:       sp_b2c_msg_ingresar                     */
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
/*      Ingresa la información de un mensaje de texto de un Cliente     */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    05/Dic/2018           TBA              Emision Inicial            */
/*    02/Jul/2019           SMO              Req 118629                 */
/*    10/Jul/2019           SMO              Req 118629                 */
/************************************************************************/

use cob_bvirtual
go

if exists (select 1 from sysobjects where name = 'sp_b2c_msg_ingresar')
    drop proc sp_b2c_msg_ingresar
go

create proc sp_b2c_msg_ingresar(
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
@i_cliente      int,                      --Titular o deudor principal de la cuenta o préstamo
@i_banco        cuenta,                   --Numero de la cuenta o prestamo sobre el cual aplica el mensaje
@i_tipo_msg     catalogo,                 --Es el id del campo tm_tipo_msg en la tabla bv_b2c_tipo_msg
@i_var1         varchar(64)  = null,      --Texto que reemplazará la cadena [VAR1] en el mensaje
@i_var2         varchar(64)  = null,      --Texto que reemplazará la cadena [VAR2] en el mensaje
@i_var3         varchar(64)  = null,      --Texto que reemplazará la cadena [VAR3] en el mensaje
@i_var4         varchar(64)  = null,      --Texto que reemplazará la cadena [VAR4] en el mensaje
@i_var5         varchar(64)  = null,      --Texto que reemplazará la cadena [VAR5] en el mensaje
@o_msg          varchar(200) = null output
)
as
declare
@w_fecha_hoy   datetime,
@w_texto_base  varchar(1000),
@w_tipo_resp   catalogo,
@w_otp         char(1),
@w_texto_final varchar(1000),
@w_error       int,
@w_sp_name     varchar(24)

select @w_sp_name = 'sp_b2c_msg_ingresar'

-- Mostrar la version del programa
if @t_show_version = 1
begin
   print 'Stored procedure = ' + @w_sp_name + '1.0.0.0'
   return 0
end


if not exists (select 1 from cobis..cl_ente where en_ente = @i_cliente) begin
   select @w_error = 1890009
   goto ERROR
end

select @w_fecha_hoy = getdate()

select 
@w_texto_base = tm_texto_base,
@w_tipo_resp  = tm_trespuesta,
@w_otp        = tm_otp
from cob_bvirtual..bv_b2c_tipo_msg
where tm_tipo_msg = @i_tipo_msg

select @w_texto_final = @w_texto_base 

select @w_texto_final = replace(@w_texto_final, '[VAR1]', isnull(@i_var1,''))
select @w_texto_final = replace(@w_texto_final, '[VAR2]', isnull(@i_var2,''))
select @w_texto_final = replace(@w_texto_final, '[VAR3]', isnull(@i_var3,''))
select @w_texto_final = replace(@w_texto_final, '[VAR4]', isnull(@i_var4,''))
select @w_texto_final = replace(@w_texto_final, '[VAR5]', isnull(@i_var5,''))

delete bv_b2c_msg
where ms_cliente  = @i_cliente
and   ms_tipo_msg = @i_tipo_msg --ms_texto = @w_texto_final
and   ms_respuesta is null
and   ms_tipo_msg <> 'EROR_DES'

insert bv_b2c_msg (
ms_cliente,    ms_banco,       ms_tipo_msg,    
ms_texto,      ms_fecha_ing,   ms_trespuesta,  
ms_otp,        ms_var1,        ms_var2,        
ms_var3,       ms_var4,        ms_var5
)
values(
@i_cliente,     @i_banco,     @i_tipo_msg,  
@w_texto_final, @w_fecha_hoy, @w_tipo_resp, 
@w_otp,         @i_var1,      @i_var2,      
@i_var3,        @i_var4,      @i_var5
)

if @@error <> 0
begin
   select @w_error = 1890001
   goto ERROR
end
          
return 0		  

ERROR:

select @o_msg = mensaje
from cobis..cl_errores 
where numero = @w_error

return @w_error

go

