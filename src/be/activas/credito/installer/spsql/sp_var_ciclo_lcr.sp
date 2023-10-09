/************************************************************************/
/*  Archivo:                sp_var_ciclo_lcr.sp                         */
/*  Stored procedure:       sp_var_ciclo_lcr                            */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           Sonia Rojas                                 */
/*  Fecha de Documentacion: 04/Dic/2019                                 */
/************************************************************************/
/*          IMPORTANTE                                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*          PROPOSITO                                                   */
/* Procedure tipo Variable, retorna el número de ciclo de una LCR       */
/*                                                                      */
/************************************************************************/

use cob_credito
go

if exists(select 1 from sysobjects where name ='sp_var_ciclo_lcr')
	drop proc sp_var_ciclo_lcr
go

create proc [dbo].[sp_var_ciclo_lcr](
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int,
	@s_user             varchar(30),
	@s_sesn             int,
	@s_term             varchar(30),
	@s_date             datetime,
	@s_srv              varchar(30),
	@s_lsrv             varchar(30),
	@s_ofi              smallint,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty              char(1)     = null,
	@t_trn				int = null,
	@t_show_version     BIT = 0,
    @i_id_inst_proc    	int,    --codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare 
@w_sp_name                 varchar(32),
@w_valor_ant               varchar(255),
@w_valor_nuevo             varchar(255),
@w_error                   int,
@w_msg                     varchar(255),
@w_ente                    int,
@w_operacion               int,
@w_registros               int


select @w_sp_name = 'sp_var_ciclo_lcr'

select @w_ente = io_campo_1
from cob_workflow..wf_inst_proceso
where io_id_inst_proc = @i_id_inst_proc

select @w_registros  = count(1) 
from cob_cartera..ca_operacion
where op_toperacion = 'REVOLVENTE'
and op_cliente      = @w_ente

select @w_registros = isnull(@w_registros,0)

if @w_registros = 0 
   select @w_registros = 1
   
select @w_valor_nuevo = @w_registros
 

if @i_id_asig_act is null select @i_id_asig_act = 0

-- valor anterior de variable tipo en la tabla cob_workflow..wf_variable
select @w_valor_ant    = isnull(va_valor_actual, '')
from cob_workflow..wf_variable_actual
where va_id_inst_proc = @i_id_inst_proc
and va_codigo_var     = @i_id_variable

if @@rowcount > 0  --ya existe
begin
   --print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
   update cob_workflow..wf_variable_actual set
   va_valor_actual         = @w_valor_nuevo 
   where va_id_inst_proc   = @i_id_inst_proc
   and   va_codigo_var     = @i_id_variable    
end
else
begin
   insert into cob_workflow..wf_variable_actual
   (va_id_inst_proc, va_codigo_var, va_valor_actual) values
   (@i_id_inst_proc, @i_id_variable, @w_valor_nuevo)

end
--print '@i_id_inst_proc %1! @w_asig_actividad %2! @w_valor_ant %3!',@i_id_inst_proc, @w_asig_actividad, @w_valor_ant
if not exists(select 1 from cob_workflow..wf_mod_variable
              where mv_id_inst_proc = @i_id_inst_proc and
              mv_codigo_var         = @i_id_variable  and
              mv_id_asig_act        = @i_id_asig_act)
begin
   insert into cob_workflow..wf_mod_variable
   (mv_id_inst_proc  ,mv_codigo_var  ,mv_id_asig_act ,mv_valor_anterior,mv_valor_nuevo ,mv_fecha_mod) values
   (@i_id_inst_proc  ,@i_id_variable ,@i_id_asig_act ,@w_valor_ant     ,@w_valor_nuevo , getdate())
			
   if @@error > 0 begin
      select 
	  @w_error = 2101002,
	  @w_msg = 'REGISTRO YA EXISTE'
      GOTO ERROR
   end 

end

return 0


ERROR:
return @w_error

go

