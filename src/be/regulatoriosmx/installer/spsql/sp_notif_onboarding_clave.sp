use cob_conta_super
go

if object_id ('sp_notif_onboarding_clave') is not null
   drop procedure sp_notif_onboarding_clave
go
/*************************************************************************/
/*  Archivo:            sp_notif_onboarding_clave.sp                     */
/*  Stored procedure:   sp_notif_onboarding_clave                        */
/*  Base de datos:      cob_conta_super                                  */
/*  Producto:           Originacion                                      */
/*  Disenado por:       ACH                                              */
/*  Fecha de escritura: 11/03/2022                                       */
/*************************************************************************/
/*                             IMPORTANTE                                */
/*  Este programa es parte de los paquetes bancarios propiedad de        */
/*  "MACOSA", representantes exclusivos para el Ecuador de NCR           */
/*  Su uso no autorizado queda expresamente prohibido asi como           */
/*  cualquier acion o agregado hecho por alguno de sus                   */
/*  usuarios sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante.                  */
/*************************************************************************/
/*                             PROPOSITO                                 */
/*  Este procedimiento almacenado, asocia el correo que envia el buc     */
/*  con el template NotifOnboardingPassword.xslt. Caso Inicial #168293   */
/*************************************************************************/
/*                           MODIFICACIONES                              */
/*  FECHA         AUTOR                       RAZON                      */
/*  11-03-2022    ACH      Emision Inicial                               */
/*  10/11/2022    ACH      R#196073 Envio de documentos digitales        */ 
/*************************************************************************/
create procedure sp_notif_onboarding_clave(
    @i_estado	      char(1)     = null,  --1
    @i_cliente        int         = null,  --2
	@i_banco          varchar(24) = null,  --3
    @i_buc_cli        varchar(10) = null,  --4
    @i_mail_doc       varchar(50) = null,  --5
    @i_tipo_notific   varchar(10) = null   --6
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
  @w_from                varchar(60),
  @w_canal_banco         int,
  @w_canal_onb           int,
  @w_toperacion          varchar(20),
  @w_top_desc            varchar(256)
  
-- NOMBRE DEL SP
select @w_sp_name = 'sp_notif_onboarding_clave'

   print @i_buc_cli
   print @i_mail_doc
   
   -- seccion cliente - busqueda con el buc
   select @w_cod_cliente = en_ente
   from cobis..cl_ente
   where en_banco = @i_buc_cli

    print 'ingreso a GRAOB'

    select @w_toperacion = op_toperacion from cob_cartera..ca_operacion where op_banco = @i_banco
    select @w_canal_banco = cod_canal from cob_credito..cr_cli_reporte_on_boarding_det where cod_banco = @i_banco
    select @w_canal_onb = ca_canal from cobis..cl_canal where ca_nombre = 'b2c_digital' and ca_estado = 'V'
	
    if (@w_canal_banco = @w_canal_onb) begin
	    select @w_subject = nr_subjet_pass,
		       @w_top_desc = nr_tproducto_descp
		from cob_cartera..ca_notificacion_reporte where nr_tproducto = 'ONBOARDING' and nr_job = @i_tipo_notific
		
        -- Seccion para seleccionar el proveedor
         select @w_nombre_tplat = 'NotifOnboardingPassword.xslt'
         select @w_from = null
         select @w_tipo_correo = 'MAIL'
        
        -- seccion template  - busqueda del codigo del template asociado
        select @w_id = te_id 
        from cobis..ns_template
        where te_nombre = @w_nombre_tplat        
        
        -- creacion xml con el buc que tiene relacion con el template
        select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><buc>'+@i_buc_cli+'</buc><numBanco>'+@i_banco+'</numBanco><tproductoDesc>' +@w_top_desc+ '</tproductoDesc></data>'
	
	end else begin
	    select @w_subject = nr_subjet_pass,
		       @w_top_desc = nr_tproducto_descp
		from cob_cartera..ca_notificacion_reporte where nr_tproducto = @w_toperacion and nr_job = @i_tipo_notific
			
		-- Seccion para seleccionar el proveedor
        select @w_nombre_tplat = 'NotifGeneracionReportePassword.xslt'
        select @w_from = null
        select @w_tipo_correo = 'MAIL'
        
        -- seccion template  - busqueda del codigo del template asociado
        select @w_id = te_id 
        from cobis..ns_template
        where te_nombre = @w_nombre_tplat
        
        -- creacion xml con el buc que tiene relacion con el template
        select @w_body = '<?xml version="1.0" encoding="ISO-8859-1"?><data><buc>'+@i_buc_cli+'</buc><numBanco>'+@i_banco+'</numBanco><tproductoDesc>' +@w_top_desc+ '</tproductoDesc></data>'
	end
      
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
   	   update cob_credito..cr_cli_reporte_on_boarding
   	   set co_estd_clv_co = 'E'
   	   where co_ente = @i_cliente
	   and co_banco = @i_banco
   	end
   	else begin
   	   update cob_credito..cr_cli_reporte_on_boarding
   	   set co_estd_clv_co = 'T'
   	   where co_ente = @i_cliente
	   and co_banco = @i_banco 
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
