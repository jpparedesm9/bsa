/************************************************************************/
/*   Archivo:                 sp_var_nro_ciclos_rev.sp				    */
/*   Stored procedure:        sp_var_nro_ciclos_rev						*/
/*   Base de Datos:           cob_credito                               */
/*   Producto:                Credito                                   */
/*   Disenado por:                                                      */
/*   Fecha de Documentacion:  Noviembre 2019                            */
/************************************************************************/
/*                            IMPORTANTE                                */
/*   Este programa es parte de los paquetes bancario s propiedad de     */
/*   'COBISCorp'.                                                       */
/*   Su uso no autorizado queda expresamente prohibido asi como         */
/*   cualquier autorizacion o agregado hecho por alguno de sus          */
/*   usuario sin el debido consentimiento por escrito de la             */
/*   Presidencia Ejecutiva de MACOSA o su representante                 */
/************************************************************************/
/*                         PROPOSITO                                    */
/*   Obtener el número de ciclos de los créditos revolventes            */
/*	                     												*/
/************************************************************************/
/*                              MODIFICACIONES                          */
/*   Fecha      Nombre          Proposito                               */
/*   05/11/2019 A. Ortiz        Emision Inicial                         */
/************************************************************************/
use cob_credito
go

if not object_id('sp_var_nro_ciclos_rev') is null
   drop proc sp_var_nro_ciclos_rev
go

create proc sp_var_nro_ciclos_rev(
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int         = null, 
	@s_term             varchar(30) = null,
	@s_date             datetime    = null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint    = null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty              char(1)     = null,
	@t_trn				int         = null,
	@t_show_version     BIT         = 0,
    @i_id_inst_proc    	int,		--codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint
)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_cliente				int,
		@w_resultado			int,
		@w_asig_actividad 		int,		
		@w_valor_ant      		varchar(255),
		@w_valor_nuevo    		varchar(255),
		@w_valor_actual			varchar(10)
		
		
	select @w_sp_name 	= 'sp_var_nro_ciclos_rev'
 

	select @w_cliente 		= io_campo_1 
	from cob_workflow..wf_inst_proceso
	where io_id_inst_proc 	= @i_id_inst_proc
		
	select @w_resultado = count(op_operacion) + 1  -- el ciclo minimo es 1
	from cob_cartera..ca_operacion 
	where op_toperacion='REVOLVENTE' and op_cliente = @w_cliente
		
	if @w_resultado is null
	begin
		select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
		exec   @w_error  = cobis..sp_cerror
			   @t_debug  = 'N',
			   @t_file   = '',
			   @t_from   = @w_sp_name,
			   @i_num    = @w_error
           return @w_error
	end

	select @w_valor_nuevo = convert(varchar,@w_resultado)

	if @t_debug = 'S'
	begin
		print '@w_valor_nuevo: ' + convert(varchar, @w_valor_nuevo )	
	end

	-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
	select @w_valor_ant    = isnull(va_valor_actual, '')
	from cob_workflow..wf_variable_actual
	where va_id_inst_proc = @i_id_inst_proc
	and va_codigo_var   = @i_id_variable

	if @@rowcount > 0  --ya existe
	begin
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
	
	return 0
	
	go