/************************************************************************/
/*  archivo:                lcr_gen_ref_srv.sp                          */
/*  stored procedure:       sp_lcr_gen_ref_srv                          */
/*  base de datos:          cob_cartera                                 */
/*  producto:               credito                                     */
/*  disenado por:           Alexander Inca                              */
/*  fecha de documentacion: Noviembre 2018                              */
/************************************************************************/
/*          importante                                                  */
/*  este programa es parte de los paquetes bancarios propiedad de       */
/*  "macosa",representantes exclusivos para el ecuador de la            */
/*  at&t                                                                */
/*  su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  presidencia ejecutiva de macosa o su representante                  */
/************************************************************************/
/*          proposito                                                   */
/*             Generar Referencia para valde de compra LCR              */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    14/Oct/2020           AIN              Emision Inicial            */
/************************************************************************/

use cob_cartera 
go

if exists(select 1 from sysobjects where name ='sp_lcr_gen_ref_srv')
	drop proc sp_lcr_gen_ref_srv
go


create proc sp_lcr_gen_ref_srv(
   @s_ssn              int           = null,
   @s_ofi              smallint,
   @s_user             login,
   @s_date             datetime,
   @s_srv              varchar(30)   = null,
   @s_term             descripcion   = null,
   @s_rol              smallint      = null,
   @s_lsrv             varchar(30)   = null,
   @s_sesn             int           = null,
   @s_org              char(1)       = null,
   @s_org_err          int           = null,
   @s_error            int           = null,
   @s_sev              tinyint       = null,
   @s_msg              descripcion   = null,
   @t_rty              char(1)       = null,
   @t_trn              int           = null,
   @t_debug            char(1)       = 'N',
   @t_file             varchar(14)   = null,
   @t_from             varchar(30)   = null,
   --OBLIGATORIOS PARA EL SERVICIO
   @i_canal            catalogo      = 'B2C',
   @i_banco            cuenta        ,
   @i_monto            money         ,
   @i_monto_cap        money         , -- para referencias socio comercial
   @i_monto_iva        money         , -- para referencias socio comercial
   @i_monto_com        money         , -- para referencias socio comercial
   @i_renovar          char(1)       = 'N',
   --NO OBLIGATORIOS SOLOPAPA PRUEBAS
   @i_forma_desembolso catalogo      = 'NC_BCO_MN',
   @i_cuenta           cuenta        = null ,    
   @i_en_linea         char(1)       = 'N',  
   @i_fecha_valor      datetime      = null,    --PARA PRUEBAS DE DESEMBOLSO
   @i_secuencial       int           = 0,  
   --MENSAJE DE ERROR  
   @o_msg             varchar(255)    = null out

)as 
declare 
@w_msg                      varchar(255),
@w_error                    int,
@w_operacionca              int ,
@w_sp_name                  descripcion,
@w_secuencial               int,
@w_referencia               varchar(100),
@w_folio                    varchar(15),
--PARA ENVIO DE CORREO
@w_mailCliente              varchar(250),
@w_cliente                  int,
@w_subject                  varchar(100),
@w_body                     varchar(500),
@w_colectivo                varchar(10),
@w_nombre_colectivo         varchar(25)




--1.- Validacion de la operacion 
select 
@w_operacionca       = op_operacion,
@w_cliente           = op_cliente
from ca_operacion 
where op_banco = @i_banco 

if @@rowcount = 0 begin 
   select  
   @w_msg  = 'ERROR:EL CLIENTE NO TIENE UNA LINEA DE CREDITO APROBADA ',
   @w_error= 70001
   goto ERROR_FIN
end 



exec @w_secuencial  = sp_gen_sec
@i_operacion        = @w_operacionca


--LLAMADO AL SO DE CORRESPONSAL

exec @w_error= cob_cartera..sp_santander_gen_ref
@s_ssn                 = @s_ssn,
@s_user                = @s_user,           
@s_sesn                = @s_sesn,
@s_term                = @s_term,
@s_date                = @s_date,            
@s_srv                 = @s_srv,               
@s_lsrv                = @s_lsrv,       
@i_id_referencia       = @i_banco ,
@i_tipo_tran           = 'PI',
--@i_secuencial          = @w_secuencial,
@i_canal               ='B2C', --PROVIENE DE LA B2C PARA GENERAR DISPERSIONES DE UN DIA DE DURACION
@i_monto               = @i_monto,
@i_monto_cap           = @i_monto_cap,
@i_monto_iva           = @i_monto_iva,
@i_monto_com           = @i_monto_com,
@o_referencia          = @w_referencia out

if @w_error <> 0 begin 
   select  
   @w_msg  = 'ERROR: NO SE PUDO GENERAR LA REFERENCIA ',
   @w_error= 700099
   goto ERROR_FIN
end 



select @w_folio = convert(varchar(10),@w_operacionca)+'_'+convert(varchar(10),@w_secuencial)

--SE OBTIENE EL NOMBRE DEL SOCIO COMERCIAL
select @w_colectivo = ea_colectivo from cobis..cl_ente_aux where ea_ente = @w_cliente
select @w_nombre_colectivo = valor from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_socio_comercial') and codigo = @w_colectivo

select  
'Institucion'     = 'SANTANDER',
'Referencia'      = @w_referencia,
'Tipo'            = 'DISPOSICIÓN DEL CRÉDITO',
'Fecha_operacion' = getdate(),
'Hora_operacion'  = getdate(),
'Folio'           = @w_folio,
'Estado'          = 'EN PROCESO',
'Mensaje'         = 'Campo para colocar el mensaje que debe presentarse en la app',
'Socio'           = @w_nombre_colectivo


-- INICIO CORREO

select @w_body = 'Estimado(a) Señor(a).' + char(13) + char(13)
select @w_body = @w_body + 'A continuación el número de referencia de compra: ' + char(13)
select @w_body = @w_body + 'No. ' + @w_referencia + char(13) + char(13) + 'Saludos.'
   
-- Creacion de un subject
select @w_subject = 'Generación de Referencia de Compra'

-- Consulta datos de correo y datos de envio
select @w_mailCliente = di_descripcion 
from cobis..cl_direccion 
where di_ente = @w_cliente
and di_tipo = 'CE'

if @w_mailCliente is not null 
begin
  -- Envio de correo con # referencia
  exec @w_error =  cobis..sp_despacho_ins
       @i_cliente          = @w_cliente,
       @i_template         = 0,
       @i_servicio         = 1,
       @i_estado           = 'P',
       @i_tipo             = 'MAIL',
       @i_tipo_mensaje     = 'I',
       @i_prioridad        = 1,
       @i_from             = null,
       @i_to               = @w_mailCliente,
       @i_cc               = null,
       @i_bcc              = null,
       @i_subject          = @w_subject,
       @i_body             = @w_body,
       @i_content_manager  = 'TEXT',
       @i_retry            = 'S',
       @i_fecha_envio      = null,
       @i_hora_ini         = null,
       @i_hora_fin         = null,
       @i_tries            = 0,
       @i_max_tries        = 2,
       @i_var1             = null
  	   
  if @w_error <> 0
  begin
     select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DEL CODIGO DEL CLIENTE'+convert(varchar(100),@w_cliente)
     select @w_error = 5000
     
  end
end

-- FIN CORREO

return 0

ERROR_FIN:

print 'Error lcr_gen_ref_srv: '+convert(varchar, @w_error)


if @i_en_linea = 'S' begin 
   exec cobis..sp_cerror
   @t_debug = 'N',
   @t_from  = @w_sp_name,
   @i_num   = @w_error,
   @i_msg   = @w_msg

end else begin 
   exec sp_errorlog 
   @i_fecha     = @s_date,
   @i_error     = @w_error,
   @i_usuario   = @s_user,
   @i_tran      = 7999,
   @i_tran_name = @w_sp_name,
   @i_cuenta    = @i_banco,
   @i_rollback  = 'N',
   @i_descripcion = @w_msg
end   

select @o_msg = @w_msg
return @w_error
GO

