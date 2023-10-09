/****************************************************************/
/*   ARCHIVO:         	sp_carga_dato_negocio.sp		        */
/*   NOMBRE LOGICO:   	sp_carga_dato_negocio       		    */
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
/*  Registrar los datos del negocio para respaldo del prestamo  */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   19-12-2019    A. Ortiz        Emision Inicial.     	    */
/****************************************************************/
use cobis
go

if exists (select 1 from sysobjects where name = 'sp_carga_dato_negocio')
   drop proc sp_carga_dato_negocio
go

create procedure sp_carga_dato_negocio(
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
	@t_rty				char(1)     = null,
	@t_trn				int         = null,	
	@i_id_inst_proc   int,    --codigo de instancia del proceso
	@i_id_inst_act    int        = null,    
	@i_id_empresa     int        = null, 
	@o_id_resultado   smallint  = null out     

)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_id_formulario        int,
		@w_version_formulario   int,
		@w_nombre_formulario    varchar(100),
		@w_sit_version          char(1),
		@w_calificacion         int,
		@w_calificacion_minima	int,
		@w_ingreso_semanal      money,
		@w_gasto_semanal        money,
		@w_limite_inferior      money,
		@w_limite_superior      money,
		@w_direccion            int,
		@w_utilidad             money,
		@w_capacidad            money,
		@w_diferencia_ingresos  money,
		@w_consecutivo          int,
		@w_porcentaje_gto       money,
		@w_porcentaje_utildad   money,
		@w_estado               varchar(60),
		@w_porc_gasto_mensual   int,
		@w_porc_utilidad_mensual   int,
		@w_count				int,
		@w_respuestas			varchar(60),
		@w_comodin				varchar(60),
		@w_pregunta				int,
		@w_preguntas_max		int,
		@w_max_resp_ente		int,
		@w_resp_comodin     	char(1),
		@w_ente             	int,
		@w_resultado        	varchar(16),
		@w_total_punto_maximos  money,
		@w_puntos_ente			int,
		@w_calificacion_form    int,
		@w_total_cero			int,
		@w_msg                  varchar(250)
		
		
	select @w_sp_name 	= 'sp_carga_dato_negocio'
	
	select @w_limite_inferior = pa_money 
	from cobis..cl_parametro 
	where pa_nemonico = 'LIMINF'
	
	select @w_limite_superior = pa_money
	from cobis..cl_parametro 
	where pa_nemonico = 'LIMSUP'
	
	select @w_porc_gasto_mensual = pa_int
	from cobis..cl_parametro 
	where pa_nemonico = 'PGM'
	
	select @w_porc_utilidad_mensual = pa_int
	from cobis..cl_parametro 
	where pa_nemonico = 'PUM'
	
	select @w_ente = io_campo_1 from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc
	
	--el formulario no tiene una califiacion 0
	select @w_total_cero = 0 
	

	print 'VALIDA FORMULARIO'
	if not exists(select 1 from cobis..cl_frm_ente_respuesta 
				where en_ente 		= @w_ente)
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 70326
		return 1
	end
	
	if exists(select * from cl_frm_preguntas where pe_pregunta=19) AND exists(select * from  cl_frm_seccion_ctrl where sc_seccion=2 AND sc_visible='S')
	begin
		-- SUMA DE INGRESOS SEMANALES
		select @w_ingreso_semanal = sum(convert(money,rt_respuesta)) from cl_frm_ente_resp_tabla 
		where rt_pregunta_form = 19 and rt_id_columna > 1
		and rt_ente = @w_ente
		
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
	
	-- SUMA DE GASTOS SEMANALES
	if exists(select * from cl_frm_ente_resp_tabla_tmp 
	where rt_pregunta_form = 20 and rt_id_columna > 1
	and rt_ente = @w_ente)
	begin
		--Suma de TODOS los Gastos Semanales debe estar entre 1000 y 300,000 pesos
		select @w_gasto_semanal = sum(convert(money,rt_respuesta)) from cl_frm_ente_resp_tabla_tmp 
		where rt_pregunta_form = 20 and rt_id_columna > 1
		and rt_ente = @w_ente
	
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
	
	select @w_diferencia_ingresos = @w_ingreso_semanal - @w_gasto_semanal
	
	if @w_diferencia_ingresos > @w_limite_superior
	begin
		exec cobis..sp_cerror
			@t_debug = @t_debug,
			@t_file  = @t_file, 
			@t_from  = @w_sp_name,
			@i_num   = 70337
		return 1
	end
	
	--OBTENEMOS LA UTILIDAD
	select @w_utilidad = @w_ingreso_semanal - @w_gasto_semanal
	
	--OBTENEMOS LA CALIFICACION
	select @w_id_formulario = ne_id_formulario,@w_version_formulario = ne_vers_formulario,
	@w_calificacion_minima = ne_calif_minima
	from cl_frm_negocio
	where ne_estado_version = 'P'
	
	select * into #tmp_respuesta from cl_frm_ente_respuesta where en_ente = @w_ente

	-- 1.- Debe generar una nota sobre 100 puntos es decir,que en todas las preguntas se logró la calificación máxima
	--Total de preguntas con calificacion maxima
	select @w_preguntas_max = count(cp_id_pregunta) from cl_frm_catalogo_pregunta 
	where cp_puntos =(select max(cp_puntos) from cl_frm_catalogo_pregunta)
	and cp_id_form = @w_id_formulario
	
	print @w_preguntas_max

	select @w_max_resp_ente = count(en_pregunta_form) from cobis..cl_frm_catalogo_pregunta,cobis..cl_frm_ente_respuesta
	where cp_codigo = en_respuesta and cp_id_pregunta = en_pregunta_form and en_ente = @w_ente
	and cp_puntos = (select max(cp_puntos) from cl_frm_catalogo_pregunta)
	and en_formulario = @w_id_formulario

	print @w_max_resp_ente
	
	if @w_max_resp_ente = @w_preguntas_max
	begin
		select @w_puntos_ente = 100
		select @w_resultado = 'OK'
		print 'calificacion máxima:. '+convert(varchar,@w_puntos_ente)
	end
	--else
	--begin
		-- 3.- Si existe una pregunta con calificación -999, la calificación del formulario será directamente 0 puntos inicio	
		select @w_count = count(en_pregunta_form) from cl_frm_ente_respuesta where en_ente = @w_ente
		
		while @w_count > 0
		begin -- inicio del while
			(select top(1)  @w_pregunta = en_pregunta_form,@w_respuestas = en_respuesta FROM #tmp_respuesta);

			if @w_respuestas = 'S' and @w_pregunta = 21
			begin
				select @w_comodin = cp_puntos from cl_frm_catalogo_pregunta 
				where cp_id_pregunta = @w_pregunta and cp_codigo = @w_respuestas
				and cp_id_form = @w_id_formulario
		
				if @w_comodin = @w_comodin
					select @w_puntos_ente = 0
					select @w_resultado = 'DEVOLVER'
					select @w_total_cero = 1 -- calificacion 0 
					print 'Calificacion Obtenida:.  '+ convert(varchar,@w_puntos_ente)

			end
			
			if @w_respuestas != 'S' and @w_pregunta = 21
			begin
				select @w_calificacion = sum(cp_puntos) from cobis..cl_frm_catalogo_pregunta,cobis..cl_frm_ente_respuesta
				where cp_codigo = en_respuesta and cp_id_pregunta = en_pregunta_form and en_ente = @w_ente
				and en_formulario = @w_id_formulario
				select @w_puntos_ente = @w_calificacion
				select @w_resultado = 'OK'
				print 'Calificacion Obtenida:.  '+ convert(varchar,@w_puntos_ente)
			end
		
			delete from #tmp_respuesta where en_pregunta_form = @w_pregunta
			select @w_count=count(*) from #tmp_respuesta
		end  -- fin del while
	--end

	
	-- 4.- Los formularios que no tengan puntajes asociados, es decir que la suma de sus Máximas
	--	   Calificación posibles de todas las preguntas sea CERO, se calificarán directamente en 100 puntos.
	--	   Se excluirá de esta sumatoria las preguntas calificadas con el comodín “-999”.
	
	select @w_total_punto_maximos = sum(cp_puntos) from cl_frm_catalogo_pregunta 
	where cp_puntos =(select max(cp_puntos) from cl_frm_catalogo_pregunta)
	and cp_id_form = @w_id_formulario

	if @w_total_punto_maximos = 0 or @w_total_punto_maximos is null
	begin
		select @w_puntos_ente = 100;
		select @w_resultado = 'OK'
	end

	select @w_puntos_ente = sum(cp_puntos) from cobis..cl_frm_catalogo_pregunta,cobis..cl_frm_ente_respuesta
	where cp_codigo = en_respuesta and cp_id_pregunta = en_pregunta_form 
	and en_ente = @w_ente and en_pregunta_form !=21
	and en_formulario = @w_id_formulario 
	select @w_resultado = 'OK'			 


	-- 5.- Obtener la calificacion final
	--obtener el total de puntos de las respuestas maximas
	select @w_total_punto_maximos = sum(cp_puntos) from cl_frm_catalogo_pregunta 
	where cp_puntos =(select max(cp_puntos) from cl_frm_catalogo_pregunta)
	and cp_id_form = @w_id_formulario

	print @w_puntos_ente
	print @w_total_punto_maximos				

	select @w_calificacion_form = (@w_puntos_ente / @w_total_punto_maximos) * 100
	select @w_calificacion_form = round(@w_calificacion_form,0)
	
	if @w_total_cero = 1
		begin
		select @w_calificacion_form = 0
		select @w_resultado = 'DEVOLVER'
		end
				
	print 'Calificacion final del cliente para el formulario 1:. '+convert(varchar,@w_calificacion_form)

	--OBTENEMOS LA DIRECCION DEL CLIENTE
	select @w_direccion = di_direccion 
	from cobis..cl_direccion 
	where di_ente = @w_ente and di_principal = 'S'
	
	
	select @w_consecutivo = isnull(max(nc_negocio ),0)+1 from cobis..cl_neg_cliente
	
	--PORCENTAJE DE GASTOS MESUALES
	select @w_porcentaje_gto = (ROUND((CONVERT(FLOAT,@w_gasto_semanal * @w_porc_gasto_mensual) / 100),0))
	--PORCENTAJE DE UTLIDAD MENSUAL
	select @w_porcentaje_utildad = (ROUND((CONVERT(FLOAT,@w_utilidad * @w_porc_utilidad_mensual) / 100),0))
	
	if @w_porcentaje_utildad > @w_porcentaje_gto
	begin
		select @w_capacidad = @w_porcentaje_utildad
	end
	else
	begin
		select @w_capacidad = @w_porcentaje_gto
	end
	
	--	Obtener el estado del formulario
	if @w_calificacion_form < @w_calificacion_minima
    begin
        select @w_estado = 'R', @w_resultado = 'DEVOLVER'
    end
    
	if @w_calificacion_form >= @w_calificacion_minima
    begin
        select @w_estado = 'AN'
    end

	if exists(select 1 from cl_neg_cliente where nc_ente = @w_ente and nc_inst_proc = @i_id_inst_proc)
	begin
		delete from cl_neg_cliente where nc_ente = @w_ente and nc_inst_proc = @i_id_inst_proc

		insert into cobis..cl_neg_cliente(
			nc_negocio,		nc_ente,			nc_direccion,	nc_fecha_investigacion,
			nc_ingreso,		nc_gasto,			nc_utilidad,	nc_calificacion,
			nc_estado,		nc_cap_pago,		nc_formulario,	nc_version,
			nc_inst_proc,	nc_investigador,	nc_verificador)
		values(@w_consecutivo,	@w_ente,			@w_direccion,	  getdate(),
			@w_ingreso_semanal,		@w_gasto_semanal,		@w_utilidad,	  @w_calificacion_form,
			@w_estado,			@w_capacidad,		@w_id_formulario, @w_version_formulario,
			@i_id_inst_proc,	@s_user,			NULL)

		if @@error <> 0
		begin
			exec sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 70327
				/* 'Error en creacion de transaccion de servicio'*/
			return  1
		end
	end
	else
	begin
		insert into cobis..cl_neg_cliente(
			nc_negocio,		nc_ente,			nc_direccion,	nc_fecha_investigacion,
			nc_ingreso,		nc_gasto,			nc_utilidad,	nc_calificacion,
			nc_estado,		nc_cap_pago,		nc_formulario,	nc_version,
			nc_inst_proc,	nc_investigador,	nc_verificador)
		values(@w_consecutivo,	@w_ente,			@w_direccion,	  getdate(),
			@w_ingreso_semanal,		@w_gasto_semanal,		@w_utilidad,	  @w_calificacion_form,
			@w_estado,			@w_capacidad,		@w_id_formulario, @w_version_formulario,
			@i_id_inst_proc,	@s_user,			NULL)
		
		if @@error <> 0
		begin
			exec sp_cerror
				@t_debug = @t_debug,
				@t_file  = @t_file,
				@t_from  = @w_sp_name,
				@i_num   = 70327
				/* 'Error en creacion de transaccion de servicio'*/
			return  1
		end
	end
	
	if @w_resultado = 'OK'
	begin
		print 'Estamos en el OK'
		select @o_id_resultado = 1 -- OK		
	end
	else
	begin
		print 'Estamos en el DEVOLVER'
		select @o_id_resultado = 2 -- DEVOLVER		
	end

return 0

go
