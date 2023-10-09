/************************************************************/
/*   ARCHIVO:         sp_grupal_reglas.sp                   */
/*   NOMBRE LOGICO:   sp_grupal_reglas                      */
/*   PRODUCTO:        COBIS CREDITO                         */
/************************************************************/
/*                     IMPORTANTE                           */
/*   Esta aplicacion es parte de los  paquetes bancarios    */
/*   propiedad de MACOSA S.A.                               */
/*   Su uso no autorizado queda  expresamente  prohibido    */
/*   asi como cualquier alteracion o agregado hecho  por    */
/*   alguno de sus usuarios sin el debido consentimiento    */
/*   por escrito de MACOSA.                                 */
/*   Este programa esta protegido por la ley de derechos    */
/*   de autor y por las convenciones  internacionales de    */
/*   propiedad intelectual.  Su uso  no  autorizado dara    */
/*   derecho a MACOSA para obtener ordenes  de secuestro    */
/*   o  retencion  y  para  perseguir  penalmente a  los    */
/*   autores de cualquier infraccion.                       */
/************************************************************/
/*                     PROPOSITO                            */
/*  Evaluacion de reglas para encontrar el calculo de porc. */
/*  incremento y monto maximo por cliente                   */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR        RAZON                       */
/* 02/MAR/2017     LGU          Emision Inicial             */
/* 13/Jun/2019     P. Ortiz     Cambiar valor monto         */
/* 27/Ago/2019     RMAESTRE     Cambiar VALIDACION          */
/* 							    Y VALLOR NULL EN 0          */
/* 10/Nov/2020     S. Rojas     Mejoras                     */
/* 22/Mar/2021     ACH          Caso155813-validacion       */ 
/*                              monto anterior              */
/* 18/Mar/2021     S.Rojas      Req #147999                 */
/* 06/Ene/2023     ACH          REQ #199804 OT RecuperaciOn */
/*                              monto MAximo grupal         */
/* 27/Ene/2023     ACH          REQ #199804 V2 comentario 42*/
/************************************************************/
USE cob_credito
GO

IF OBJECT_ID ('dbo.sp_grupal_reglas') IS NOT NULL
	DROP PROCEDURE dbo.sp_grupal_reglas
GO

CREATE PROC dbo.sp_grupal_reglas
    @s_ssn              int 	    = NULL,	
    @s_rol              smallint    = null,	
    @s_ofi              smallint    = NULL,	
    @s_sesn             int 	    = NULL,
    @t_trn              int         = null,		
    @s_user             login 	    = NULL,
    @s_term             varchar(30) = NULL,
    @s_date             DATETIME    = NULL,
    @s_srv              varchar(30) = NULL,
    @s_lsrv             varchar(30) = NULL,
    @i_tramite          INT,
    @i_id_rule          VARCHAR(30),
    @i_grupo            int  =null,
	@i_valida_part       char(1)      = 'S', -- Para indicar si aplica las reglas solo para los integrantes del grupo que participan. Si llega N, entonces valida a todos.
    @o_msg1             varchar(1200) = null output,
    @o_msg2             varchar(1200) = null output,
    @o_msg3             varchar(1200) = null output,
    @o_msg4             varchar(1200) = null output,
	@o_resultado        varchar(255)  = null output
AS

declare 
@w_rule                         int,
@w_rule_version                 int,
@w_retorno_val                  varchar(255),	
@w_retorno_id                   int,
@w_variables                    varchar(255),
@w_result_values                varchar(255),
@w_error                        int,
@w_id_variable                  int,
@w_miembro                      int,
@w_valor_ant                    varchar(255),
@w_resul_ciclo                  VARCHAR(30),
@w_id_inst_proc                 INT,
@w_monto_ultimo                 MONEY,
@w_grupo                        INT,
@w_emprendedor                  varchar(3),
@w_var_dias_atraso_grupal       int,
@w_var_en_nro_ciclo             smallint,
@w_var_experiencia              varchar(1),  
@w_parent                       int,
@w_var_experiencia_crediticia   varchar(2),
@w_tr_promocion                 char(1),
@w_tr_promocion_grupo           char(2),
@w_contador                     int,
@w_credito_extra                money,
@w_cliente_valida               int,
@w_nombre_valida                varchar(100),
@w_valor_valida                 money,
@w_msg                          varchar(255),
@w_ciclo_grupal                 int,                
@w_monto_sol                    money,
@w_cuenta_ref                   money,
@w_incremento                   money,
@w_nem_solicitud                varchar(20),
@w_reduccion_tasa_grupal        float,
@w_tasa_grupal                  float, 
@w_min_porc_tasa_grupal         float,
@w_tramite_ant                  int,
@w_operacion_ant                INT,
@w_tasa_grupal_aux              float,
@w_referencia_ren_ant           varchar(24),
@w_incremento_max               money,
@w_monto_default                int,
@w_monto_ultima_op              money,
@w_dc_ciclo_cli_grupo           int,
@w_incremento_nueva_op          money
					
select @w_monto_default  = 999999999

select 
@w_id_inst_proc       = io_id_inst_proc,
@w_grupo              = io_campo_1, 
@w_tramite_ant        = io_campo_5,
@w_nem_solicitud      = pr_nemonico
from   cob_workflow..wf_inst_proceso, cob_workflow..wf_proceso
where  io_codigo_proc = pr_codigo_proceso
and    io_campo_3     = @i_tramite

-- SRO. PARAMETRO REDUCCION DE TASA GRUPAL
select @w_reduccion_tasa_grupal = isnull( pa_float, 3.0 )
from cobis..cl_parametro
where pa_nemonico               = 'RDTGRP'
and   pa_producto               = 'CRE'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR_FIN
end

-- SRO. PARAMETRO MINIMO TASA GRUPAL
select @w_min_porc_tasa_grupal = isnull(pa_float,70.0)
from cobis..cl_parametro
where pa_nemonico               = 'MNPRTG'
and   pa_producto               = 'CRE'

if @@rowcount = 0 begin
   select @w_error = 101077
   goto ERROR_FIN
end

--Obtengo la promocion de grupo
SELECT @w_tr_promocion_grupo=tr_promocion FROM cob_credito..cr_tramite WHERE tr_tramite= @i_tramite

if @i_id_rule = 'TASA_GRP'
begin

   
   if @w_nem_solicitud = 'CRRENGR' begin 
   
      select @w_tasa_grupal_aux = or_tasa_ciclo_ant
	  from cob_credito..cr_op_renovar
	  where or_tramite      = @i_tramite	
	  
      select @w_tasa_grupal = @w_tasa_grupal_aux - @w_reduccion_tasa_grupal 
	  if @w_tasa_grupal < @w_min_porc_tasa_grupal select @w_tasa_grupal = convert(float, @w_tasa_grupal_aux)
	  
   end else begin
   
      if exists (select 1 from cob_credito..cr_op_renovar where or_grupo = @w_grupo ) begin 
	  
         select @w_referencia_ren_ant = max(or_referencia_grupal) 
         from  cob_credito..cr_op_renovar 
         where or_grupo               = @w_grupo
         
         select @w_operacion_ant = op_operacion
         from  cob_cartera..ca_operacion
         where op_banco          = @w_referencia_ren_ant
         
         select @w_tasa_grupal = ro_porcentaje 
         from cob_cartera..ca_rubro_op
         where ro_operacion    = @w_operacion_ant
         and   ro_concepto     = 'INT'
		 
	  end else begin
	  
         exec @w_error           = cob_cartera..sp_ejecutar_regla
         @s_ssn                  = @s_ssn,
         @s_ofi                  = @s_ofi,
         @s_user                 = @s_user,
         @s_date                 = @s_date,
         @s_srv                  = @s_srv,
         @s_term                 = @s_term,
         @s_rol                  = @s_rol,
         @s_lsrv                 = @s_lsrv,
         @s_sesn                 = @s_sesn,
         @i_regla                = 'TASA_GRP', 	 
         @i_id_inst_proc         = @w_id_inst_proc,
         @o_resultado1           = @w_retorno_val out
         
         if @w_error <> 0 begin 
            select 
            @w_msg   = 'ERROR: AL EJECUTAR LA REGLA DE TASA GRUPAL' ,
            @w_error = 70005
            goto ERROR_FIN   
         end
	     
         select @w_tasa_grupal = case when @w_retorno_val is null or convert(float, @w_retorno_val) = 0 then 0 else convert(float, @w_retorno_val) end
      end

	  
	  
   end
   
   select @o_resultado = convert(varchar, @w_tasa_grupal)
   
   print 'sp_grupal_reglas TASA_GRP @w_porcentaje '+@o_resultado
end
  
if @i_id_rule = 'VAL_TRAMITE' begin
   select @o_msg1=''
   select @o_msg2=''
   select @o_msg3=''
   select @o_msg4=''
	
   select @w_cliente_valida = -1
	
   select @w_credito_extra = pa_money  
   from cobis..cl_parametro 
   where pa_nemonico = 'CREXTR' and pa_producto = 'CRE'
   
   select *
   into #tg_tramite_grupal
   from cr_tramite_grupal
   where tg_tramite = @i_tramite
		
   --Existen prestamos cuyo porcentaje de Incremeto grupal es menor o igual a -100
   if exists(select 1 from #tg_tramite_grupal where tg_monto > 0 and
              tg_incremento <=-100)
   begin
      select @o_msg1 = 'Existen prestamos cuyo porcentaje de incremeto grupal es menor o igual a -100'
      select @w_error = 208927
        
      exec @w_error = cobis..sp_cerror
           @t_debug  = 'N',
           @t_file   = '',
           @t_from   = 'sp_grupal_reglas',
           @i_num    = @w_error,
           @i_msg    = 'Existen prestamos cuyo porcentaje de incremeto grupal es menor o igual a -100'
   end
    
   select @w_cliente_valida = 0
   while 1=1
   begin
      select top 1 
      @w_cliente_valida = tg_cliente,
      @w_monto_sol      = tg_monto, --6000
      @w_cuenta_ref     = isnull(tg_monto_cuenta_ref,0),
      @w_incremento     = tg_monto_ult_op + tg_monto_ult_op * tg_incremento/100.0
      from #tg_tramite_grupal 
      where tg_cliente > @w_cliente_valida 
      and tg_monto > 0
      --and tg_monto_cuenta_ref is not null
      order by tg_cliente asc
      
      if @@rowcount = 0 break
      
      if @w_cuenta_ref >= @w_incremento
         select @w_valor_valida = @w_cuenta_ref
      else
         select @w_valor_valida = @w_incremento
       
      --@w_valor_valida
      -- validar porcentaje
      if (@w_monto_sol > @w_valor_valida)--3900
      begin
         select @w_nombre_valida = en_nomlar
    	 from cobis..cl_ente
    	 where en_ente = @w_cliente_valida
    	 
         select @w_error = 208927
         select @o_msg1 = 'El cliente ' + @w_nombre_valida + ' solicita un valor superior al monto permitido ('+convert(varchar,@w_valor_valida)+')'
        
		 exec @w_error = cobis..sp_cerror
		      @t_debug  = 'N',
		      @t_file   = '',
		      @t_from   = 'sp_grupal_reglas',
		      @i_num    = @w_error,
		      @i_msg    = @o_msg1
	     break
      end
   end
    
   select @w_cliente_valida = -1

   select top 1 
   @w_cliente_valida = tg_cliente,
   @w_valor_valida = tg_monto_max_calc
   from #tg_tramite_grupal 
   where tg_monto > tg_monto_max_calc 
   and tg_monto > 0
    
   -- validar monto maximo
   -- if exists(select 1 from cr_tramite_grupal where tg_tramite = @i_tramite and tg_monto > tg_monto_max_calc and tg_monto > 0)
   if @w_cliente_valida <> -1
   begin
      select @w_nombre_valida = en_nomlar
      from cobis..cl_ente
      where en_ente = @w_cliente_valida
    	
      select @w_error = 208928
      select @o_msg2 = 'El cliente ' + @w_nombre_valida +' solicita un valor superior al monto Máximo ('+convert(varchar,@w_valor_valida)+')'
        
	  exec @w_error = cobis..sp_cerror
	  @t_debug  = 'N',
	  @t_file   = '',
	  @t_from   = 'sp_grupal_reglas',
	  @i_num    = @w_error,
	  @i_msg    = @o_msg2
   end
   -- validar monto minimo
   select @w_cliente_valida = -1
   
   select top 1 
   @w_cliente_valida = tg_cliente,
   @w_valor_valida = tg_monto_min_calc
   from #tg_tramite_grupal 
   where tg_monto < tg_monto_min_calc 
   and tg_monto > 0
    
   --if exists(select 1 from cr_tramite_grupal where tg_tramite = @i_tramite and tg_monto < tg_monto_min_calc and tg_monto > 0)
   if @w_cliente_valida <> -1
   begin
    	select @w_nombre_valida = en_nomlar
    	from cobis..cl_ente
    	where en_ente = @w_cliente_valida
    	
        select @w_error = 208929
        select @o_msg3 = 'El cliente ' + @w_nombre_valida +' solicita un valor inferior al monto Mínimo ('+convert(varchar,@w_valor_valida)+')'
        
        
		exec @w_error = cobis..sp_cerror
		@t_debug  = 'N',
		@t_file   = '',
		@t_from   = 'sp_grupal_reglas',
		@i_num    = @w_error,
		@i_msg    =  @o_msg3
   end
    
   select @w_cliente_valida = -1
     
   select top 1 
   @w_cliente_valida = tg_cliente,
   @w_valor_valida = gpi_cred_max_comp+@w_credito_extra
   from cr_grupo_promo_inicio, #tg_tramite_grupal 
   where tg_grupo = gpi_grupo 
   and gpi_ente = tg_cliente
   and tg_monto > (gpi_cred_max_comp+@w_credito_extra)
    
   select @w_ciclo_grupal = isnull(gr_num_ciclo,0) + 1 from cobis..cl_grupo where gr_grupo = @w_grupo
   -- validar credito maximo
   if not exists(select 1 from cr_grupo_promo_inicio where gpi_tramite = @i_tramite and gpi_cred_max_comp is null)
   begin
      if @w_tr_promocion_grupo = 'S' and @w_ciclo_grupal = 1 and @w_cliente_valida <> -1
	  --and exists(select 1 from cr_grupo_promo_inicio, cr_tramite_grupal where tg_tramite = @i_tramite and gpi_tramite = tg_tramite and tg_monto > (gpi_cred_max_comp+@w_credito_extra))
	  begin
	     select @w_nombre_valida = en_nomlar
    	 from cobis..cl_ente
    	 where en_ente = @w_cliente_valida
    	 
	     select @w_error = 208945
	     select @o_msg2 = 'El cliente ' + @w_nombre_valida +' solicita un valor mayor al Crédito Máximo ('+convert(varchar,@w_valor_valida)+')'
        
		 exec @w_error = cobis..sp_cerror
			@t_debug  = 'N',
			@t_file   = '',
			@t_from   = 'sp_grupal_reglas',
			@i_num    = @w_error,
			@i_msg    = @o_msg2
	  end
   end
	
   return 0
end

select @w_id_inst_proc = isnull(@w_id_inst_proc,-1)

if @w_id_inst_proc = -1
    select @w_grupo = @i_grupo 
    
select @w_tr_promocion_grupo = isnull(@w_tr_promocion_grupo,'NO')
if @w_tr_promocion_grupo = 'S' select @w_tr_promocion_grupo = 'SI'
if @w_tr_promocion_grupo = 'N' select @w_tr_promocion_grupo = 'NO'


if @i_id_rule   = 'MONTO_GRP'
begin
   print 'SMO sp_dias_atraso_grupal '+ convert(varchar,@w_grupo)
   EXEC @w_error = sp_dias_atraso_grupal
	    @i_grupo			= @w_grupo,
		@i_ciclos_ant		= 1,
		@i_es_ciclo_ant     = 'S',
		@o_resultado    	= @w_var_dias_atraso_grupal OUTPUT 
   
   if @w_error<>0
   begin
      exec @w_error = cobis..sp_cerror
	       @t_debug  = 'N',
	       @t_file   = '',
	       @t_from   = 'sp_grupal_reglas',
	       @i_num    = @w_error,
	       @i_msg    = 'Error al determinar Dia Atraso Grupal'
   end
end 


select
@w_rule           = bpl_rule.rl_id,
@w_rule_version   = rv_id
from cob_pac..bpl_rule
inner join cob_pac..bpl_rule_version  on bpl_rule.rl_id = bpl_rule_version.rl_id
where rv_status   = 'PRO'
and rl_acronym    = @i_id_rule
and getdate()     >= rv_date_start
and getdate()     <= rv_date_finish

select @w_id_variable  = vb_codigo_variable
from cob_workflow..wf_variable
where vb_abrev_variable     = 'CLINROCLIN'

select @w_miembro = 0
select @w_miembro  = tg_cliente
from cob_credito..cr_tramite_grupal
where tg_tramite       =   @i_tramite
and (tg_participa_ciclo <> 'N' or @i_valida_part = 'N')
and tg_cliente         >  @w_miembro
order by tg_cliente desc

while @@rowcount > 0
begin

   select @w_valor_ant   = isnull(va_valor_actual, '')
   from cob_workflow..wf_variable_actual
   where va_id_inst_proc = @w_id_inst_proc
   and va_codigo_var     = @w_id_variable
   
   if @@rowcount > 0  --ya existe
   begin
      update cob_workflow..wf_variable_actual
      set va_valor_actual = @w_miembro
      where va_id_inst_proc = @w_id_inst_proc
      and va_codigo_var   = @w_id_variable
   end
   else
   begin
      insert into cob_workflow..wf_variable_actual
                (va_id_inst_proc, va_codigo_var, va_valor_actual)
      values (@w_id_inst_proc, @w_id_variable, @w_miembro )
   end

   IF @i_id_rule   = 'INC_GRP'
   BEGIN
      exec @w_error          = cob_pac..sp_exec_variable_by_rule
           @s_ssn             = @s_ssn,
           @s_sesn            = @s_sesn,
           @s_user            = @s_user,
           @s_term            = @s_term,
           @s_date            = @s_date,
           @s_srv             = @s_srv,
           @s_lsrv            = @s_lsrv,
           @s_ofi             = @s_ofi,
           @t_file            = null,
           @s_rol             = @s_rol,
           @s_org_err         = null,
           @s_error           = null,
           @s_msg             = null,
           @s_org             = '',
           @s_culture         = 'ES_EC',
           @t_rty             = '',
           @t_trn             = @t_trn,
           @t_show_version    = 0,
           @i_id_inst_proc    = @w_id_inst_proc,
           @i_id_inst_act     = 0,
           @i_id_asig_act     = 0,
           @i_id_empresa      = 1,
           @i_acronimo_regla  = 'INC_GRP',
           @i_var_nombre      = 'NROCLIND', -- LGU nombre de una variable especifica
           @o_resultado       = @w_resul_ciclo  out-- LGU resultado de evaluar una sola variable
      
      --print 'Se ejecutan las variables de la regla  RESULTADO CLI ' + convert(VARCHAR, @w_miembro) + ' CICLO ' + @w_resul_ciclo
	  IF @w_resul_ciclo > 1 --CICLO DEL Cliente en toda su vida
	  begin
		 exec @w_error          = cob_pac..sp_exec_variable_by_rule
	            @s_ssn             = @s_ssn,
	            @s_sesn            = @s_sesn,
	            @s_user            = @s_user,
	            @s_term            = @s_term,
	            @s_date            = @s_date,
	            @s_srv             = @s_srv,
	            @s_lsrv            = @s_lsrv,
	            @s_ofi             = @s_ofi,
	            @t_file            = null,
	            @s_rol             = @s_rol,
	            @s_org_err         = null,
	            @s_error           = null,
	            @s_msg             = null,
	            @s_org             = '',
	            @s_culture         = 'ES_EC',
	            @t_rty             = '',
	            @t_trn             = @t_trn,
	            @t_show_version    = 0,
	            @i_id_inst_proc    = @w_id_inst_proc,
	            @i_id_inst_act     = 0,
	            @i_id_asig_act     = 0,
	            @i_id_empresa      = 1,
	            @i_acronimo_regla  = @i_id_rule
	
	     --Se ejecuta la regla		 
	     select @w_retorno_val = '0'
	     select @w_retorno_id = 0
	     select @w_variables = ''
	     select @w_result_values = ''
	     
	     exec @w_error           = cob_pac..sp_rules_run
	            @s_ssn             = @s_ssn,
	            @s_sesn            = @s_sesn,
	            @s_user            = @s_user,
	            @s_term            = @s_term,
	            @s_date            = @s_date,
	            @s_srv             = @s_srv,
	            @s_lsrv            = @s_lsrv,
	            @s_ofi             = 1,
	            @s_rol             = 3,
	            @t_trn             = 1111,
	            @i_status          = 'V',
	            @i_id_inst_proceso = @w_id_inst_proc,
	            @i_code_rule       = @w_rule,
	            @i_version         = @w_rule_version,
	            @o_return_value    = @w_retorno_val   out,
	            @o_return_code     = @w_retorno_id    out,
	            @o_return_variable = @w_variables     out,
	            @o_return_results  = @w_result_values out,
	            --@s_culture         = 'ES_EC',
	            @i_mode            = 'WFL',
	            @i_abreviature      = null,
	            @i_simulator       = 'N',
	            @i_nivel           =  0,
	            @i_modo            = 'S'
				
		    --print '@w_retorno_val: '+convert(varchar, @w_retorno_val)
	        --print '@w_retorno_id: '+convert(varchar, @w_retorno_id)
	        --print '@w_variables: '+convert(varchar, @w_variables)
	        --print '@w_result_values: '+convert(varchar, @w_result_values)

	     if @w_error<>0
	     begin
	        exec @w_error = cobis..sp_cerror
	             @t_debug  = 'N',
	             @t_file   = '',
	             @t_from   = 'sp_rules_run',
	             @i_num    = @w_error
	     END
		 
         PRINT '@w_retorno_val INGRP: '+convert(varchar, @w_retorno_val)
	     print '@w_retorno_id INGRP: '+convert(varchar, @w_retorno_id)
	     print '@w_variables INGRP: '+convert(varchar, @w_variables)
	     print '@w_result_values INGRP: '+convert(varchar, @w_result_values)
         print '@w_monto_default: '+convert(varchar, @w_monto_default)	    

		 --PorCaso #199804
         select @w_dc_ciclo_cli_grupo = null, @w_grupo = null, @w_monto_ultimo = null, 
		        @w_monto_ultima_op = null, @w_incremento_max = null
		 select @w_grupo = tg_grupo 
		 from cob_credito..cr_tramite_grupal
         where tg_tramite = @i_tramite
	
	     --CICLO del cliente dentro del grupo
		 select @w_dc_ciclo_cli_grupo = max(dc_ciclo)
		 from cob_cartera..ca_det_ciclo 
		 where dc_cliente = @w_miembro and dc_grupo = @w_grupo
		 
         select @w_dc_ciclo_cli_grupo = isnull(@w_dc_ciclo_cli_grupo, 0)

		 print '-->>>Ciclo del cliente en el grupo: ' + convert(varchar, @w_dc_ciclo_cli_grupo) + 
		       '-->>>Ciclo del cliente: ' + convert(varchar, @w_resul_ciclo) +
		       '-->>>Grupo: ' + convert(varchar, @w_grupo) +
		       '-->>>Tramite: ' + convert(varchar, @i_tramite) +
			   '-->>>Miembro: ' + convert(varchar, @w_miembro) +
			   '-->>>EsPromo: ' + convert(varchar, @w_tr_promocion_grupo)
					
	     if(@w_tr_promocion_grupo = 'SI' or (@w_dc_ciclo_cli_grupo < 2)) begin -- Funcionalidad Inicial
		     print 'Grupo promo o ciclo del cliente en el grupo menor o igual a 2'
			 SELECT TOP 1 @w_monto_ultimo = op_monto
	         FROM cob_cartera..ca_operacion ,cob_cartera..ca_estado, 
                 cob_credito..cr_tramite_grupal -- Caso#155813
	         WHERE op_cliente = @w_miembro
	         AND op_estado = es_codigo
	         AND (es_procesa='S' OR op_estado = 3)
	         and op_toperacion = 'GRUPAL'
	         and tg_operacion = op_operacion -- Caso#155813
			 and tg_prestamo <> tg_referencia_grupal
	         ORDER BY op_operacion DESC
			 --sale para ciclo 3
         end else begin -- porCaso#199804
		 	 print 'Grupo NO promo con ciclo del cliente en el grupo mayor a 2'
			 
			 --valores del tramite anterior
			 select top 1 @w_incremento_nueva_op = tg_monto  + tg_monto * @w_retorno_val /100, -- Incremento para el trAmite actual, solo x eso se calcula con el tg_monto
					      @w_monto_ultima_op = op_monto
			 FROM cob_cartera..ca_operacion ,cob_cartera..ca_estado, 
                 cob_credito..cr_tramite_grupal -- Caso#155813
	         WHERE op_cliente = @w_miembro
	         AND op_estado = es_codigo
	         AND (es_procesa='S' OR op_estado = 3)
	         and op_toperacion = 'GRUPAL'
	         and tg_operacion = op_operacion -- Caso#155813
			 and tg_prestamo <> tg_referencia_grupal
	         ORDER BY op_operacion DESC
			 			 
			 SELECT @w_incremento_nueva_op = isnull (@w_incremento_nueva_op , @w_monto_default)
			 
			 --maximo incremento entregado en los ciclos anteriores sin contar el valor por defecto
		     select @w_incremento_max = isnull(max(tg_monto_ult_op  + tg_monto_ult_op * tg_incremento /100), @w_monto_default) -- calculo normal del incremento.
             from cob_cartera..ca_operacion ,cob_cartera..ca_estado, 
                 cob_credito..cr_tramite_grupal
             where op_cliente = @w_miembro
             and op_estado = es_codigo
             and (es_procesa='S' OR op_estado = 3)
             and op_toperacion = 'GRUPAL'
             and tg_operacion = op_operacion
			 and tg_prestamo <> tg_referencia_grupal
             and tg_monto_ult_op <> @w_monto_default
			 
			 print '-->>@w_incremento_nueva_op: ' + convert(varchar, isnull(@w_incremento_nueva_op, 0)) + 
                   '-->>@w_incremento_max: ' + convert(varchar, isnull(@w_incremento_max, 0)) +
                   '--->>Cliente: ' + convert(varchar, @w_miembro) + 
                   '--->>Incremento: ' + convert(varchar, isnull(@w_retorno_val,0))
				   
			 if(@w_incremento_nueva_op < @w_incremento_max and @w_incremento_max <> @w_monto_default) begin
				print '--->>>Toma el monto y el incremento de la operación con maximo incremento'
				select @w_retorno_val = null				 
				select @w_monto_ultimo = tg_monto_ult_op,
				       @w_retorno_val = tg_incremento
                from cob_cartera..ca_operacion ,cob_cartera..ca_estado, 
                     cob_credito..cr_tramite_grupal
                where op_cliente = @w_miembro
                and op_estado = es_codigo
                and (es_procesa='S' OR op_estado = 3)
                and op_toperacion = 'GRUPAL'
                and tg_operacion = op_operacion
				and tg_prestamo <> tg_referencia_grupal
                and (tg_monto_ult_op  + tg_monto_ult_op * tg_incremento /100) = @w_incremento_max
			 end else begin
				print '--->>>Toma el monto prestado del Ultimo trAmite'
				select @w_monto_ultimo = @w_monto_ultima_op
			 end
		 end					
	     SELECT @w_monto_ultimo = isnull(@w_monto_ultimo, 0)
	  END -- si cilo es mayor que uno
	  ELSE
	  BEGIN
	     --PRINT '--------- 100'
	     SELECT @w_retorno_val = 100
	     SELECT @w_monto_ultimo = 999999999
	  END
	  
	  print '--->>@w_monto_ultimo: ' + convert(varchar, isnull(@w_monto_ultimo,0)) + 
	        '--->>Incremento: ' + convert(varchar, isnull(@w_retorno_val,0)) + 
	        '--->>Cliente: ' + convert(varchar, @w_miembro) + 
	        '--->>Grupo: ' + convert(varchar, isnull(@w_grupo, 0))+ 
	        '--->>Tramite: ' + convert(varchar, isnull(@i_tramite, 0))
			
      UPDATE cob_credito..cr_tramite_grupal SET
      tg_incremento = convert(numeric(8,4), @w_retorno_val),
      tg_monto_ult_op = convert(money, @w_monto_ultimo)
      WHERE tg_tramite = @i_tramite
      AND tg_cliente = @w_miembro
      
      select @w_error = @@error
      if @w_error<>0
      BEGIN 
         exec @w_error = cobis..sp_cerror
              @t_debug  = 'N',
              @t_file   = '',
              @t_from   = 'sp_grupal_reglas',
              @i_num    = @w_error,
              @i_msg    = 'Error al actualizar campo INCREMENTO del tramite grupal'
      END
      
   END 
   
   
   IF @i_id_rule = 'MONTO_GRP'
   BEGIN
      print 'calcula monto grupal del cliente '+convert(varchar,@w_miembro)
	  SELECT 
	  @w_var_en_nro_ciclo = en_nro_ciclo
	  FROM  cobis..cl_ente
	  WHERE  en_ente   = @w_miembro
	      
	  IF (@w_var_en_nro_ciclo IS NULL)
	  BEGIN
	  	 select @w_var_en_nro_ciclo = 1
	  end
	  else
	  BEGIN
		 select @w_var_en_nro_ciclo = @w_var_en_nro_ciclo+1
	  end
      PRINT '@w_var_en_nro_ciclo--->'+ convert(VARCHAR(50),@w_var_en_nro_ciclo)
		 
	    --Ejecucion del Experiencia Crediticia
	  EXEC @w_error =cob_credito..sp_var_experiencia_crediticia
           @i_id_cliente=@w_miembro,
           @o_resultado     = @w_var_experiencia_crediticia OUTPUT 
      
      if @w_error<>0
	  begin
	     exec @w_error = cobis..sp_cerror
	        @t_debug  = 'N',
	        @t_file   = '',
	        @t_from   = 'sp_grupal_reglas',
	        @i_num    = @w_error,
	        @i_msg    = 'Error al determinar la Experiencia Crediticia del Cliente'
	  END
       
      PRINT 'ID cliente en Regla--> '+ convert (VARCHAR(50), @w_miembro)
      PRINT 'Var Experiencia Crediticia'+ convert (VARCHAR(50), @w_var_experiencia_crediticia)
	  
      select @w_contador = count(1) 
	  from cob_credito..cr_grupo_promo_inicio
	  where gpi_grupo = @w_grupo
	  
	  print 'SMO integrantes promo desde grupal_reglas >>> '+convert(varchar,@w_contador)
	  ---tr_promocion
      --IF (@w_tr_promocion_grupo = 'S')
      -- BEGIN
      --TODO: Validar si se genera la tabla grupo_promo_inicio en cada ciclo o se toma el del primer ciclo, en base al grupo
      IF EXISTS(SELECT 1 FROM cob_credito..cr_grupo_promo_inicio WHERE 
                     gpi_grupo=@w_grupo AND gpi_ente=@w_miembro)
      BEGIN
		 print 'encuentra promocion'
         SELECT @w_tr_promocion='S' 
      END
      ELSE
      BEGIN
	     print 'NO encuentra promocion'
         SELECT @w_tr_promocion='N' 
      END

      --END
      --ELSE
      --BEGIN
      -- SELECT @w_tr_promocion='N' 
      -- END
		
	  PRINT 'Promocion final par el  cliente --->'+ convert(varchar(50),@w_tr_promocion)
	      
      set @w_resul_ciclo = isnull(@w_tr_promocion_grupo,'NO')+'|' + 
        					 isnull (@w_tr_promocion,'N')+ '|' + 
                             isnull(convert(VARCHAR,@w_var_en_nro_ciclo),'1') + '|' + 
	  				         isnull(convert(VARCHAR,@w_var_dias_atraso_grupal),'0') + '|' + 
	  				         isnull(@w_var_experiencia_crediticia,' ')
	     				         
	   
	  Print'@w_resul_ciclo'+ convert(VARCHAR(50),@w_resul_ciclo)
	  
	  -- LLAMA A LA REGLA - RETORNA EL TIPO DE CR+DITO CUANDO SECTOR = 'CR+DITO EMPRESARIAL'
	     exec @w_error    = cob_pac..sp_rules_param_run
	     @s_rol             = @s_rol,
	     @i_rule_mnemonic   = @i_id_rule,
	     @i_var_values      = @w_resul_ciclo, 
	     @i_var_separator   = '|',
	     @o_return_variable = @w_variables  out,
	     @o_return_results  = @w_result_values   OUT,
	     @o_last_condition_parent = @w_parent out
		 --PRINT '----------------------------------------------------------------------'
		 --print' CL : ' + convert(VARCHAR, @w_miembro) + ' EVALUAR =' + @w_resul_ciclo
	     --print '@w_variables: '+convert(varchar, @w_variables)
	     --print '@w_result_values: '+convert(varchar, @w_result_values)
		 --PRINT '----------------------------------------------------------------------'
         
	     if @w_error != 0
	     begin
	          print 'Print: fallo MONTO_GRP para cliente ' + convert(VARCHAR, @w_miembro)
			  print 'Error_fallo_monto_grp_regla:' + convert(VARCHAR, @w_error)
	          GOTO SIGUIENTE
	     end
	     if @w_result_values IS null
	     BEGIN
	     	SELECT @w_result_values = '0|0'
	     end
	
	     PRINT '@w_variables MTGRP'    + convert(VARCHAR(50),@w_variables)
		 PRINT '@w_result_values MTGRP'+ convert(VARCHAR(50),@w_result_values)
		 PRINT '@w_parent MTGRP'       + convert(VARCHAR(50),@w_parent)
--////////////////////////////////////////////////////// 

        --SELECT 'tramite' = @i_tramite, 'cliente' = @w_miembro, 'monto_maximo' = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|','')
        UPDATE cob_credito..cr_tramite_grupal SET
        tg_monto_max      = isnull(tg_monto_max, replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|','')),
        tg_monto_max_calc = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|',''),
        tg_monto_min_calc = replace(convert(varchar, substring(@w_result_values, 1,   charindex('|', @w_result_values) - 1)),'|','')
        WHERE tg_tramite = @i_tramite
        AND tg_cliente = @w_miembro
        select @w_error = @@error
		
        if @w_error<>0
        begin
            goto ERROR_FIN
        END
        
    END  -- monto grupal
	


SIGUIENTE:
    select @w_miembro        = tg_cliente
    from cob_credito..cr_tramite_grupal
    where tg_tramite         =   @i_tramite
    and (tg_participa_ciclo   <> 'N' or @i_valida_part = 'N')
    and tg_cliente           >  @w_miembro
    order by tg_cliente desc
end -- WHILE

RETURN 0
ERROR_FIN:

exec @w_error = cobis..sp_cerror
@t_debug  = 'N',
@t_file   = '',
@t_from   = 'sp_grupal_reglas',
@i_num    = @w_error,
@i_msg    = @w_msg

return @w_error

go
