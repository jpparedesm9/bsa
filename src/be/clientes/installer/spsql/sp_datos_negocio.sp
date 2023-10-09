/****************************************************************/
/*   ARCHIVO:         	sp_datos_negocio.sp		                */
/*   NOMBRE LOGICO:   	sp_datos_negocio       		            */
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
/*   Consultar datos para realizar la investigacion de tu 		*/
/*   negocio                									*/
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   11-12-2019    A. Ortiz        Emision Inicial.     	    */
/****************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_datos_negocio')
   drop proc sp_datos_negocio
go

create procedure sp_datos_negocio(
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int			= null,
	@s_term             varchar(30) = null,
	@s_date             datetime	= null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint	= null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_trn				int         = null,
	@i_ente             int         = null,
	@i_operacion        char(1)     = null,
	@i_id_formulario    int         = null,
	@i_vers_formulario  int         = null,
	@i_id_pregunta      int         = null,
	@i_tipo_respuesta   char(1)     = null,
	@i_preg_form        int         = null,
	@i_respuesta        varchar(255)= null,
	@i_column           int 		  = null,
	@i_inst_proc        int         = null,
	@i_fila             tinyint     = null,
	@i_es_registro      char(1)     = 'N',
	@i_flag             char(1)     = null,
	@i_etapa			varchar(64)	= null,
	@o_ente				int			= null out,
	@o_mensaje			varchar(255)= null out
)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_id_formulario        int,
		@w_vers_formulario      int,
		@w_nombre_formulario    varchar(100),
		@w_sit_version          char(1),
		@w_calif_minima			int,
		@w_sp					varchar(64),
		@w_return        	    int,
		@w_name_column       	varchar(60),
		@w_id_sec            	int,
		@w_count				int,
		@w_response             varchar(254),
		@w_fecha 				datetime,
		@w_user					login,
		@w_idrespuesta          int,
		@w_limite_inferior      money,
		@w_limite_superior      money,
		@w_ingreso_semanal      money,
		@w_gasto_semanal        money,
		@w_diferencia_ingresos  money,
		@w_valor		        money,
		@w_pregunta_multi       int,
		@w_validacion		    money,
		@w_multiplo             int,
		@w_msg                  varchar(250),
		@w_id_fila				int,
		@w_tipo_ingreso			varchar(254),
		@w_id_documento			int,
		@w_desc_tipo_doc		varchar(254),
		@w_fila					int,
		@w_doc_gastos			tinyint,
		@w_gastos				tinyint
		
	select @w_sp_name 	= 'sp_datos_negocio'
	
	select @w_limite_inferior = pa_money 
	from cobis..cl_parametro 
	where pa_nemonico = 'LIMINF'
	
	select @w_limite_superior = pa_money
	from cobis..cl_parametro 
	where pa_nemonico = 'LIMSUP'

	select @w_multiplo = pa_int
	from cobis..cl_parametro 
	where pa_nemonico = 'MCIEN'

	if @i_operacion = 'S'
	begin 
	/* */
		if not exists(select 1 from cl_frm_negocio
			where ne_estado_version = 'P')
		begin
			if @@rowcount = 0
			begin
				exec sp_cerror
					@t_debug = @t_debug,
					@t_file  = @t_file, 
					@t_from  = @w_sp_name,
					@i_num   = 70328,
					@i_msg   = 'No existe un formulario vigente'
				return 1
			end
		end
	
		/* OBTENER LOS DATOS DEL FORMULARIO*/
		select  @w_id_formulario     = ne_id_formulario,
				@w_vers_formulario   = ne_vers_formulario,
				@w_nombre_formulario = ne_nombre_formulario,
				@w_sit_version       = ne_estado_version,
				@w_calif_minima      = ne_calif_minima		   
		from cl_frm_negocio
		where  ne_estado_version = 'P'

		
		if @@rowcount > 1
		begin
			exec sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file, 
				@t_from  = @w_sp_name,
				@i_num   = 70329,
				@i_msg   = 'Existen más de un formulario con estado Activo'
			return 1
		end
	
		select 	@w_id_formulario,
				@w_vers_formulario,
				@w_nombre_formulario,
				@w_sit_version,
				@w_calif_minima
		
		/* OBTENER LA LISTA DE SECCIONES DEL FORMULARIO */
		
		select 	'idFormulario'    = se_id_formulario,
				'idVerFormulario' = se_id_vers_form,
				'idSeccion'       = se_id_seccion,
				'nombreEtiqueta'  = se_etiqueta,
				'descEtiqueta'    = se_descripcion,
				'habilitado'	  = sc_habilitado
		from cl_frm_seccion, cl_frm_seccion_ctrl
		where se_id_formulario = @w_id_formulario
		and sc_frm_id = se_id_formulario
		and se_id_seccion = sc_seccion
		and ((sc_etapa = @i_etapa and sc_visible = 'S') or @i_etapa not in(select sc_etapa from  cl_frm_seccion_ctrl where sc_frm_id=@w_id_formulario))
	
	
		if @@rowcount = 0
		begin
			exec sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file, 
				@t_from  = @w_sp_name,
				@i_num   = 70330,
				@i_msg   = 'No existe secciones para el formulario'
			return 1
		end
	
		/* OBTENER LISTA DE PREGUNTAS DEL FORMULARIO */
		
		select 	'identPregunta'   = pe_pregunta,
				'identFormulario' = pe_formulario,
				'identSeccion'    = pe_seccion,
				'nombreEtiqueta'  = pe_etiqueta,
				'descripcion'  	  = pe_descripcion,
				'tipoRespuesta'   = pe_tipo_resp,
				'obligatoria'	  = pe_obligatoria,
				'registros'		  = pe_registros,
				'repetidos'		  = pe_repetidos
		from cl_frm_preguntas
		where pe_formulario = @w_id_formulario
		
		if @@rowcount = 0
		begin
		  exec sp_cerror
		  @t_debug = @t_debug,
		  @t_file  = @t_file, 
		  @t_from  = @w_sp_name,
		  @i_num   = 70331,
		  @i_msg   = 'No exiten preguntas del formulario'
		  return 1
		end
	
		/* OBTENER LISTA DE PREGUNTAS DEL FORMULARIO TIPO TABLA */
		
		select 	'identForm'     = pt_formulario,
				'preguntaForm'  = pt_pregunta_form,
				'iTabla'        = pt_tabla,
				'nombreColumna' = pt_columna,
				'tipoDato'      = pt_tipo_dato,
				'catAsociado'   = pt_catalogo,
				'obligatoriedad' = pt_obligatoriedad
		from cl_frm_pregunta_tabla
		where pt_formulario = @w_id_formulario
		
		if @@rowcount = 0
		begin
		  exec sp_cerror
		  @t_debug = @t_debug,
		  @t_file  = @t_file, 
		  @t_from  = @w_sp_name,
		  @i_num   = 70332,
		  @i_msg   = 'No exiten preguntas tipo tabla para el formulario'
		  return 1
		end
		
		/* OBTENER EL CATALOGO DE PREGUNTAS */
	
		select 	'iCatRespuesta' = cp_id_cat_resp,
				'iForm'  		= cp_id_form,
				'iPregunta'     = cp_id_pregunta,
				'catalogo' 		= cp_catalogo,
				'codigo'      	= cp_codigo,
				'valor'   		= cp_valor,
				'puntos' 		= cp_puntos
		from cl_frm_catalogo_pregunta
		where cp_id_form = @w_id_formulario
		
		if @@rowcount = 0
		begin
		  exec sp_cerror
		  @t_debug = @t_debug,
		  @t_file  = @t_file, 
		  @t_from  = @w_sp_name,
		  @i_num   = 70333,
		  @i_msg   = 'No existen respuesta relacionadas al formulario'
		  return 1
		end
		
	end
	
	if @i_operacion = 'R'
	begin
	
		if @i_flag = 'F'  --- Almacenar datos de las temporales a tablas definitivas
		begin
			if exists(select * from cl_frm_preguntas where pe_pregunta=19) AND exists(select * from  cl_frm_seccion_ctrl where sc_seccion=2 AND sc_visible='S')
			begin
				--Suma de TODOS los Ingresos Semanales debe estar entre 1000 y 300,000 pesos
				select @w_ingreso_semanal = sum(convert(money,rt_respuesta)) from cl_frm_ente_resp_tabla_tmp 
				where rt_pregunta_form = 19 and rt_id_columna > 1
				and rt_ente = @i_ente

				if @w_ingreso_semanal between @w_limite_inferior and @w_limite_superior
				begin
					select @w_ingreso_semanal = @w_ingreso_semanal
				end
				else 
				begin -- Error en la insercion
					select @w_msg = 'La suma de los ingresos semanales del cliente no esta en el rango permitido (<'+convert(varchar,@w_limite_inferior)+'> a <'+convert(varchar,@w_limite_superior)+'>)'
					exec sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 70335,
					@i_msg   = @w_msg
					return 1
				end
			end
			
			if exists(select * from cl_frm_ente_resp_tabla_tmp 
			where rt_pregunta_form = 20 and rt_id_columna > 1
			and rt_ente = @i_ente)
			begin
				--Suma de TODOS los Gastos Semanales debe estar entre 1000 y 300,000 pesos
				select @w_gasto_semanal = sum(convert(money,rt_respuesta)) from cl_frm_ente_resp_tabla_tmp 
				where rt_pregunta_form = 20 and rt_id_columna > 1
				and rt_ente = @i_ente
			
				if @w_gasto_semanal between @w_limite_inferior and @w_limite_superior
				begin
					print @w_gasto_semanal
					select @w_gasto_semanal = @w_gasto_semanal
				end
				else
				begin 
					select @w_msg = 'La suma de los gastos semanales del cliente no esta en el rango permitido (<'+convert(varchar,@w_limite_inferior)+'> a <'+convert(varchar,@w_limite_superior)+'>)'
					exec sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 70336,
						@i_msg   = @w_msg
					return 0
				end
			end

			--Diferencia entre la totalidad de ingresos y gastos sea un valor superior a los 1000 pesos
			select @w_diferencia_ingresos = @w_ingreso_semanal - @w_gasto_semanal
			
			if @w_diferencia_ingresos < @w_limite_inferior
			begin
				select @w_msg = 'Las diferencia entre ingresos y gastos, es muy pequeña, no llegan a los <'+convert(varchar,@w_limite_inferior)+'> pesos.'
				exec sp_cerror
					@t_from  = @w_sp_name,
					@i_num   = 70337,
					@i_msg   = @w_msg
				return 1
			end 
			
			
			--Validar si hay documentos de soporte para ingresos
			if(@w_ingreso_semanal is not null AND @w_ingreso_semanal > 0)
			begin
				select rt_fila,rt_respuesta
				into #ingresos
				from cl_frm_ente_resp_tabla_tmp 
				where rt_ente= @i_ente 
				and rt_pregunta_form=19 
				and rt_id_columna=1		

				select @w_id_fila=1
				select @w_desc_tipo_doc = ''
				
				while(1=1)
				begin
					select @w_tipo_ingreso = rt_respuesta
					from #ingresos
					where rt_fila = @w_id_fila
					
					if @@rowcount = 0
						break
					
					if(@w_tipo_ingreso = 'LI')
					begin
						select @w_fila= rt_fila 
						from cl_frm_ente_resp_tabla_tmp 
						where rt_ente			=	@i_ente
						and rt_pregunta_form	=	19 
						and rt_respuesta		=	@w_tipo_ingreso
						and rt_fila				= 	@w_id_fila
						
						select @w_valor=sum(convert(money,rt_respuesta))
						from cl_frm_ente_resp_tabla_tmp 
						where rt_ente=@i_ente
						and rt_pregunta_form=19 
						and rt_fila=@w_fila 
						and rt_id_columna>1
						
						if(@w_valor > 0)
						begin						
							select @w_id_documento = td_codigo_tipo_doc from cob_workflow..wf_tipo_documento where td_nombre_tipo_doc='COMPROBANTE LIBRO DE INGRESOS'
							
							if not exists(select * from cob_workflow..wf_req_inst where ri_id_inst_proc=@i_inst_proc and ri_codigo_tipo_doc=@w_id_documento)
							begin
								select @w_desc_tipo_doc= @w_desc_tipo_doc + ' COMPROBANTE LIBRO DE INGRESOS,'
							end
						end
					end
					if(@w_tipo_ingreso = 'FA')
					begin
						select @w_fila= rt_fila 
						from cl_frm_ente_resp_tabla_tmp 
						where rt_ente			=	@i_ente
						and rt_pregunta_form	=	19 
						and rt_respuesta		=	@w_tipo_ingreso
						and rt_fila				= 	@w_id_fila
						
						select @w_valor=sum(convert(money,rt_respuesta))
						from cl_frm_ente_resp_tabla_tmp 
						where rt_ente=@i_ente
						and rt_pregunta_form=19 
						and rt_fila=@w_fila 
						and rt_id_columna>1
						
						if(@w_valor > 0)
						begin
							select @w_id_documento = td_codigo_tipo_doc from cob_workflow..wf_tipo_documento where td_nombre_tipo_doc='COMPROBANTE FACTURAS'
							
							if not exists(select * from cob_workflow..wf_req_inst where ri_id_inst_proc=@i_inst_proc and ri_codigo_tipo_doc=@w_id_documento)
							begin
								select @w_desc_tipo_doc= @w_desc_tipo_doc + ' COMPROBANTE FACTURAS,'
							end
						end
					end
					if(@w_tipo_ingreso = 'NR')
					begin
						select @w_fila= rt_fila 
						from cl_frm_ente_resp_tabla_tmp 
						where rt_ente			=	@i_ente
						and rt_pregunta_form	=	19 
						and rt_respuesta		=	@w_tipo_ingreso
						and rt_fila				= 	@w_id_fila
						
						select @w_valor=sum(convert(money,rt_respuesta))
						from cl_frm_ente_resp_tabla_tmp 
						where rt_ente=@i_ente
						and rt_pregunta_form=19 
						and rt_fila=@w_fila 
						and rt_id_columna>1
						
						if(@w_valor > 0)
						begin
							select @w_id_documento = td_codigo_tipo_doc from cob_workflow..wf_tipo_documento where td_nombre_tipo_doc='COMPROBANTE NOTAS DE REMISION'
							
							if not exists(select * from cob_workflow..wf_req_inst where ri_id_inst_proc=@i_inst_proc and ri_codigo_tipo_doc=@w_id_documento)
							begin
								select @w_desc_tipo_doc= @w_desc_tipo_doc + ' COMPROBANTE NOTAS DE REMISION,'
							end
						end
					end
					
					delete from #ingresos where rt_fila = @w_id_fila
					select @w_id_fila= @w_id_fila+1
				end	

				if(@w_desc_tipo_doc is not null AND @w_desc_tipo_doc <> '')
				begin
					select @w_msg = 'Falta capturar Comprobante de ingreso tipo: '+SUBSTRING(@w_desc_tipo_doc,0,LEN(@w_desc_tipo_doc))
					exec sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 70337,
						@i_msg   = @w_msg
					return 1
				end
			end
			
			if(@w_gasto_semanal is not null AND @w_gasto_semanal > 0)
			begin
				select @w_doc_gastos = isnull(count(*),0) from cob_workflow..wf_req_inst 
				where ri_id_inst_proc = @i_inst_proc
				and ri_codigo_tipo_doc in (select td_codigo_tipo_doc 
											from cob_workflow..wf_tipo_documento 
											where td_nombre_tipo_doc like 'COMPROBANTE DE GASTOS%')
											
				select @w_gastos = isnull(count(*),0)
				from cl_frm_ente_resp_tabla_tmp
				where rt_ente= @i_ente
				and rt_pregunta_form=20 
				and rt_id_columna=1	
				
				if(@w_gastos > 0 and @w_gastos <> @w_doc_gastos)
				begin
					select @o_mensaje = 'Se deberia agregar un comprobante de gastos por cada item registrado'
				end
			end			
			
			--El valor a solicitar (pregunta 16) debe ser múltiplo de 100 Pesos.
			select @w_valor = en_respuesta, @w_pregunta_multi = en_pregunta_form from cl_frm_ente_respuesta_tmp 
			where en_ente 		= @i_ente
			and en_formulario	= @i_id_formulario
			and en_pregunta_form = 16
			
			if @w_pregunta_multi = 16
			begin
				if @w_valor = 0
				begin
					exec sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 70339,
						@i_msg   = 'Se debe solicitar un monto mayor a 0'
					return 1
				end
				
				select @w_validacion = @w_valor % @w_multiplo
				 
				if @w_validacion != 0
				begin
					exec sp_cerror
						@t_from  = @w_sp_name,
						@i_num   = 70339,
						@i_msg   = 'El valor a solicitar debe ser múltiplo de 100 pesos.'
					return 1
				end 
			end
			
			

			if exists(select 1 from cl_frm_ente_respuesta 
			where en_ente 			= @i_ente
			and en_formulario		= @i_id_formulario
			and en_version			= @i_vers_formulario)

			begin
				delete from cl_frm_ente_respuesta 
				where en_ente 			= @i_ente
				and en_formulario		= @i_id_formulario
				and en_version			= @i_vers_formulario
				and en_pregunta_form	in (select  en_pregunta_form
											from cl_frm_ente_respuesta_tmp 
											where en_ente 		= @i_ente
											and en_formulario	= @i_id_formulario
											and en_version 		= @i_vers_formulario)
						
			end 
				
			insert into cl_frm_ente_respuesta(
				en_ente,	en_respuesta_ente,	en_formulario,
				en_version,	en_pregunta_form,	en_respuesta,
				en_fecha_registro, en_usuario)					
			select  en_ente,en_respuesta_ente,en_formulario,
					en_version,en_pregunta_form,en_respuesta,
					en_fecha_registro,
					en_usuario
			from cl_frm_ente_respuesta_tmp 
			where en_ente 		= @i_ente
			and en_formulario	= @i_id_formulario
			and en_version 		= @i_vers_formulario
			
			if @@error != 0
			begin
				-- Error en la insercion
				exec sp_cerror
				@t_from  = @w_sp_name,
				@i_num   = 103118,
				@i_msg   = 'Error en insercion definitiva de datos: cl_frm_ente_respuesta'
				return 1
			end
				
			if exists(select 1 from cl_frm_ente_resp_tabla 
						where rt_ente 		= @i_ente 
						and rt_formulario 	= @i_id_formulario
						and rt_version 		= @i_vers_formulario)
			begin
				delete from cl_frm_ente_resp_tabla 
				where rt_ente 			= @i_ente
				and rt_formulario 		= @i_id_formulario
				and rt_version 			= @i_vers_formulario
				and rt_pregunta_form 	in (select  rt_pregunta_form
											from cl_frm_ente_resp_tabla_tmp
											where rt_ente 		= @i_ente 
											and rt_formulario 	= @i_id_formulario
											and rt_version 		= @i_vers_formulario)
			end
					
			insert into cl_frm_ente_resp_tabla
				(rt_ente,			rt_fila,			rt_respuesta, 	rt_formulario,
				rt_version, 		rt_pregunta_form,	rt_id_columna)
			select  rt_ente,		rt_fila,rt_respuesta,
					rt_formulario,	rt_version,
					rt_pregunta_form,rt_id_columna
			from cl_frm_ente_resp_tabla_tmp
			where rt_ente 		= @i_ente 
			and rt_formulario 	= @i_id_formulario
			and rt_version 		= @i_vers_formulario
			
			if @@error != 0
			begin
				-- Error en la insercion
				exec sp_cerror
				@t_from  = @w_sp_name,
				@i_num   = 103118,
				@i_msg   = 'Error en insercion definitiva de datos: cl_frm_ente_resp_tabla'
				return 1
			end
			
			return 0
		end
		
		if @i_flag = 'I' ---	Eliminar los datos del cliente de las tablas temporales
		begin 
			
			delete from cl_frm_ente_respuesta_tmp where en_ente = @i_ente
			and en_formulario		= @i_id_formulario
			and en_version			= @i_vers_formulario			
			
			delete from cl_frm_ente_resp_tabla_tmp 
			where rt_ente 		= @i_ente
			and rt_formulario 	= @i_id_formulario
			and rt_version 		= @i_vers_formulario
		end		
      
		if @i_es_registro = 'N'
		begin        
			
			select @w_idrespuesta = en_respuesta_ente 
			from cl_frm_ente_respuesta 
			where en_ente 		= @i_ente 
			and en_formulario 	= @i_id_formulario
			and en_version 		= @i_vers_formulario
			and en_pregunta_form = @i_id_pregunta
			
			if @w_idrespuesta is null
				select @w_idrespuesta = isnull(max(en_respuesta_ente),0) + 1 from cl_frm_ente_respuesta
				
			
			---Insertar en la tabla temporal
			insert into cl_frm_ente_respuesta_tmp 
			values( @i_ente,			@w_idrespuesta,		@i_id_formulario,
					@i_vers_formulario,	@i_id_pregunta,		@i_respuesta,
					GETDATE(), 			@s_user)
			
			if @@error != 0
			begin
				-- Error en la insercion
				exec sp_cerror
				@t_from  = @w_sp_name,
				@i_num   = 103118,
				@i_msg   = 'Error en inserción de datos'
				return 1
			end
		end
		
		if @i_es_registro = 'S'
		begin			
			
			insert into cl_frm_ente_resp_tabla_tmp
			values(
			@i_ente,			@i_fila,			@i_respuesta,	@i_id_formulario,
			@i_vers_formulario,	@i_id_pregunta,		@i_column)
			
			if @@error != 0
			begin
				-- Error en la insercion
				exec sp_cerror
				@t_from  = @w_sp_name,
				@i_num   = 103118,
				@i_msg   = 'Error en inserción en tabla: cl_frm_ente_resp_tabla_tmp'
				return 1
			end
		end	
	end

	if @i_operacion = 'F'
	begin
		select  'formulario' 	= pe_formulario,
				'version'    	= pe_version, 
				'pregunta'   	= pe_pregunta,
				'tipo_respuesta'= pe_tipo_resp,
				'respuesta' 	= en_respuesta
		from cobis..cl_frm_preguntas,cobis..cl_frm_ente_respuesta
		where pe_pregunta = en_pregunta_form and
		pe_formulario = en_formulario and
		pe_version = en_version
		and en_ente = @i_ente

		select  'form' 		= rt_formulario,
				'version' 	= rt_version,
				'question' 	= rt_pregunta_form,
				'response' 	= rt_respuesta,
				'column' 	= rt_id_columna,
				'row' 		= rt_fila
		from cobis..cl_frm_ente_resp_tabla where rt_ente = @i_ente
	end
	
	if @i_operacion = 'Q'
	begin	
		if not exists (select 1 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_inst_proc)
		begin
			exec sp_cerror
			@t_from  = @w_sp_name,
			@i_num   = 103118,
			@i_msg   = 'No existe la instancia de proceso'
			return 1
		end
	
		select @o_ente = io_campo_1 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_inst_proc
	end

return 0
	ERROR: 
	exec cobis..sp_cerror
     @t_debug = 'N',
     @t_file = null,
     @t_from  = @w_sp_name,
     @i_num = @w_error,
	 @i_msg = @w_msg
	 
return @w_error

go