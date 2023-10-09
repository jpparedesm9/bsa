/************************************************************************/
/*	Archivo: 	        act_fag.sp                              */
/*	Stored procedure:       sp_act_fag                              */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           jennifer Velandia            	      	*/
/*			                                         	*/
/*	Fecha de escritura:     Diciembre-2002  			*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa 	es para la actualizacion masiva de numero de    */
/*      certificago FAG com archivo enviado por FINAGRO                 */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/*      Feb 10 2003     Milena Gonzalez Modificacion segun Pruebas      */
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_act_fag')
    drop proc sp_act_fag
go
create procedure sp_act_fag(
        @s_ssn                int      = null,
        @s_date               datetime = null,
        @s_user               login    = null,
        @s_corr               char(1)  = null,
        @s_ssn_corr           int      = null,
        @t_rty                char(1)  = null,
        @t_trn                smallint = null,
        @t_file               varchar(14) = null,
        @i_fecha              datetime    = null,
        @s_term               descripcion = null )
    
as
declare  
        @w_today              datetime        ,     /* fecha del dia */ 
        @w_return             int             ,    /* valor que retorna */
        @w_sp_name            varchar(32)     ,
        @w_error             int              ,
                 
        /* Variables */
        @w_fag                 descripcion      ,
        @w_pagare              descripcion      ,
	@w_codigo_externo       varchar(64)     ,
	@w_num_dcto             varchar(13)     ,
        /* campos para validacion */
        @w_ft_certificadow	varchar(13)     ,
	@w_ft_identificacionw	varchar(14)	,
	@w_ft_documentow	descripcion	,
        @w_ft_certificado	varchar(13)     ,
	@w_ft_identificacion	varchar(14)	,
	@w_ft_documento		descripcion	,
	@w_ente                 int             ,
	@w_encedruc             varchar(30)     ,
	@w_secservicio            int ,
        @w_siguiente_tipo       descripcion,
        @w_tipo_superior3       descripcion,
        @w_tipo_superiorx       descripcion,
        @w_padre                descripcion,
        @w_ft_acta              varchar(13),
        @w_ft_fecha_acta        datetime ,        
        @w_ft_actaw             varchar(13) ,
        @w_ft_fecha_actaw       datetime 
    

select @w_today   = @s_date
select @w_sp_name = 'sp_act_fag'
select @s_term    = 'consola' 


   /* parametros */
   select @w_fag   = pa_char    -- FAG
     from cobis..cl_parametro
    where pa_producto = 'GAR'
      and pa_nemonico = 'FAG'
   set transaction isolation level read uncommitted   

   select @w_pagare   = pa_char    -- FAG
     from cobis..cl_parametro
    where pa_producto = 'GAR'
      and pa_nemonico = 'PAGA'
   set transaction isolation level read uncommitted   

   
   /*emg Feb-10-03 hallar grupos inferiores para identificar garantias tipo FAG*/

    create table #superior (tipo varchar(64))

    insert into #superior
    select tc_tipo  
    from cob_custodia..cu_tipo_custodia
    where tc_tipo = @w_fag
    union
    select tc_tipo 
    from cob_custodia..cu_tipo_custodia
    where tc_tipo_superior 	= @w_fag
    union
    select tc_tipo 
    from cob_custodia..cu_tipo_custodia
    where tc_tipo_superior in (select tc_tipo 
                               from   cob_custodia..cu_tipo_custodia
                               where  tc_tipo_superior = @w_fag)

        
     
   truncate table cu_finagro_tmp 
   
   delete  cu_error_carga
   where ec_fecha = @i_fecha
   
   /*  cursor para validar la informacion de la tabla */
   declare cursor_valida cursor for
     select
      ft_certificadow , ft_identificacionw, ft_documentow, ft_actaw, convert(varchar,convert(datetime,ft_fecha_actaw,103),101)
      from  cu_finagro_tmpw	
      for read only

      open cursor_valida             
         
      fetch cursor_valida into  
         @w_ft_certificadow, 	@w_ft_identificacionw	,  @w_ft_documentow  ,@w_ft_actaw,@w_ft_fecha_actaw
           
      while @@fetch_status = 0
        begin
          if @@fetch_status = -1
           begin  -- ERROR DEL CURSOR
      
            exec cobis..sp_cerror
            @t_file  = @t_file, 
            @t_from  = @w_sp_name,
            @i_num   = 1909001 
            return 1 
                 
           end

            /* borra */
           select    @w_ente             = null,
                     @w_codigo_externo   = null





                                         
           if @w_ft_certificadow	= '0' 
           or @w_ft_certificadow       = null
            

              insert into cu_error_carga 
              values ( @i_fecha, @w_ft_certificadow, @w_ft_identificacionw,
              'NUMERO DE CERTIFICADO INVALIDO')
            else 
              begin
                select @w_ente       = en_ente
                from cobis..cl_ente
                where en_subtipo > 'A'
                and   en_ced_ruc = @w_ft_identificacionw
                set transaction isolation level read uncommitted   
    
                select  @w_codigo_externo = cu_codigo_externo
                from   cu_cliente_garantia, cu_custodia,cu_item,cu_item_custodia
                where cg_ente           = @w_ente      
                and   cg_principal    = 'D'
                and   cu_tipo           in (select tipo  from #superior)
                and cu_estado in ('F','V','P')
                and cg_tipo_cust = cu_tipo
                and cu_codigo_externo = cg_codigo_externo
                and ic_item = it_item
                and it_tipo_custodia = cu_tipo
                and it_nombre = @w_pagare
                and ic_tipo_cust = it_tipo_custodia
                and ic_custodia = cu_custodia
                and ic_valor_item = @w_ft_documentow
                and cu_sucursal = ic_sucursal
                and cu_codigo_externo  = ic_codigo_externo     
                 


                if @w_ente > 0 or @w_ente is not null
                  begin 
                    if @w_codigo_externo is not null
                      insert into cu_finagro_tmp
                      values ( @w_ft_certificadow, @w_ft_identificacionw,  @w_ft_documentow,@w_ft_actaw,@w_ft_fecha_actaw)  
                    else    
                      insert into cu_error_carga 
                      values ( @i_fecha, @w_ft_certificadow,
                               @w_ft_identificacionw,'CLIENTE SIN GARANTIA FAG, O NO APLICA')
                   end
                 else
                    insert into cu_error_carga 
                    values  ( @i_fecha, @w_ft_certificadow,@w_ft_identificacionw,
                    'CLIENTE NO EXISTE EN LA BASE DE DATOS O INVALIDO') 
               end
              
                 
         fetch cursor_valida into  
         @w_ft_certificadow, 	@w_ft_identificacionw	,  @w_ft_documentow  , @w_ft_actaw, @w_ft_fecha_actaw
        
    end  --while     
    close cursor_valida
    deallocate cursor_valida 
           
          
      
  /*  cursor de actualizacion  cu_finagro_tmp los ok unicamente*/
      declare cursor_archivo cursor for
      select  ft_certificado,   ft_identificacion,	ft_documento	, ft_acta, ft_fecha_acta
      from  cu_finagro_tmp	
      for read only
   
      open cursor_archivo             
         
      fetch cursor_archivo into 
        @w_ft_certificado ,	@w_ft_identificacion,	@w_ft_documento, @w_ft_acta, @w_ft_fecha_acta			   
          
   
   while @@fetch_status = 0
    begin
      if @@fetch_status = -1
         begin
          exec cobis..sp_cerror
          @t_file  = @t_file, 
          @t_from  = @w_sp_name,
          @i_num   = 1909001 
          return 1 
          end

          select   @w_ente             = null,
                   @w_codigo_externo   = null,
                   @w_encedruc         = null
                  
            select @w_ente       = en_ente
             from cobis..cl_ente
             where en_subtipo > 'A'
             and en_ced_ruc = @w_ft_identificacion
             set transaction isolation level read uncommitted   
    
            
                select @w_codigo_externo = cu_codigo_externo
                from   cu_cliente_garantia, cu_custodia,cu_item,cu_item_custodia
                where cg_ente           = @w_ente      
                and   cg_principal    = 'D'
                and   cu_tipo           in (select tipo  from #superior)
                and cu_estado in ('F','V','P')
                and cu_codigo_externo = cg_codigo_externo
                and cg_tipo_cust = cu_tipo
                and ic_item = it_item
                and it_tipo_custodia = cu_tipo
                and it_nombre = @w_pagare
                and ic_tipo_cust = it_tipo_custodia
                and ic_custodia = cu_custodia
                and ic_valor_item = @w_ft_documento
                and cu_sucursal = ic_sucursal
                and cu_codigo_externo  = ic_codigo_externo     




          select @w_secservicio = @@spid 
          /* ts antes del proceso */
          insert into ts_custodia
          select 
          @w_secservicio,         19091,                'P',
          @i_fecha,             'garbatch',                 @s_term, 
          cu_oficina,           'cu_custodia',        cu_filial,                         
          cu_sucursal ,         cu_tipo,              cu_custodia,
          cu_propuesta,         cu_estado,            cu_fecha_ingreso,
          cu_valor_inicial,     cu_valor_actual,      cu_moneda,
          cu_garante,           cu_instruccion,       cu_descripcion,
          cu_poliza,            cu_inspeccionar,      cu_motivo_noinsp,
          cu_suficiencia_legal, cu_fuente_valor,      cu_situacion,
          cu_almacenera,
          cu_aseguradora,       cu_cta_inspeccion,    cu_tipo_cta,
          cu_direccion_prenda,  cu_ciudad_prenda,     cu_telefono_prenda,
          cu_mex_prx_inspec,    cu_fecha_modif,       cu_fecha_const,
          cu_porcentaje_valor,  cu_periodicidad,      cu_depositario,
          cu_posee_poliza,      cu_nro_inspecciones,  cu_intervalo,
          cu_cobranza_judicial, cu_fecha_retiro,      cu_fecha_devolucion,
          cu_fecha_modificacion, cu_usuario_crea,     cu_usuario_modifica,
          cu_estado_poliza,     cu_cobrar_comision,   cu_cuenta_dpf,
          cu_codigo_externo,    cu_fecha_insp,        cu_abierta_cerrada,
          cu_adecuada_noadec,   cu_propietario,       cu_plazo_fijo,
          cu_monto_pfijo,       cu_oficina_contabiliza, cu_compartida,
          cu_valor_compartida,  cu_fecha_reg,         cu_fecha_prox_insp,
          cu_valor_cobertura,   cu_num_acciones,      cu_valor_accion,
          cu_ubicacion,         cu_estado_credito,    cu_cuantia,
          cu_vlr_cuantia,       cu_licencia,          cu_fecha_vcto,
          cu_fecha_avaluo,      cu_fecha_vencimiento, cu_porcentaje_cobertura,
          cu_entidad_emisora,   cu_fuente_valor_accion, cu_fecha_accion,
          cu_num_dcto,          cu_fvalor_bruto,       cu_fanticipos,
          cu_fpor_impuestos,    cu_fpor_retencion,     cu_fvalor_neto,
          cu_ffecha_emision,    cu_ffecha_vtodoc,      cu_ffecha_inineg,
          cu_ffecha_vtoneg,     cu_ffecha_pago,        cu_fbase_calculo,
          cu_fdias_negocio,     cu_fnum_dex,           cu_ffecha_dex,
          cu_fproveedor,        cu_fcomprador,         cu_fresp_pago,
          cu_fresp_dscto,       cu_ftasa,              cu_siniestro,
          cu_castigo,           cu_agotada,            cu_clase_custodia,
          cu_fecha_sol_exp,     cu_fecha_apr_pre,      cu_fecha_sol_rec,
          cu_fecha_sol_ren,     cu_fecha_pro,          cu_num_acta_apr_pre,
          cu_num_acta_apr,      cu_clase_vehiculo,     cu_expedido,
          cu_causa_nexp
          from               cu_custodia
          where cu_codigo_externo = @w_codigo_externo
          if @@error <> 0 
          begin
         /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903001
          return 1 
         end      


          update cu_custodia
          set cu_num_dcto  = @w_ft_certificado,
              cu_num_acta_apr  = @w_ft_acta,
              cu_fecha_apr  = @w_ft_fecha_acta, 
              cu_expedido   = 'N'
          where cu_codigo_externo = @w_codigo_externo 

         if @@error <> 0 
         begin
         /* Error en insercion de registro */
            exec cobis..sp_cerror
            @t_from  = @w_sp_name,
            @i_num   = 1905001
            return 1 
         end

          
          
          select @w_secservicio = @@spid 

          /* ts despues de act */
          insert into ts_custodia
          select 
      @w_secservicio,         19091,                'A',
      @i_fecha,             'garbatch',                 @s_term, 
      cu_oficina,           'cu_custodia',        cu_filial,                         
      cu_sucursal ,         cu_tipo,              cu_custodia,
      cu_propuesta,         cu_estado,            cu_fecha_ingreso,
      cu_valor_inicial,     cu_valor_actual,      cu_moneda,
      cu_garante,           cu_instruccion,       cu_descripcion,
      cu_poliza,            cu_inspeccionar,      cu_motivo_noinsp,
      cu_suficiencia_legal, cu_fuente_valor,      cu_situacion,
      cu_almacenera,
      cu_aseguradora,       cu_cta_inspeccion,    cu_tipo_cta,
      cu_direccion_prenda,  cu_ciudad_prenda,     cu_telefono_prenda,
      cu_mex_prx_inspec,    cu_fecha_modif,       cu_fecha_const,
      cu_porcentaje_valor,  cu_periodicidad,      cu_depositario,
      cu_posee_poliza,      cu_nro_inspecciones,  cu_intervalo,
      cu_cobranza_judicial, cu_fecha_retiro,      cu_fecha_devolucion,
      cu_fecha_modificacion, cu_usuario_crea,     cu_usuario_modifica,
      cu_estado_poliza,     cu_cobrar_comision,   cu_cuenta_dpf,
      cu_codigo_externo,    cu_fecha_insp,        cu_abierta_cerrada,
      cu_adecuada_noadec,   cu_propietario,       cu_plazo_fijo,
      cu_monto_pfijo,       cu_oficina_contabiliza, cu_compartida,
      cu_valor_compartida,  cu_fecha_reg,         cu_fecha_prox_insp,
      cu_valor_cobertura,   cu_num_acciones,      cu_valor_accion,
      cu_ubicacion,         cu_estado_credito,    cu_cuantia,
      cu_vlr_cuantia,       cu_licencia,          cu_fecha_vcto,
      cu_fecha_avaluo,      cu_fecha_vencimiento, cu_porcentaje_cobertura,
      cu_entidad_emisora,   cu_fuente_valor_accion, cu_fecha_accion,
      cu_num_dcto,          cu_fvalor_bruto,       cu_fanticipos,
      cu_fpor_impuestos,    cu_fpor_retencion,     cu_fvalor_neto,
      cu_ffecha_emision,    cu_ffecha_vtodoc,      cu_ffecha_inineg,
      cu_ffecha_vtoneg,     cu_ffecha_pago,        cu_fbase_calculo,
      cu_fdias_negocio,     cu_fnum_dex,           cu_ffecha_dex,
      cu_fproveedor,        cu_fcomprador,         cu_fresp_pago,
      cu_fresp_dscto,       cu_ftasa,              cu_siniestro,
      cu_castigo,           cu_agotada,            cu_clase_custodia,
      cu_fecha_sol_exp,     cu_fecha_apr_pre,      cu_fecha_sol_rec,
      cu_fecha_sol_ren,     cu_fecha_pro,          cu_num_acta_apr_pre,
      cu_num_acta_apr,      cu_clase_vehiculo,     cu_expedido,
          cu_causa_nexp
      from               cu_custodia
      where cu_codigo_externo = @w_codigo_externo           
      if @@error <> 0 
        begin
        /* Error en insercion de registro */
         exec cobis..sp_cerror
         @t_from  = @w_sp_name,
         @i_num   = 1903001
        return 1 
        end      
                  
         
       
        fetch cursor_archivo into 
        @w_ft_certificado ,	@w_ft_identificacion,	@w_ft_documento		, @w_ft_acta, @w_ft_fecha_acta


 end   --  FIN DEL WHILE

   /*   if (@@fetch_status = -1)  -- ERROR DEL CURSOR
      begin
         exec cobis..sp_cerror
         @t_debug = @t_debug,
         @t_file  = @t_file, 
         @t_from  = @w_sp_name,
         @i_num   = 1909001 
         return 1 
      end  */
      close cursor_archivo
      deallocate cursor_archivo      
  return 0
ERROR:    /* RUTINA QUE DISPARA sp_cerror DADO EL CODIGO DEL ERROR */
   exec cobis..sp_cerror             
   @t_from  = @w_sp_name, 
   @i_num   = @w_error
   return 1 
go
    
           
