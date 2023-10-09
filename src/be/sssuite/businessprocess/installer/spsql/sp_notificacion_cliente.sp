/************************************************************/
/*   ARCHIVO:         sp_notificacion_cliente.sp            */
/*   NOMBRE LOGICO:   sp_notificacion_cliente               */
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
/*    Envia el correo al cliente en una actividad automática*/
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 05/Enero/2017   VBR                 Emision Inicial      */
/************************************************************/
use cob_workflow
go
if exists (select 1 from sysobjects where name = 'sp_notificacion_cliente')
   drop proc sp_notificacion_cliente
go
create proc sp_notificacion_cliente 
        (@s_ssn        int         = null,
	     @s_ofi        smallint,
	     @s_user       login,
         @s_date       datetime,
	     @s_srv		   varchar(30) = null,
	     @s_term	   descripcion = null,
	     @s_rol		   smallint    = null,
	     @s_lsrv	   varchar(30) = null,
	     @s_sesn	   int 	       = null,
	     @s_org		   char(1)     = NULL,
		 @s_org_err    int 	       = null,
         @s_error      int 	       = null,
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
@w_num_banco       varchar(30),
@w_return          int,
@w_email_body      varchar(1000),
@w_cliente         int,
@w_oficial         smallint,
@w_correos         varchar(255),
@w_tramite         int,
@w_nombre          VARCHAR(50),
@w_apellido        VARCHAR(50),
@w_mail_cliente    VARCHAR(30)


/* Obtengo el numero de prestamo*/
select @w_tramite      = io_campo_3
from   cob_workflow..wf_inst_proceso
where  io_id_inst_proc = @i_id_inst_proc

-- ENVIAR LA NOTIFICACION POR CORREO AL CLIENTE 
SELECT @w_cliente  = en_ente,
       @w_nombre   = en_nombre, 		
       @w_apellido = p_p_apellido + ' '+ p_s_apellido
FROM cob_credito..cr_deudores DEU,  cobis..cl_ente
WHERE de_tramite = @w_tramite
AND de_rol = 'D'
AND de_cliente = en_ente

-- CORREO PARA CLIENTE
select @w_mail_cliente = isnull(di_descripcion, '1')
from cobis..cl_direccion
where di_ente = @w_cliente
and di_tipo  = (select B.codigo from cobis..cl_tabla A, cobis..cl_catalogo B where A.tabla = 'cl_tdireccion' 
                and B.tabla = A.codigo and B.valor like '%MAIL%')

if @w_mail_cliente <> '1'
begin
    select @w_email_body = 'Estimado(a) Sr(a).:'+' '+ @w_nombre +' '+ @w_apellido + char(13) + char(13) +
                           'Su solicitud de Crédito fue aprobada, por favor acercarse para el desembolso.' + char(13) + char(13) + char(13) +
                           'Saludos Cordiales'

    exec cobis..sp_despacho_ins @s_ssn = @s_ssn, @s_user = @s_user, @s_sesn = @s_sesn, @s_term = @s_term, @s_date = @s_date, @s_srv = @s_srv, @s_ofi = @s_ofi,
                                @i_template=0, @i_servicio = 1, @i_tipo_mensaje = 'I', @i_prioridad = 1, @i_bcc = null, @i_fecha_envio = null, @i_hora_ini = null, @i_hora_fin = null,
                                @i_tipo = 'MAIL', @i_content_manager = 'TEXT', @i_estado = 'P', @i_retry = 'S', @i_max_tries = 3,
                                @i_cliente = @w_cliente, @i_to = @w_mail_cliente, @i_body = @w_email_body, @i_subject = 'NOTIFICACION AUTOMATICA - SOLICITUD DE CREDITO'
end
else
begin
    print '[DEBUG:] No se encontraron destinatarios para - TRAMITE: '+ convert(VARCHAR(10),@w_tramite) + ' INSTANCIA_PROCESO: ' + convert(VARCHAR(10),@i_id_inst_proc)
end

set @o_id_resultado = 1

return 0

go
