/*************************************************************************/
/*   Archivo:            sp_eje_regla_valid_cli.sp                       */
/*   Stored procedure:   sp_eje_regla_valid_cli                          */
/*   Base de datos:      cobis                                           */
/*   Producto:           Clientes                                        */
/*   Disenado por:       ACH                                             */
/*   Fecha de escritura: 24/02/2022                                      */
/*************************************************************************/
/*                           IMPORTANTE                                  */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'MACOSA', representantes exclusivos para el Ecuador de NCR          */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBISCORP o su representante.              */
/*************************************************************************/
/*                                  PROPOSITO                            */
/*   Este programa ejecuta la regla monto del credito en base a la       */
/*   calificacion (onboarding)                                           */
/*************************************************************************/
/*                                MODIFICACIONES                         */
/*   FECHA       AUTOR                       RAZON                       */
/* 24/02/2022     ACH     Version Inicial - Caso168293 Auto onboarding   */
/* 04/07/2022     ACH     188497, valida la calificacion para continuar  */
/*************************************************************************/
use cobis
go

if object_id ('sp_eje_regla_valid_cli') is not null
   drop procedure sp_eje_regla_valid_cli
go

create proc sp_eje_regla_valid_cli (
       @s_ssn             int         = null,
       @s_user            login       = null,
       @s_term            varchar(32) = null,
       @s_date            datetime    = null,
       @s_sesn            int         = null,
       @s_culture         varchar(10) = null,
       @s_srv             varchar(30) = null,
       @s_lsrv            varchar(30) = null,
       @s_ofi             smallint    = null,
       @s_rol             smallint    = null,
       @s_org_err         char(1)     = null,
       @s_error           int         = null,
       @s_sev             tinyint     = null,
       @s_msg             descripcion = null,
       @s_org             char(1)     = null,
       @t_debug           char(1)     = 'N',
       @t_file            varchar(10) = null,
       @t_from            varchar(32) = null,
       @t_show_version    bit         = 0,
       @i_ente            int         = null,
       @i_debug           char(1)     = 'N',
	   @i_regla           varchar(10) = null,
	   @i_opcion          varchar(2) = null,
       @o_monto           money       = null out, -- salida regla Monto Cliente Digitales - Auto onboarding MONINDCLID
       @o_calif_riesgo    varchar(10) = null out, -- 
	   @o_puntaje         int         = null out, -- 
	   @o_continua        char(1)     = null out,
	   @o_riesgo_ind      varchar(10) = null out,
	   @o_calif_matriz    varchar(10) = null out
)
as

declare   
@w_sp_name            varchar(32),
@w_ts_name            varchar(32),
@w_num_error          int,
@w_calificacion_cli   varchar(2), -- RIESGO INDIVIDUAL EXTERNO
@w_resultado          varchar(255),
@w_condiciones        varchar(255),
@w_error              int,
@w_msg                varchar(255),
@w_parent             int,
@w_variables          varchar(255),
@w_result_values      varchar(255),
@w_monto              money,
@w_calif_riesgo       varchar(10),
@w_puntaje            int,
@w_resultado1         varchar(255),
@w_resultado2         varchar(255),
@w_in_ln_ng           char(2),
@w_riesgo_ind         varchar(10),
@w_continua           char(1),
@w_riesgo_matriz      varchar(256),
@w_calif_matriz       varchar(256),
@w_max_mop            int ,
@w_pag_ctas_abi       money,
@w_porc_ctas_tot      float

--referencia: sp_riesgo_ind_externo   
select @w_sp_name = 'sp_eje_regla_valid_cli'
select @w_continua = 'N'

if (@i_regla = 'BUROCALDIG') begin  ----  Regla Buro.Calif

    exec @w_error = cobis..sp_buro_pago_mensual
         @i_ente = @i_ente,
         @o_max_mop = @w_max_mop out,
         @o_pag_ctas_abi = @w_pag_ctas_abi out,
         @o_porc_ctas_tot = @w_porc_ctas_tot out
    
    if @w_error <> 0 begin
       select
       @w_error        = @w_error,
       @w_sp_name      = 'cobis..sp_buro_pago_mensual',
       @w_msg          = 'Error al ejecutar sp_buro_pago_mensual '
       goto ERROR_PROCESO
    end    
    
	--select @w_condiciones = '3|10897|0.8|'
	select @w_condiciones = convert(varchar(256), @w_max_mop) + '|' + convert(varchar(256), @w_pag_ctas_abi) + '|' + convert(varchar(256), @w_porc_ctas_tot) + '|'
	
	exec @w_error                   = cob_pac..sp_rules_param_run
         @s_rol                     = @s_rol,
         @i_rule_mnemonic           = @i_regla,
         @i_var_values              = @w_condiciones, --@i_valor_variable_regla,
         @i_var_separator           = '|',
         @i_modo                    = 'S',
         @i_tipo                    = 'S',
         @o_return_variable         = @w_variables     out,
         @o_return_results          = @w_result_values out,
         @o_last_condition_parent   = @w_parent        out	 
		 
    if @w_error <> 0 begin
       select
       @w_error        = @w_error,
       @w_sp_name      = 'cob_pac..sp_rules_param_run',
       @w_msg          = 'Error al ejecutar sp_rules_param_run '
       goto ERROR_PROCESO
    end

    if @w_result_values is not null and datalength(@w_result_values) > 0 begin
       select @w_resultado1  = convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values)-1))  
        
    end 
	
	select @w_calif_riesgo = isnull(@w_resultado1,'')

    if((@w_calif_riesgo != 'F') and (upper(@w_calif_riesgo) != '')) -- por caso 188497
        select @w_continua = 'S'
	else
	    select @w_continua = 'N'	
    
    update cobis..cl_ente_aux 
	set ea_nivel_riesgo_cg  = isnull(@w_calif_riesgo, ea_nivel_riesgo_cg),
		ea_puntaje_riesgo_cg = @w_puntaje
    where ea_ente = @i_ente

    print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Regla: ' + isnull(@i_regla, '') + 
          '-->>Condiciones: ' + isnull(@w_condiciones,'') + '-->>Resultado: ' + convert(varchar(30), isnull(@w_result_values, '')) +  
          '-->>Continua: ' + @w_continua

    goto fin
end

--select @w_calificacion_cli = 'A'
if (@i_regla = 'MONINDCLID') begin

    select @w_calificacion_cli = ea_nivel_riesgo_cg
	from cobis..cl_ente_aux
	where ea_ente = @i_ente
	
    select @w_condiciones = ltrim(@w_calificacion_cli)

    exec @w_error                   = cob_pac..sp_rules_param_run
         @s_rol                     = @s_rol,
         @i_rule_mnemonic           = @i_regla,
         @i_var_values              = @w_condiciones, --@i_valor_variable_regla,
         @i_var_separator           = '|',
         @i_modo                    = 'S',
         @i_tipo                    = 'S',
         @o_return_variable         = @w_variables     out,
         @o_return_results          = @w_result_values out,
         @o_last_condition_parent   = @w_parent        out	 
		 
    if @w_error <> 0 begin
       select
       @w_error        = @w_error,
       @w_sp_name      = 'cob_pac..sp_rules_param_run',
       @w_msg          = 'Error al ejecutar sp_rules_param_run '
       goto ERROR_PROCESO
    end

    if @w_result_values is not null and datalength(@w_result_values) > 0
        select @w_resultado1  = convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values)-1))		
	
	select @w_monto = @w_resultado1,
	       @w_continua = 'S'

    print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Regla: ' + @i_regla + '-->>Condiciones: ' + isnull(@w_condiciones,'') + 
	             '-->>Resultado: ' + convert(varchar(30), isnull(@w_result_values,'')) +  '-->>Continua: ' + @w_continua	
	
    goto fin
end

if (@i_regla = 'RIESGO_IND') begin
    -- listasNegras
    select @w_in_ln_ng = case when ea_lista_negra = 'N' and ea_negative_file = 'N' then 'NO' else 'SI' end        
	from cobis..cl_ente_aux
	where ea_ente = @i_ente
 	
    select @w_calificacion_cli = ltrim(ea_nivel_riesgo_cg)
	from cobis..cl_ente_aux
	where ea_ente = @i_ente
	
	select @w_condiciones = @w_in_ln_ng + '|' + @w_calificacion_cli
	
	exec @w_error                   = cob_pac..sp_rules_param_run
         @s_rol                     = @s_rol,
         @i_rule_mnemonic           = @i_regla,
         @i_var_values              = @w_condiciones, --@i_valor_variable_regla,
         @i_var_separator           = '|',
         @i_modo                    = 'S',
         @i_tipo                    = 'S',
         @o_return_variable         = @w_variables     out,
         @o_return_results          = @w_result_values out,
         @o_last_condition_parent   = @w_parent        out	 
		 
    if @w_error <> 0 begin
       select
       @w_error        = @w_error,
       @w_sp_name      = 'cob_pac..sp_rules_param_run',
       @w_msg          = 'Error al ejecutar sp_rules_param_run '
       goto ERROR_PROCESO
    end
	
    if @w_result_values is not null and datalength(@w_result_values) > 0 begin
       select @w_resultado1  = convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values)-1))	   
    end		

	if (@w_resultado1 = 'ROJO')
	    select @w_continua = 'N'
	else
	    select @w_continua = 'S'

	select @w_riesgo_ind = @w_resultado1
	
	update cobis..cl_ente
	set p_calif_cliente = isnull(@w_riesgo_ind, p_calif_cliente)
	where en_ente = @i_ente

    print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Regla: ' + @i_regla + '-->>Condiciones: ' + isnull(@w_condiciones,'') + 
	             '-->>Resultado: ' + convert(varchar(30), isnull(@w_result_values,'')) +  '-->>Continua: ' + @w_continua	
				 
    goto fin
end

---va el llamado de matriz de riesgo
if (@i_opcion = 'GM') begin

    exec @w_error       = cob_credito..sp_regla_matriz_riesgo
    @i_operacion        = 'I',
    @i_ente             = @i_ente
    
    if @w_error <> 0 begin
	    select @w_continua = 'N'
        select
        @w_error        = @w_error,
        @w_sp_name      = 'cob_pac..sp_rules_param_run',
        @w_msg          = 'Error al ejecutar sp_rules_param_run '
        goto ERROR_PROCESO
    end
	  
    select @w_riesgo_matriz = C.valor 
    from cobis..cl_tabla T, cobis..cl_catalogo C
    where T.tabla = 'ca_lcr_riesgo_pld' and T.codigo = C.tabla and C.codigo = 4
	
	if exists(select 1 from cobis..cl_ente_aux where ea_ente = @i_ente and ea_nivel_riesgo = @w_riesgo_matriz)
	    select @w_continua = 'N'
	else
        select @w_continua = 'S'	

    select @w_calif_matriz = ea_nivel_riesgo from cobis..cl_ente_aux where ea_ente = @i_ente
    print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>opcion' + @i_opcion + '-->>Continua: ' + @w_continua
	
    goto fin		
end

fin:
	select @o_monto = @w_monto,
		   @o_puntaje = @w_puntaje,
	       @o_calif_riesgo = @w_calif_riesgo,
		   @o_continua = @w_continua,
		   @o_riesgo_ind = @w_riesgo_ind,
		   @o_calif_matriz = @w_calif_matriz
	
SALIDA_PROCESO:
    return 0

ERROR_PROCESO:
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = @w_error
    
    return @w_error

go
