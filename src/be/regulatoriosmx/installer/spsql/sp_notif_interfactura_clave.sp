use cob_conta_super
go

if object_id ('sp_notif_interfactura_clave') is not null
   drop procedure sp_notif_interfactura_clave
go
/*************************************************************************/
/*   Archivo:            sp_notif_interfactura_clave.sp                  */
/*   Stored procedure:   sp_notif_interfactura_clave                     */
/*   Base de datos:      cob_conta_super                                 */
/*   Producto:           Originacion                                     */
/*   Disenado por:       AINCA                                           */
/*   Fecha de escritura: 15/09/2018                                      */
/*************************************************************************/
/*                                  IMPORTANTE                           */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   "MACOSA", representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier acion o agregado hecho por alguno de sus                  */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante.                 */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este procedimiento almacenado, asocia el correo que envia el buc    */
/*   con el template NotifInterfacturaPassword.xslt                      */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA               AUTOR                       RAZON               */
/*   12-02-2019          AINCA                 Emision Inicial           */
/*   26-06-2019          PXSG                  Estado de Cuenta LCR      */
/*                                             req. 115931               */
/* 12/Mar/2020           AGO                  #123672 --FASE 2           */
/* 04/Ene/2022           AIN                  #122730 - Integración prov */
/*************************************************************************/
create procedure sp_notif_interfactura_clave(
@i_estado			char(1)     = null,
@i_codig_nec      int         = null,
@i_buc_cli        varchar(10) = null,
@i_mail_doc       varchar(50) = null 

)
as
declare
  @w_return              int,
  @w_sp_name             varchar(30),
  @w_codig_nec           int,
  @w_mail_doc            varchar(50),
  @w_buc_cli             varchar(10),
  @w_cont_P              int,
  @w_cod_cliente         int,
  @w_id                  int,
  @w_error               int,
  @w_subject             varchar(100),
  @w_body                varchar(500),
  @w_msg                 varchar(200),
  @w_num_eje             int,
  @w_status_nec          char(1),
  @w_contar_prov         int,
  @w_nombre_prov         varchar(10),
  @w_nombre_tplat        varchar(50),
  @w_tipo_correo         varchar(10),
  @w_from                varchar(60)
  
-- NOMBRE DEL SP
select @w_sp_name = 'sp_notif_interfactura_clave'

      
   print @i_codig_nec
   print @i_buc_cli
   print @i_mail_doc
   
   -- seccion cliente - busqueda con el buc
   select @w_cod_cliente = en_ente
   from cobis..cl_ente
   where en_banco = @i_buc_cli
   
   -- Seccion para seleccionar el proveedor
   select @w_contar_prov = count(1) from cobis..cl_catalogo where tabla = (SELECT codigo FROM cobis..cl_tabla WHERE tabla = 'cl_proveedor_correo') and estado = 'V'
   
   if @w_contar_prov = 1  
   BEGIN
      select @w_nombre_prov = codigo,
             @w_from        = valor
	  from cobis..cl_catalogo 
	  where tabla = (SELECT codigo 
	                 FROM cobis..cl_tabla 
					 WHERE tabla = 'cl_proveedor_correo') 
	  and estado = 'V'
	  
	  if @w_nombre_prov = 'INFOBIP'
	  begin
	     select @w_nombre_tplat = 'NotifInterfacturaPasswordRest.xslt'
		 select @w_tipo_correo = 'REST'
	  end
	  else
	  begin 
	     select @w_nombre_tplat = 'NotifInterfacturaPassword.xslt'
		 select @w_from = null
		 select @w_tipo_correo = 'MAIL'
	  end	  
   end
   else
   begin 
   -- Valores por defecto de no encontrar un destinatario activo o solo uno activo, no pueden estar 2 activos
      select @w_nombre_tplat = 'NotifInterfacturaPassword.xslt'
	  select @w_from = null
	  select @w_tipo_correo = 'MAIL'
   end
   
   -- seccion template  - busqueda del codigo del template asociado
   select @w_id = te_id 
   from cobis..ns_template
   where te_nombre = @w_nombre_tplat
   
   -- Creacion de un subject
   select @w_subject = 'Contraseña de Estado de Cuenta'
   
   -- creacion xml con el buc que tiene relacion con el template
   select @w_body = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><buc>'+@i_buc_cli+'</buc></data>'
   
   -- Ejecucion del sp para las notificaciones y envio de mail
   exec @w_error =  cobis..sp_despacho_ins
        @i_cliente          = @w_cod_cliente,
        @i_template         = @w_id,
        @i_servicio         = 1,
        @i_estado           = 'P',
        @i_tipo             = @w_tipo_correo,
        @i_tipo_mensaje     = 'I',
        @i_prioridad        = 1,
        @i_from             = @w_from,
        @i_to               = @i_mail_doc,
        @i_cc               = null,
        @i_bcc              = null,
        @i_subject          = @w_subject,
        @i_body             = @w_body,
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

   	   update sb_ns_estado_cuenta
   	   set in_estd_clv_co = 'F'
   	   where nec_codigo = @i_codig_nec
 
   	     
   	end
   	else
   	begin
   	   update sb_ns_estado_cuenta
   	   set in_estd_clv_co = 'T'
   	   where nec_codigo = @i_codig_nec	   
   	end
	
   	if @w_error <> 0
       begin
          select @w_msg = 'ERROR AL ENVIAR NOTIFICACION DE LA CODIGO DEL CLIENTE'+convert(varchar(100),@w_cod_cliente),
   	             @w_error = 5000
          goto ERROR1
       end
   	
   	ERROR1:
       print 'ERROR A INSERTAR>> '+convert(varchar(10),@w_error)+' mensaje>>'+@w_msg
       CONTINUAR:

return 0

GO
