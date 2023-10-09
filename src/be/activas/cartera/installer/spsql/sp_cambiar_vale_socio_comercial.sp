
/************************************************************************/
/*   Archivo:                sp_cambiar_vale_socio_comercial.sp         */
/*   Stored procedure:       sp_cambiar_vale_socio_comercial            */
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
/*   Cambiar vale socio comercial                                       */
/************************************************************************/  
/*          MODIFICACIONES                                              */
/*  FECHA          AUTOR          RAZON                                 */
/*  07/Dic/2021    KVI      Agregado llamado a sp de log                */
/************************************************************************/

use cob_cartera
go


if exists (select 1 from sysobjects where name = 'sp_cambiar_vale_socio_comercial')
   drop proc sp_cambiar_vale_socio_comercial
go

CREATE proc sp_cambiar_vale_socio_comercial(
       @s_ssn             int         = null,
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
	   

@i_referencia varchar(40) =null, -- N° REFERENCIA
@i_fecha_proceso date=null, -- FECHA PROCESO
@i_monto_solicitar money =null,-- MONTO
@o_codigo_autorizacion varchar(6) =null out,
@o_fecha_autorizacion  varchar(25)= null out) --CODIGO DE AUTORIZACION
as
declare		@w_sp_name   		   varchar(32),
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
			@w_resultado_com       varchar(30),
			@w_monto_aprobado      money,
			@w_monto_compra        money,
			@w_estado              char(1),
			@w_iva                 money,
			@w_comision                 money,
			@w_fecha_actual    date       = null,
			@w_hora_actual     varchar(8)   =null,
			@w_hora_y_fecha    varchar(20) =null
			

	
	
	    select @w_sp_name='sp_cambiar_vale_socio_comercial'
	
			
			
               
               
        -- Se consulta la Operacion       
        select @w_codigo_interno=co_codigo_interno,
        @w_monto_compra = co_monto_cap,
        @w_estado=co_estado
		from cob_cartera..ca_lcr_referencia_sc 
		where co_referencia = @i_referencia
		and co_estado = 'Z'
		
		-- Se consulta el banco y el cliente
		select @w_banco=op_banco,
		@w_cliente=op_cliente
		from cob_cartera..ca_operacion 
		where op_operacion=@w_codigo_interno --cob_cartera..ca_lcr_referencia_sc.co_codigo_interno
		



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
		@o_resultado1 = @w_resultado_com out
		
		
		if @w_error <> 0 begin
		   select
		   @w_error        = @w_error,
		   @w_sp_name      = 'cob_cartera..sp_ejecutar_regla',
		   @w_msg          = 'Error al ejecutar cob_cartera..sp_ejecutar_regla '
		      goto ERROR     
		   end
		
		
		
		
		select @w_comision=(@i_monto_solicitar*cast(@w_resultado_com as float)/100)
		
		select @w_iva=(@w_comision*@w_porc_iva/100)
		
		select @w_monto_aprobado=@i_monto_solicitar+ @w_iva+@w_comision;
	
	


          select @o_codigo_autorizacion= LEFT(SUBSTRING (RTRIM(Rand()) + SUBSTRING(RTRIM(Rand()),3,11), 3,11),6) 
          
		     select @w_hora_actual= CONVERT(char(8), GETDATE(), 108)
			
			select @w_fecha_actual= fp_fecha from cobis..ba_fecha_proceso 
			
			
			select @w_hora_y_fecha= CONVERT(varchar, @w_fecha_actual, 23) + ' ' + @w_hora_actual
			    
		   
			-- select @o_fecha_autorizacion= convert(datetime,@w_hora_y_fecha)
			select @o_fecha_autorizacion= @w_hora_y_fecha
           
          
          insert into cob_cartera.dbo.ca_desembolsos_pendientes
                  (dp_referencia,dp_banco,  dp_fecha_proceso , dp_estado ,dp_login , dp_monto_aprobado ,dp_monto_compra ,
                   dp_comision , dp_iva, dp_codido_autorizacion)
            values(@i_referencia, @w_banco, @w_fecha_actual ,'I',@s_user,@w_monto_aprobado ,@i_monto_solicitar ,@w_comision ,@w_iva,@o_codigo_autorizacion)
            
            if @@error <> 0 return 601161
            
            --Se actualiza referencia a aplicada
				UPDATE cob_cartera..ca_lcr_referencia_sc
				SET co_estado = 'A'
				WHERE co_referencia =@i_referencia 
				and co_estado = 'Z'
				
				if @@error <> 0 return 355032
				
				
		   if @i_fecha_proceso is null
		   begin
			select @i_fecha_proceso = @s_date
		   end
           
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
		   @i_cod_autorizacion   = @o_codigo_autorizacion,
           @i_tipo_transaccion   = 'A',
           @i_fecha_proceso      = @w_fecha_actual,
		   @i_num_referencia     = @i_referencia,
		   @i_fecha_referencia   = @i_fecha_proceso,
		   @i_estado             = 'A',
		   @i_monto_aprobado     = @w_monto_compra,
		   @i_monto_compra       = @i_monto_solicitar,
		   @i_monto_total_compra = @w_monto_vale,
		   @i_comision           = @w_comision,
		   @i_iva                = @w_iva,
		   @i_error              = 0,
           @i_mensaje_error      = 'Transaccion Autorizada, por favor Cambie el Vale'
		   
		   if @w_error <> 0 begin
		   	goto ERROR
		   end
		
           /*INSERT INTO cob_cartera.dbo.ca_lcr_log_socio_comercial
				(ls_codigo_autorizacion, ls_tipo_transaccion, ls_fecha_proceso, ls_numero_referencia, ls_fecha_referencia,
				ls_estado, ls_login, ls_monto_aprobado, ls_monto_compra, ls_monto_total_compra,
				ls_comision, ls_iva,ls_error, ls_mensaje_error)
				VALUES(@o_codigo_autorizacion, 'A', @w_fecha_actual, @i_referencia, @i_fecha_proceso, 'A', @s_user, @w_monto_compra, @i_monto_solicitar, @w_monto_vale, @w_comision, @w_iva, 0, 'Transaccion Autorizada, por favor Cambie el Vale');
		       
			if @@error <> 0 return 601161*/
          	

return 0


ERROR:


exec cobis..sp_cerror
      @t_debug = 'N',
      @t_file  = null,
      @t_from  = @w_sp_name,
      @i_num   = @w_error
return @w_error  



