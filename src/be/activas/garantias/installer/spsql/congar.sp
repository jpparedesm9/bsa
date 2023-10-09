use cob_custodia
go

if exists(select 1 from sysobjects where name = 'sp_congar_gar')
   drop proc sp_congar_gar
go
create proc sp_congar_gar
   @i_filial   int,
   @i_fecha    datetime,
   @i_cierre   char(1) = 'M',
   @i_opcion   char(1) = 'C'
as
declare
   @w_tc_oficina        int,
   @w_tc_tipo_bien      char(1),
   @w_tc_op_clase       char(1),
   @w_tc_moneda         int,
   @w_tc_calificacion   char(1),
   @w_tc_clase_custodia char(1),
   @w_tc_tipo           descripcion,
   @w_tc_codvalor       int,
   @w_tc_valor          money,
   @w_tc_codigo_externo varchar(50),
   @w_dp_cuenta         varchar(60),
   @w_dp_area           varchar(10),
   @w_anexo             varchar(255),
   @w_valor_nal         float,
   @w_valor_ext         float,
   @w_error             int,
   @w_cotizacion        float,
   @w_re_area           smallint,
   @w_cuenta_final      varchar(60),
   @w_adicional         varchar(50),
   @w_fecha             varchar(10),
   @w_err_conta        varchar(10)



   exec @w_error = cob_interfase..sp_errorcconta
   @t_trn       = 60025,
   @i_operacion = 'D',
   @i_empresa   =  @i_filial,
   @i_producto  = 19

   if @w_error != 0
      return @w_error


   delete cob_ccontable..cco_boc
   where bo_empresa   = 1
   and   bo_fecha     = @i_fecha
   and   bo_producto  = 19


   declare cVal cursor
   for select tc_oficina,		tc_tipo_bien,    	tc_op_clase,         	tc_moneda,
              tc_calificacion, 		tc_clase_custodia,   	tc_tipo,		tc_codvalor,     
	      isnull(tc_valor, 0), 	dp_cuenta,		dp_area
       from   cu_tmp_contagar_mes, 
	      cob_conta..cb_det_perfil
       where  dp_codval 	= tc_codvalor
       and    dp_producto 	= 19
       and    dp_perfil   	= 'BOC'
       and    isnull(tc_valor, 0)!= 0
   
   open cVal
   fetch cVal
   into  @w_tc_oficina,
         @w_tc_tipo_bien,      @w_tc_op_clase,       @w_tc_moneda,
         @w_tc_calificacion,   @w_tc_clase_custodia, @w_tc_tipo,
         @w_tc_codvalor,       @w_tc_valor,          @w_dp_cuenta,
         @w_dp_area
   while (@@fetch_status = 0)
   begin

      if @w_dp_cuenta is not null
      begin
         select @w_cuenta_final = ''
         exec @w_error = sp_resuelve_param
              @i_filial            = @i_filial,
              @i_tc_tipo_bien      = @w_tc_tipo_bien,
              @i_tc_op_clase       = @w_tc_op_clase,
              @i_tc_moneda         = @w_tc_moneda,
              @i_tc_calificacion   = @w_tc_calificacion,
              @i_tc_clase_custodia = @w_tc_clase_custodia,
              @i_tc_tipo           = @w_tc_tipo,
              @i_cuenta_orig       = @w_dp_cuenta,
              @o_cuenta_dest       = @w_cuenta_final out
         
         if @w_error != 0 
         begin
	    select @w_anexo = ''
	    select @w_cuenta_final = ''
	    select @w_anexo = 'Error en sp_resuelve_param'
            goto  ERROR_CUADRE
         end

         if @w_tc_moneda = 0
            select @w_valor_nal = @w_tc_valor,
                   @w_valor_ext = null
         ELSE
         begin
            select @w_valor_ext = @w_tc_valor
            exec cob_cartera..sp_conversion_moneda
                 @s_date               = @i_fecha,
                 @i_opcion             = 'L',
                 @i_moneda_monto       = @w_tc_moneda,
                 @i_moneda_resultado   = 0,
                 @i_monto              = @w_valor_ext,
                 @i_fecha              = @i_fecha,
                 @o_monto_resultado    = @w_valor_nal out,
                 @o_tipo_cambio        = @w_cotizacion out
         end

         select @w_re_area = ta_area
         from   cob_conta..cb_tipo_area
         where  ta_empresa  = @i_filial
         and    ta_producto = 19
         and    ta_tiparea  = @w_dp_area

         if @w_tc_oficina = 9000
            select @w_re_area = 3030
        
         if @w_tc_oficina = 3029
            select @w_re_area = 3029
        
         exec @w_error = cob_ccontable..sp_ing_opera
              @i_empresa        = @i_filial,
              @i_producto       = 19,
              @i_fecha          = @i_fecha, 
              @i_cuenta         = @w_cuenta_final,
              @i_oficina        = @w_tc_oficina, 
              @i_area           = @w_re_area,
              @i_moneda         = @w_tc_moneda,
              @i_val_opera_mn   = @w_valor_nal,
              @i_val_opera_me   = @w_valor_ext,
              @i_tipo           = 'S',
              @t_trn            = 60032,
              @i_operacion = 'I'
            
         if @w_error != 0 -- ERROR GRAVE
         begin
	    select @w_anexo = ''
	    select @w_anexo = 'Error en cob_ccontable..sp_ing_opera'
            select @w_anexo = @w_anexo + ' OFI: ' + convert(varchar(4), @w_tc_oficina)
            select @w_anexo = @w_anexo + '  CUENTA : ' + @w_cuenta_final
            select @w_anexo = @w_anexo + '  AREA : ' + convert(varchar(6), @w_dp_area)
            select @w_anexo = @w_anexo + '  MONEDA : ' + convert(varchar(3), @w_tc_moneda)
            select @w_anexo = @w_anexo + '  VALOR : ' + convert(varchar(30), @w_tc_valor)
               
            goto ERROR_CUADRE
         end

         --Insertar Detalle BD de Cuadre emg
      end
      ELSE
      begin
         select @w_anexo = ''
	 select @w_anexo = 'No existe cuenta'   
         select @w_anexo = @w_anexo + '   OFI: ' + convert(varchar(4), @w_tc_oficina)
         select @w_anexo = @w_anexo + '  CUENTA : SIN CUENTA PARA CODIGO VALOR 22'
         select @w_anexo = @w_anexo + '  AREA : ' + convert(varchar(6), @w_dp_area)
         select @w_anexo = @w_anexo + '  MONEDA : ' + convert(varchar(3), @w_tc_moneda)
         select @w_anexo = @w_anexo + '  VALOR : ' + convert(varchar(30), @w_tc_valor)
         
         goto ERROR_CUADRE
      end

      goto SIGUIENTE

      ERROR_CUADRE:
      insert into cu_error_contagar
      (ec_fecha_proc,  ec_cta_contable,  ec_cta_final,  ec_error)
      values (@w_fecha,@w_dp_cuenta,@w_cuenta_final, @w_anexo)
      SIGUIENTE: 
      fetch cVal
      into  @w_tc_oficina,
            @w_tc_tipo_bien,      @w_tc_op_clase,       @w_tc_moneda,
            @w_tc_calificacion,   @w_tc_clase_custodia, @w_tc_tipo,
            @w_tc_codvalor,       @w_tc_valor,          @w_dp_cuenta,
            @w_dp_area
   end
   close cVal
   deallocate cVal


   if @i_opcion = 'D'
   begin
   exec @w_error = cob_ccontable..sp_ing_opera_det
        @i_empresa        = @i_filial,
        @i_producto       = 19,
        @i_fecha          = @i_fecha, 
        @i_operacion      = 'D',
        @t_trn            = 60033
   
   if @w_error != 0
      return @w_error

   declare cValDet cursor
   for select tc_oficina,		tc_tipo_bien,    	tc_op_clase,         	tc_moneda,
              tc_calificacion, 		tc_clase_custodia,   	tc_tipo,		tc_codvalor,     
	      isnull(tc_valor, 0), 	dp_cuenta,		dp_area,	        tc_codigo_externo
       from   cu_tmp_contagar_det_mes, 
	      cob_conta..cb_det_perfil
       where  dp_codval 	= tc_codvalor
       and    dp_producto 	= 19
       and    dp_perfil   	= 'BOC'
       and    isnull(tc_valor, 0)!= 0
   
   open cValDet
   fetch cValDet
   into  @w_tc_oficina,
         @w_tc_tipo_bien,      @w_tc_op_clase,       @w_tc_moneda,
         @w_tc_calificacion,   @w_tc_clase_custodia, @w_tc_tipo,
         @w_tc_codvalor,       @w_tc_valor,          @w_dp_cuenta,
         @w_dp_area,	       @w_tc_codigo_externo
   while (@@fetch_status = 0)
   begin

      if @w_dp_cuenta is not null
      begin
         select @w_cuenta_final = ''
         exec @w_error = sp_resuelve_param
              @i_filial            = @i_filial,
              @i_tc_tipo_bien      = @w_tc_tipo_bien,
              @i_tc_op_clase       = @w_tc_op_clase,
              @i_tc_moneda         = @w_tc_moneda,
              @i_tc_calificacion   = @w_tc_calificacion,
              @i_tc_clase_custodia = @w_tc_clase_custodia,
              @i_tc_tipo           = @w_tc_tipo,
              @i_cuenta_orig       = @w_dp_cuenta,
              @o_cuenta_dest       = @w_cuenta_final out
         
         if @w_error != 0 
         begin
	    select @w_anexo = ''
	    select @w_cuenta_final = ''
	    select @w_anexo = 'Error en sp_resuelve_param'
            goto  ERROR_CUADRE_DET
         end

         if @w_tc_moneda = 0
            select @w_valor_nal = @w_tc_valor,
                   @w_valor_ext = null
         ELSE
         begin
            select @w_valor_ext = @w_tc_valor
            exec cob_cartera..sp_conversion_moneda
                 @s_date               = @i_fecha,
                 @i_opcion             = 'L',
                 @i_moneda_monto       = @w_tc_moneda,
                 @i_moneda_resultado   = 0,
                 @i_monto              = @w_valor_ext,
                 @i_fecha              = @i_fecha,
                 @o_monto_resultado    = @w_valor_nal out,
                 @o_tipo_cambio        = @w_cotizacion out
         end

         select @w_re_area = ta_area
         from   cob_conta..cb_tipo_area
         where  ta_empresa  = @i_filial
         and    ta_producto = 19
         and    ta_tiparea  = @w_dp_area

         if @w_tc_oficina = 9000
            select @w_re_area = 3030
        
         if @w_tc_oficina = 3029
            select @w_re_area = 3029
        
         exec @w_error = cob_ccontable..sp_ing_opera_det
              @i_empresa        = @i_filial,
              @i_producto       = 19,
              @i_fecha          = @i_fecha, 
              @i_cuenta         = @w_cuenta_final,
              @i_oficina        = @w_tc_oficina, 
              @i_area           = @w_re_area,
              @i_moneda         = @w_tc_moneda,
              @i_val_opera_mn   = @w_valor_nal,
              @i_val_opera_me   = @w_valor_ext,
              @i_tipo           = 'S',
              @t_trn            = 60032,
              @i_operacion      = 'I',
              @i_operacion_mod  = @w_tc_codigo_externo,
              @i_adicional      = @w_tc_codigo_externo
                                
            
         if @w_error != 0 -- ERROR GRAVE
         begin
	    select @w_anexo = ''
	    select @w_anexo = 'Error en cob_ccontable..sp_ing_opera'
            select @w_anexo = @w_anexo + '  OFI: ' + convert(varchar(4), @w_tc_oficina)
            select @w_anexo = @w_anexo + '  CUENTA : ' + @w_cuenta_final
            select @w_anexo = @w_anexo + '  AREA : ' + convert(varchar(6), @w_dp_area)
            select @w_anexo = @w_anexo + '  MONEDA : ' + convert(varchar(3), @w_tc_moneda)
            select @w_anexo = @w_anexo + '  VALOR : ' + convert(varchar(30), @w_tc_valor)
               
            goto ERROR_CUADRE_DET
         end

         --Insertar Detalle BD de Cuadre emg
      end
      ELSE
      begin
         select @w_anexo = ''
	 select @w_anexo = 'No existe cuenta'
         select @w_anexo = @w_anexo + '  OFI: ' + convert(varchar(4), @w_tc_oficina)
         select @w_anexo = @w_anexo + '  CUENTA : SIN CUENTA PARA CODIGO VALOR 22'
         select @w_anexo = @w_anexo + '  AREA : ' + convert(varchar(6), @w_dp_area)
         select @w_anexo = @w_anexo + '  MONEDA : ' + convert(varchar(3), @w_tc_moneda)
         select @w_anexo = @w_anexo + '  VALOR : ' + convert(varchar(30), @w_tc_valor)
         
         goto ERROR_CUADRE_DET
      end

      goto SIGUIENTE_DET

      ERROR_CUADRE_DET:
      insert into cu_error_contagar_det
      (ec_fecha_proc,  ec_cta_contable,  ec_cta_final,  ec_garantia, ec_error)
      values (@w_fecha,@w_dp_cuenta,@w_cuenta_final,@w_tc_codigo_externo, @w_anexo)


      SIGUIENTE_DET: 
      fetch cValDet
      into  @w_tc_oficina,
            @w_tc_tipo_bien,      @w_tc_op_clase,       @w_tc_moneda,
            @w_tc_calificacion,   @w_tc_clase_custodia, @w_tc_tipo,
            @w_tc_codvalor,       @w_tc_valor,          @w_dp_cuenta,
            @w_dp_area,		  @w_tc_codigo_externo
   end
   close cValDet
   deallocate cValDet
   end


return 0
go
