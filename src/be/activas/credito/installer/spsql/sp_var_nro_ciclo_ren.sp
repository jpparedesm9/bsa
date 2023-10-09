
use cob_credito 
go 

IF OBJECT_ID ('dbo.sp_var_nro_ciclos_ren') IS NOT NULL
	DROP PROCEDURE dbo.sp_var_nro_ciclos_ren
GO


/************************************************************************/
/*  Archivo:                sp_var_numero_ciclo_ren.sp                  */
/*  Stored procedure:       sp_var_numero_ciclo_ren                     */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/************************************************************************/
/*                          IMPORTANTE                                  */
/*  Este programa es parte de los paquetes bancarios propiedad de       */
/*  "MACOSA",representantes exclusivos para el Ecuador de la            */
/*  AT&T                                                                */
/*  Su uso no autorizado queda expresamente prohibido asi como          */
/*  cualquier autorizacion o agregado hecho por alguno de sus           */
/*  usuario sin el debido consentimiento por escrito de la              */
/*  Presidencia Ejecutiva de MACOSA o su representante                  */
/************************************************************************/
/*                          PROPOSITO                                   */
/*Procedure  tipo  Variable,  ciclo de renovacion financiada            */
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA       AUTOR               RAZON                               */
/*  05/01/22    Andy Gonzalez                 Emision Inicial           */
/* **********************************************************************/

create proc sp_var_nro_ciclos_ren(
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
    @i_id_inst_act     	int ,    
    @i_id_asig_act     	int ,
    @i_id_empresa      	int , 
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
		@w_valor_actual			varchar(10),
		@w_grupo                int      
		
		
   select @w_sp_name 	= 'sp_var_nro_ciclos_ren'
   select  @w_resultado  = 0

   select @w_grupo 		= io_campo_1 
   from cob_workflow..wf_inst_proceso
   where io_id_inst_proc 	= @i_id_inst_proc
   and io_campo_7 		= 'S' -- Cambiar a Grupo Solidario 'S'
		
		
	
   select or_referencia_grupal, tg_referencia_grupal, or_grupo
   into #renovaciones_operaciones
   from cob_credito..cr_op_renovar,
   cob_credito..cr_tramite_grupal,
   cob_cartera..ca_operacion
   where or_operacion_original = tg_operacion
   and op_operacion = tg_operacion
   and tg_grupo = @w_grupo 
   and or_finalizo_renovacion = 'S'
   group by or_referencia_grupal, tg_referencia_grupal,or_grupo


   select or_grupo, numero_renova = count(1)
   into #renovacion_grupo
   from #renovaciones_operaciones
   group by or_grupo

   select @w_resultado = isnull(numero_renova,0) from #renovacion_grupo
 
   select  @w_resultado =  @w_resultado  -- COMO BASE RENOVACIONES DE 3 CICLOS GRUPALES 
		
		
	if @w_resultado < 0
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

GO

