/************************************************************************/
/*      Archivo:                sp_auto_onboard_form_kyc.sp               */
/*      Stored procedure:       sp_auto_onboard_form_kyc                  */
/*      Base de datos:          cobis                                   */
/*      Producto:               Clientes                                */
/*      Disenado por:           KVIZCAINO                               */
/*      Fecha de escritura:     Febrero/2022                            */
/************************************************************************/
/*                              IMPORTANTE                              */
/*      Este programa es parte de los paquetes bancarios propiedad de   */
/*      'COBISCORP'.                                                    */
/*      Su uso no autorizado queda expresamente prohibido asi como      */
/*      cualquier alteracion o agregado hecho por alguno de sus         */
/*      usuarios sin el debido consentimiento por escrito de la         */
/*      Presidencia Ejecutiva de COBISCORP o su representante.          */
/************************************************************************/
/*                              PROPOSITO                               */
/*      Operaciones para formulario KYC AutoOnboarding.                 */
/************************************************************************/
/*                             MODIFICACION                             */
/*    FECHA                 AUTOR                 RAZON                 */
/*    24/02/2022             KVI              Emision Inicial           */
/************************************************************************/

use cobis
go

if exists (select 1 from sysobjects where name = 'sp_auto_onboard_form_kyc')
    drop proc sp_auto_onboard_form_kyc
go

create proc sp_auto_onboard_form_kyc(
@s_ssn              int         = null,
@s_sesn             int         = null,
@s_date             datetime    = null,
@s_user             varchar(14) = null,
@s_term             varchar(30) = null,
@s_ofi              smallint    = null,
@s_srv              varchar(30) = null,
@s_lsrv             varchar(30) = null,
@s_rol              smallint    = null,
@s_org              varchar(15) = null,
@s_culture          varchar(15) = null,
@t_rty              char(1)     = null,
@t_debug            char(1)     = 'N',
@t_file             varchar(14) = null,
@t_trn              int         = null,
@i_operacion        varchar(10) = 'I',
@i_cliente          int,
@i_tipo             varchar(10) = null,
@i_respuesta        varchar(10) = null,
@i_aceptar          char(1)     = null
)
as
declare
@w_sp_name          varchar(25),
@w_error            int,
@w_msg              varchar(200),
@w_profesion        catalogo,
@v_profesion        catalogo,
@w_codigo           int,
@w_actividad_ec     varchar(10),
@v_actividad_ec     varchar(10),
@w_recurso          varchar(10),
@v_recurso          varchar(10),
@w_destino_credito  varchar(10),
@v_destino_credito  varchar(10)


select @w_sp_name = 'sp_auto_onboard_form_kyc'

if not exists(select 1 from cobis..cl_ente where en_ente = @i_cliente)
begin
   select * from cobis..cl_ente 
   where en_ente = @i_cliente
   if @@rowcount = 0
   begin
     select 
     @w_error = 2101152 -- No existe el cliente
     goto ERROR
   end
end

if @i_operacion = 'I'
begin
  if @i_tipo = 'OPA'-- Pregunta: OCUPACION, PROFESION, ACTIVIDAD
  begin   
    select @t_trn = isnull(@t_trn,104) -- Transaccion 104 corresponde a la operacion U 
	
    -- SELECCIONAR PROFESION ANTERIOR DEL CLIENTE
    select @w_profesion = p_profesion
    from cl_ente 
    where en_ente = @i_cliente
    
    -- CAPTURAR DATOS QUE HA CAMBIADO
    select @v_profesion = @w_profesion
    
    if @w_profesion = @i_respuesta      
      select @w_profesion = null, @v_profesion = null
    else   
      select @w_profesion = @i_respuesta
	
    -- ACTUALIZACION PROFESION CLIENTE	
	update cobis..cl_ente
    set p_profesion = isnull(@i_respuesta, p_profesion)
    where en_ente = @i_cliente
  
    if @@error <> 0
    begin
       select 
       @w_error = 105051 -- Error en actualización de cliente
       goto ERROR
    end
    
    -- TRANSACCION DE SERVICIO PREVIO
    insert into ts_persona_prin (secuencia,     tipo_transaccion,    clase,             fecha,           usuario, 
                                 terminal,      srv,                 lsrv,              persona,         oficina, 
  							     fecha_mod,     hora,                profesion)
  							   
                         values (@s_ssn,        @t_trn,              'P',               @s_date,         @s_user, 
                                 @s_term,       @s_srv,              @s_lsrv,           @i_cliente,      @s_ofi,                                          
                                 getdate(),     getdate(),           @v_profesion)
  
    if @@error <> 0
    begin
       select 
       @w_error = 103005 -- Error en creación de transacción de servicio
       goto ERROR
    end
    
    -- TRANSACCION DE SERVICIO ACTUAL
    insert into ts_persona_prin (secuencia,     tipo_transaccion,    clase,             fecha,           usuario, 
                                 terminal,      srv,                 lsrv,              persona,         oficina, 
  							     fecha_mod,     hora,                profesion)
  							   
                         values (@s_ssn,        @t_trn,              'A',               @s_date,         @s_user, 
                                 @s_term,       @s_srv,              @s_lsrv,           @i_cliente,      @s_ofi,                                          
                                 getdate(),     getdate(),           @w_profesion)
  
    if @@error <> 0
    begin
       select 
       @w_error = 103005 -- Error en creación de transacción de servicio
       goto ERROR
    end  		   
  end
  
  
  if @i_tipo = 'AEG'-- Pregunta: ACTIVIDAD ECONOMICA GENERICA
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_act_eco_generica, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,        @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_act_eco_generica = @i_respuesta,
	      ko_fecha_proceso    = @s_date,
		  ko_fecha_real       = getdate(),
		  ko_aceptar          = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
	
	
  if @i_tipo = 'AEE'-- Pregunta: ACTIVIDAD ECONOMICA ESPECIFICA
  begin
    if not exists(select 1 from cl_negocio_cliente where nc_ente = @i_cliente)
    begin
	   exec @w_error     = cobis..sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_negocio_cliente',
            @o_siguiente = @w_codigo out            

       if @w_error <> 0
       begin
           select @w_error = 2101007 -- No existe tabla en tabla de secuenciales
           goto ERROR
       end
		
      insert into cl_negocio_cliente(nc_codigo, nc_ente,    nc_actividad_ec, nc_estado_reg)
                              values(@w_codigo, @i_cliente, @i_respuesta,    'V'          )
	  
      if @@error <> 0
      begin   
         select @w_error = 108003 -- ERROR AL INSERTAR NEGOCIO DEL CLIENTE!
         goto ERROR
      end
      
      insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,      ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_estado_reg,     ts_hora,         ts_canal,
	  ts_actividad_ec)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,         @s_ofi,
      @s_date,            'I',              'V',               getdate(),       'AutoOnboarding',
	  @i_respuesta)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end	  
    end
    else
    begin
      -- SELECCIONAR INFORMACION ANTERIOR DEL CLIENTE
      select @w_actividad_ec = nc_actividad_ec,
	         @w_codigo       = nc_codigo
      from cl_negocio_cliente 
      where nc_ente = @i_cliente

      -- CAPTURAR DATOS QUE HA CAMBIADO
      select @v_actividad_ec = @w_actividad_ec
      
      if @w_actividad_ec = @i_respuesta      
        select @w_actividad_ec = null, @v_actividad_ec = null
      else   
        select @w_actividad_ec = @i_respuesta
	  
	  -- ACTUALIZACION ACTIVIDAD ECONOMICA DEL CLIENTE
	  update cl_negocio_cliente
      set nc_actividad_ec = @i_respuesta
      where nc_ente = @i_cliente
	  
	  if @@error != 0
      begin
         select @w_error = 108004 -- ERROR AL ACTUALIZAR NEGOCIO DEL CLIENTE!
         goto ERROR
      end
	  
	  -- TRANSACCION DE SERVICIO PREVIO
	  insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,        ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_hora,           ts_canal,          ts_actividad_ec)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,           @s_ofi,
      @s_date,            'P',              getdate(),         'AutoOnboarding',  @v_actividad_ec)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end
	  
	  -- TRANSACCION DE SERVICIO ACTUAL
	  insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,        ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_hora,           ts_canal,          ts_actividad_ec)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,           @s_ofi,
      @s_date,            'A',              getdate(),         'AutoOnboarding',  @w_actividad_ec)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end	
    end	  
  end  
  
  
  if @i_tipo = 'ORE'-- Pregunta: ORIGEN DE LOS RECURSOS
  begin
    if not exists(select 1 from cl_negocio_cliente where nc_ente = @i_cliente)
    begin
	   exec @w_error     = cobis..sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_negocio_cliente',
            @o_siguiente = @w_codigo out            

       if @w_error <> 0
       begin
           select @w_error = 2101007 -- No existe tabla en tabla de secuenciales
           goto ERROR
       end
		
      insert into cl_negocio_cliente(nc_codigo, nc_ente,    nc_recurso,      nc_estado_reg)
                              values(@w_codigo, @i_cliente, @i_respuesta,    'V'          )
	  
      if @@error <> 0
      begin   
         select @w_error = 108003 -- ERROR AL INSERTAR NEGOCIO DEL CLIENTE!
         goto ERROR
      end
      
      insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,      ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_estado_reg,     ts_hora,         ts_canal,
	  ts_recurso)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,         @s_ofi,
      @s_date,            'I',              'V',               getdate(),       'AutoOnboarding',
	  @i_respuesta)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end	  
    end
    else
    begin
      -- SELECCIONAR INFORMACION ANTERIOR DEL CLIENTE
      select @w_recurso = nc_recurso,
	         @w_codigo  = nc_codigo
      from cl_negocio_cliente 
      where nc_ente = @i_cliente

      -- CAPTURAR DATOS QUE HA CAMBIADO
      select @v_recurso = @w_recurso
      
      if @w_recurso = @i_respuesta      
        select @w_recurso = null, @v_recurso = null
      else   
        select @w_recurso = @i_respuesta  
	  
	  -- ACTUALIZACION ACTIVIDAD ECONOMICA DEL CLIENTE
	  update cl_negocio_cliente
      set nc_recurso = @i_respuesta
      where nc_ente = @i_cliente
	  
	  if @@error != 0
      begin
         select @w_error = 108004 -- ERROR AL ACTUALIZAR NEGOCIO DEL CLIENTE!
         goto ERROR
      end
	  
	  -- TRANSACCION DE SERVICIO PREVIO
	  insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,        ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_hora,           ts_canal,          ts_recurso)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,           @s_ofi,
      @s_date,            'P',              getdate(),         'AutoOnboarding',  @v_recurso)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end
	  
	  -- TRANSACCION DE SERVICIO ACTUAL
	  insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,        ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_hora,           ts_canal,          ts_recurso)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,           @s_ofi,
      @s_date,            'A',              getdate(),         'AutoOnboarding',  @w_recurso)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end	 
    end	  
  end  
  
  
  if @i_tipo = 'DRE'-- Pregunta: DESTINO DE LOS RECURSOS
  begin
    if not exists(select 1 from cl_negocio_cliente where nc_ente = @i_cliente)
    begin
	   exec @w_error     = cobis..sp_cseqnos
            @t_debug     = @t_debug,
            @t_file      = @t_file,
            @t_from      = @w_sp_name,
            @i_tabla     = 'cl_negocio_cliente',
            @o_siguiente = @w_codigo out            

       if @w_error <> 0
       begin
           select @w_error = 2101007 -- No existe tabla en tabla de secuenciales
           goto ERROR
       end
		
      insert into cl_negocio_cliente(nc_codigo, nc_ente,    nc_destino_credito, nc_estado_reg)
                              values(@w_codigo, @i_cliente, @i_respuesta,       'V'          )
	  
      if @@error <> 0
      begin   
         select @w_error = 108003 -- ERROR AL INSERTAR NEGOCIO DEL CLIENTE!
         goto ERROR
      end
      
      insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,      ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_estado_reg,     ts_hora,         ts_canal,
	  ts_destino_credito)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,         @s_ofi,
      @s_date,            'I',              'V',               getdate(),       'AutoOnboarding',
	  @i_respuesta)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end	  
    end
    else
    begin
      -- SELECCIONAR INFORMACION ANTERIOR DEL CLIENTE
      select @w_destino_credito = nc_destino_credito,
	         @w_codigo  = nc_codigo
      from cl_negocio_cliente 
      where nc_ente = @i_cliente

      -- CAPTURAR DATOS QUE HA CAMBIADO
      select @v_destino_credito = @w_destino_credito
      
      if @w_destino_credito = @i_respuesta      
        select @w_destino_credito = null, @v_destino_credito = null
      else   
        select @w_destino_credito = @i_respuesta  
	  
	  -- ACTUALIZACION ACTIVIDAD ECONOMICA DEL CLIENTE
	  update cl_negocio_cliente
      set nc_destino_credito = @i_respuesta
      where nc_ente = @i_cliente
	  
	  if @@error != 0
      begin
         select @w_error = 108004 -- ERROR AL ACTUALIZAR NEGOCIO DEL CLIENTE!
         goto ERROR
      end
	  
	  -- TRANSACCION DE SERVICIO PREVIO
	  insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,        ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_hora,           ts_canal,          ts_destino_credito)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,           @s_ofi,
      @s_date,            'P',              getdate(),         'AutoOnboarding',  @v_destino_credito)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end
	  
	  -- TRANSACCION DE SERVICIO ACTUAL
	  insert into ts_negocio_cliente(
      ts_secuencial,      ts_codigo,        ts_ente,           ts_usuario,        ts_oficina,
      ts_fecha_proceso,   ts_operacion,     ts_hora,           ts_canal,          ts_destino_credito)
      values (                                                                  
      @s_sesn,            @w_codigo,        @i_cliente,        @s_user,           @s_ofi,
      @s_date,            'A',              getdate(),         'AutoOnboarding',  @w_destino_credito)
	  
      if @@error <> 0
      begin   
         select @w_error = 103005 -- Error en creación de transacción de servicio
         goto ERROR
      end	  
	end
  end  
  
  
  if @i_tipo = 'FEA'-- Pregunta: FIRMA ELECTRONICA AVANZADA
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_firma_electronica, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,         @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_firma_electronica = @i_respuesta,
	      ko_fecha_proceso     = @s_date,
		  ko_fecha_real        = getdate(),
		  ko_aceptar           = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'FPU'-- Pregunta: FUNCIONES PUBLICAS
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_funciones_publicas, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,          @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_funciones_publicas = @i_respuesta,
	      ko_fecha_proceso      = @s_date,
		  ko_fecha_real         = getdate(),
		  ko_aceptar            = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'TIN'-- Pregunta: TRANSFERENCIAS INTERNACIONALES
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_serv_transf_inter, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,         @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_serv_transf_inter = @i_respuesta,
	      ko_fecha_proceso     = @s_date,
		  ko_fecha_real        = getdate(),
		  ko_aceptar           = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'CVD'-- Pregunta: COMPRA VENTA DIVISAS
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_transac_divisas, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,       @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_transac_divisas = @i_respuesta,
	      ko_fecha_proceso   = @s_date,
		  ko_fecha_real      = getdate(),
		  ko_aceptar         = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'TNEN'-- Pregunta: TRANSFERENCIAS NACIONALES ENVIADAS NUMERO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_tran_nac_env_num, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,        @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_tran_nac_env_num = @i_respuesta,
	      ko_fecha_proceso    = @s_date,
		  ko_fecha_real       = getdate(),
		  ko_aceptar          = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'TNEM'-- Pregunta: TRANSFERENCIAS NACIONALES ENVIADAS MONTO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_tran_nac_env_monto, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,          @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_tran_nac_env_monto = @i_respuesta,
	      ko_fecha_proceso      = @s_date,
		  ko_fecha_real         = getdate(),
		  ko_aceptar            = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'TNRN'-- Pregunta: TRANSFERENCIAS NACIONALES RECIBIDAS NUMERO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_tran_nac_rec_num, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,        @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_tran_nac_rec_num = @i_respuesta,
	      ko_fecha_proceso    = @s_date,
		  ko_fecha_real       = getdate(),
		  ko_aceptar          = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'TNRM'-- Pregunta: TRANSFERENCIAS NACIONALES RECIBIDAS MONTO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_tran_nac_rec_monto, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,          @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_tran_nac_rec_monto = @i_respuesta,
	      ko_fecha_proceso      = @s_date,
		  ko_fecha_real         = getdate(),
		  ko_aceptar            = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'DEN'-- Pregunta: DEPOSITOS EN EFECTIVO NUMERO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_depo_efectivo_num, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,         @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_depo_efectivo_num = @i_respuesta,
	      ko_fecha_proceso     = @s_date,
		  ko_fecha_real        = getdate(),
		  ko_aceptar           = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'DEM'-- Pregunta: DEPOSITOS EN EFECTIVO MONTO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_depo_efectivo_monto, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,           @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_depo_efectivo_monto = @i_respuesta,
	      ko_fecha_proceso       = @s_date,
		  ko_fecha_real          = getdate(),
		  ko_aceptar             = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'DNEN'-- Pregunta: DEPOSITOS NO EFECTIVO NUMERO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_depo_no_efectivo_num, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,            @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_depo_no_efectivo_num = @i_respuesta,
	      ko_fecha_proceso        = @s_date,
		  ko_fecha_real           = getdate(),
		  ko_aceptar              = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end
  
  
  if @i_tipo = 'DNEM'-- Pregunta: DEPOSITOS NO EFECTIVO MONTO
  begin
    if not exists(select 1 from cl_auto_onboard_form_kyc where ko_ente = @i_cliente)
	begin
	  insert into cl_auto_onboard_form_kyc(ko_ente,    ko_depo_no_efectivo_monto, ko_fecha_proceso, ko_fecha_real, ko_aceptar)
	                                values(@i_cliente, @i_respuesta,              @s_date,          getdate(),     @i_aceptar)
	end
	else
	begin
	  update cl_auto_onboard_form_kyc 
	  set ko_depo_no_efectivo_monto = @i_respuesta,
	      ko_fecha_proceso          = @s_date,
		  ko_fecha_real             = getdate(),
		  ko_aceptar                = @i_aceptar
	  where ko_ente = @i_cliente
	end
	
	if @@error <> 0
    begin
       select 
       @w_error = 108003, 
       @w_msg   = 'ERROR: AL INSERTAR/ACTUALIZAR CLIENTE ' + convert(varchar(200),@i_cliente) + 'EN TABLA KYC - PREGUNTA:' + @i_tipo
       goto ERROR
    end
  end

end

if @i_operacion = 'C' -- Consulta Reporte
begin
  select 
      'fechaProceso'          = (select convert(varchar(10), fp_fecha, 103)from cobis..ba_fecha_proceso), 
      'nombre'            	  = isnull(en_nombre,'')+ ' ' +isnull(p_s_nombre,'')+ ' ' +isnull(p_p_apellido,'') +' ' +isnull(p_s_apellido,''),
      'genero'                = (select valor from cl_catalogo where codigo = p_sexo
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_sexo')),
      'rfcHomoclave'          = en_nit,
      'ciudadNac'			  = (select valor from cl_catalogo where codigo = convert(varchar(10), p_depa_nac)
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_provincia')),
      'fechaNac'    		  = convert(varchar(10), p_fecha_nac, 103),
      'paisNac'    			  = (select pa_descripcion from cl_pais where pa_pais = p_pais_emi),
      'nacionalidad'      	  = (select valor from cl_catalogo where codigo = en_nac_aux
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_nacionalidad')),	                                	
      'calleNumero'   		  = (select top 1 convert(varchar(40),isnull(di_calle, '')) + ' ' + convert(varchar(10),isnull(di_nro, '')) 
                                 + (case di_nro_interno when -1 then '' else (' (' + convert(varchar(10), di_nro_interno) + ')') end)  
                                 from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),	        							
      'colonia'               = (select pq_descripcion from cl_parroquia where pq_parroquia = (select top 1 convert(varchar(10), di_parroquia) 
                                 from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
      'municipio'             = (select ci_descripcion from cl_ciudad where ci_ciudad = (select top 1 convert(varchar(10), di_ciudad) 
                                 from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
      'estado'                = (select pv_descripcion from cl_provincia where pv_provincia = (select top 1 convert(varchar(10), di_provincia) 
      							 from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
      'codPostal'             = (select top 1 di_codpostal from cl_direccion where di_ente = en_ente and di_tipo = 'RE'),
      'pais'                  = (select pa_descripcion from cl_pais where pa_pais = (select top 1 di_pais from cl_direccion where di_ente = en_ente and di_tipo = 'RE')),
      'ocupacion'             = (select valor from cl_catalogo where codigo = p_profesion
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_profesion')), 
      'actEcoGenerica'        = (select valor from cl_catalogo where codigo = (select top 1 ko_act_eco_generica from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente)
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_profesion')),  
      'actEcoEspecifica'      = (select acg_actividad_especifica from cl_actividad_generica 
      							 where acg_codigo_actividad = (select top 1 nc_actividad_ec from cobis..cl_negocio_cliente where nc_ente = en_ente)), 
      'curp'                  = en_ced_ruc,
      'telefono'              = isnull((select top 1 isnull(te_valor+'; ','') from cobis..cl_telefono, cobis..cl_direccion where di_ente =  en_ente
                                        and di_ente = te_ente
                                        and di_tipo = 'RE'
                                        and te_tipo_telefono = 'D'),'') +
                                isnull((select top 1 te_valor from cobis..cl_telefono, cobis..cl_direccion
                                        where di_ente = en_ente
                                        and di_ente = te_ente
                                        and di_tipo = 'RE'
                                        and te_tipo_telefono = 'C'),''),
      'email'				  = (select top 1 di_descripcion from cobis..cl_direccion 
                                 where di_ente = en_ente and di_tipo = 'CE'),
      'firmaElecAvanzada'     = (select top 1 (case ko_firma_electronica when 'S' then 'SI' when 'N' then 'NO' else '' end)                                                                	  
	                             from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), 
      'origenRecursos'        = (select valor from cl_catalogo where codigo = (select top 1 nc_recurso from cobis..cl_negocio_cliente where nc_ente = en_ente)
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_recursos_credito')),
      'destinoRecursos'       = (select valor from cl_catalogo where codigo = (select top 1 nc_destino_credito from cobis..cl_negocio_cliente where nc_ente = en_ente)
                                 and tabla = (select codigo from cl_tabla where tabla = 'cl_destino_credito')),
      'respA'                 = (select top 1 (case ko_funciones_publicas when 'S' then 'SI' when 'N' then 'NO' else '' end)                                                                	  
	                             from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), 
      'respB'                 = (select top 1 (case ko_serv_transf_inter when 'S' then 'SI' when 'N' then 'NO' else '' end)                                                                	  
	                             from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), 
      'respC'                 = (select top 1 (case ko_transac_divisas when 'S' then 'SI' when 'N' then 'NO' else '' end)                                                                	  
	                             from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente),  
      'numEstOperEnv'         = isnull((select top 1 ko_tran_nac_env_num from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''), 
      'montoEstOperEnv'       = isnull((select top 1 convert(varchar,format(convert(money,ko_tran_nac_env_monto),'N')) from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''),  
      'numEstOperRec'         = isnull((select top 1 ko_tran_nac_rec_num from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''), 
      'montoEstOperRec'       = isnull((select top 1 convert(varchar,format(convert(money,ko_tran_nac_rec_monto),'N')) from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''),  
      'numEstOperEfe'         = isnull((select top 1 ko_depo_efectivo_num from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''), 
      'montoEstOperEfe'       = isnull((select top 1 convert(varchar,format(convert(money,ko_depo_efectivo_monto),'N')) from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''),  
      'numEstOperNoEfe'       = isnull((select top 1 ko_depo_no_efectivo_num from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''), 
      'montoEstOperNoEfe'     = isnull((select top 1 convert(varchar,format(convert(money,ko_depo_no_efectivo_monto),'N')) from cobis..cl_auto_onboard_form_kyc where ko_ente = en_ente), ''),  
      'nombreEjecutivo'       = '',
      'codigo'            	  = en_ente,
      'numContraparte'        = '01',
      'canalContratacion'     = '02',
      'fechaNacConst'         = ''
  from cobis..cl_ente, cobis..cl_ente_aux   
  where en_ente = @i_cliente
  and en_ente = ea_ente
end

return 0

ERROR:
exec cobis..sp_cerror
        @t_debug  = 'N',
        @t_file   = null,
        @t_from   = @w_sp_name,
        @i_num    = @w_error,
        @i_msg    = @w_msg
        
return @w_error
go