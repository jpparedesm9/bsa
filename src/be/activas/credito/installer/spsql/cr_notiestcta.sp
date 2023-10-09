/************************************************************************/
/*      Archivo:                        cr_notiestcta.sp                */
/*      Stored procedure:               sp_notifica_estado_cta          */
/*      Base de Datos:                  cob_credito                     */
/*      Producto:                       Credito                         */
/************************************************************************/
/*                      IMPORTANTE                                      */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.    Su uso no  autorizado dara  derecho a    COBISCorp para */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*                      PROPOSITO                                       */
/* Realiza el envio de notificacion de los estado de cuenta a los       */
/* clientes del banco                                                   */
/************************************************************************/
/*                     MODIFICACIONES                                   */
/*   FECHA         AUTOR         RAZON                                  */
/* 31/AGO/2017     WToledo			Emision inicial 		                  */
/************************************************************************/

use cob_credito
go

if exists(select * from sysobjects where name = 'sp_notifica_estado_cta')
   drop proc sp_notifica_estado_cta
go

create proc sp_notifica_estado_cta(   
   @i_to            varchar(255),        --mail
   @i_cc            varchar(255) = null,
   @i_bcc           varchar(255) = null,
   @i_subject       varchar(510) = null,
   @i_cliente       int,                 --codigo cliente
   @i_nombre        varchar(255) = null, --nombre de cliente
   @i_attachment    varchar(65)  = null, --nombre del archivo adjunto
   @i_tipo_notific  varchar(10)
)
as declare 
   @w_sp_name       varchar(30),
   @w_body          varchar(2000),
   @w_error         int,
   @w_text_mail     varchar(255),
   @w_from          varchar(60),
   @w_fecha_hoy     varchar(10),
   @w_fecha         datetime,
   @w_mensaje       varchar(255),
   @w_password      varchar(30),
   @w_numerr        int

select @w_sp_name= 'sp_notifica_estado_cta'
select @w_fecha = getdate();

if @i_to is null or @i_to = ''
begin
    select  @w_mensaje = 'ERROR: CLIENTE NO TIENE CORREO DE NOTIFICACION',
            @w_error = 724622
    goto ERROR  
end

select @w_from = isnull(pa_char,50) 
from cobis..cl_parametro 
where pa_nemonico = 'MANO' 
and pa_producto = 'REC'

select @w_password = pa_char
from cobis..cl_parametro
where pa_producto = 'CRE'
and pa_nemonico = 'PWDEEC'

select @w_body = 'Estimado(a) Señor(a).' + char(13) + @i_nombre + char(13) + char(13)

if @i_tipo_notific = 'EEC_NOTIF'
begin
   select @w_body = @w_body + 'Adjunto el archivo ' + isnull(@i_attachment,'') + ' con su estado de cuenta.' +  char(13) + char(13) + 'Saludos.'
end
else if (@i_tipo_notific = 'EEC_PSSWD')
begin
   select @w_body = @w_body + 'Acontinuación la contraseña para los archivos codificados: ' + char(13)
   select @w_body = @w_body + '---> ' + @w_password + char(13) + char(13) + 'Saludos.'
end
else
begin
   select @w_body = ''
end

exec @w_error =  cobis..sp_despacho_ins
        @i_cliente          = @i_cliente,
        @i_template         = 0,
        @i_servicio         = 1,
        @i_estado           = 'P',
        @i_tipo             = 'MAIL',
        @i_tipo_mensaje     = 'I',
        @i_prioridad        = 1,
        @i_from             = @w_from,
        @i_to               = @i_to,
        @i_cc               = @i_cc,
        @i_bcc              = @i_bcc,
        @i_subject          = @i_subject,
        @i_body             = @w_body,
        @i_content_manager  = 'TEXT',
        @i_retry            = 'S',
        @i_fecha_envio      = null,
        @i_hora_ini         = null,
        @i_hora_fin         = null,
        @i_tries            = 0,
        @i_max_tries        = 2,
        @i_var1             = @i_attachment
if @w_error <> 0
begin
    select 
      @w_numerr = 2101149,
      @w_mensaje = 'ERROR AL ENVIAR NOTIFICACION'
    goto ERROR
end

exec @w_error = sp_actualiza_est_cta_env
      @i_operacion = 'D',
      @i_cliente   = @i_cliente
if @w_error <> 0
begin
    select 
      @w_numerr = 2101140,
      @w_mensaje = 'ERROR AL ACTUALIZAR LA NOTIFICACION'
    goto ERROR
end

return 0

ERROR:
exec cobis..sp_cerror
   @t_debug	= 'N', 
   @t_file	= '',
   @t_from  = @w_sp_name,
   @i_num	= @w_numerr,
   @i_msg	= @w_mensaje
return @w_error 

go

