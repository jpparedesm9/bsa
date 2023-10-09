/****************************************************************/
/*   ARCHIVO:         	sp_notificacion_LCR.sp		            */
/*   NOMBRE LOGICO:   	sp_notificacion_LCR       		        */
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
/*  contratado por biometricos LCR          					*/
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   06/11/2020    JCASTRO             Emision inicial 140485   */
/*   09/11/2022    KVI       R.196073-Tanqueo tabla gen.archivos*/
/****************************************************************/
use cobis
go
if exists (select 1 from sysobjects where name = 'sp_notificacion_LCR')
   drop proc sp_notificacion_LCR
go
create procedure sp_notificacion_LCR (
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
		@w_message			varchar(1000),
		@w_ente             int         ,
		@w_to               varchar(255),
		@w_cc               varchar(255),
		@w_bcc              varchar(255),
		@w_asesor           int,
		@w_nom_asesor       varchar(255),
		@w_cliente          varchar(255),
		@w_documento        varchar(20),
		@w_product			varchar(50),
		@w_product_type		varchar(50),
		@w_date				date,
		@w_suc				varchar(25),
		@w_contact			varchar(64),
		@w_biocheck			char(1),
		@w_tramite			int,
		@w_oficina          varchar(100),
		@w_ofi_cod          int,
		@w_param_ofis		int,
		@w_envio_correo     char(1),
		@w_correo_cli       varchar(50),
        @w_correo_ase       varchar(50),
		@w_template_cli     int,
		@w_template_ase     int,
		@w_anio             varchar(4),	
        @w_mes_in			varchar(15),
        @w_mes_es			varchar(15),
        @w_dia 				varchar(2),
        @w_fecha_hora       varchar(50),
        @w_num_suc          int,
        @w_canal            int -- Req.196073
		
		
	select @w_envio_correo = pa_char from cobis..cl_parametro where pa_nemonico = 'CLCR' and pa_producto = 'CLI'
    select @w_template_cli = te_id from cobis..ns_template where te_nombre = 'NotificacionBiometricaCLILCR.xslt'
    select @w_template_ase = te_id from cobis..ns_template where te_nombre = 'NotificacionBiometricaASELCR.xslt'
    
    -- Obtener formato de fecha
    select @w_anio   = LTRIM(RTRIM(convert(varchar,DATENAME(yyyy,getdate()))))
    select @w_mes_in = LTRIM(RTRIM(convert(varchar,DATENAME(mm,getdate()))))
    select @w_dia    = LTRIM(RTRIM(convert(varchar,DATENAME(dd,getdate()))))
        
    select @w_mes_es = (case @w_mes_in when 'January'  then 'Enero' 
                                       when 'February' then 'Febrero'    when 'March' then 'Marzo' 
                                       when 'April'    then 'Abril'      when 'May' then 'Mayo' 
                                       when 'June'     then 'Junio'      when 'July' then 'Julio' 
                                       when 'August'   then 'Agosto'
                                       when 'September'then 'Septiembre' when 'October' then 'Octubre' 
                                       when 'November' then 'Noviembre'  when 'December' then 'Diciembre' end)
        
    -- select @w_fecha_hora =  @w_dia+'/'+@w_mes_es+'/'+@w_anio + ' a las ' + convert(varchar, getdate(), 8)
    select @w_fecha_hora =  convert(varchar(10),getdate(),103) + ' a las ' + convert(varchar, getdate(), 8)
		
	select @w_biocheck= pa_char from cobis..cl_parametro where pa_nemonico = 'VBIO'
	
	--SI NO HAY PARAMETRIA DE OFICINAS PARA BIOCHECK SE CONSIDERA SOLO EL PARAMETRO VBIO
	select @w_param_ofis = count(*) from cl_catalogo where tabla = (select codigo from cl_tabla where tabla ='cl_ofi_biocheck')

	select @w_tramite      = io_campo_3,
	       @w_ente         = io_campo_1,
	       @w_product_type = io_campo_4
	from   cob_workflow..wf_inst_proceso
	where  io_id_inst_proc = @i_id_inst_proc

	select @w_oficina = (select of_nombre from cobis..cl_oficina where of_oficina = tr_oficina),
	       @w_ofi_cod = tr_oficina,
	       @w_asesor  = tr_oficial
	from   cob_credito..cr_tramite
	where  tr_tramite = @w_tramite
	
    select @w_nom_asesor = fu_nombre
    from   cobis..cl_funcionario
    where  fu_funcionario = @w_asesor
    
    select @w_correo_ase = mf_descripcion
    from   cobis..cl_medios_funcio
    where  mf_funcionario = @w_asesor

	select @w_sp_name = 'sp_notificacion_LCR'
	
    if (exists (select * from cl_catalogo c,cl_tabla t where t.codigo = c.tabla  and t.tabla = 'cl_ofi_biocheck' and c.codigo = convert(varchar(5),@w_ofi_cod) and c.estado='V') and @w_biocheck ='S')
	OR (@w_biocheck ='S' AND @w_param_ofis = 0)
	begin

		   if @w_envio_correo = 'S'
		   begin
			   
		      ------------------------------------
		      ---   ENVIO NOTIFICACION CLIENTE ---
		      ------------------------------------
			  select @w_cliente   = isnull(en_nombre,'')+' '+isnull(p_s_nombre,'')+' '+isnull(p_p_apellido,'')+' '+isnull(p_s_apellido,''),
                     @w_documento = en_rfc
              from   cobis..cl_ente
              where  en_ente = @w_ente

              select @w_correo_cli = di_descripcion from cobis..cl_direccion where di_ente =  @w_ente and di_tipo = 'CE'
              select @w_product	   = op_banco from cob_cartera..ca_operacion where op_tramite = @w_tramite
              select @w_contact    = pa_char from cobis..cl_parametro where pa_nemonico = 'NDCB' and pa_producto = 'CLI'

              if @w_correo_cli is not null
			  begin 
                   select @w_message = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><tipoCredito>'+LTRIM(RTRIM(@w_product_type))+' </tipoCredito><numeroCredito>'+LTRIM(RTRIM(@w_product))+'</numeroCredito><fechaHora>'+LTRIM(RTRIM(@w_fecha_hora))+'</fechaHora><sucursal>'+LTRIM(RTRIM(@w_ofi_cod))+'</sucursal><contacto>'+LTRIM(RTRIM(@w_contact))+'</contacto></data>'

                   exec cobis..sp_despacho_ins
                        @i_cliente          = @w_ente,
                        @i_servicio         = 1,
                        @i_template         = @w_template_cli,
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
		      
		      -----------------------------------
		      ---   ENVIO NOTIFICACION ASESOR ---
		      -----------------------------------
		      if @w_correo_ase is not null
		      begin 
                    if @w_nom_asesor is null
                    begin 
                         select @w_nom_asesor = 'TUIIO'
                    end
              
                    select @w_message = '<?xml version=''1.0'' encoding=''ISO-8859-1''?><data><asesor>'+LTRIM(RTRIM(@w_nom_asesor))+'</asesor><tipoCredito>'+LTRIM(RTRIM(@w_product_type))+' </tipoCredito><numeroCredito>' +LTRIM(RTRIM(@w_product))+'</numeroCredito><cliente>'+LTRIM(RTRIM(@w_cliente))+'</cliente><documento>'+LTRIM(RTRIM(@w_documento))+'</documento><fechaHora>'+LTRIM(RTRIM(@w_fecha_hora))+'</fechaHora><sucursal>'+LTRIM(RTRIM(@w_ofi_cod))+'</sucursal><contacto>'+LTRIM(RTRIM(@w_contact))+'</contacto></data>'
                                
                    exec cobis..sp_despacho_ins
                         @i_cliente          = @w_ente,
                         @i_servicio         = 1,
                         @i_template         = @w_template_ase,
                         @i_estado           = 'P',
                         @i_tipo             = 'MAIL',
                         @i_tipo_mensaje     = 'I', 
                         @i_prioridad        = 1,
                         @i_from             = null,
                         @i_to               = @w_correo_ase, -- correo del asesor
                         @i_cc               = '',
                         @i_bcc              = '',
                         @i_subject          = 'Contratación biométrica TUIIO',
                         @i_body             = @w_message,
                         @i_content_manager  = 'HTML',
                         @i_retry            = 'S',
                         @i_tries            = 0,
                         @i_max_tries        = 3
              end
		   end
    end
	
	--Inicio Req.196073	
	------------------------------------
	---   TANQUEO TABLA ARCHIVOS     ---
	------------------------------------
    select @w_correo_cli = di_descripcion from cobis..cl_direccion where di_ente =  @w_ente and di_tipo = 'CE'
    select @w_product= op_banco from cob_cartera..ca_operacion where op_tramite = @w_tramite

    if @w_correo_cli is not null
	begin 	
        select @w_canal = ca_canal from cobis..cl_canal where ca_nombre = 'web'
	    			
	    if not exists (select 1 from cob_credito..cr_cli_reporte_on_boarding where co_tramite = @w_tramite)
        begin
	        print 'TANQUEO CLIENTE:' + convert(varchar,@w_ente) + ' -OPERACION ' + @w_product_type + ':' + @w_product + ' -TRAMITE:' + convert(varchar,@w_tramite)
	     
            insert into cob_credito..cr_cli_reporte_on_boarding( 
	    	    co_ente, 
                co_buc,           co_banco,         co_tramite,      co_email,        co_est_zip,      
            	co_fecha_zip,     co_est_envio,     co_fecha_envio,  co_ruta_zip,     co_estd_clv_co,
				co_fecha_reg)
            select 
	    	    @w_ente, 
                en_banco,         @w_product,       @w_tramite,      @w_correo_cli,   'P',
                null,             null,             null,            null,            null,
				getdate()
            from cobis..cl_ente
            where en_ente = @w_ente
            
            if @@rowcount = 0  
	    	begin
                print 'ERROR: NO SE PUDO TANQUEAR LA OPERACION ' + @w_product_type + ' SECCION REPORTES 1 en sp_notificacion_LCR'
            end
	     
            insert into cob_credito..cr_cli_reporte_on_boarding_det( 
	            cod_ente,
                cod_buc,              cod_banco,             cod_tramite,         cod_cod_documento, 
                cod_est_gen,                                                      cod_fecha_gen,         
              	cod_enviar_correo,                                                cod_ruta_gen, 
	     	    cod_est_des_alfresco,                                             cod_canal,
				cod_id_inst_proc,     cod_grupo,             cod_carpeta,   	  
				cod_nombre_doc,       cod_codigo_tipo_doc,   cod_fecha_reg)								
            select 
	            co_ente,                                     
                co_buc,               co_banco,              co_tramite,          ra_cod_documento,
                case when ra_est_gen = 'S'          then 'P' else null end,       null,
                case when ra_est_envio = 'S'        then 'S' else 'N'  end,       null,
	     	    case when ra_est_des_alfresco = 'S' then 'P' else null end,       ra_canal,
				@i_id_inst_proc,      null,                  ra_carpeta,         
				null, 				  ra_codigo_tipo_doc,    getdate()
            from cob_credito..cr_cli_reporte_on_boarding, cob_credito..cr_reporte_on_boarding
            where co_tramite = @w_tramite
	    	and ra_toperacion = @w_product_type
	        and ra_canal = @w_canal	
			
			if @@rowcount = 0
	    	begin
                print 'ERROR: NO SE PUDO TANQUEAR LA OPERACION ' + @w_product_type + ' SECCION REPORTES 2 en sp_notificacion_LCR' 
            end
			
			update cob_credito..cr_cli_reporte_on_boarding_det
			set cod_nombre_doc = ri_nombre_doc 
			from cob_workflow..wf_req_inst
			where cod_id_inst_proc = ri_id_inst_proc
			and   cod_codigo_tipo_doc = ri_codigo_tipo_doc
			and   cod_id_inst_proc = @i_id_inst_proc
			
			update cob_credito..cr_cli_reporte_on_boarding_det
			set cod_nombre_doc = ltrim(rtrim(isnull(dd_tipo_doc,''))) + '.' + ltrim(rtrim(isnull(dd_extension,''))) 
			from cob_credito..cr_documento_digitalizado
			where cod_id_inst_proc = dd_inst_proceso
			and   cod_ente = dd_cliente
			and   cod_id_inst_proc = @i_id_inst_proc
			and   cod_ente = @w_ente
			and   cod_cod_documento in (112,120)
			and   dd_tipo_doc = case when cod_cod_documento = 112 then '009' --sol.comp.gr      
			                         when cod_cod_documento = 120 then '006' --sol.comp.in    
					                 else null 
				                end 
        end 
	end
	--Fin Req.196073

select @o_id_resultado = 1

return 0
	
go