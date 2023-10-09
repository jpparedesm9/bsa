/****************************************************************/
/*   ARCHIVO:         	sp_var_edad_grupal.sp				    */
/*   NOMBRE LOGICO:   	sp_var_edad_grupal                      */
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
/*                     PROPOSITO                             	*/
/*																*/
/****************************************************************/
/*   FECHA         AUTOR               RAZON                	*/
/*   28-Oct-2019   Agustin Ortiz       Emision Inicial.     	*/
/****************************************************************/

use cob_credito
go

if not object_id('sp_var_edad_grupal') is null
   drop proc sp_var_edad_grupal

go  

create proc sp_var_edad_grupal(
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int         = null,
	@s_user             varchar(30) = null,
	@s_sesn             int 		= null,
	@s_term             varchar(30) = null,
	@s_date             datetime 	= null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint 	= null,
	@t_file             varchar(14) = null,
	@s_rol              smallint    = null,
	@s_org_err          char(1)     = null,
	@s_error            int         = null,
	@s_sev              tinyint     = null,
	@s_msg              descripcion = null,
	@s_org              char(1)     = null,
	@s_culture         	varchar(10) = 'NEUTRAL',
	@t_rty              char(1)     = null,
	@t_trn				int 		= null,
	@t_show_version     BIT 		= 0,
    @i_id_inst_proc    	int,    	--codigo de instancia del proceso
    @i_id_inst_act     	int,    
    @i_id_asig_act     	int,
    @i_id_empresa      	int, 
    @i_id_variable     	smallint,
	@o_respuesta        char(2) = null output
)
as
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_grupo				int,
		@w_resultado			int,
		@w_asig_actividad 		int,		
		@w_valor_ant      		varchar(255),
		@w_valor_nuevo    		varchar(255),
		@w_operacion            varchar(64),
		@w_count				int,
		@w_ente					int,
		@w_fecha				datetime
		
	select @w_sp_name = 'sp_var_edad_grupal'

   select @w_grupo 		= io_campo_1,
		  @w_operacion  = io_campo_4
   from cob_workflow..wf_inst_proceso
   where io_id_inst_proc 	= @i_id_inst_proc

   if @w_operacion = 'GRUPAL'
   begin
		select cg_ente 
		into #integrantes
		from cobis..cl_cliente_grupo 
		where cg_grupo = @w_grupo and cg_estado = 'V'

		select @w_count=count(*) from #integrantes
		
		if @w_ente = 0 return 0
		else
		begin
			while @w_count > 0
			begin
				(select top(1) @w_ente = cg_ente FROM #integrantes);
				
				exec @w_error = cob_credito..sp_var_validacion_edad
					 @i_id_inst_proc = @i_id_inst_proc,
					 @i_ente         = @w_ente,
					 @i_tproducto    = @w_operacion,
					 @o_resultado    = @o_respuesta out
                     print 'VALIDANDO: ' + convert(varchar,@w_ente) + ' res: '+convert(varchar,@o_respuesta)+ ' grup '+convert(varchar,@w_grupo)

					 
				delete from #integrantes where cg_ente = @w_ente 
				select @w_count=count(*) from #integrantes
				if @o_respuesta = 'NO'
				begin
					select @w_count = 0
				end

			end
		end
		select @w_valor_nuevo = convert(varchar,@o_respuesta)
	end
   
   if @w_operacion IN ('REVOLVENTE','INDIVIDUAL')
   begin
		select @w_fecha = p_fecha_nac  
		from cobis..cl_ente 
		where en_ente = @w_grupo

		exec @w_error = cob_credito..sp_var_validacion_edad
					 @i_id_inst_proc = @i_id_inst_proc,
					 @i_ente         = @w_grupo,
					 @i_tproducto    = @w_operacion,
					 @o_resultado    = @o_respuesta out
                     print 'VALIDANDO: ' + convert(varchar,@w_ente) + ' res: '+convert(varchar,@o_respuesta)+ ' grup '+convert(varchar,@w_grupo)

		select @w_valor_nuevo = convert(varchar,@o_respuesta)
	end

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
		if object_id('tempdb..#integrantes') is not null
		begin
			drop table #integrantes
		end

	return 0
go
