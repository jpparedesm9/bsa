/*************************************************************************/
/*   Archivo:            sp_eje_regla_calif_cli.sp                       */
/*   Stored procedure:   sp_eje_regla_calif_cli                          */
/*   Base de datos:      cob_credito                                     */
/*   Producto:           Credito                                         */
/*   Disenado por:       KVI                                             */
/*   Fecha de escritura: Marzo 2023                                      */
/*************************************************************************/
/*                       IMPORTANTE                                      */
/*   Este programa es parte de los paquetes bancarios propiedad de       */
/*   'COBIS'.                                                            */
/*   Su uso no autorizado queda expresamente prohibido asi como          */
/*   cualquier alteracion o agregado hecho por alguno de sus             */
/*   usuarios sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de COBIS o su representante legal.            */
/*************************************************************************/
/*                       PROPOSITO                                       */
/*   Este programa ejecuta las reglas de calificacion del cliente        */
/*************************************************************************/
/*                       MODIFICACIONES                                  */
/*   FECHA       AUTOR                       RAZON                       */
/*   20/03/2023  KVI     Emision Inicial - Caso203112                    */
/*************************************************************************/
use cob_credito
go

if object_id ('sp_eje_regla_calif_cli') is not null
   drop procedure sp_eje_regla_calif_cli
go

create proc sp_eje_regla_calif_cli (
       @s_ssn                int         = null,
       @s_user               login       = null,
       @s_term               varchar(32) = null,
       @s_date               datetime    = null,
       @s_sesn               int         = null,
       @s_culture            varchar(10) = null,
       @s_srv                varchar(30) = null,
       @s_lsrv               varchar(30) = null,
       @s_ofi                smallint    = null,
       @s_rol                smallint    = null,
       @s_org_err            char(1)     = null,
       @s_error              int         = null,
       @s_sev                tinyint     = null,
       @s_msg                descripcion = null,
       @s_org                char(1)     = null,
       @t_debug              char(1)     = 'N',
       @t_file               varchar(10) = null,
       @t_from               varchar(32) = null,
       @t_show_version       bit         = 0,
	   @i_debug              char(1)     = 'N',
       @i_ente               int         = null,       
	   @i_regla              varchar(10) = null,
	   @i_canal              int         = null,
	   @i_tipo_calif_eva_cli varchar(10) = null,
	   @i_dias_vig_buro      int         = null, -- mismo valor de @o_vigencia
	   @i_evaluar_reglas     char(1)     = null, -- S evalua nuevamente las reglas si no regresa los valores en base
	   @o_nivel_riesgo_1     char(1)     = null out,
       @o_nivel_riesgo_2     char(2)     = null out,
       @o_color              varchar(10) = null out, 
       @o_letra              varchar(10) = null out,
       @o_vigencia           int         = null out,
       @o_tipo_calif         varchar(10) = null out	   
)
as

declare   
@w_sp_name            varchar(32),
@w_ts_name            varchar(32),
@w_error              int,
@w_msg                varchar(255),
@w_num_error          int,
@w_nivel_riesgo_1     char(1),
@w_nivel_riesgo_2     char(2),
@w_condiciones        varchar(255),
@w_resultado1         varchar(255),
@w_resultado2         varchar(255),
@w_color              varchar(10),
@w_letra              varchar(10),
@w_parent             int,
@w_variables          varchar(255),
@w_result_values      varchar(255),
@w_oficina            smallint,
@w_vigencia           int,
@w_tipo_calif         varchar(10),
@w_fecha_proceso      datetime


select @w_sp_name = 'sp_eje_regla_calif_cli'

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

if (@i_regla = 'CALFIN')  ----  Regla de calificacion final del cliente
begin 
    
	if (@i_evaluar_reglas = 'N') begin	    
        select @w_letra = ea_nivel_riesgo_cg
		from cobis..cl_ente_aux
        where ea_ente = @i_ente 
	    
	    select @w_color = p_calif_cliente
		from cobis..cl_ente
	    where en_ente = @i_ente
	    and en_subtipo = 'P'

        update cr_vigencia_tipo_calif
	    set vg_evaluo_buro = @i_evaluar_reglas, 
		    vg_result_eval = @w_color + '|' + @w_letra + '|'
	    where vg_ente = @i_ente
	
        print 'No evaluo Reglas -->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Color' + @w_color + '-->>RiesgoIndExt:' + @w_letra		  
		goto fin	
	end
	
    exec @w_error              = cob_credito..sp_var_nivel_riesgo_1
         @i_ente               = @i_ente,
		 @i_tipo_calif_eva_cli = @i_tipo_calif_eva_cli,
		 @i_dias_vig_buro      = @i_dias_vig_buro,
		 @i_evaluar_reglas     = @i_evaluar_reglas,
         @o_resultado          = @w_nivel_riesgo_1 output 
    
    if @w_error <> 0 begin
       select
       @w_error        = @w_error,
       @w_sp_name      = 'cob_credito..sp_var_nivel_riesgo_1',
       @w_msg          = 'Error al ejecutar sp_var_nivel_riesgo_1 '
       goto ERROR_PROCESO
    end   

    exec @w_error          = cob_credito..sp_var_nivel_riesgo_2
         @i_ente           = @i_ente,
         @o_calif_riesgo_2 = @w_nivel_riesgo_2 output 
    
    if @w_error <> 0 begin
       select
       @w_error        = @w_error,
       @w_sp_name      = 'cob_credito..sp_var_nivel_riesgo_2',
       @w_msg          = 'Error al ejecutar sp_var_nivel_riesgo_2 '
       goto ERROR_PROCESO
    end 	
    
	--select @w_condiciones = 'A|MB'
	select @w_condiciones = @w_nivel_riesgo_1 + '|' + @w_nivel_riesgo_2 
	
	exec @w_error                   = cob_pac..sp_rules_param_run
         @s_rol                     = @s_rol,
         @i_rule_mnemonic           = @i_regla,
         @i_var_values              = @w_condiciones, 
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
	begin
        select @w_resultado1  = convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values)-1))  
		
	    if datalength(@w_result_values) > (charindex('|', @w_result_values) +1 ) 
		begin
            select @w_resultado2  = convert(varchar,substring(@w_result_values, charindex('|', @w_result_values)+1, datalength(@w_result_values)-1))
            select @w_resultado2  = convert(varchar,substring(@w_resultado2,1 ,charindex('|', @w_resultado2)-1))
	    end
    end
        
	
	select @w_color = isnull(@w_resultado1,'')
	select @w_letra = isnull(@w_resultado2,'')

    update cobis..cl_ente_aux 
    set ea_nivel_riesgo_cg  = @w_letra
    where ea_ente = @i_ente 
	
	update cobis..cl_ente 
	set p_calif_cliente = @w_color             
	where en_ente = @i_ente
	and en_subtipo = 'P'

    print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Regla: ' + isnull(@i_regla, '') + 
          '-->>Condiciones: ' + isnull(@w_condiciones,'') + '-->>Resultado: ' + convert(varchar(30), isnull(@w_result_values, ''))

    update cr_vigencia_tipo_calif
	set vg_evaluo_buro = @i_evaluar_reglas, vg_result_eval = @w_result_values
	where vg_ente = @i_ente	

    goto fin
end


if (@i_regla = 'TIPCALCLI')  ----  Regla Tipo Calificacion Cliente
begin 

    select @w_oficina = en_oficina 
	from cobis..cl_ente
	where en_ente = @i_ente
        
	--select @w_condiciones = '1053|4'
	select @w_condiciones = convert(varchar(256), @w_oficina) + '|' + convert(varchar(256), @i_canal)
	
	exec @w_error                   = cob_pac..sp_rules_param_run
         @s_rol                     = @s_rol,
         @i_rule_mnemonic           = @i_regla,
         @i_var_values              = @w_condiciones, 
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
	begin
        select @w_resultado1  = convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values)-1))  
		
	    if datalength(@w_result_values) > (charindex('|', @w_result_values) +1 ) 
		begin
            select @w_resultado2  = convert(varchar,substring(@w_result_values, charindex('|', @w_result_values)+1, datalength(@w_result_values)-1))
            select @w_resultado2  = convert(varchar,substring(@w_resultado2,1 ,charindex('|', @w_resultado2)-1))
	    end
    end
        
	
	select @w_vigencia = isnull(@w_resultado1,'')
	select @w_tipo_calif = isnull(@w_resultado2,'')
	
	if not exists (select 1 from cr_vigencia_tipo_calif where vg_ente = @i_ente)
	begin 
	    insert into cr_vigencia_tipo_calif 
	           (vg_ente, vg_oficina, vg_canal, vg_vigencia, vg_tipo_calif, vg_usuario, vg_fecha_reg, vg_fecha_proc)
	    values (@i_ente, @w_oficina, @i_canal, @w_vigencia, @w_tipo_calif, @s_user,    getdate(),    isnull(@s_date,@w_fecha_proceso))
    end
	else 
	begin 
	    insert into cob_credito_his..cr_vigencia_tipo_calif_his (vgh_ente, vgh_oficina, vgh_canal, vgh_vigencia, vgh_tipo_calif, vgh_usuario, vgh_fecha_reg, vgh_fecha_proc, vgh_fecha_paso_his, vgh_evaluo_buro, vgh_result_eval)
	    select vg_ente, vg_oficina, vg_canal, vg_vigencia, vg_tipo_calif, vg_usuario, vg_fecha_reg, vg_fecha_proc, getdate(), vg_evaluo_buro, vg_result_eval
        from cr_vigencia_tipo_calif 
		where vg_ente = @i_ente 

        delete from cr_vigencia_tipo_calif 
		where vg_ente = @i_ente 
        
        insert into cr_vigencia_tipo_calif
	           (vg_ente, vg_oficina, vg_canal, vg_vigencia, vg_tipo_calif, vg_usuario, vg_fecha_reg, vg_fecha_proc)
	    values (@i_ente, @w_oficina, @i_canal, @w_vigencia, @w_tipo_calif, @s_user,    getdate(),    isnull(@s_date,@w_fecha_proceso))		
	end 

    print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Regla: ' + isnull(@i_regla, '') + 
          '-->>Condiciones: ' + isnull(@w_condiciones,'') + '-->>Resultado: ' + convert(varchar(30), isnull(@w_result_values, '')) 

    goto fin
end


fin:
	select @o_nivel_riesgo_1 = @w_nivel_riesgo_1,
           @o_nivel_riesgo_2 = @w_nivel_riesgo_2, 	
	       @o_color          = @w_color,
		   @o_letra          = @w_letra,
		   @o_vigencia       = @w_vigencia, 
	       @o_tipo_calif     = @w_tipo_calif
		   
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
