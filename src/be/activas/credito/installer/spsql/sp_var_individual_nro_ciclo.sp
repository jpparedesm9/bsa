USE cob_credito
GO
/************************************************************/
/*   ARCHIVO:         sp_var_individual_nro_ciclo.sp        */
/*   NOMBRE LOGICO:   sp_var_individual_nro_ciclo           */
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
/*  Obtiene el porcentaje atrasado del ciclo indv anterior  */
/************************************************************/
/*                     MODIFICACIONES                       */
/*   FECHA         AUTOR               RAZON                */
/* 19/JUL/2017     ACH                 Emision Inicial      */
/************************************************************/

IF OBJECT_ID ('dbo.sp_var_individual_nro_ciclo') IS NOT NULL
    DROP PROCEDURE dbo.sp_var_individual_nro_ciclo
GO

CREATE PROC dbo.sp_var_individual_nro_ciclo(
    @s_ssn          int         = null,
    @s_ofi          smallint,
    @s_user         login,
    @s_date         datetime,
    @s_srv          varchar(30) = null,
    @s_term         descripcion = null,
    @s_rol          smallint    = null,
    @s_lsrv         varchar(30) = null,
    @s_sesn         int         = null,
    @s_org          char(1)     = NULL,
    @s_org_err      int         = null,
    @s_error        int         = null,
    @s_sev          tinyint     = null,    
    @s_msg          descripcion = null,
	@s_culture      varchar(10) = 'NEUTRAL',
    @t_rty          char(1)     = null,
    @t_trn          int         = null,
    @t_debug        char(1)     = 'N',
    @t_file         varchar(14) = null,
    @t_from         varchar(30) = null,
	@t_show_version BIT         = 0,
    --variables
    @i_id_inst_proc int,    --codigo de instancia del proceso
    @i_id_inst_act  int,    
    @i_id_asig_act  int,
    @i_id_empresa   int, 
    @i_id_variable  smallint
)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_ente				    int,
		@w_resultado			int,    
        @w_asig_actividad       int,        
        @w_valor_ant            varchar(255),
        @w_valor_nuevo          varchar(255),
        @w_est_cancelado        tinyint
    
        
select @w_sp_name = 'sp_var_individual_nro_ciclo'

select @w_ente             = io_campo_1 
from   cob_workflow..wf_inst_proceso
where  io_id_inst_proc     = @i_id_inst_proc

exec @w_error     =   cob_cartera..sp_estados_cca
@o_est_cancelado  =   @w_est_cancelado out

select @w_resultado = count(1) + 1
from   cob_credito..cr_tramite , cob_cartera..ca_operacion
where  tr_grupal IS null
and    op_tramite = tr_tramite
and    op_estado =  @w_est_cancelado
and    op_cliente = @w_ente
    
if @w_resultado is null
begin
   select @w_error  = 6904007 --No existieron resultados asociados a la operacion indicada   
   exec   @w_error  = cobis..sp_cerror
          @t_debug  = 'N',
          @t_file   = '',
          @t_from   = @w_sp_name,
          @i_num    = @w_error
   return @w_error
end

-- Resultado
select @w_valor_nuevo = convert(varchar,@w_resultado)

--if @t_debug = 'S'
--begin
    print '@w_valor_nuevo: ' + convert(varchar, @w_valor_nuevo )    
--end

--insercion en estrucuturas de variables


if @i_id_asig_act is null
  select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
  from cob_workflow..wf_variable_actual
 where va_id_inst_proc = @i_id_inst_proc
   and va_codigo_var   = @i_id_variable

if @@rowcount > 0  --ya existe
begin
  --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
  update cob_workflow..wf_variable_actual
     set va_valor_actual = @w_valor_nuevo 
   where va_id_inst_proc = @i_id_inst_proc
     and va_codigo_var   = @i_id_variable    
end
else
begin
  insert into cob_workflow..wf_variable_actual
         (va_id_inst_proc, va_codigo_var, va_valor_actual)
  values (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo )

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc AND
                    mv_codigo_var= @i_id_variable AND
                    mv_id_asig_act = @i_id_asig_act)
BEGIN
    insert into cob_workflow..wf_mod_variable
           (mv_id_inst_proc, mv_codigo_var, mv_id_asig_act,
            mv_valor_anterior, mv_valor_nuevo, mv_fecha_mod)
    values (@i_id_inst_proc, @i_id_variable, @i_id_asig_act,
            @w_valor_ant, @w_valor_nuevo , getdate())
            
    if @@error > 0
    begin
            --registro ya existe
            
          exec cobis..sp_cerror
          @t_debug = @t_debug,
          @t_file = @t_file, 
          @t_from = @t_from,
          @i_num = 2101002
    return 1
    end 

END

return 0
GO


