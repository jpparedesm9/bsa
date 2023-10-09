/************************************************************************/
/*  Archivo:                sp_notif_otorgamiento.sp                    */
/*  Stored procedure:       sp_notif_otorgamiento                       */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Sonia Rojas                                 */
/*  Fecha de Documentacion: 27/09/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Esta aplicacion es parte de los paquetes bancarios propiedad        */
/*  de COBISCorp.                                                       */
/*  Su uso no    autorizado queda  expresamente   prohibido asi como    */
/*  cualquier    alteracion o  agregado  hecho por    alguno  de sus    */
/*  usuarios sin el debido consentimiento por   escrito de COBISCorp.   */
/*  Este programa esta protegido por la ley de   derechos de autor      */
/*  y por las    convenciones  internacionales   de  propiedad inte-    */
/*  lectual.   Su uso no  autorizado dara  derecho a    COBISCorp para  */
/*  obtener ordenes  de secuestro o  retencion y para  perseguir        */
/*  penalmente a los autores de cualquier   infraccion.                 */
/************************************************************************/
/*          PROPOSITO                                                   */
/*  Ejecuta el envio de la notificacion de rechazo tipo 1 al cliente    */
/*  con copia al asesor                                                 */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                   RAZON                         */
/* 27/09/2019     SRO                 Emision Inicial                   */
/************************************************************************/
use 
cob_credito
go

IF OBJECT_ID ('dbo.sp_notif_otorgamiento') IS NOT NULL
	DROP PROCEDURE dbo.sp_notif_otorgamiento
GO

create proc sp_notif_otorgamiento(
    @s_ssn        int         = null,
    @s_ofi        smallint,
    @s_user       login,
    @s_date       datetime,
    @s_srv        varchar(30) = null,
    @s_term       descripcion = null,
    @s_rol        smallint    = null,
    @s_lsrv       varchar(30) = null,
    @s_sesn       int         = null,
    @s_org        char(1)     = NULL,
    @s_org_err   int         = null,
    @s_error            int         = null,
    @s_sev        tinyint     = null,
    @s_msg        descripcion = null,
    @t_rty        char(1)     = null,
    @t_trn        int         = null,
    @t_debug      char(1)     = 'N',
    @t_file       varchar(14) = null,
    @t_from       varchar(30)  = null,
    --variables
    @i_id_inst_proc int,    --codigo de instancia del proceso
    @i_id_inst_act  int,
    @i_id_empresa   int,
    @o_id_resultado  smallint  out
)as

declare
@w_banco           varchar(30),
@w_return          int,
@w_email_body      varchar(1000),
@w_cod_oficial     smallint,
@w_cod_cliente     int,
@w_tramite         int,
@w_id              int,
@w_nombre          varchar(50),
@w_mail_oficial    varchar(30),
@w_mail_cliente    varchar(30),
@w_cod_alterno     varchar(50),
@w_grupal          char(1),
@w_tmail           varchar(10),
@w_error           int,
@w_msg             varchar(200),
@w_nombre_template varchar(30)

/* Obtengo el numero de prestamo*/
select @w_cod_cliente  = io_campo_1,
       @w_tramite      = io_campo_3
from   cob_workflow..wf_inst_proceso
where  io_id_inst_proc = @i_id_inst_proc

SELECT @w_tmail = pa_char FROM cobis..cl_parametro WHERE pa_nemonico= 'TEMFU' AND pa_producto = 'ADM'

-- CORREO PARA EL CLIENTE 
select  top 1 @w_mail_cliente = isnull(di_descripcion, '1')
from cobis..cl_direccion
where di_ente    = @w_cod_cliente
and   di_tipo    = 'CE'

select @w_cod_oficial = ea_asesor_ext
from cobis..cl_ente_aux
where ea_ente = @w_cod_cliente

-- CORREO PARA OFICIAL
SELECT TOP 1 @w_mail_oficial = isnull(mf_descripcion, '1'),
             @w_nombre       = fu_nombre
from cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_medios_funcio
where oc_oficial     = @w_cod_oficial
and   fu_funcionario = oc_funcionario
and   fu_funcionario = mf_funcionario
and   mf_tipo        = @w_tmail 

--@w_nombre_template

if (@w_mail_cliente is not null or rtrim(ltrim(@w_mail_cliente)) <> '') 
begin
   if (@w_mail_oficial is null or rtrim(ltrim(@w_mail_oficial)) = '')
      select @w_mail_oficial = pa_char from cobis..cl_parametro where pa_nemonico = 'CPDSAN'
       
    -- seccion template  - busqueda del codigo del template asociado
   select @w_id = te_id 
   from cobis..ns_template
   where te_nombre = 'NotifOtorgamiento.xslt'
  
   
   -- creacion xml con el buc que tiene relacion con el template
   select @w_email_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data></data>'
   
   -- Ejecucion del sp para las notificaciones y envio de mail
   exec @w_error =  cobis..sp_despacho_ins
        @i_cliente          = @w_cod_cliente,
        @i_template         = @w_id,
        @i_servicio         = 1,
        @i_estado           = 'P',
        @i_tipo             = 'MAIL',
        @i_tipo_mensaje     = 'I',
        @i_prioridad        = 1,
        @i_from             = null,
        @i_to               = @w_mail_cliente,
        @i_cc               = @w_mail_oficial,
        @i_bcc              = null,
        @i_subject          = 'NOTIFICACION AUTOMATICA - Solicitud Aprobada',
        @i_body             = @w_email_body,
        @i_content_manager  = 'HTML',
        @i_retry            = 'S',
        @i_fecha_envio      = null,
        @i_hora_ini         = null,
        @i_hora_fin         = null,
        @i_tries            = 0,
        @i_max_tries        = 2,
        @i_var1             = null	
     
       if @w_error <> 0
       begin
          select 
          @w_msg = 'ERROR AL ENVIAR NOTIFICACION DEL CLIENTE '+convert(varchar(100),@w_cod_cliente),
          @w_error = 5000
          goto ERROR
       end
   	
   	
end
else
begin
    print '[DEBUG:] No se encontraron destinatarios para - TRAMITE: '+ convert(VARCHAR(10),@w_tramite) + ' INSTANCIA_PROCESO: ' + convert(VARCHAR(10),@i_id_inst_proc)
end

set @o_id_resultado = 1

return 0

ERROR:
print 'ERROR A INSERTAR>> '+convert(varchar(10),@w_error)+' mensaje>>'+@w_msg
return @w_error

GO

