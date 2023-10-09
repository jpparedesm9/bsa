use cob_custodia
go

if exists(select 1 from sysobjects where name = 'sp_conta_gar')
   drop proc sp_conta_gar
go
create proc sp_conta_gar
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
   @w_ente              int,
   @w_var_ente          varchar(20),
   @w_cotizacion        float,
   @w_re_area           smallint,
   @w_cuenta_final      varchar(60),
   @w_adicional         varchar(50),
   @w_fecha             varchar(10),
   @w_err_conta        varchar(10)

begin
   
   truncate table cu_tmp_contagar
   truncate table cu_tmp_contagar_det

   --TABLA DE ERRORES
   truncate table cu_error_contagar
   truncate table cu_error_contagar_det


   select @w_fecha = convert(varchar(10),@i_fecha,101)


   select @w_err_conta = pa_char
   from cobis..cl_parametro
   where pa_nemonico = 'ERRCO'
   and   pa_producto = 'GAR'


if @i_cierre = 'M'
begin
   /*********************************************************/
   /*******FUTUROS Y VIGENTE POR CANCELAR (GAR-REAL)*********/   
   /*********************************************************/

   insert into cu_tmp_contagar_det
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cu_oficina_contabiliza,		tc_tipo_bien,    	'-',               	isnull(cu_moneda,0),
          '-',             			'-',               	cu_tipo,		
	  isnull((select cv_codval 
           from   cu_codigo_valor
           where  cv_tipo	= cu_custodia.cu_tipo
           and    cv_estado     = cu_custodia.cu_estado),(select cv_codval 
						           from   cu_codigo_valor
						           where  cv_tipo	= @w_err_conta
						           and    cv_estado     = cu_custodia.cu_estado)),
	  (isnull(cu_valor_inicial,0)),		cu_codigo_externo 
   from   cu_custodia,
          cu_tipo_custodia
   where  cu_tipo 	  	= tc_tipo
   and    tc_contabilizar 	= 'S'
   and    tc_tipo 	  	> ''
   and    cu_oficina	  	>= 0
   and    cu_codigo_externo	> ''
   and	  cu_moneda             >= 0
   and    cu_valor_inicial 	>= 0
   and	  cu_estado		in ('F','X','K')
   and    tc_clase              = 'I'



   /*********************************************************/
   /*******FUTUROS Y VIGENTE POR CANCELAR (GAR-DOCU)*********/   
   /*********************************************************/


   insert into cu_tmp_contagar_det
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cu_oficina_contabiliza,		tc_tipo_bien,    	'-',               	isnull(cu_moneda,0),
          '-',             			'-',               	cu_tipo,		
	  isnull((select cv_codval 
           from   cu_codigo_valor
           where  cv_tipo	= cu_custodia.cu_tipo
           and    cv_estado     = cu_custodia.cu_estado),(select cv_codval 
						           from   cu_codigo_valor
						           where  cv_tipo	= @w_err_conta
						           and    cv_estado     = cu_custodia.cu_estado)),
	  (isnull(cu_valor_inicial,0)),		cu_codigo_externo 
   from   cu_custodia,
          cu_tipo_custodia
   where  cu_tipo 	  	= tc_tipo
   and    tc_contabilizar 	= 'S'
   and    tc_tipo 	  	> ''
   and    cu_oficina	  	>= 0
   and    cu_codigo_externo	> ''
   and	  cu_moneda             >= 0
   and    cu_valor_inicial 	>= 0
   and	  cu_estado		in ('F','X','K','V')
   and    tc_clase              = 'O'


   insert into cu_tmp_contagar
         (tc_oficina,			tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 		tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor)
   select tc_oficina,			tc_tipo_bien,    	'-',               	tc_moneda,
          '-',             		'-',               	tc_tipo,		tc_codvalor,
	  sum(isnull(tc_valor,0)) 
   from	  cu_tmp_contagar_det
   group  by tc_oficina, tc_tipo_bien, tc_moneda, tc_tipo,tc_codvalor



   truncate table cu_tmp_contagar_mes
   truncate table cu_tmp_contagar_det_mes
   truncate table cu_custodia_resp 
   truncate table cu_custodia_resp_vig

   insert into cu_tmp_contagar_mes
   select	*
   from		cu_tmp_contagar
   where	tc_codvalor >= 0

   insert into cu_tmp_contagar_det_mes
   select	*
   from		cu_tmp_contagar_det
   where	tc_codvalor >= 0

   insert into cu_custodia_resp 
   select  cu_codigo_externo,
           cu_estado,
           cu_oficina_contabiliza,		
           cu_moneda,
           cu_tipo, 
           cu_valor_inicial,
           cu_clase_custodia
   from    cob_custodia..cu_custodia,
	   cob_custodia..cu_tipo_custodia
   where   cu_estado 	in ('V')
   and     tc_tipo	= cu_tipo
   and     tc_clase 	= 'I'

   exec @w_error	=  sp_valid_estado_gar
	@i_filial	=  1

   if @w_error != 0
      return @w_error

end

if @i_cierre = 'C'
begin
   /*******************************************/
   /*************** VIGENTE IDONEAS ***********/   
   /*******************************************/

   insert into cu_tmp_contagar_det
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cr_oficina_contabiliza,		'-',             	dg_clase,		isnull(cr_moneda,0),
          isnull(co_calif_final, 'A'),		cr_clase_custodia, 	'-',			cv_codval,
	  isnull((dg_valor_resp)/cv_valor,0),		cr_codigo_externo
   from   cu_custodia_resp ,
	  cob_credito..cr_dato_garantia,
	  cob_credito..cr_calificacion_op,
	  cu_codigo_valor,
	  cob_conta..cb_vcotizacion
   where  cr_codigo_externo	= dg_garantia
   and    cr_codigo_externo	> ''
   and    dg_garantia   	> ''
   and    dg_cliente            > 0
   and    dg_producto           > 0
   and    dg_operacion          > 0
   and    co_num_op_banco       = dg_banco
   and    co_producto       	= dg_producto
   and	  cv_tipo               = cr_tipo
   and    cv_estado             = 'V'
   and    cv_moneda 		= cr_moneda
   and    cv_fecha 		=(select max(cv_fecha)
                        	  from 	cob_conta..cb_vcotizacion
                        	  where cv_moneda 	= cu_custodia_resp.cr_moneda
                        	  and	cv_fecha 	<= @i_fecha)





   /*******************************************/
   /*************** VIGENTE NO IDONEAS ********/   
   /*******************************************/

   insert into cu_tmp_contagar_det
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cr_oficina_contabiliza,		'-',             	dg_clase,		isnull(cr_moneda,0),
          isnull(co_calif_final, 'A'),		        cr_clase_custodia, 	'-',			cv_codval,
	  isnull((dg_monto_distribuido)/cv_valor,0),	cr_codigo_externo
   from   cu_custodia_resp ,
	  cob_credito..cr_dato_garantia_otras,
	  cob_credito..cr_calificacion_op,
	  cu_codigo_valor,
	  cob_conta..cb_vcotizacion
   where  cr_codigo_externo	= dg_garantia
   and    cr_codigo_externo	> ''
   and    dg_garantia   	> ''
   and    dg_cliente            > 0
   and    dg_producto           > 0
   and    dg_operacion          > 0
   and    co_num_op_banco       = dg_banco
   and    co_producto       	= dg_producto
   and	  cv_tipo               = cr_tipo
   and    cv_estado             = 'V'
   and    cv_moneda 		= cr_moneda
   and    cv_fecha 		=(select max(cv_fecha)
                        	  from 	cob_conta..cb_vcotizacion
                        	  where cv_moneda 	= cu_custodia_resp.cr_moneda
                        	  and	cv_fecha 	<= @i_fecha)




   insert into cu_custodia_resp_vig
   select cr_codigo_externo,
	  isnull(tc_codigo_externo,'S')
   from	cu_custodia_resp left outer join cu_tmp_contagar_det on cr_codigo_externo = tc_codigo_externo

   delete cu_custodia_resp_vig
   where  cr_contable	<> 'S'


   insert into cu_tmp_contagar_det
         (tc_oficina,							tc_tipo_bien,    	tc_op_clase,       	
	  tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		
	  tc_codvalor,     
	  tc_valor,				tc_codigo_externo)
   select cu_custodia_resp.cr_oficina_contabiliza,			'-',             	'-',			
          cu_custodia_resp.cr_moneda,          '-',			cu_custodia_resp.cr_clase_custodia, 	
          '-',			
          (select cv_codval 
	   from   cu_codigo_valor
	   where  cv_tipo	=  @w_err_conta
           and    cv_estado     = cu_custodia_resp.cr_estado),	 
	   isnull(cr_valor,0),				cu_custodia_resp.cr_codigo_externo
   from    cu_custodia_resp_vig,
	   cu_custodia_resp
   where   cu_custodia_resp.cr_codigo_externo = cu_custodia_resp_vig.cr_codigo_externo 


   insert into cu_tmp_contagar
         (tc_oficina,				tc_tipo_bien,    	tc_op_clase,       	tc_moneda,
          tc_calificacion, 			tc_clase_custodia, 	tc_tipo,		tc_codvalor,     
	  tc_valor)
   select tc_oficina,				'-',             	tc_op_clase,		tc_moneda,
          tc_calificacion,			tc_clase_custodia,	'-',			tc_codvalor,
	  sum(isnull(tc_valor,0)) 
   from   cu_tmp_contagar_det
   group  by tc_oficina, tc_op_clase, tc_moneda, tc_calificacion,tc_clase_custodia,tc_codvalor


   insert into cu_tmp_contagar_mes
   select	*
   from		cu_tmp_contagar
   where	tc_codvalor >= 0

   insert into cu_tmp_contagar_det_mes
   select	*
   from		cu_tmp_contagar_det
   where	tc_codvalor >= 0

   exec @w_error = cob_interfase..sp_errorcconta
   @t_trn       = 60025,
   @i_operacion = 'D',
   @i_empresa   =  @i_filial,
   @i_producto  = 19

   if @w_error != 0
      return @w_error


   delete cob_ccontable..cco_boc_det
   where bo_empresa   = 1
   and   bo_fecha     = @i_fecha
   and   bo_producto  = 19

   and   bo_tipo in ('S','M')
   
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
       and    dp_perfil   	= 'GAR'
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


         select @w_ente = 1,
                @w_var_ente = null

         select @w_ente  = cg_ente
         from   cob_custodia..cu_cliente_garantia
         where  cg_codigo_externo = @w_tc_codigo_externo

         select @w_var_ente = convert(varchar(20),@w_ente )

        
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
              @i_adicional      = @w_var_ente
                                
            
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
   deallocate  cValDet
   end

end
return 0
go

