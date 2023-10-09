
/************************************************************************/
/*   Archivo:                sp_validacion_vale_socio_comercial.sp      */
/*   Stored procedure:       sp_validacion_vale_socio_comercial         */
/*   Base de datos:          cob_cartera                                */
/*   Producto:               Cartera                                    */
/*   Disenado por:           Javier Ariza                               */
/*   Fecha de escritura:     Octubre/2021                               */
/************************************************************************/
/*                             IMPORTANTE                               */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBISCORP S.A.'.                                                  */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBISCORP S.A. o su representante.        */
/************************************************************************/  
/*                            PROPOSITO                                 */
/*   Validacion de Referencia vale Socio Comercial                      */
/************************************************************************/  
/*          MODIFICACIONES                                              */
/*  FECHA          AUTOR          RAZON                                 */
/*  07/Dic/2021    KVI      Agregado llamado a sp de log                */
/************************************************************************/

use cob_cartera
go	


if exists (select 1 from sysobjects where name = 'sp_validacion_vale_socio_comercial')
   drop proc sp_validacion_vale_socio_comercial
go
	
	create proc sp_validacion_vale_socio_comercial(
	   @s_ssn              int         = null,
	   @s_ofi              smallint    = null,
	   @s_user             login       = null,
	   @s_date             datetime    = null,
	   @s_srv              varchar(30) = null,
	   @s_term	           descripcion = null,
	   @s_rol              smallint    = null,
	   @s_lsrv	           varchar(30) = null,
	   @s_sesn	           int 	       = null,
	   @s_org              char(1)     = null,
	   @s_org_err          int 	       = null,
	   @s_error            int 	       = null,
	   @s_sev              tinyint     = null,
	   @s_msg              descripcion = null,
	   @t_rty              char(1)     = null,
	   @t_trn              int         = null,
	   @t_debug            char(1)     = 'N',
	   @t_file             varchar(14) = null,
	   @t_from             varchar(30) = null,
	   -- -------------------------------------------
	   @i_referencia        varchar(40), -- NÂ° REFERENCIA
	   @i_banco            cuenta     = null,
	   @i_fecha_proceso    date       = null,  -- FECHA PROCESO
	   @i_monto_solicitar  money      = null, -- MONTO
	   @i_operacion 	   char(1)    = null,
	   @o_error            int        = null output, -- 0, 1
	   @o_mensaje          varchar(500) = null output,
	   @o_resultado1	   varchar(255) = null output
	   ) 
	as
	declare @w_sp_name   		   varchar(32),
			@w_error               int,
			@w_msg                 varchar(250) ,
			@w_count               tinyint,
			@w_codigo_interno	   varchar(250),
			@w_banco               cuenta       ,
			@w_cuenta			   varchar(45),
			@w_monto_vale          money,
			@w_tipo_mercado  	   varchar(64),
			@w_nivel_cliente	   varchar(64),
			@w_cliente             int,
			@w_param_colectivo     varchar(30),
			@w_param_nivel_colectivos  varchar(30),
			@w_param_regla		   varchar(64),
			@w_porc_iva            float,
			@w_resultado_val       varchar(30),
			@w_monto_compra        money,
			@w_estado              char(1),
			@w_iva                 money,
			@w_comision                 money,
			@w_fecha_actual    date       = null,
			@w_hora_actual     varchar(8)   =null,
			@w_hora_y_fecha    varchar(20) =null,
			@w_hora_completa   datetime= null,
			@w_inst_proceso    int = null,
		    @w_tramite         int = null,
			@w_param_monto_min money = null,
			@w_monto_min       money = null,
			@w_fecha_real      datetime = null
		
			
	select @w_sp_name = 'sp_validacion_vale_socio_comercial'

	
	
	
	select @w_hora_actual= CONVERT(char(8), GETDATE(), 108)
	
	select @w_fecha_actual= fp_fecha from cobis..ba_fecha_proceso 
	
	
	select @w_hora_y_fecha= CONVERT(varchar, @w_fecha_actual, 111) + ' ' + @w_hora_actual
	     
    select @w_hora_completa= convert(datetime,@w_hora_y_fecha)
	
	
	if(@i_operacion = 'C')
	begin
		if @i_fecha_proceso is null
		begin
			select @i_fecha_proceso = @s_date
		end
		
		select @w_count = count(1) from cob_cartera..ca_lcr_referencia_sc
		where co_referencia = @i_referencia
		and co_estado = 'Z'
		
		if @w_count = 1 --@i_referencia
		begin
			
			--select @i_fecha_proceso,@i_referencia
			
			if EXISTS (select 1 from cob_cartera..ca_lcr_referencia_sc
						where co_referencia = @i_referencia --@i_referencia
						AND co_fecha_proceso = @i_fecha_proceso
						and co_estado = 'Z')
			begin
				select co_monto_cap,--monto vale autorizado
				co_fecha_proceso,--vigencia de referencia
				'VIGENTE'--estado referencia
				from cob_cartera..ca_lcr_referencia_sc
				where co_referencia =@i_referencia
				and co_estado = 'Z'
			end 
			else
			begin
				select co_monto_cap,--monto vale autorizado
				co_fecha_proceso,--vigencia de referencia
				'CADUCADA'
				from cob_cartera..ca_lcr_referencia_sc
				where co_referencia =@i_referencia
				and co_estado = 'Z'
				
				--Se actualiza referencia a caducada
				UPDATE cob_cartera..ca_lcr_referencia_sc
				SET co_estado = 'X'
				WHERE co_referencia =@i_referencia 
				and co_estado = 'Z'
				
			end
		end
		else if @w_count = 0
		begin
			select @w_msg = 'Número de referencia no existe, por  favor valide el número ingresado '+convert(varchar(250), @i_referencia),
			 @w_error = 001
			goto ERROR1
		end	   
		else if @w_count > 1
		begin
			select @w_msg = 'ERROR AL CONSULTAR REFERENCIA SOCIO COMERCIAL '+convert(varchar(100), @i_referencia),
				@w_error = 5000
			goto ERROR1
		end
	end


	-- ------------------------------------------
	-- Referencia Vigente--

	if(@i_operacion = 'V')
	BEGIN 
		
        if @i_fecha_proceso is null
		begin
			select @i_fecha_proceso = @s_date
		end
		

		--Se consulta operacion y Monto de compra
		select @w_codigo_interno=co_codigo_interno,
		       @w_monto_compra=co_monto_cap,
		       @w_estado=co_estado
		from cob_cartera..ca_lcr_referencia_sc 
		where co_referencia = @i_referencia

		select
			@w_cliente=op_cliente,
			@w_tramite = op_tramite
		from cob_cartera..ca_operacion 
		where op_operacion=@w_codigo_interno 
		
		--print 'el resultado codigo interno es'+@w_codigo_interno
	  
		select @w_porc_iva = ro_porcentaje from ca_rubro_op
		where ro_operacion = @w_codigo_interno
		and ro_concepto = 'IVA_INT'  
		
		select
		@w_cuenta = ea_cta_banco ,
		@w_tipo_mercado = ea_colectivo ,
		@w_nivel_cliente = ea_nivel_colectivo
		from cobis..cl_ente_aux
		where ea_ente = @w_cliente

		select @w_param_colectivo = pa_char from cobis..cl_parametro WHERE pa_nemonico = 'CDDFCL'
		select @w_param_nivel_colectivos = pa_char from cobis..cl_parametro WHERE pa_nemonico = 'CDDFNC'
		select @w_param_regla = isnull(@w_tipo_mercado, @w_param_colectivo) + '|' + isnull(@w_nivel_cliente, @w_param_nivel_colectivos ) + '|' + convert(varchar,@i_monto_solicitar)
		
		
		--print 'el resultado de la regla'+@w_param_regla
		--print 'el resultado es'+convert(varchar(100),@i_fecha_proceso)
		--print 'el iva es'+convert(varchar(100),@w_porc_iva)
		
		exec @w_error = cob_cartera..sp_ejecutar_regla
		@s_ssn = @s_ssn,
		@s_ofi = @s_ofi,
		@s_user = @s_user,
		@s_date = @i_fecha_proceso,
		@s_srv = @s_srv,
		@s_term = @s_term,
		@s_rol = @s_rol,
		@s_lsrv = @s_lsrv,
		@s_sesn = @s_ssn,
		@i_regla = 'LCRPORCOM',
		@i_tipo_ejecucion = 'REGLA',
		@i_valor_variable_regla = @w_param_regla,
		@o_resultado1 = @w_resultado_val out
	
		
		--print 'el resultado comision es'+@w_resultado_val
		
		
		select @w_comision=(@i_monto_solicitar*cast(@w_resultado_val as float)/100)
		
		select @w_iva=(@w_comision*@w_porc_iva/100)
		
		select @w_monto_vale=@i_monto_solicitar+ @w_iva +@w_comision;
	
		
		-- ==============================================================
		-- Validacion Monto Minimo
		-- REGLA DE MONTO MIN DE DESEMBOLSO
		select @w_resultado_val = null
		select @w_inst_proceso = io_id_inst_proc
		from cob_workflow..wf_inst_proceso
		where io_campo_3 = @w_tramite
		
		select @w_param_monto_min = isnull(pa_money,0) from cobis..cl_parametro where pa_nemonico = 'MINDIS'

		exec @w_error = cob_cartera..sp_ejecutar_regla
		@s_ssn   = @s_ssn,
		@s_ofi   = @s_ofi,
		@s_user  = @s_user,
		@s_date  = @i_fecha_proceso,
		@s_srv   = @s_srv,
		@s_term  = @s_term,
		@s_rol   = @s_rol,
		@s_lsrv  = @s_lsrv,
		@s_sesn  = @s_ssn,
		@i_regla = 'LCRMMUTI',
		@i_tipo_ejecucion = 'WORKFLOW',
		@i_id_inst_proc   = @w_inst_proceso,
		@o_resultado1     = @w_resultado_val out
		if @w_error <> 0 begin
			select
			@o_mensaje = 'ERROR: AL EJECUTAR LA REGLA DE MONTO MIN DE DESEMBOLSO' ,
			@o_error = 70005
			return 0
			--goto ERROR1
		end
		select @w_monto_min = isnull(convert(money,@w_resultado_val), @w_param_monto_min)

		-- ==============================================================
		
		--print 'el resultado monto vale es'+convert(varchar(100),@w_monto_vale)
		
		--Se Verifica el monto del Vale
		if @i_monto_solicitar < @w_monto_min
		begin
			select @o_error   = 1,
		       @o_mensaje = 'El Monto de Compra debe ser superior o igual a: '+convert(varchar,@w_monto_min)
		end
		else if @i_monto_solicitar > @w_monto_compra begin
			select @o_error   = 1,
		       @o_mensaje = 'Transacción Rechazada, por favor verifique el Monto de Compra'
		end
		else begin
			select @o_error   = 0,
		       @o_mensaje =  'Resultado Exitoso, por favor Cambie el Vale'
			 
		end
		
		
		Select @w_fecha_real = getdate()
		
		--log de aditoria		
		exec @w_error = cob_cartera..lcr_socio_comercial_log
		@s_ssn                = @s_ssn,
		@s_ofi                = @s_ofi,
		@s_user               = @s_user,
		@s_date               = @i_fecha_proceso,
		@s_srv                = @s_srv,
		@s_term               = @s_term,
		@s_rol                = @s_rol,
		@s_lsrv               = @s_lsrv,
		@s_sesn               = @s_ssn,
		@s_org                = @s_org,
        @i_tipo_transaccion   = 'V',
        @i_fecha_proceso      = @w_fecha_real,
		@i_num_referencia     = @i_referencia,
		@i_fecha_referencia   = @i_fecha_proceso,
		@i_estado             = @w_estado,
		@i_monto_aprobado     = @w_monto_compra,
		@i_monto_compra       = @i_monto_solicitar,
		@i_monto_total_compra = @w_monto_vale,
		@i_comision           = @w_comision,
		@i_iva                = @w_iva,
		@i_error              = @o_error,
        @i_mensaje_error      = @o_mensaje
		
		if @w_error <> 0 begin
			goto ERROR1
		end
		
		/*INSERT INTO cob_cartera.dbo.ca_lcr_log_socio_comercial
		(ls_codigo_autorizacion, ls_tipo_transaccion, ls_fecha_proceso, ls_numero_referencia, ls_fecha_referencia,
		ls_estado, ls_login, ls_monto_aprobado, ls_monto_compra, ls_monto_total_compra,
		ls_comision, ls_iva,ls_error, ls_mensaje_error)
		VALUES(null, 'V', getdate(), @i_referencia, @i_fecha_proceso, @w_estado, @s_user, @w_monto_compra, @i_monto_solicitar, @w_monto_vale, @w_comision, @w_iva, @o_error, @o_mensaje)*/
	end

	return 0

	ERROR1:
		exec cobis..sp_cerror
			@t_debug  = 'N',
			@t_file   = null,
			@t_from   = @w_sp_name,
			@i_num    = @w_error,
			@i_msg    = @w_msg
		return @w_error
