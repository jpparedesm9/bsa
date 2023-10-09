/************************************************************************/
/*  Archivo:                sp_var_dias_validacion_ine.sp               */
/*  Stored procedure:       sp_var_dias_validacion_ine                  */
/*  Base de Datos:          cob_credito                                 */
/*  Producto:               Credito                                     */
/*  Disenado por:           F.Sanmiguel                                 */
/*  Fecha de Documentacion: 19/Feb/2020                                 */
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
/* valida la cantidad de dias desde la ultima validacion INE para cada	*/
/* integrante del grupo y genera una observacion						*/
/************************************************************************/
/*          MODIFICACIONES                                              */
/*  FECHA         AUTOR                     RAZON                       */
/* 19/Feb/2020    F.Sanmiguel    Emision Inicial                        */
/* 17/Sep/2021    ACH            ERR#168924,se toma el parametro de ingr*/
/* **********************************************************************/
USE cob_credito;
GO

IF EXISTS (SELECT 1 FROM sysobjects o, sysusers u WHERE o.uid = u.uid AND o.name = 'sp_var_dias_validacion_ine' AND u.name = 'dbo' AND o.type = 'P')
    DROP PROCEDURE sp_var_dias_validacion_ine;
GO

CREATE PROCEDURE [dbo].[sp_var_dias_validacion_ine](
	@t_debug       		char(1)     = 'N',
	@t_from        		varchar(30) = null,
	@s_ssn              int = null,
	@s_user             varchar(30) = null,
	@s_sesn             int = null,
	@s_term             varchar(30) = null,
	@s_date             datetime = null,
	@s_srv              varchar(30) = null,
	@s_lsrv             varchar(30) = null,
	@s_ofi              smallint = null,
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
declare	@w_sp_name 				varchar(64),
		@w_error				int,
		@w_ente					int,
		@w_resultado			int,
		@w_valor_ante      		varchar(255),
		@w_valor_nuevo    		varchar(255),
		@w_ente_tmp				int,
		@w_days_tmp				int,
		@w_resultado_tmp		varchar(255),
		@w_asig_act				int,
		@w_usuario				varchar(64),
		@w_numero				int,
		@w_cadena				varchar(255)
		
	select @w_sp_name = 'sp_var_dias_validacion_ine'

	select @w_ente 		= io_campo_1 
		from cob_workflow..wf_inst_proceso
		where io_id_inst_proc 	= @i_id_inst_proc

	if @w_ente is not null
		if @t_debug = 'S'
			begin
				print '@w_ente: ' + convert(varchar, @w_ente )	
			end

		select @w_resultado =  max(DATEDIFF(DAY,rb_fecha_registro,GETDATE()))  FROM cobis..cl_respuesta_bio where rb_inst_proc = @i_id_inst_proc 

        select 	@w_asig_act = convert(int, @i_id_asig_act) -- antes: io_campo_2
			from cob_workflow..wf_inst_proceso where io_id_inst_proc = @i_id_inst_proc
			
		select @w_usuario = fu_nombre from cobis..cl_funcionario where fu_login = @s_user

		--iteracion
		declare cur CURSOR LOCAL for
			select rb_ente FROM cobis..cl_respuesta_bio where rb_inst_proc = @i_id_inst_proc 
		open cur
		fetch next from cur into @w_ente_tmp

		
		while @@FETCH_STATUS = 0 BEGIN
			select  @w_days_tmp = DATEDIFF(DAY,rb_fecha_registro,GETDATE())  FROM cobis..cl_respuesta_bio where rb_inst_proc = @i_id_inst_proc and rb_ente = @w_ente_tmp
			select  @w_days_tmp = isnull(@w_days_tmp,0)
			
					exec 	cob_cartera..sp_ejecutar_regla
							@s_ssn                  = @s_ssn,
							@s_ofi                  = @s_ofi,
							@s_user                 = @s_user,
							@s_date                 = @s_date,
							@s_srv                  = @s_srv,
							@s_term                 = @s_term,
							@s_rol                  = @s_rol,
							@s_lsrv                 = @s_lsrv,
							@s_sesn                 = @s_sesn,
							@i_regla                = 'PVALINE', 
							@i_tipo_ejecucion       = 'REGLA',     
							@i_valor_variable_regla = @w_days_tmp,
							@o_resultado1           = @w_resultado_tmp out
 
			 select @w_numero = max(ob_numero)+ 1 from cob_workflow..wf_observaciones where ob_id_asig_act = @w_asig_act
			 if @w_resultado_tmp = 1 --NO CUMPLE 
				begin
					select @w_cadena = 'El cliente '+ convert(varchar,@w_ente_tmp) + 'NO cumple con la politica de Periodo de vigencia de validación INE'
					insert into cob_workflow..wf_observaciones (ob_id_asig_act, ob_numero, ob_fecha, ob_categoria, ob_lineas, ob_oficial, ob_ejecutivo)
						values (@w_asig_act, @w_numero, getdate(), 4, 1, 'a', @w_usuario)
				 
						insert into cob_workflow..wf_ob_lineas (ol_id_asig_act, ol_observacion, ol_linea, ol_texto)
						values (@w_asig_act, @w_numero, 1, @w_cadena)
						select  @w_numero = @w_numero + 1
				end
				
			fetch next from cur into @w_ente_tmp
		END
		close cur
		deallocate cur	
		
		--fin interacion

		select @w_valor_nuevo = convert(varchar,isnull(@w_resultado,0))

		if @t_debug = 'S'
		begin
			print '@w_valor_nuevo: ' + convert(varchar, @w_valor_nuevo )	
		end

		-- valor anterior de variable tipop en la tabla cob_workflow..wf_variable
		select @w_valor_ante    = isnull(va_valor_actual, '')
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