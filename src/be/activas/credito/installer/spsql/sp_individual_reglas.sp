USE cob_credito
GO
/************************************************************/
/*   ARCHIVO:         sp_individual_reglas.sp               */
/*   NOMBRE LOGICO:   sp_individual_reglas                  */
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
/*  Evaluacion de reglas para encontrar monto maximo        */
/*  por cliente. FLUJOO INDIVIDUAL                          */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 02/MAR/2017     LGU                 Emision Inicial      */
/************************************************************/
    
IF OBJECT_ID ('dbo.sp_individual_reglas') IS NOT NULL
    DROP PROCEDURE dbo.sp_individual_reglas
GO

CREATE PROC dbo.sp_individual_reglas
    @s_ssn              int 	    = NULL,	
    @s_rol              smallint    = null,
    @s_ofi              smallint    = null,		
    @t_trn              int         = null,	
    @s_sesn             int 	    = NULL,
    @s_user             login 	    = NULL,
    @s_term             varchar(30) = NULL,
    @s_date             DATETIME    = NULL,
    @s_srv              varchar(30) = NULL,
    @s_lsrv             varchar(30) = NULL,	
    @i_tramite          INT,
    @i_id_rule          VARCHAR(30),
    @o_msg1             varchar(100) = null output
AS

declare @w_rule             int,
        @w_rule_version     int,
        @w_retorno_val      varchar(255),
        @w_retorno_id       int,
        @w_variables        varchar(255),
        @w_result_values    varchar(255),
        @w_error            int,
        @w_valor_ant        varchar(255),
        @w_resul_ciclo      VARCHAR(30),
        @w_id_inst_proc     INT,
        @w_cliente          int,
        @w_monto_ultimo     MONEY

IF @i_id_rule = 'VAL_TRAMITE'
BEGIN
    -- validar monto maximo
    IF EXISTS(SELECT 1 FROM cr_tramite WHERE tr_tramite = @i_tramite AND tr_monto > tr_monto_max)
    begin
        --print'[DEBUG:] Existen Prestamos que superan el monto maximo'
--        raiserror ('Existen Prestamos que superan el monto maximo', 0, 0)
        select @o_msg1 = 'Monto del préstamo es superior al monto Máximo'
        SELECT @w_error = 208930
        exec @w_error = cobis..sp_cerror
                @t_debug  = 'N',
                @t_file   = '',
                @t_from   = 'sp_grupal_reglas',
                @i_num    = @w_error,
                @i_msg    = 'Monto del préstamo es superior al monto Máximo'
    end
    -- validar monto minimo
    IF EXISTS(SELECT 1 FROM cr_tramite WHERE tr_tramite = @i_tramite AND tr_monto < tr_monto_min)
    begin
        --print'[DEBUG:] Monto del prestamo es inferior al monto minimo'
--        raiserror ('Existen Prestamos que superan el monto maximo', 0, 0)
        select @o_msg1 = 'Monto del préstamo es inferior al monto Mínimo'
         SELECT @w_error = 208931
        exec @w_error = cobis..sp_cerror
                @t_debug  = 'N',
                @t_file   = '',
                @t_from   = 'sp_grupal_reglas',
                @i_num    = @w_error,
                @i_msg    = 'Monto del préstamo es inferior al monto Mínimo'
    end
    RETURN 0
END


select @w_id_inst_proc = io_id_inst_proc
from   cob_workflow..wf_inst_proceso
where  io_campo_3 = @i_tramite

select @w_id_inst_proc = isnull(@w_id_inst_proc,-1)

select
    @w_rule           = bpl_rule.rl_id,
    @w_rule_version   = rv_id
from cob_pac..bpl_rule
inner join cob_pac..bpl_rule_version  on bpl_rule.rl_id = bpl_rule_version.rl_id
where rv_status   = 'PRO'
and rl_acronym    = @i_id_rule
and getdate()     >= rv_date_start
and getdate()     <= rv_date_finish


select @w_cliente = tr_cliente
from cob_credito..cr_tramite , cob_cartera..ca_operacion
where tr_tramite = @i_tramite
and op_tramite = tr_tramite

if @i_id_rule = 'VAL_MONTON_MAXIND'
begin
 -- retorno el valor del Monto maximo para individuales
    select 'tramite'   = @i_tramite,
           'cliente'   = @w_cliente,
           'monto_maximo' =tr_monto_max 
    from cob_credito..cr_tramite
    where tr_tramite=@i_tramite 
    return 0
end

BEGIN


    --  @i_id_rule = 'MONTO_IND'
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
            @s_ofi             = @s_ofi,
            @s_rol             = @s_rol,
            @t_trn             = @t_trn,
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


    -- @i_id_rule   = 'MONTO_IND'
    BEGIN
        SELECT 'tramite' = @i_tramite, 'cliente' = @w_cliente, 'monto_maximo' = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|','')
        UPDATE cob_credito..cr_tramite SET
            tr_monto_max      = replace(convert(varchar, substring(@w_result_values, charindex('|', @w_result_values) + 1, 300)),'|',''),
			tr_monto_min      = replace(convert(varchar, substring(@w_result_values, 1, charindex('|', @w_result_values) -1)),'|','')
        WHERE tr_tramite = @i_tramite
        select @w_error = @@error
        if @w_error<>0
        begin
            exec @w_error = cobis..sp_cerror
                @t_debug  = 'N',
                @t_file   = '',
                @t_from   = 'sp_individual_reglas',
                @i_num    = @w_error,
                @i_msg    = 'Error al actualizar campo MONTO MAXIMO O MINIMO DEL TRAMITE INDIVIDUAL'
        END
    END

end -- WHILE

RETURN 0

GO
