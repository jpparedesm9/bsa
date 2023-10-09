/************************************************************************/
/*  Archivo:                sp_notif_rechazo_1.sp                       */
/*  Stored procedure:       sp_notif_rechazo_1                          */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Nathali Mejia                               */
/*  Fecha de Documentacion: 21/Ago/2019                                 */
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
/*21/Ago/2019    N. Mejia            Emision Inicial                    */
/************************************************************************/
use cob_credito
go

IF OBJECT_ID ('dbo.sp_notif_rechazo_1') IS NOT NULL
	DROP PROCEDURE dbo.sp_notif_rechazo_1
GO

create proc sp_notif_rechazo_1
        (@s_ssn        int         = null,
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
@w_banco              varchar(30),
@w_return             int,
@w_email_body         varchar(1000),
@w_cod_oficial        smallint,
@w_cod_cliente        int,
@w_tramite            int,
@w_id                 int,
@w_nombre             varchar(50),
@w_mail_oficial       varchar(30),
@w_mail_cliente       varchar(30),
@w_cod_alterno        varchar(50),
@w_grupal             char(1),
@w_tmail              varchar(10),
@w_error              int,
@w_msg                varchar(200),
@w_nombre_template    varchar(30),
@w_nombre_act         varchar(30),
@w_id_inst_act_parent int


/* Obtengo el numero de prestamo*/
select 
@w_cod_cliente  = io_campo_1,
@w_tramite      = io_campo_3
from   cob_workflow..wf_inst_proceso 
where  io_id_inst_proc = @i_id_inst_proc

select @w_grupal = tr_grupal
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

if @w_grupal = 'S'
begin
	/* Obtengo el numero de prestamo*/
	select @w_cod_oficial  = tr_oficial,
	       @w_banco        = tg_referencia_grupal
	from   cob_credito..cr_tramite  t, cob_credito..cr_tramite_grupal
	where  tr_tramite  = tg_tramite
	and    tg_tramite  = @w_tramite
end
else
begin
	select @w_cod_oficial  = tr_oficial
	from   cob_credito..cr_tramite  t
	where  tr_tramite = @w_tramite
	
end

SELECT @w_tmail = pa_char FROM cobis..cl_parametro WHERE pa_nemonico= 'TEMFU' AND pa_producto = 'ADM'

-- CORREO PARA EL CLIENTE 
select  top 1 @w_mail_cliente = isnull(di_descripcion, '1')
from cobis..cl_direccion
where di_ente = @w_cod_cliente
and di_tipo   = 'CE'

-- CORREO PARA OFICIAL
SELECT TOP 1 @w_mail_oficial = isnull(mf_descripcion, '1'),
             @w_nombre       = fu_nombre
from cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_medios_funcio
where oc_oficial             = @w_cod_oficial
and fu_funcionario           = oc_funcionario
and fu_funcionario           = mf_funcionario
and mf_tipo                  = @w_tmail 

--@w_nombre_template
select @w_id_inst_act_parent = id_inst_act_parent
from cob_workflow..wf_inst_actividad
where ia_id_inst_proc        = @i_id_inst_proc

select @w_nombre_act = ia_nombre_act
from cob_workflow..wf_inst_actividad 
where ia_id_inst_act = @w_id_inst_act_parent

if (@w_nombre_act = (select pa_char from cobis..cl_parametro where pa_nemonico = 'ETACCB' and pa_producto = 'CRE')) begin
   select @w_nombre_template = 'NotifRechazoTipo1.xslt'
end 
else if (@w_nombre_act = (select pa_char from cobis..cl_parametro where pa_nemonico = 'ETABLN' and pa_producto = 'CRE')) or 
        (@w_nombre_act = (select pa_char from cobis..cl_parametro where pa_nemonico = 'ETACRL' and pa_producto = 'CRE')) begin
   select @w_nombre_template = 'NotifRechazoTipo2.xslt'
end
else if (@w_nombre_act = (select pa_char from cobis..cl_parametro where pa_nemonico = 'ETAVDA' and pa_producto = 'CRE')) begin
   select @w_nombre_template = 'NotifRechazoTipo3.xslt'
end

if (@w_mail_cliente is not null or rtrim(ltrim(@w_mail_cliente)) <> '') 
begin
   if (@w_mail_oficial is null or rtrim(ltrim(@w_mail_oficial)) = '')
      select @w_mail_oficial = pa_char from cobis..cl_parametro where pa_nemonico = 'CPDSAN'
       
    -- seccion template  - busqueda del codigo del template asociado
   select @w_id = te_id 
   from cobis..ns_template
   where te_nombre = @w_nombre_template

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
        @i_subject          = 'NOTIFICACION AUTOMATICA - Solicitud Declinada',
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
          select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DEL CLIENTE '+convert(varchar(100),@w_cod_cliente),
   	             @w_error = 5000
          goto ERROR1
       end
   	
   	ERROR1:
       print 'ERROR A INSERTAR>> '+convert(varchar(10),@w_error)+' mensaje>>'+@w_msg	
end
else
begin
    print '[DEBUG:] No se encontraron destinatarios para - TRAMITE: '+ convert(VARCHAR(10),@w_tramite) + ' INSTANCIA_PROCESO: ' + convert(VARCHAR(10),@i_id_inst_proc)
end

set @o_id_resultado = 1

return 0


GO

