/************************************************************************/
/*	Archivo: 	        avapla.sp                               */
/*	Stored procedure:       sp_avapla                               */
/*	Base de datos:  	cob_custodia				*/
/*	Producto:               garantias               		*/
/*	Disenado por:           jennifer Velandia            	      	*/
/*			                                         	*/
/*	Fecha de escritura:     Diciembre-2002  			*/
/************************************************************************/
/*				PROPOSITO				*/
/*	Este programa genera tabla  de planificadores/avaluadores       */
/************************************************************************/
/*				MODIFICACIONES				*/
/*	FECHA		AUTOR		RAZON				*/
/************************************************************************/
use cob_custodia
go
if exists (select 1 from sysobjects where name = 'sp_avapla')
    drop proc sp_avapla
go
create procedure sp_avapla(
        @s_ssn                int          = null,
        @s_date               datetime     = null,
        @s_user               login        = null,
        @s_term               varchar(64)  = null,
        @s_corr               char(1)      = null,
        @s_ssn_corr           int          = null,
        @s_ofi                smallint     = null,
        @t_rty                char(1)      = null,
        @t_trn                smallint     = null,
        @t_file               varchar(14)  = null,
        @i_fecha              datetime     = null )
    
as
declare  
        @w_today              datetime,     /* fecha del dia */ 
        @w_return             int,          /* valor que retorna */
        @w_sp_name            varchar(32),  /* nombre stored proc*/
        @w_error              int        ,

        /* Variables */
       
        @w_codigo_externo       varchar(64)     ,
        @w_inspector            int         ,
	@w_especialidad         catalogo        ,  
	@w_nombre               descripcion     ,
	@w_telefono             varchar(20)     ,
	@w_direccion            descripcion     ,
	@w_ciudad               int 	        ,
	@w_cta_inspector        ctacliente      ,        
	@w_regional             catalogo        ,
	@w_fecha_insp           datetime        ,
        @w_valor_fact           money           ,
        @w_evaluacion           catalogo        ,
        @w_desevaluacion        descripcion     ,
        @w_des_especialidad     descripcion     ,
        @w_des_ciudad           descripcion     ,
        @w_ente                 int             ,
        @w_sub_tipo             char(1)         , 
        @w_fecha_creaente       datetime        ,
        @w_encedruc             varchar(30)     ,
        @wfec_env_carta         datetime        ,
        @w_ahoficina            smallint        ,
        @woficina               descripcion     ,
        @w_des_evaluacion       descripcion     ,
        @w_des_regional         descripcion     ,
        @w_oficina              descripcion     ,
        @wfecha_ins             datetime        ,
        @w_pla_tipo_persona     varchar(15)     ,
        @w_tipo_cust            descripcion     ,
        @w_gp_tramite           int             ,
        @w_estado_tramite       catalogo        ,
        @wop_banco              cuenta          ,
        @w_max_occ              int             ,
        @w_reg                  int             ,
        @w_tipo_c               descripcion     ,
        @w_valor                char
                   

select @w_today   = @s_date
select @w_sp_name = 'sp_avapla'

   
         
   truncate table cu_planavaluador 
   truncate table cu_plplanificador
       
      /*  avaluadores  */ 
      declare cursor_avaluador cursor for
       select 
        is_inspector,           is_especialidad,     	is_nombre ,              
	is_telefono,            is_direccion,           is_ciudad ,              
	is_cta_inspector ,      is_regional ,           is_cliente_inspec
        from cu_inspector  
        --where is_tipo_inspector = 'A' emg mar-01-03
        where is_inspector > 0
        for read only
 
      open cursor_avaluador
      fetch cursor_avaluador into 
        @w_inspector,           @w_especialidad,     	@w_nombre ,              
	@w_telefono,            @w_direccion,           @w_ciudad ,              
	@w_cta_inspector ,      @w_regional,            @w_ente            
     
     while @@fetch_status = 0
      begin
        if @@fetch_status = -1
          begin
            select @w_error = 1909001
            close cursor_avaluador
            deallocate cursor_avaluador
            goto ERROR
          end

        /* borra */
         select 
         
         @w_des_especialidad  = null,
         @w_des_regional      = null,
         @woficina            = null,
         @w_fecha_insp        = null,   
         @w_valor_fact        = null,   
         @w_evaluacion        = null,   
         @w_des_evaluacion    = null,
         @w_des_especialidad  = null,
         @w_encedruc          = null,
         @wfec_env_carta      = null,
         @woficina            = null, 
         @w_ahoficina         = null,
         @wfecha_ins          = null,
         @w_sub_tipo          = null,    
         @w_fecha_creaente    = null,
         @w_pla_tipo_persona  = null,
         @w_tipo_cust         = null,
         @w_des_ciudad        = null,
         @w_max_occ           = 0   ,
         @w_tipo_c            = null
        
         select @w_des_especialidad = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cu_esp_inspector'
         and   A.codigo = @w_especialidad
 	 set transaction isolation level read uncommitted

 
         select @w_des_regional = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cl_oficina'
         and   A.codigo = @w_regional
         set transaction isolation level read uncommitted

         
         select @w_des_ciudad = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cl_ciudad'
         and   A.codigo = convert(varchar(10),@w_ciudad)
	 set transaction isolation level read uncommitted



      /*  garantias  */ 
      declare cursor_garantias cursor for
       select  in_fecha_insp ,        
               in_valor_fact  ,    
               A.valor,
               in_tipo_cust,
               pi_codigo_externo,
               pi_fecha_insp ,
               pi_fenvio_carta  
        from   cu_inspeccion,cu_por_inspeccionar,cobis..cl_catalogo A,cobis..cl_tabla B
              where  in_inspector = @w_inspector
              and in_custodia      = pi_custodia
              and in_tipo_cust     = pi_tipo
              and B.codigo = A.tabla
              and B.tabla  = 'cu_evaluacion'
              and A.codigo = in_evaluacion
              and pi_inspector_asig =in_inspector
              and pi_codigo_externo = in_codigo_externo
              and pi_lote = in_lote
              and in_codigo_externo > ''
              --order by in_fecha_insp  
              for read only

      open cursor_garantias
      fetch cursor_garantias into 
        @w_fecha_insp,           @w_valor_fact,     	@w_desevaluacion,              
	@w_tipo_cust,            @w_codigo_externo,           @wfecha_ins ,              
	@wfec_env_carta
     
     while @@fetch_status = 0
      begin
        if @@fetch_status = -1
          begin
            select @w_error = 1909001
            close cursor_garantias
            deallocate cursor_garantias
            goto ERROR
          end


              
             
       select @w_sub_tipo       =  en_subtipo ,
              @w_encedruc       =  en_ced_ruc ,
              @w_fecha_creaente =  en_fecha_crea  
              from cobis..cl_ente
              where en_ente = @w_ente
              set transaction isolation level read uncommitted

                 
      if  @w_sub_tipo = 'P'
          select @w_pla_tipo_persona = 'PERSONA'
      else    
            select @w_pla_tipo_persona = 'COMPA¥IA'         


         
       /*  cartera  la ultima inspector*/
       select @w_gp_tramite = gp_tramite
       from cob_credito..cr_gar_propuesta
       where  gp_garantia = @w_codigo_externo  
       

       select @w_estado_tramite = b.codigo
       from   cob_credito..cr_tramite,cobis..cl_tabla a, cobis..cl_catalogo b
       where  tr_tramite = @w_gp_tramite
       and    a.codigo = b.tabla
       and    a.tabla = 'cr_estado_tramite'
       and    b.codigo = tr_estado
    

                       
      /*select @w_ahoficina = ah_oficina
      from cob_ahorros..ah_cuenta
             where ah_cliente = @w_ente*/
             
      exec cob_interfase..sp_avapla_interfase
      @i_cliente    =   @w_ente,
      @o_ahoficina  =   @w_ahoficina out 
  
      select @w_oficina = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cl_oficina'
         and   A.codigo = convert(varchar(10),@w_ahoficina)
         set transaction isolation level read uncommitted

                       
         insert into cu_planavaluador
         (
          pla_inspector   ,       pla_tipo_persono,           pla_fecha_crea,    
          pla_especialidad,       pla_nombre,                 pla_identifica ,   
          pla_telefono,           pla_direccion ,             pla_ciudad,        
          pla_cta_inspector ,     pla_ah_oficina,             pla_regional,      
          pla_fenvio_carta ,      pla_fecha_insp,             pla_valor_fact,    
          pla_evaluacion ,        pla_codigo_externo ,
          pla_tramite,            pla_tr_estado ,             pla_fecha_vis                                   
          )    
          values( 
          @w_inspector   ,        @w_pla_tipo_persona ,      convert(varchar(10),@w_fecha_creaente,101) ,     
          @w_des_especialidad,    @w_nombre,                 @w_encedruc ,          
          @w_telefono,            @w_direccion ,             @w_des_ciudad,           
          @w_cta_inspector ,      @w_oficina,                @w_des_regional,        
          convert(varchar(10),@wfec_env_carta,101) , convert(varchar(10),@w_fecha_insp,101),             @w_valor_fact,        
          @w_desevaluacion,       @w_codigo_externo ,
          @w_gp_tramite,          @w_estado_tramite,         convert(varchar(10),@wfecha_ins,101)                                          
           )

          if @@error <> 0 
          begin
          -- Error en insercion de registro 
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903001
          return 1 
          end

          -- print 'ava %1! gar %2! max %3!',@w_inspector ,@w_reg ,@w_max_occ 
          
        select @w_max_occ = @w_max_occ - 1
                
        select @w_codigo_externo  = null,
               @wfecha_ins        = null ,
               @wfec_env_carta    = null ,
               @w_ahoficina       = null ,
               @w_desevaluacion   = null,
               @w_oficina         = null
               
      fetch cursor_garantias into 
        @w_fecha_insp,           @w_valor_fact,     	@w_desevaluacion,              
	@w_tipo_cust,            @w_codigo_externo,           @wfecha_ins ,              
	@wfec_env_carta
         
       end    

        fetch cursor_avaluador into 
        @w_inspector,           @w_especialidad,     	@w_nombre ,              
	@w_telefono,            @w_direccion,           @w_ciudad ,              
	@w_cta_inspector ,      @w_regional ,           @w_ente           
     
      close cursor_garantias
      deallocate cursor_garantias

 end   --  FIN DEL WHILE

      close cursor_avaluador
      deallocate cursor_avaluador
    
    /*  planificadores  */ 
      declare cursor_planificador cursor for
       select 
        is_inspector,           is_especialidad,     	is_nombre ,              
	is_telefono,            is_direccion,           is_ciudad ,              
	is_cta_inspector ,      is_regional ,           is_cliente_inspec
	                
         from cu_inspector  
         where is_tipo_inspector = 'P'
	 and is_inspector > 0
         --order by is_inspector

      open cursor_planificador
      fetch cursor_planificador into 
        @w_inspector,           @w_especialidad,     	@w_nombre ,              
	@w_telefono,            @w_direccion,           @w_ciudad ,              
	@w_cta_inspector ,      @w_regional,            @w_ente            
         
     while @@fetch_status = 0
      begin
        if @@fetch_status = -1
          begin
                select @w_error = 1909001
                close cursor_planificador
                deallocate cursor_planificador
                goto ERROR
         
          end

        /* borra */
                          
          select 
         
         @w_des_especialidad  = null,
         @woficina            = null,
         @w_des_regional      = null,
         @w_fecha_insp        = null,   
         @w_valor_fact        = null,   
         @w_evaluacion        = null,   
         @w_des_evaluacion    = null,
         @w_des_especialidad  = null,
         @w_encedruc          = null,
         @wfec_env_carta      = null,
         @woficina            = null, 
         @w_ahoficina         = null,
         @wfecha_ins          = null,
         @w_sub_tipo          = null,    
         @w_fecha_creaente    = null,
         @w_pla_tipo_persona  = null,
         @w_tipo_cust         = null,
         @w_gp_tramite        = null,
         @wop_banco           = null,
         @w_des_ciudad        = null,
         @w_tipo_c            = null,
         @w_estado_tramite    = null           
  
          
         select @w_des_especialidad = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cu_esp_inspector'
         and   A.codigo = @w_especialidad
 	 set transaction isolation level read uncommitted



       select @w_des_regional = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cl_oficina'
         and   A.codigo = @w_regional
	 set transaction isolation level read uncommitted

         select @w_des_ciudad = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cl_ciudad'
         and   A.codigo = convert(varchar(10),@w_ciudad)
         set transaction isolation level read uncommitted
       
      
       select distinct in_custodia, in_tipo_cust into #trabajo 
       from   cu_inspeccion
       where  in_inspector = @w_inspector
       and    in_codigo_externo > ''
  
      select @w_max_occ =  @@rowcount 

      while @w_max_occ > 0 
      begin
       set rowcount 1
       select @w_reg     = in_custodia ,
              @w_tipo_c  = in_tipo_cust 
       from #trabajo
       
       set rowcount 0                          
     
         
       select @w_sub_tipo       =  en_subtipo ,
              @w_encedruc       =  en_ced_ruc ,
              @w_fecha_creaente =  en_fecha_crea  
              from cobis..cl_ente
              where en_ente = @w_ente
	      set transaction isolation level read uncommitted
             
             
      if  @w_sub_tipo = 'P'
          select @w_pla_tipo_persona = 'PERSONAL'
      else    
            select @w_pla_tipo_persona = 'COMPAÑIA' 
            
                       
      /*select @w_ahoficina = ah_oficina
      from cob_ahorros..ah_cuenta
             where ah_cliente = @w_ente        */     
      exec cob_interfase..sp_avapla_interfase
      @i_cliente    =   @w_ente,
      @o_ahoficina  =   @w_ahoficina out         
              
      select @w_oficina = A.valor
         from  cobis..cl_catalogo A,cobis..cl_tabla B
         where B.codigo = A.tabla
         and   B.tabla  = 'cl_oficina'
         and   A.codigo = convert(varchar(10),@w_ahoficina)      
	 set transaction isolation level read uncommitted


       select @w_valor = pa_char
       from cobis..cl_parametro
       where pa_producto = 'CRE'
       and   pa_nemonico = 'VPLANIF'
       set transaction isolation level read uncommitted

       select @wfecha_ins   = ag_fecha_visita,
              @wfec_env_carta = ag_fecha_reporte,
              @w_gp_tramite = ag_tramite,
              @w_valor_fact = ag_valor_visita
       from   cob_credito..cr_agenda
       where  ag_planificador = convert(varchar(20),@w_inspector)
       and    ag_categoria    = @w_valor
       and    ag_oficial > 0

       select @w_estado_tramite = b.codigo
       from   cob_credito..cr_tramite,cobis..cl_tabla a, cobis..cl_catalogo b
       where  tr_tramite = @w_gp_tramite
       and    a.codigo = b.tabla
       and    a.tabla = 'cr_estado_tramite'
       and    b.codigo = tr_estado    

       select @wop_banco     = op_banco,
              @w_codigo_externo = gp_garantia
       from cob_cartera..ca_operacion,cob_credito..cr_gar_propuesta
       where  op_tramite  = @w_gp_tramite
       and    gp_tramite = op_tramite
       --order by  op_fecha_fin
         
                 	
         insert into cu_plplanificador
         (
          plp_inspector   ,       plp_tipo_persono,           plp_fecha_crea,    
          plp_especialidad,       plp_nombre,                 plp_identifica ,   
          plp_direccion ,         plp_ciudad,                 plp_telefono,
          plp_cta_inspector ,     plp_ah_oficina,             plp_regional,      
          plp_fenvio_carta ,      plp_fecha_insp,             plp_codigo_externo ,
          plp_tramite,            plp_tr_estado,              plp_valor_fact,             
          plp_evaluacion,         plp_fecha_vis ,             plp_op_banco   
          )    
          values( 
          @w_inspector   ,        @w_pla_tipo_persona ,      convert(varchar(10),@w_fecha_creaente,101) ,     
          @w_des_especialidad,    @w_nombre,                 @w_encedruc ,          
          @w_direccion ,          @w_des_ciudad,             @w_telefono,
          @w_cta_inspector ,      @w_oficina,                @w_des_regional,        
          convert(varchar(10),@wfec_env_carta,101)   ,     convert(varchar(10),@w_fecha_insp,101),             @w_codigo_externo,
          @w_gp_tramite,          @w_estado_tramite,         @w_valor_fact,             
          @w_desevaluacion,       convert(varchar(10),@wfecha_ins,101),               @wop_banco  ) 

	  if @@error <> 0 
	  begin
          -- Error en insercion de registro 
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903001
          return 1 
          end
      
          
        select @w_max_occ = @w_max_occ - 1
        delete  from #trabajo
        where  in_custodia = @w_reg 
        and in_tipo_cust = @w_tipo_c
        if @@error <> 0 
        begin
        /* Error en insercion de registro */
          exec cobis..sp_cerror
          @t_from  = @w_sp_name,
          @i_num   = 1903001
          return 1 
        end
         
        /* borra campos */
        select @w_codigo_externo  = null,
               @wfecha_ins        = null ,
               @wfec_env_carta    = null ,
               @w_gp_tramite      = null, 
               @wop_banco         = null ,
               @w_desevaluacion   = null,
               @w_oficina         = null, 
               @w_ahoficina       = null
         
       end    
     
        drop table #trabajo      
                                        
        fetch cursor_planificador into 
        @w_inspector,           @w_especialidad,     	@w_nombre ,              
	@w_telefono,            @w_direccion,           @w_ciudad ,              
	@w_cta_inspector ,      @w_regional ,           @w_ente           
     

 end   --  FIN DEL WHILE

      close cursor_planificador
      deallocate cursor_planificador
          
      
  return 0
ERROR:    /* RUTINA QUE DISPARA sp_cerror DADO EL CODIGO DEL ERROR */
   exec cobis..sp_cerror             
   @t_from  = @w_sp_name, 
   @i_num   = @w_error
   return 1 
go
    
           
