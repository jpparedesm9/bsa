/************************************************************************/
/*   Archivo:              sp_var_nivel_riesgo_2.sp                     */
/*   Stored procedure:     sp_var_nivel_riesgo_2.sp                     */
/*   Base de datos:        cob_credito                                  */
/*   Producto:             Credito                                      */
/*   Disenado por:         KVI                                          */
/*   Fecha de escritura:   Marzo 2023                                   */
/************************************************************************/
/*                         IMPORTANTE                                   */
/*   Este programa es parte de los paquetes bancarios propiedad de      */
/*   'COBIS'.                                                           */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier alteracion o agregado hecho por alguno de sus            */
/*   usuarios sin el debido consentimiento por escrito de la            */
/*   Presidencia Ejecutiva de COBIS o su representante legal.           */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Consulta el Nivel de Riesgo 2 - Calificacion(MAB,B,M,A,MA,CE,SE)   */
/************************************************************************/
/*                         MODIFICACIONES                               */
/*   FECHA         AUTOR                   RAZON                        */
/*   17/03/2023    KVI         Emision Inicial                          */
/************************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_nivel_riesgo_2')
   drop proc sp_var_nivel_riesgo_2
go

create proc sp_var_nivel_riesgo_2
(
    @s_ssn             int         = null,
    @s_user            login       = null,
    @s_sesn            int         = null,
    @s_term            varchar(30) = null,
    @s_date            datetime    = null,
    @s_srv             varchar(30) = null,
    @s_lsrv            varchar(30) = null,
    @s_ofi             smallint    = null,
    @s_servicio        int         = null,
    @s_cliente         int         = null,
    @s_rol             smallint    = null,
    @s_culture         varchar(10) = null,
    @s_org             char(1)     = null,
	@t_debug           char(1)     = 'N',
	@t_file            varchar(10) = null,
    @i_ente            int,
    @o_calif_riesgo_2  char(2)     = null out
)
as
declare
    @w_sp_name          varchar(100),
	@w_return        	int,
    @w_error            int,
    @w_msg              varchar(255),
	@w_condiciones      varchar(255),
	@w_resultado1       varchar(255),
	@w_variables        varchar(255),
	@w_result_values    varchar(255),
	@w_parent           int,
	@w_regla            varchar(10),
	@w_resultado        int
	

select @w_sp_name    = 'sp_var_nivel_riesgo_2'

if @i_ente is null return 0

print 'Ingreso Nivel Riesgo 2'

select @w_regla = 'NRIESGO2' -- Regla Nivel de Riesgo 2

exec @w_error                   = cob_credito..sp_var_val_score_buro
     @i_ente                    = @i_ente,
     @o_resultado               = @w_resultado out

if @w_error <> 0 begin
    select
    @w_error        = @w_error,
    @w_sp_name      = 'cob_credito..sp_var_val_score_buro',
    @w_msg          = 'Error al ejecutar sp_var_val_score_buro'
    goto ERROR_PROCESO
end
   
select @w_condiciones = convert(varchar,@w_resultado)
	
exec @w_error                   = cob_pac..sp_rules_param_run
     @s_rol                     = @s_rol,
     @i_rule_mnemonic           = @w_regla, 
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

if @w_result_values is not null and datalength(@w_result_values) > 0 begin
    select @w_resultado1  = convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values)-1))	   
end		

select @o_calif_riesgo_2  = @w_resultado1

update cobis..cl_ente_aux 
set ea_nivel_riesgo_2 = @o_calif_riesgo_2
where ea_ente = @i_ente

print 'Resultado-->>Cliente: ' + convert(varchar(30), @i_ente) + '-->>Regla: ' + @w_regla + '-->>Condiciones: ' + isnull(@w_condiciones,'') + 
      '-->>Resultado: ' + convert(varchar(30), isnull(@w_result_values,'')) 	
	

print 'calificacion riesgo 2: ' + @o_calif_riesgo_2

return 0

ERROR_PROCESO:
    exec cobis..sp_cerror
    @t_debug = @t_debug,
    @t_file  = @t_file, 
    @t_from  = @w_sp_name,
    @i_num   = @w_error
    
    return @w_error

go
