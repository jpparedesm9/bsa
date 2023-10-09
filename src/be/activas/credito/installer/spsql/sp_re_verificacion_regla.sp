/************************************************************************/
/*  Archivo:                sp_re_verificacion_regla.sp                 */
/*  Stored procedure:       sp_re_verificacion_regla                    */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Sandino Dávila                              */
/*  Fecha de Documentacion: 04/May/2018                                 */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*  Ejecución de reglas                                                 */
/************************************************************************/
/*                        MODifICACIONES                                */
/*  FECHA        AUTOR                       RAZON                      */
/* 04/May/2018   SDA      Emision Inicial                               */
/* 09/Nov/2020   DCU      Mejoras                                       */
/* 22/Mar/2021   ACH      Caso155813-validacion monto anterior          */
/* 09/Jun/2021   ACH      Caso160251-se añade un out para que no        */
/*                        retorne null sp sp_dias_atraso_grupal         */
/* 06/Ene/2023   ACH      REQ #199804 OT RecuperaciOn monto MAximo grup */
/* 27/Ene/2023   ACH      REQ #199804 V2 comentario 42                  */
/************************************************************************/

USE cob_credito
GO

if exists(select 1 from sysobjects where name ='sp_re_verificacion_regla')
	DROP proc sp_re_verificacion_regla
GO

CREATE PROC sp_re_verificacion_regla
(	@s_ssn        	INT         = NULL,
	@s_ofi        	SMALLINT    = NULL,
	@s_user       	login       = NULL,
	@s_date       	DATETIME    = NULL,
	@s_srv		   	VARCHAR(30) = NULL,
	@s_term	   		descripcion = NULL,
	@s_rol		   	SMALLINT    = NULL,
	@s_lsrv	   		VARCHAR(30)	= NULL,
	@s_sesn	   		INT 	    = NULL,
	@s_org		   	CHAR(1)     = NULL,
	@s_org_err	    INT 	    = NULL,
	@s_error     	INT 	    = NULL,
	@s_sev        	TINYINT     = NULL,
	@s_msg        	descripcion = NULL,
	@t_rty        	CHAR(1)     = NULL,
	@t_trn        	INT         = NULL,
	@t_debug      	CHAR(1)     = 'N',
	@t_file       	VARCHAR(14) = NULL,
	@t_from       	VARCHAR(30) = NULL,
	--variables
	@i_id_inst_proc	INT,    -- Codigo de instancia del proceso
	@i_id_inst_act 	INT,	-- Codigo instancia de la atividad
	@i_id_empresa	INT,	-- Codigo de la empresa
	@o_id_resultado SMALLINT  OUT
)
AS 
DECLARE	-- Variables de trabajo
@w_sp_name                  varchar(20),
@w_msg                      varchar(255),
@w_tramite					INT,
@w_tr_promocion_grupo		CHAR(2),
@w_grupo					INT,
@w_id_regla					INT,
@w_version_regla			INT,
@w_var_dias_atraso_grupal	INT,
@w_miembro					INT,
@w_emprendedor				VARCHAR(3),
@w_var_en_nro_ciclo			SMALLINT,
@w_var_experiencia			VARCHAR(1),
@w_var_exp_crediticia		VARCHAR(2),
@w_tr_promocion				CHAR(1),
@w_resul_ciclo				VARCHAR(30),
@w_variables				VARCHAR(255),
@w_result_values			VARCHAR(255),
@w_monto_max				MONEY,
@w_monto_min				MONEY,
@w_parent					INT,
@w_cli_monto_grupo			VARCHAR(255),
@w_cli_increm_grupo			VARCHAR(255),
@w_retorno_val				VARCHAR(255),
@w_retorno_id				INT,
@w_numero_linea				INT,
@w_error					INT,
@w_monto_ultimo             MONEY,
@w_cliente_valida           int,
@w_monto_sol                money,
@w_cuenta_ref               money,
@w_incremento               money,
@w_valor_valida             money,
@w_id_variable              int,
@w_valor_ant                varchar(255),
@w_monto_default            int,
@w_dc_ciclo_cli_grupo       int,
@w_monto_ultima_op          money,
@w_incremento_max           money,
@w_incremento_nueva_op      money,
@w_incremento_ultima_op     money,
@w_monto_ult_op_max         money

select @w_sp_name = 'sp_re_verificacion_regla'

declare @w_tramite_grupal table (
	tg_tramite          	int NOT NULL,
	tg_grupo            	int NOT NULL,
	tg_cliente          	int NOT NULL,
	tg_monto            	money NOT NULL,
	tg_grupal           	char(1) NOT NULL,
	tg_operacion        	int NULL,
	tg_prestamo         	varchar(15) NULL,
	tg_referencia_grupal	varchar(15) NULL,
	tg_cuenta           	varchar(45) NULL,
	tg_cheque           	int NULL,
	tg_participa_ciclo  	char(1) NULL,
	tg_monto_aprobado   	money NULL,
	tg_ahorro           	money NULL,
	tg_monto_max        	money NULL,
	tg_bc_ln            	char(10) NULL,
	tg_incremento       	numeric(8,4) NULL,
	tg_monto_ult_op     	money NULL,
	tg_monto_max_calc   	money NULL,
	tg_nueva_op         	int NULL,
	tg_monto_min_calc   	money NULL,
	tg_conf_grupal      	char(1) NULL,
	tg_monto_cuenta_ref 	money NULL 
)
-- Seteo de variables
select @w_monto_default  = 999999999
select @w_numero_linea = 0
PRINT 'Inicia reverificacion Regla para proceso--->:' + convert(varchar(30), @i_id_inst_proc)
select	@w_tramite	=	io_campo_3,
		@w_grupo	=	io_campo_1
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc


SELECT  @w_id_regla			= R.rl_id,
		@w_version_regla	= rv_id
FROM cob_pac..bpl_rule R
INNER JOIN cob_pac..bpl_rule_version RV on R.rl_id = RV.rl_id
WHERE R.rl_acronym = 'INC_GRP'
AND RV.rv_status = 'PRO'
AND GETDATE() >= RV.rv_date_start
AND GETDATE() <= RV.rv_date_finish

PRINT 'Inicia reverificacion Regla para proceso--->:' + convert(varchar(30), @i_id_inst_proc) + '---Tramite:' + convert(varchar(30), @w_tramite)

-- Consulta los dias de atraso grupal
EXEC @w_error		= sp_dias_atraso_grupal
@i_grupo		    = @w_grupo,
@i_ciclos_ant	    = 1,
@i_es_ciclo_ant	    = 'S',
@o_resultado	    = @w_var_dias_atraso_grupal out

if @w_error <> 0
begin

   select @w_msg		= 'Error al determinar Dia Atraso Grupal'
   goto ERROR
   
end
PRINT 'Pasa validacion de dias atraso Grupal para proceso--->:' + convert(varchar(30), @i_id_inst_proc) + '---Tramite:' + convert(varchar(30), @w_tramite)
--Obtengo la promocion de grupo
select @w_tr_promocion_grupo = tr_promocion 
from cob_credito..cr_tramite 
where tr_tramite =@w_tramite

select  @w_tr_promocion_grupo = isnull(@w_tr_promocion_grupo,'NO')
if @w_tr_promocion_grupo = 'S' 
	select @w_tr_promocion_grupo = 'SI'
else
	select @w_tr_promocion_grupo = 'NO'



if (@w_tr_promocion_grupo = 'SI')
begin
	EXEC cob_credito..sp_var_integrantes_original
	@i_id_inst_proc = @i_id_inst_proc,
	@i_id_inst_act = 1,
	@i_id_asig_act = 1,
	@i_id_empresa = 1,
	@i_id_variable = 1
end
PRINT 'Pasa @w_tr_promocion_grupo Grupal para proceso--->:' + convert(varchar(30), @i_id_inst_proc) + '---Tramite:' + convert(varchar(30), @w_tramite)
-- Consulta los clientes del trámite


insert into @w_tramite_grupal
select *
from cob_credito..cr_tramite_grupal
where tg_tramite = @w_tramite


select	@w_miembro  =	0

-- Recorre cada cliente
WHILE 1 = 1 begin
	-- Inicio WHILE
	-- Inicia Validar Regla Monto Grupal
	
	select	top 1 @w_miembro  =	tg_cliente
    from @w_tramite_grupal
    where tg_tramite          = @w_tramite
    and tg_participa_ciclo    <> 'N'
    and tg_cliente            > @w_miembro
    order by tg_cliente asc
	
	if @@rowcount = 0 break

	-- Consulta tipo de empresario
	PRINT 'Ingresa al While de clientes para proceso--->:' + convert(varchar(30), @i_id_inst_proc) + '---Tramite:' + convert(varchar(30), @w_tramite)
	PRINT 'SMO sp_re_verificacion_regla @w_miembro clientes--->'+ convert(varchar(50),@w_miembro)
	select @w_var_en_nro_ciclo = en_nro_ciclo
	from  cobis..cl_ente
	where  en_ente   = @w_miembro


	-- Setea el número de ciclos de cliente
	if (@w_var_en_nro_ciclo IS NULL)
	begin
		select @w_var_en_nro_ciclo = 1
	end
	else
	begin
		select @w_var_en_nro_ciclo = @w_var_en_nro_ciclo+1
	end
	
	PRINT 'SMO sp_re_verificacion_regla  @w_var_en_nro_ciclo clientes--->'+ convert(varchar(50),@w_var_en_nro_ciclo)

	-- Ejecuta la experiencia crediticia del cliente
	EXEC	@w_error		= cob_credito..sp_var_experiencia_crediticia
			@i_id_cliente	= @w_miembro,
			@o_resultado	= @w_var_exp_crediticia OUTPUT
	-- Valida si Existio error 
	if @w_error <> 0
	begin
	   print 'SMO sp_re_verificacion_regla ERROR exp crediticia '+convert(varchar,@w_error)   
       select @w_msg = 'Error al determinar la Experiencia Crediticia del Cliente'
	   goto ERROR
	end

	print 'SMO sp_re_verificacion_regla RESULTADO exp crediticia '+@w_var_exp_crediticia
	-- Valida si el cliente esta en la tabla coloca las promociones
	if (@w_tr_promocion_grupo = 'SI')
	begin
		if exists(select 1 from cob_credito..cr_grupo_promo_inicio 
				  where gpi_grupo = @w_grupo 
				  and gpi_ente = @w_miembro)
		begin
			select @w_tr_promocion='S' 
		end
		else
		begin
			select @w_tr_promocion='N' 
		end
	end
	else
	begin
		select @w_tr_promocion='N' 
	end
	
	 PRINT 'SMO Promocion final par el  cliente reverificacion --->'+ convert(varchar(50),@w_tr_promocion)

	select @w_variables = ''
	select @w_result_values = ''
	select @w_parent = ''

	-- Setear el resultado del ciclo
	SET @w_resul_ciclo	=   isnull(@w_tr_promocion_grupo,'NO')+'|' + 
        					 isnull (@w_tr_promocion,'N')+ '|' + 
                             isnull(convert(VARCHAR,@w_var_en_nro_ciclo),'1') + '|' + 
	  				         isnull(convert(VARCHAR,@w_var_dias_atraso_grupal),'0') + '|' + 
	  				         isnull(@w_var_exp_crediticia,' ')
	  				      
	  				    
	  				         
						  
	Print'SMO sp_re_verificacion_regla  @w_resul_ciclo reverificacion'+ convert(VARCHAR(50),@w_resul_ciclo)					  

	-- Ejecución de la regla para Monto Grupal
	EXEC	@w_error					= cob_pac..sp_rules_param_run
			@s_rol						= @s_rol,
			@i_rule_mnemonic			= 'MONTO_GRP',
			@i_var_values				= @w_resul_ciclo, 
			@i_var_separator			= '|',
			@o_return_variable			= @w_variables  OUT,
			@o_return_results			= @w_result_values   OUT,
			@o_last_condition_parent	= @w_parent OUT

	-- Valida si existio error
	if @w_error <> 0
	begin
		-- Setea los clientes con error al ejecutar la regla
		if @w_cli_monto_grupo IS NULL
			select @w_cli_monto_grupo = convert(VARCHAR, @w_miembro)
		else
			select @w_cli_monto_grupo = @w_cli_monto_grupo + ',' + convert(VARCHAR, @w_miembro)
	end
	else
	begin	
         PRINT 'SMO sp_re_verificacion_regla  @w_variables sp_re_verificacion MTGRP'    + convert(VARCHAR(50),@w_variables)
		 PRINT 'SMO sp_re_verificacion_regla  @w_result_values sp_re_verificacion MTGRP'+ convert(VARCHAR(50),@w_result_values)
		 PRINT 'SMO sp_re_verificacion_regla  @w_parent sp_re_verificacion MTGRP'       + convert(VARCHAR(50),@w_parent)	
		 PRINT 'SMO sp_re_verificacion_regla  @w_miembro sp_re_verificacion MTGRP'       + convert(VARCHAR(50),@w_miembro)
		-- Actualiza tabla de registro de datos de la regla
		
		update @w_tramite_grupal SET
        tg_monto_max      = isnull(tg_monto_max, replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|','')),
        tg_monto_max_calc = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|',''),
        tg_monto_min_calc = replace(convert(varchar, substring(@w_result_values, 1,   charindex('|', @w_result_values) - 1)),'|','')
        where tg_tramite = @w_tramite
        and tg_cliente = @w_miembro
		
		update cr_tramite_grupal SET
        tg_monto_max      = isnull(tg_monto_max, replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|','')),
        tg_monto_max_calc = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|',''),
        tg_monto_min_calc = replace(convert(varchar, substring(@w_result_values, 1,   charindex('|', @w_result_values) - 1)),'|','')
        where tg_tramite = @w_tramite
        and tg_cliente = @w_miembro
		
		-- Valida si existe error
		select @w_error = @@error
        if @w_error<>0
        begin
            select @w_msg    = 'Error al actualizar campo MONTO MAXIMO del tramite grupal'
			goto ERROR
        end
		else
		begin		
			if exists(	select 1 
						from @w_tramite_grupal 
						where tg_tramite = @w_tramite 
						and tg_cliente = @w_miembro
						and tg_monto != 0)
			begin
			PRINT 'cliente tiene monto !0 MG'
			-- Validaciones de grupo
			if NOT exists(	select 1 
						from @w_tramite_grupal 
						where tg_tramite = @w_tramite 
						and tg_cliente = @w_miembro
						and (tg_monto >= tg_monto_min_calc 
						and tg_monto <= tg_monto_max_calc))
			begin
			
			PRINT 'cliente no cumple regla de Monto Grupal'
				if @w_cli_monto_grupo IS NULL
				begin
				PRINT '@w_cli_monto_grupo is null en MG'
				PRINT '@w_cli_monto_grupo is null en MG clientes--->'+ convert(varchar(50),@w_miembro)
					select @w_cli_monto_grupo = convert(VARCHAR, @w_miembro)
				end
				else
				begin
				PRINT '@w_cli_monto_grupo is  not null en MG'
				PRINT '@w_cli_monto_grupo is  not  null en MG clientes--->'+ convert(varchar(50),@w_miembro)
					select @w_cli_monto_grupo = @w_cli_monto_grupo + ',' + convert(VARCHAR, @w_miembro)
			end
		end
	end
	end
	end

 PRINT 'Inicia Incremento Grupal @w_miembro clientes IG--->'+ convert(varchar(50),@w_miembro)
	-- Finaliza Validar Regla Monto Grupal

	-- Inicia Validar Regla Incremento Grupal

	-- Setea variable 
	select	@w_resul_ciclo = NULL
	
-- Por caso #149444, inicio
   select @w_id_variable  = vb_codigo_variable
   from cob_workflow..wf_variable
   where vb_abrev_variable     = 'CLINROCLIN'

   select @w_valor_ant   = isnull(va_valor_actual, '')
   from cob_workflow..wf_variable_actual
   where va_id_inst_proc = @i_id_inst_proc--@w_id_inst_proc
   and va_codigo_var     = @w_id_variable
   
   if @@rowcount > 0  --ya existe
   begin
      update cob_workflow..wf_variable_actual
      set va_valor_actual = @w_miembro
      where va_id_inst_proc = @i_id_inst_proc--@w_id_inst_proc
      and va_codigo_var   = @w_id_variable
   end
   else
   begin
      insert into cob_workflow..wf_variable_actual
                (va_id_inst_proc, va_codigo_var, va_valor_actual)
      values (@i_id_inst_proc, @w_id_variable, @w_miembro )
   end
-- Por caso #149444, fin
	EXEC	@w_error			= cob_pac..sp_exec_variable_by_rule
			@s_ssn				= @s_ssn,
			@s_sesn				= @s_sesn,
			@s_user				= @s_user,
			@s_term				= @s_term,
			@s_date				= @s_date,
			@s_srv				= @s_srv,
			@s_lsrv				= @s_lsrv,
			@s_ofi				= @s_ofi,
			@t_file				= NULL,
			@s_rol				= @s_rol,
			@s_org_err			= NULL,
			@s_error			= NULL,
			@s_msg				= NULL,
			@s_org				= '',
			@s_culture			= 'ES_EC',
			@t_rty				= '',
			@t_trn				= @t_trn,
			@t_show_version		= 0,
			@i_id_inst_proc		= @i_id_inst_proc,
			@i_id_inst_act		= 0,
			@i_id_asig_act		= 0,
			@i_id_empresa		= 1,
			@i_acronimo_regla	= 'INC_GRP',
			@i_var_nombre		= 'NROCLIND',
			@o_resultado		= @w_resul_ciclo  OUT

			print '159229 Ejecucion SP cob_pac..sp_exec_variable_by_rule, @w_error: ' + + convert(varchar(30), @w_error)
			print '159229 Instancia proceso: ' + convert(varchar(30), @i_id_inst_proc)
			print '159229 Salida @o_resultado: ' + convert(varchar(30), @w_resul_ciclo)
			
	-- Valida si el ciclo es mayor a uno volver a ejecutar
	if @w_resul_ciclo > 1 --CICLO DEL Cliente en toda su vida
	begin
		-- Ejecuta la variable por regla
		EXEC	@w_error			= cob_pac..sp_exec_variable_by_rule
				@s_ssn				= @s_ssn,
				@s_sesn				= @s_sesn,
				@s_user				= @s_user,
				@s_term				= @s_term,
				@s_date				= @s_date,
				@s_srv				= @s_srv,
				@s_lsrv				= @s_lsrv,
				@s_ofi				= @s_ofi,
				@t_file				= NULL,
				@s_rol				= @s_rol,
				@s_org_err			= NULL,
				@s_error			= NULL,
				@s_msg				= NULL,
				@s_org				= '',
				@s_culture			= 'ES_EC',
				@t_rty				= '',
				@t_trn				= @t_trn,
				@t_show_version		= 0,
				@i_id_inst_proc		= @i_id_inst_proc,
				@i_id_inst_act		= 0,
				@i_id_asig_act		= 0,
				@i_id_empresa		= 1,
				@i_acronimo_regla	= 'INC_GRP'
				
				print '159229 Ejecucion SP cob_pac..sp_exec_variable_by_rule, @w_error: ' + + convert(varchar(30), @w_error)
				print '159229 Instancia proceso: ' + convert(varchar(30), @i_id_inst_proc)
		
		-- Seteo de variables para la regla
		SELECT	@w_retorno_val		= '0',
				@w_retorno_id		= 0,
				@w_variables		= '',
				@w_result_values	= ''
				
		-- Ejecutar Regla
		EXEC	@w_error           = cob_pac..sp_rules_run
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
	            @i_id_inst_proceso = @i_id_inst_proc,
	            @i_code_rule       = @w_id_regla,
	            @i_version         = @w_version_regla,
	            @o_return_value    = @w_retorno_val   out,
	            @o_return_code     = @w_retorno_id    out,
	            @o_return_variable = @w_variables     out,
	            @o_return_results  = @w_result_values out,
	            @i_mode            = 'WFL',
	            @i_abreviature      = null,
	            @i_simulator       = 'N',
	            @i_nivel           =  0,
	            @i_modo            = 'S'

	            print '159229 Ejecucion SP cob_pac..sp_rules_run, @w_error: ' + + convert(varchar(30), @w_error)
	            print '159229 Instancia proceso: ' + convert(varchar(30), @i_id_inst_proc)
		        print '159229 Salida @o_return_value: ' + convert(varchar(30), @w_retorno_val)
		        print '159229 Salida @o_return_code: ' + convert(varchar(30), @w_retorno_id)
		        print '159229 Salida @o_return_variable: ' + convert(varchar(30), @w_variables)
		        print '159229 Salida @o_return_results: ' + convert(varchar(30), @w_result_values)
		
		-- Valida si existio error
		if @w_error <> 0
		begin
			-- Setea los clientes con error al ejecutar la regla
			if @w_cli_increm_grupo IS NULL
				select @w_cli_increm_grupo = convert(VARCHAR, @w_miembro)
			else
				select @w_cli_increm_grupo = @w_cli_increm_grupo + ',' + convert(VARCHAR, @w_miembro)
		end
		else
		begin
		    --PorCaso #199804
            select @w_dc_ciclo_cli_grupo = null, @w_grupo = null, @w_monto_ultimo = null, 
                   @w_monto_ultima_op = null, @w_incremento_max = null
		    select @w_grupo = tg_grupo 
		    from cob_credito..cr_tramite_grupal
            where tg_tramite = @w_tramite
		    
	        --CICLO del cliente dentro del grupo
		    select @w_dc_ciclo_cli_grupo = max(dc_ciclo) 
		    from cob_cartera..ca_det_ciclo 
		    where dc_cliente = @w_miembro and dc_grupo = @w_grupo

            select @w_dc_ciclo_cli_grupo = isnull(@w_dc_ciclo_cli_grupo, 0)
		    
		    print '-->>>Ciclo del cliente en el grupo: ' + convert(varchar, @w_dc_ciclo_cli_grupo) + 
		          '-->>>Ciclo del cliente: ' + convert(varchar, @w_resul_ciclo) +
		          '-->>>Grupo: ' + convert(varchar, @w_grupo) +
		          '-->>>Tramite: ' + convert(varchar, @w_tramite) +
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
            end else begin
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
		end
		select @w_monto_ultimo = isnull(@w_monto_ultimo,0)
	end	
	else
	begin
	    --PRINT '--------- 100'
	    select @w_retorno_val = 100
	    select @w_monto_ultimo = 999999999
	end
	
	  print '--->>@w_monto_ultimo: ' + convert(varchar, isnull(@w_monto_ultimo,0)) + 
	        '--->>Incremento: ' + convert(varchar, isnull(@w_retorno_val,0)) + 
	        '--->>Cliente: ' + convert(varchar, @w_miembro) + 
	        '--->>Grupo: ' + convert(varchar, isnull(@w_grupo, 0))+ 
	        '--->>Tramite: ' + convert(varchar, isnull(@w_tramite, 0))
	 
	    update @w_tramite_grupal SET
        tg_incremento    = convert(numeric(8,4), @w_retorno_val),
        tg_monto_ult_op  = convert(money, @w_monto_ultimo)
        where tg_tramite = @w_tramite
        and tg_cliente   = @w_miembro
	 
	    update cr_tramite_grupal SET
        tg_incremento    = convert(numeric(8,4), @w_retorno_val),
        tg_monto_ult_op  = convert(money, @w_monto_ultimo)
        where tg_tramite = @w_tramite
        and tg_cliente   = @w_miembro
		
		
		
        if @w_error <> 0
        begin 
           select @w_msg    = 'Error al actualizar campo INCREMENTO del tramite grupal'
		   goto ERROR
        end
		else
		begin
		
	        if exists(	select 1 
						from @w_tramite_grupal 
						where tg_tramite = @w_tramite 
						and tg_cliente = @w_miembro
						and tg_monto != 0)
	        begin	
	        
	        select 
            @w_cliente_valida = tg_cliente,
            @w_monto_sol      = tg_monto,
            @w_cuenta_ref     = isnull(tg_monto_cuenta_ref,0),
            @w_incremento     = tg_monto_ult_op + tg_monto_ult_op * tg_incremento/100.0
            from @w_tramite_grupal 
            where tg_tramite = @w_tramite 
            and tg_monto > 0
            and tg_cliente = @w_miembro
            
            if @w_cuenta_ref >= @w_incremento
            select @w_valor_valida = @w_cuenta_ref
            else
            select @w_valor_valida = @w_incremento
	        
	        	PRINT 'Monto diferente de cero en IG:'
	        if exists(select 1 from @w_tramite_grupal where tg_tramite = @w_tramite  and
              tg_monto > @w_valor_valida
              and tg_cliente =@w_miembro)
	    						
	    		begin
	    		   	PRINT 'Ingresa en if cuando no pasa la regla de Ig'
	    			if @w_cli_increm_grupo IS NULL
	    			begin
	    			PRINT '@w_cli_increm_grupo is null en Ig'
	    			PRINT '@w_cli_monto_grupo is null en IG clientes--->'+ convert(varchar(50),@w_miembro)
	    				select @w_cli_increm_grupo = convert(VARCHAR, @w_miembro)
	    			end
	    			else
	    			begin
	    			PRINT '@w_cli_increm_grupo no es en Ig'
	    			PRINT '@w_cli_monto_grupo is  not null en IG clientes--->'+ convert(varchar(50),@w_miembro)
	    				select @w_cli_increm_grupo = @w_cli_increm_grupo + ',' + convert(VARCHAR, @w_miembro)
	    			end
	    		end	
		    end		
		
	    end	
		
	-- Finaliza Validar Regla Incremento Grupal

end	-- Fin WHILE
 PRINT 'Inicia Observaciones' 
 
 PRINT 'Observaciones @w_cli_monto_grupo' + convert(VARCHAR(255),@w_cli_monto_grupo)
 PRINT 'Observaciones @w_cli_increm_grupo' + convert(VARCHAR(255),@w_cli_increm_grupo)
-- Valida si existen clientes que no cumplen la regla
if @w_cli_monto_grupo IS NOT NULL
begin
	-- Ejecuta proceso para setear la obervacion
	EXEC		@w_error = cob_credito..sp_ins_observacion_reverif
				@s_ssn				= @s_ssn,
				@s_sesn				= @s_sesn,
				@s_user				= @s_user,
				@s_term				= @s_term,
				@s_date				= @s_date,
				@s_srv				= @s_srv,
				@s_lsrv				= @s_lsrv,
				@s_ofi				= @s_ofi,
				@t_file				= NULL,
				@s_rol				= @s_rol,
				@s_org_err			= NULL,
				@s_error			= NULL,
				@s_msg				= NULL,
				@s_org				= '',
				@t_rty				= '',
				@t_trn				= @t_trn,
				@i_id_inst_proc	= @i_id_inst_proc,
				@i_id_inst_act 	= NULL,	
				@i_id_empresa	= NULL,	
				@i_clientes		= @w_cli_monto_grupo,
				@i_tipo_regla	= 'M',
				@i_numero_linea	= 1

				print '159229 Ejecucion SP cob_credito..sp_ins_observacion_reverif, @w_error: ' + + convert(varchar(30), @w_error)

	-- Seteo variables de salida
	select	@o_id_resultado = 2, -- Seteo para salida de la tarea con DEVOLVER	
			@w_numero_linea = 2
end
else
begin
	-- Seteo variables de salida
	select	@o_id_resultado = 1, -- Seteo para salida de la tarea con OK
			@w_numero_linea = 1
end

-- Valida si existen clientes que no cumplen la regla
if @w_cli_increm_grupo IS NOT NULL
begin
	-- Ejecuta proceso para setear la obervacion
	EXEC		@w_error = cob_credito..sp_ins_observacion_reverif
				@s_ssn				= @s_ssn,
				@s_sesn				= @s_sesn,
				@s_user				= @s_user,
				@s_term				= @s_term,
				@s_date				= @s_date,
				@s_srv				= @s_srv,
				@s_lsrv				= @s_lsrv,
				@s_ofi				= @s_ofi,
				@t_file				= NULL,
				@s_rol				= @s_rol,
				@s_org_err			= NULL,
				@s_error			= NULL,
				@s_msg				= NULL,
				@s_org				= '',
				@t_rty				= '',
				@t_trn				= @t_trn,
				@i_id_inst_proc		= @i_id_inst_proc,
				@i_id_inst_act 		= NULL,
				@i_id_empresa		= NULL,
				@i_clientes			= @w_cli_increm_grupo,
				@i_tipo_regla		= 'I',
				@i_numero_linea		= @w_numero_linea
				
	            print '159229 Ejecucion SP cob_credito..sp_ins_observacion_reverif, @w_error: ' + + convert(varchar(30), @w_error)
end

-- VALIDA SI pasa OK O DEVOLVER
if @w_cli_increm_grupo IS NOT NULL OR @w_cli_monto_grupo IS NOT NULL
begin
	-- Seteo variables de salida
	select @o_id_resultado = 2 -- Seteo para salida de la tarea con DEVOLVER	
end
else
begin
	-- Seteo variables de salida
	select @o_id_resultado = 1 -- Seteo para salida de la tarea con OK
end

return 0

ERROR:

exec @w_error = cobis..sp_cerror
@t_debug      = 'N',
@t_file       = '',
@t_from       = @w_sp_name,
@i_num        = @w_error,
@i_msg        = @w_msg

return @w_error

go

