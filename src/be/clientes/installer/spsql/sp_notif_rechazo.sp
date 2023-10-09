/************************************************************/
/*   ARCHIVO:         sp_notif_rechazo.sp                   */
/*   NOMBRE LOGICO:   sp_notif_rechazo                      */
/*   PRODUCTO:        COBIS WORKFLOW                        */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*    Envia el correo al oficial en una actividad automática*/
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 15/Junio/2017   VBR                 Emision Inicial      */
/************************************************************/
use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_notif_rechazo')
   drop proc sp_notif_rechazo
go
create proc sp_notif_rechazo
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
         @s_org_err    int         = null,
         @s_error      int         = null,
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
@w_tramite         int,
@w_nombre          varchar(50),
@w_mail_oficial    varchar(30),
@w_cod_alterno     varchar(50),
@w_grupal          char(1),
@w_tmail           varchar(10),
@w_act_correo      char(1) = 'N'

--Bandera para activar o desactivar el envio de correo - 'NOTIFICACION AUTOMATICA - SOLICITUD DE CREDITO'
if exists (select 1 from cobis..cl_catalogo
    where tabla = (select codigo from cobis..cl_tabla where tabla in ('cl_correo_activar'))
	and   codigo = 'NOTAUTSDC'
	and   estado = 'V')
begin
    select @w_act_correo = 'S'
end

if(@w_act_correo = 'N')
begin
	set @o_id_resultado = 1
	return 0
end

/* Obtengo el numero de prestamo*/
select @w_tramite      = io_campo_3
from   cob_workflow..wf_inst_proceso 
where  io_id_inst_proc = @i_id_inst_proc

select @w_grupal = tr_grupal
from cob_credito..cr_tramite
where tr_tramite = @w_tramite

if @w_grupal = 'S'
begin
	select @w_tramite      = io_campo_3,
		   @w_cod_alterno  = io_codigo_alterno,
		   @w_cod_oficial  = tr_oficial,
		   @w_banco        = tg_referencia_grupal
	from   cob_workflow..wf_inst_proceso , cob_credito..cr_tramite  t, cob_credito..cr_tramite_grupal
	where  io_id_inst_proc = @i_id_inst_proc
	and tr_tramite = io_campo_3
	AND tr_tramite = tg_tramite
end
else
begin
	select @w_tramite      = io_campo_3,
		   @w_cod_alterno  = io_codigo_alterno,
		   @w_cod_oficial  = tr_oficial,
		   @w_banco        = op_banco
	from   cob_workflow..wf_inst_proceso , cob_credito..cr_tramite  t, cob_cartera..ca_operacion
	where  io_id_inst_proc = @i_id_inst_proc
	and tr_tramite = io_campo_3
	AND tr_tramite = op_tramite
END

SELECT @w_tmail = pa_char FROM cobis..cl_parametro WHERE pa_nemonico= 'TEMFU' AND pa_producto = 'ADM'

-- CORREO PARA OFICIAL
SELECT TOP 1  @w_mail_oficial = isnull(mf_descripcion, '1'),
    @w_nombre  = fu_nombre
from cobis..cc_oficial, cobis..cl_funcionario, cobis..cl_medios_funcio
where oc_oficial = @w_cod_oficial
and fu_funcionario = oc_funcionario
and fu_funcionario = mf_funcionario
and mf_tipo  = @w_tmail 

select @w_mail_oficial = isnull(@w_mail_oficial, '1')

if @w_mail_oficial <> '1'
begin
    select @w_email_body = '' + @w_nombre + '.<br><br>' +
                           'La solicitud de Crédito No. ' + @w_cod_alterno + ' con Trámite No. ' + convert(varchar,@w_tramite) + ' ' +
                           'correspondiente a la Operación No. ' + @w_banco + ' fue RECHAZADA.<br><br><br>'

    exec cobis..sp_notificacion_general
		@i_operacion    = 'I',
		@i_mensaje      = @w_email_body,
		@i_correo       = @w_mail_oficial,
		@i_asunto       = 'NOTIFICACION AUTOMATICA - SOLICITUD DE CREDITO'
end
else
begin
    print '[DEBUG:] No se encontraron destinatarios para - TRAMITE: '+ convert(VARCHAR(10),@w_tramite) + ' INSTANCIA_PROCESO: ' + convert(VARCHAR(10),@i_id_inst_proc)
end

set @o_id_resultado = 1

return 0

go
