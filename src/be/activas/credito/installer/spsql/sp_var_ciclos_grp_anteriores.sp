/****************************************************************/
/*   ARCHIVO:         	sp_var_ciclos_grp_anteriores.sp         */
/*   NOMBRE LOGICO:   	sp_var_ciclos_grp_anteriores            */
/*   PRODUCTO:        		CARTERA                             */
/****************************************************************/
/*                     IMPORTANTE                           	*/
/*   Esta aplicacion es parte de los  paquetes bancarios    	*/
/*   propiedad de MACOSA S.A.                               	*/
/*   Su uso no autorizado queda  expresamente  prohibido    	*/
/*   asi como cualquier alteracion o agregado hecho  por    	*/
/*   alguno de sus usuarios sin el debido consentimiento    	*/
/*   por escrito de MACOSA.                                 	*/
/*   Este programa esta protegido por la ley de derechos    	*/
/*   de autor y por las convenciones  internacionales de    	*/
/*   propiedad intelectual.  Su uso  no  autorizado dara    	*/
/*   derecho a MACOSA para obtener ordenes  de secuestro    	*/
/*   o  retencion  y  para  perseguir  penalmente a  los    	*/
/*   autores de cualquier infraccion.                       	*/
/****************************************************************/
/*                     PROPOSITO                            	*/
/*	 Se define como la sumatoria de los Dias de Atraso Grupal   */
/*	 de los dos ciclos anteriores del grupo.                    */
/*	 En caso de que el ciclo actual sea 1 o 2, este valor será  */
/*	 CERO.                                                      */
/*                                                              */
/****************************************************************/
/*                     MODIFICACIONES                       	*/
/*   FECHA         AUTOR               RAZON                	*/
/*   16-May-2017   Sonia Rojas        Emision Inicial.     	    */
/****************************************************************/

use cob_credito
go

if exists (select 1 from sysobjects where name = 'sp_var_ciclos_grp_anteriores')
   drop proc sp_var_ciclos_grp_anteriores
go

create proc [dbo].[sp_var_ciclos_grp_anteriores](
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
declare	@w_sp_name 							varchar(64),
		@w_error							int,
		@w_grupo							int,
		@w_num_ciclo_ant					int,
		@w_num_ciclos_anteriores 			int, 
		@w_return   						int,
		@w_dias_atraso_ciclos_anteriores    int,
		@w_resultado						int,
		@w_asig_actividad 					int,		
		@w_valor_ant      					varchar(255),
		@w_valor_nuevo    					varchar(255)
		
select @w_sp_name = 'sp_var_ciclo_grupal_anteriores'

select @w_grupo = io_campo_1 
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc 	= @i_id_inst_proc
   and io_campo_7 		= 'S' -- Cambiar a Grupo Solidario 'S'


select @w_num_ciclos_anteriores = pa_int 
  from cobis..cl_parametro
 where pa_nemonico = 'DAGCAS'

select @w_resultado = 0
 
if @w_num_ciclos_anteriores  is null
begin
   select @w_error = 2109002   
   exec   @w_error  = cobis..sp_cerror
          @t_debug  = 'N',
          @t_file   = '',
          @t_from   = @w_sp_name,
          @i_num    = @w_error
   return @w_error
end
else
begin
	select @w_num_ciclo_ant = 1
	
	while @w_num_ciclo_ant <= @w_num_ciclos_anteriores
	begin 
		--print '@w_num_ciclo_ant: '+convert(varchar,@w_num_ciclo_ant)
		exec @w_return 			= cob_credito..sp_dias_atraso_grupal
			 @i_grupo 			= @w_grupo,
			 @i_ciclos_ant 		= @w_num_ciclo_ant,
			 @i_es_ciclo_ant 	= 'N',
			 @o_resultado 		= @w_dias_atraso_ciclos_anteriores OUT
							
							
		--print '@w_dias_atraso_ciclos_anteriores: '+convert(varchar,@w_dias_atraso_ciclos_anteriores)
		if @w_return is null
		begin
			select @w_error = 6904007 --No existieron resultados asociados a la operacion indicada   
			exec   @w_error  = cobis..sp_cerror
					@t_debug  = 'N',
					@t_file   = '',
					@t_from   = @w_sp_name,
					@i_num    = @w_error
			return @w_error
		end
		select @w_num_ciclo_ant = @w_num_ciclo_ant + 1 
		select @w_resultado = @w_resultado + @w_dias_atraso_ciclos_anteriores
		
		
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
	
end	
	


return 0
go
