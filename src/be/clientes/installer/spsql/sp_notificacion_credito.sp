/****************************************************************/
/*   ARCHIVO:         	sp_notificacion_credito.sp		        */
/*   NOMBRE LOGICO:   	sp_notificacion_credito       		    */
/*   PRODUCTO:          CLIENTES                                */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*  Notificar a los clientes de un grupo que su crédito ha sido */
/*  contratado													*/
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   14-02-2020    F. Sanmiguel        Emision Inicial.     	*/
/*   21-09-2020    A. Inca             Envío de Correos         */
/*   27-10-2020    A. Inca             Validación Biometrica    */
/*                                     para correos             */
/*   06-04-2021    ACH                 Caso#153599-cambioOficina*/
/****************************************************************/
use cobis
go
if exists (select 1 from sysobjects where name = 'sp_notificacion_credito')
   drop proc sp_notificacion_credito
go
create procedure sp_notificacion_credito(
	@t_debug       		char(1)      = 'N',
	@t_from        		varchar(30)  = null,
	@s_ssn              int          = null,
	@s_user             varchar(30)  = null,
	@s_sesn             int			 = null,
	@s_term             varchar(30)  = null,
	@s_date             datetime	 = null,
	@s_srv              varchar(30)  = null,
	@s_lsrv             varchar(30)  = null,
	@s_ofi              smallint	 = null,
	@t_file             varchar(14)  = null,
	@t_rty          	char(1)      = null,
	@s_rol              smallint     = null,
	@s_org_err          char(1)      = null,
	@s_error            int          = null,
	@s_sev              tinyint      = null,
	@s_msg              descripcion  = null,
	@s_org              char(1)      = null,
	@s_culture         	varchar(10)  = 'NEUTRAL',
	@t_trn				int          = null,
    @i_id_inst_proc 	int 		 = null,   
    @i_id_inst_act  	int 		 = null,
    @i_id_empresa   	int			 = null,
    @o_id_resultado  	smallint    	out
	
)
as
declare	@w_sp_name 			varchar(64),
		@w_error			int,
		@w_message			varchar(500),
		@w_ente             int         ,
		@w_to               varchar(255),
		@w_cc               varchar(255),
		@w_bcc              varchar(255),
		@w_product			varchar(50),
		@w_product_type		varchar(50),
		@w_date				date,
		@w_suc				varchar(25),
		@w_contact			varchar(64),
		@w_ente_tmp			int,
		@w_biocheck			char(1),
		@w_tramite			int,
		@w_oficina          smallint,
		@w_param_ofis		int,
		@w_envio_sms        char(1),
		@w_envio_correo     char(1),
		@w_correo_cli       varchar(50),
		@w_template         int,
		@w_anio             varchar(4),	
        @w_mes_in			varchar(15),
        @w_mes_es			varchar(15),
        @w_dia 				varchar(2),
        @w_fecha_hora       varchar(50),
        @w_num_suc          int,
		@w_num_cli          int,
		@w_msg_log          varchar(500)
		
	select @w_envio_sms    = pa_char from cobis..cl_parametro where pa_nemonico = 'ESCB' and pa_producto = 'CLI'
	select @w_envio_correo = pa_char from cobis..cl_parametro where pa_nemonico = 'ECCB' and pa_producto = 'CLI'
    select @w_template     = te_id from cobis..ns_template where te_nombre = 'NotificacionBiometrica.xslt'
	
	-- Obtener formato de fecha
    select @w_anio = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
    select @w_mes_in  = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
    select @w_dia  = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
        
    select @w_mes_es = (case @w_mes_in when 'January'  then 'Enero' 
                                       when 'February' then 'Febrero'    when 'March' then 'Marzo' 
                                       when 'April'    then 'Abril'      when 'May' then 'Mayo' 
                                       when 'June'     then 'Junio'      when 'July' then 'Julio' 
                                       when 'August'   then 'Agosto'
                                       when 'September'then 'Septiembre' when 'October' then 'Octubre' 
                                       when 'November' then 'Noviembre'  when 'December' then 'Diciembre' end)
        
    select @w_fecha_hora =  @w_dia+' de '+@w_mes_es+' del '+@w_anio + ' a las ' + convert(varchar, getdate(), 8)
		
	select @w_biocheck= pa_char from cobis..cl_parametro where pa_nemonico = 'VBIO'
	
	--SI NO HAY PARAMETRIA DE OFICINAS PARA BIOCHECK SE CONSIDERA SOLO EL PARAMETRO VBIO
	select @w_param_ofis = count(*) from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')

	select @w_tramite = io_campo_3 
	from cob_workflow..wf_inst_proceso
	where io_id_inst_proc = @i_id_inst_proc

	select @w_oficina = tr_oficina
	from   cob_credito..cr_tramite
	where  tr_tramite = @w_tramite

	select @w_sp_name = 'sp_notificacion_credito'
	
	select @w_msg_log = @w_sp_name + ' - ' + 'Parametro ESCB = ' + @w_envio_sms + ' - ' + 'Parametro ECCB = ' + @w_envio_correo + ' - ' + 'Parametro VBIO = ' + @w_biocheck
	
	
	-- Validación si no estan activos los parametros para el envío de correos y mensajes no realizara ninguna acción
	if (@w_envio_sms <> 'S') and (@w_envio_correo <> 'S')
	begin
	   INSERT INTO cobis..ns_notif_bio_log(nb_inst_proc, nb_descripcion, nb_fecha) 
       VALUES(@i_id_inst_proc, @w_msg_log, getdate())
	   
	   select @o_id_resultado = 1
       return 0
	end
	
	select @w_msg_log = @w_msg_log + ' - Num Oficinas = ' + convert(varchar,@w_param_ofis) + ' - ' + 'Oficina = ' + convert(varchar, @w_oficina) 
	
	if (exists (select * from cl_catalogo c,cl_tabla t where t.codigo = c.tabla  and t.tabla = 'cl_ofi_biocheck' and c.codigo = convert(varchar(5),@w_oficina) and c.estado='V') and @w_biocheck ='S')
	OR (@w_biocheck ='S' AND @w_param_ofis = 0)
	begin
	
	   -- Selecciona los clientes y se los guarda en una tabla temporal
       select rb_ente
       into #cl_respuesta_bio_tmp
	   from cobis..cl_respuesta_bio
       where rb_inst_proc = @i_id_inst_proc
	   and rb_valida_huella is null
	   
       select @w_num_cli = count(1) 
       from #cl_respuesta_bio_tmp
	   
	   select @w_msg_log = @w_msg_log + ' - Num Clientes = ' + convert(varchar,@w_num_cli)
	   
	   -- Mientras exista clientes
       while (@w_num_cli>0)
       begin
	      select top 1 @w_ente_tmp = rb_ente
	      from #cl_respuesta_bio_tmp
	      
	      if @w_envio_sms = 'S'
	      begin
	         select @w_to            = te_valor from cobis..cl_telefono where te_tipo_telefono = 'C' and te_ente = @w_ente_tmp
	         select @w_cc            = '' 
	         select @w_bcc           = '' 
	         select @w_product		= op_banco from cob_cartera..ca_operacion where op_tramite =(select io_campo_3 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc) 
	         select @w_product_type	= io_campo_4 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc  
	         select @w_date			= io_fecha_crea from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc  
	         select @w_suc			= of_nombre from cobis..cl_oficina 
	         							where of_oficina  = @w_oficina--(select io_oficina_entrega from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc) 
	         select @w_contact		= '5551694363' 
	         
	         select @w_message = 'SE AUTORIZO POR VERIFICACION BIOMETRICA LA CONTRATACION DEL CRÉDITO '
	         select @w_message = @w_message + @w_product_type + ' ' + @w_product
	         select @w_message = @w_message + ' EN SUC ' + @w_suc + ' EL ' + convert(varchar, getdate(), 3) + '. '
	         select @w_message = @w_message + 'SI NO RECONOCE LA OPERACION LLAMA ' + @w_contact
	         
	         exec cobis..sp_despacho_ins
	         	@i_cliente          = @w_ente_tmp,
	         	@i_servicio         = 1,--hay que confirmar este valor
	         	@i_estado           = 'P',
	         	@i_tipo             = 'SMS',
	         	@i_tipo_mensaje     = 'I', 
	         	@i_prioridad        = 1,
	         	@i_from             = null,
	         	@i_to               = @w_to,--numero celular del ente cl_telefono
	         	@i_cc               = @w_cc,
	         	@i_bcc              = @w_bcc,
	         	@i_subject          = 'Notificacion de Desembolso',
	         	@i_body             = @w_message,
	         	@i_content_manager  = 'TEXT',
	         	@i_retry            = 'N',
	         	@i_tries            = 0,
	         	@i_max_tries        = 0,
	         	@i_template			= ''
	   	  end
	   	     		
	   	  if @w_envio_correo = 'S'
	   	  begin
	   	     select @w_correo_cli     = di_descripcion from cobis..cl_direccion where di_ente =  @w_ente_tmp and di_tipo = 'CE'
	   	     select @w_product		  = op_banco from cob_cartera..ca_operacion where op_tramite =(select io_campo_3 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc) 
	   	     select @w_product_type   = io_campo_4 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc
	   	     select @w_num_suc		  = @w_oficina--io_oficina_entrega from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc
	   	     select @w_contact        = pa_char from cobis..cl_parametro where pa_nemonico = 'NDCB' and pa_producto = 'CLI'
	   	        
                select @w_message = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><tipoCredito>'+LTRIM(RTRIM(@w_product_type))+' </tipoCredito><numeroCredito>' +LTRIM(RTRIM(@w_product))+
                                    '</numeroCredito><fechaHora>'+LTRIM(RTRIM(@w_fecha_hora))+'</fechaHora><sucursal>'+LTRIM(RTRIM(@w_num_suc))+'</sucursal><contacto>'+LTRIM(RTRIM(@w_contact))+'</contacto></data>'
 	   	        
	   	     exec cobis..sp_despacho_ins
	   	       @i_cliente          = @w_ente_tmp,
	   	       @i_servicio         = 1,
	   	       @i_template         = @w_template,
	   	       @i_estado           = 'P',
	   	       @i_tipo             = 'MAIL',
	   	       @i_tipo_mensaje     = 'I', 
	   	       @i_prioridad        = 1,
	   	       @i_from             = null,
	   	       @i_to               = @w_correo_cli, -- correo del cliente
	   	       @i_cc               = '',
	   	       @i_bcc              = '',
	   	       @i_subject          = 'Contratación biométrica TUIIO',
	   	       @i_body             = @w_message,
	   	       @i_content_manager  = 'HTML',
	   	       @i_retry            = 'S',
	   	       @i_tries            = 0,
	   	       @i_max_tries        = 3
	   	  end
		  
		  delete from #cl_respuesta_bio_tmp
		  where rb_ente = @w_ente_tmp
		  
		  select @w_num_cli = count(1) 
          from #cl_respuesta_bio_tmp
		  
		  select @w_msg_log = @w_msg_log +  ' - Se envio:' + convert(varchar,@w_ente_tmp)
       end	
	end

INSERT INTO cobis..ns_notif_bio_log(nb_inst_proc, nb_descripcion, nb_fecha) 
VALUES(@i_id_inst_proc, @w_msg_log, getdate())
	   
select @o_id_resultado = 1

return 0
	
go