/************************************************************************/
/*      Archivo:                        envionotificacion.sp            */
/*      Stored procedure:               sp_envio_notificacion          */
/*      Base de Datos:                  cob_conta_super                 */
/*      Producto:                       Clientes                        */
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
/* Realiza el envio de correo al oficial de cumplimiento                */
/************************************************************************/

use cob_conta_super
go

if exists(select * from sysobjects where name = 'sp_envio_notificacion')
   drop proc sp_envio_notificacion
go

create proc sp_envio_notificacion(   
@i_param1  datetime --fecha
)
as declare 
@w_body         varchar(2000),
@w_nombre       varchar(255),
@w_error        int,
@w_num_clientes int,
@w_contador     int,
@w_id           int,
@w_banco        varchar(100),
@w_from         varchar(60),
@w_sp_name      varchar(60),
@w_mail         varchar(100),
@w_funcionario  int,
@w_codigo       int,
@w_num_registros int,
@w_registros     int,
@w_secuencial    int,
@w_causa         varchar(100),
@w_mensaje       varchar(100)

select
    @w_sp_name = 'sp_envio_notificacion'
  
  ---- VERSIONAMIENTO DEL PROGRAMA -------------------------------------------
  -- if @t_show_version = 1
  -- begin
    -- print 'Stored Procedure = ' + @w_sp_name + 'Version = ' + '4.0.0.0'
    -- return 0
  -- end

select @w_funcionario = pa_int 
from cobis..cl_parametro 
where pa_nemonico = 'OFCU' 
and pa_producto = 'REC'

if @w_funcionario is null
begin
    select  @w_mensaje = 'ERROR: NO EXISTE PARAMETRO FUNCIONARIO',
            @w_error = 1
            goto ERROR  
    return 1   
end

if not exists (select 1 from cobis..cl_funcionario
                    where fu_funcionario = @w_funcionario)
begin
    select  @w_mensaje = 'ERROR: NO EXISTE FUNCIONARIO',
            @w_error = 1
            goto ERROR  
    return 1    
end      

select @w_mail = mf_descripcion
from cobis..cl_medios_funcio        
where mf_funcionario = @w_funcionario  

if @w_mail is null or @w_mail = ''
begin
    select  @w_mensaje = 'ERROR: FUNCIONARIO NO TIENE CORREO DE NOTIFICACION',
            @w_error = 1
            goto ERROR  
    return 1   
end    

select @w_num_registros = isnull(count(*),0) 
from sb_consulta_transacciones
where ct_estado = 'G'
-- if @w_num_registros = 0
-- begin
    -- exec cobis..sp_errorlog
    -- @i_fecha       = @i_param1,
    -- @i_error       = 1,
    -- @i_usuario     = 'admuser',     
    -- @i_descripcion = 'NO EXISTEN REGISTROS GENERADOS',
    -- @i_rollback    = 'N',
    -- @i_tran        = 0,
    -- @i_tran_name   = @w_sp_name  
    -- return 0   
-- end

select @w_num_clientes = isnull(pa_int,50) 
from cobis..cl_parametro 
where pa_nemonico = 'NCLN' 
and pa_producto = 'REC'

select @w_from = isnull(pa_char,50) 
from cobis..cl_parametro 
where pa_nemonico = 'MANO' 
and pa_producto = 'REC'

select @w_banco = isnull(pa_char,50) 
from cobis..cl_parametro 
where pa_nemonico = 'NOBA' 
and pa_producto = 'REC'

select @w_id = te_id 
from cobis..ns_template
where te_nombre = 'NotificacionesEC_ctas.xslt'

select @w_body = "<?xml version='1.0' encoding='UTF-8'?><data>"

select @w_contador = 0,
       @w_registros = 0

while not @w_contador = @w_num_registros
begin

select  @w_secuencial = isnull(ct_secuencial,''),
        @w_codigo = isnull(ct_ente,''),
        @w_nombre = isnull(ct_nombre,'') + ' ' + isnull(ct_apellido,'') + ' ' + isnull(ct_funcionario,''),
        @w_causa  = isnull((select valor 
                     from cobis..cl_catalogo 
                     where tabla in (select codigo 
                                        from cobis..cl_tabla 
                                        where tabla = 'sb_causa_reportado')
                     and codigo = ct_causa),'')
    from sb_consulta_transacciones
    where ct_estado = 'G'
    order by ct_secuencial  

   
    select @w_body = @w_body + "<referencia><codigo>" + convert(varchar,@w_codigo) + "</codigo><nombre>" + @w_nombre + "</nombre><causa>" + @w_causa + "</causa></referencia>"
    select @w_contador = @w_contador + 1,
           @w_registros = @w_registros + 1
           

    if @w_num_clientes = @w_registros
    begin        
        select @w_body = @w_body + "<nombreBanco>" + @w_banco + "</nombreBanco></data>"                                
        exec @w_error =  cobis..sp_despacho_ins
                @i_cliente  = @w_funcionario,
                @i_template = @w_id,
                @i_servicio = 1,
                @i_estado = 'P',
                @i_tipo =   'MAIL',
                @i_tipo_mensaje = 'I',
                @i_prioridad = 1,
                @i_from = @w_from,
                @i_to = @w_mail,
                @i_cc = '',
                @i_bcc = null,
                @i_subject = 'NOTIFICACION DE CLIENTES',
                @i_body = @w_body,
                @i_content_manager = 'HTML',
                @i_retry = 'S',
                @i_fecha_envio = null,
                @i_hora_ini = null,
                @i_hora_fin = null,
                @i_tries = 0,
                @i_max_tries = 2
        if @w_error <> 0      
        begin
            select  @w_mensaje = 'ERROR AL ENVIAR NOTIFICACION',
                @w_error = @w_error
            goto ERROR           
        end         
        
        select @w_body = "<?xml version='1.0' encoding='UTF-8'?><data>"        
        select @w_registros = 0        
    end   
    
    update sb_consulta_transacciones set ct_estado = 'E'
    where ct_estado = 'G'
    and ct_secuencial = @w_secuencial
    if @@error <> 0
    begin
        select  @w_mensaje = 'ERROR AL ENVIAR NOTIFICACION',
                @w_error = @@error
            goto ERROR
    end

end

if @w_registros <> 0
begin
select @w_body = @w_body + "<nombreBanco>" + @w_banco + "</nombreBanco></data>"                        

        exec @w_error =  cobis..sp_despacho_ins
                @i_cliente  = @w_funcionario,
                @i_template = @w_id,
                @i_servicio = 1,
                @i_estado = 'P',
                @i_tipo =   'MAIL',
                @i_tipo_mensaje = 'I',
                @i_prioridad = 1,
                @i_from = @w_from,
                @i_to = @w_mail,
                @i_cc = '',
                @i_bcc = null,
                @i_subject = 'NOTIFICACION DE CLIENTES',
                @i_body = @w_body,
                @i_content_manager = 'HTML',
                @i_retry = 'S',
                @i_fecha_envio = null,
                @i_hora_ini = null,
                @i_hora_fin = null,
                @i_tries = 0,
                @i_max_tries = 2
        if @w_error <> 0
        begin
            select @w_mensaje = 'ERROR AL ENVIAR NOTIFICACION',
                    @w_error = @w_error
            goto ERROR
        end       
         
end       
return 0

ERROR:
exec cobis..sp_ba_error_log
            @t_trn         = 8205,
            @i_operacion   = 'I',
            @i_sarta       = 36006, 
            @i_batch       = 36003,
            @i_fecha_proceso= @i_param1,
            @i_error       = @w_error,
            @i_detalle     = @w_mensaje   

return @w_error            

go

