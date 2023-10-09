/************************************************************************/
/*      Archivo:                        cr_envia_correo.sp              */
/*      Stored procedure:               sp_envia_correo                 */
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
/* Realiza el envío de correo electrónico básico                        */
/************************************************************************/
/*                     MODIFICACIONES                                   */
/*   FECHA         AUTOR         RAZON                                  */
/* 23/NOV/2017     PCL			 Emisión inicial 		                */
/************************************************************************/

use cob_credito
go

if exists(select * from sysobjects where name = 'sp_envia_correo')
   drop proc sp_envia_correo
go

create proc sp_envia_correo
(   
   @i_from          varchar(255),
   @i_to            varchar(255),
   @i_cc            varchar(255) = null,
   @i_subject       varchar(510),
   @i_body			VARCHAR(5000),
   @i_attachment    varchar(65) = null --nombre del archivo adjunto
)
as declare 
   @w_sp_name       varchar(30),
   @w_mensaje       varchar(255),
   @w_error         int,
   @w_numerr        int

select @w_sp_name= 'sp_envia_correo'

exec @w_error =  cobis..sp_despacho_ins
        @i_cliente          = 0,
        @i_template         = 0,
        @i_servicio         = 1,
        @i_estado           = 'P',
        @i_tipo             = 'MAIL',
        @i_tipo_mensaje     = 'I',
        @i_prioridad        = 1,
        @i_from             = @i_from,
        @i_to               = @i_to,
        @i_cc               = @i_cc,
        @i_bcc              = NULL,
        @i_subject          = @i_subject,
        @i_body             = @i_body,
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
      @w_mensaje = 'ERROR AL ENVIAR CORREO',
      @w_numerr = @w_error
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

