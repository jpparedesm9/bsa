use cob_workflow
go
if exists (select 1 from sysobjects
            where name = 'sp_claim_task_wf')
begin
  -- print 'ELIMINANDO EL PROCEDIMIENTO sp_claim_task_wf'
  drop procedure sp_claim_task_wf
end
go
-- print 'CREANDO EL PROCEDIMIENTO sp_claim_task_wf'
go

create proc sp_claim_task_wf
( 
		@t_trn					int = null, 
		@i_task_inst_id			int = null,
		@s_srv              	varchar(30) = null, 
		@s_user             	login = null, 
		@s_term             	varchar(30) = null, 
		@s_ofi   		        int = null, 
		@s_rol					int = NULL, 
		@s_ssn              	int = null, 
		@s_lsrv   				varchar(30) = null, 
		@s_date             	datetime = null, 
		@s_msg					descripcion = NULL

)
as 
declare 
    @w_today        	datetime, 
	@w_sp_name      	varchar(32), 
	@w_return		    int,
	@w_secuencial		int,
    @w_paso			    smallint,
	@w_id_inst_proc     int,
    @w_codigo_act       smallint,
	--OGU 2014-02-03
	@w_spid             smallint, 
	@w_codigo_tipo_doc  int, 
	@w_texto            descripcion, 
	@w_es_mandatorio    bit,
	@w_tipo_doc         varchar(1), 
	@w_id_regla         int, 
	@w_categoria_doc    varchar(1),
	@w_referencia       varchar(20),
	@w_excepcionable	bit,
    @w_result           int, 	
	@w_return_value     varchar(255),
    @w_return_code      int,
	@w_rv_id            int,
	@w_id_proceso       int,
	@w_version_proc     int
		
select @w_today=getdate() 
select @w_sp_name = 'sp_ui_human_task_info' 
select @w_spid = @@spid

   
--CONSULTAR EL ID DE PASO CORRESPONDIENTE A LA INSTANCIA DE ACTIVIDAD.
   select @w_paso = pa_id_paso, 
		  @w_id_inst_proc = ia_id_inst_proc,     
		  @w_codigo_act	= ia_codigo_act,
		  @w_id_proceso = io_codigo_proc, 
		  @w_version_proc = io_version_proc
   from wf_inst_actividad, wf_paso, wf_inst_proceso
   where ia_id_inst_act  = @i_task_inst_id
     and ia_id_inst_proc = io_id_inst_proc
     and ia_codigo_act   = pa_codigo_actividad
     and io_codigo_proc  = pa_codigo_proceso
     and io_version_proc = pa_version_proceso
	 	 
   exec @w_return = cob_workflow..sp_cons_act_proceso_wf
   @t_trn	= 31754,
   @i_operacion = 'R',
   @i_codigo_actividad = @w_paso  -- id_paso
 
   if @w_return != 0
   begin
      print 'Error en ejecucion de sp'
      return 1
   end

if @w_return != 0
begin
    exec cobis..sp_cerror
         @i_num  = @w_return,
         @t_from = @w_sp_name
    return 1
end

	exec @w_return = cob_workflow..sp_obtener_requisitos_wf
					 @s_srv              = @s_srv,
					 @s_user             = @s_user, 
					 @s_term             = @s_term, 
					 @s_ofi              = @s_ofi, 
					 @s_rol              = @s_rol,	
					 @s_ssn              = @s_ssn, 
					 @s_lsrv             = @s_lsrv,
					 @s_date             = @s_date, 
					 
					 @t_trn              = @t_trn,
		@i_paso = @w_paso,
		@i_id_inst_proc = @w_id_inst_proc,
		@i_id_inst_act  = @i_task_inst_id
			
if @w_return != 0
				begin
    exec cobis..sp_cerror
         @i_num  = @w_return,
         @t_from = @w_sp_name
    return 1
		end
		
		select 'CODIGO' = ri_codigo_tipo_doc,     
           'NOMBRE_DOC' = ri_nombre_doc
    from wf_req_inst 
    where ri_id_inst_proc = @w_id_inst_proc
      and ri_codigo_act = @w_codigo_act 
      and ri_codigo_tipo_doc in ( select tr_codigo_tipo_doc
                                  from wf_tipo_req_act, wf_tipo_documento
                                  where tr_codigo_tipo_doc = td_codigo_tipo_doc
                                    and tr_id_paso = @w_paso
                                    and td_vigencia_doc = 'V' )
	
	--CONSULTAR LAS VARIABLES ASOCIADAS A UN PROCESO

   select 'CODIGO' = vb_codigo_variable, 'NOMBRE' = vb_nombre_variable, 'VALOR' = va_valor_actual

   from wf_variable_proceso, cob_workflow..wf_variable, cob_workflow..wf_inst_actividad, cob_workflow..wf_inst_proceso,

        cob_workflow..wf_variable_actual 

   where vr_codigo_proceso  = io_codigo_proc

     and vr_version_proceso  = io_version_proc

     and vr_codigo_variable = vb_codigo_variable

     and ia_id_inst_act  = @i_task_inst_id

     and ia_id_inst_proc  = io_id_inst_proc

     and va_id_inst_proc = io_id_inst_proc

     and va_codigo_var = vb_codigo_variable

   /*select 'CODIGO' = vb_codigo_variable, 'NOMBRE' = vb_nombre_variable, 'VALOR' = vb_val_variable  

   from wf_variable_proceso, cob_workflow..wf_variable, cob_workflow..wf_inst_actividad, cob_workflow..wf_inst_proceso 

   where vr_codigo_proceso  = io_codigo_proc

     and vr_version_proceso  = io_version_proc

     and vr_codigo_variable = vb_codigo_variable

     and ia_id_inst_act  = @i_task_inst_id

     and ia_id_inst_proc  = io_id_inst_proc*/

	--CONSULTAR OBSERVACION
	select 'CODIGO' = ri_codigo_tipo_doc,     
           'OBSERVACION' = ri_observacion,
		   'EXCEPCIONABLE' = ri_excepcionable
    from wf_req_inst 
    where ri_id_inst_proc = @w_id_inst_proc
      and ri_codigo_act = @w_codigo_act 
      and ri_codigo_tipo_doc in ( select tr_codigo_tipo_doc
                                  from wf_tipo_req_act, wf_tipo_documento
                                  where tr_codigo_tipo_doc = td_codigo_tipo_doc
                                    and tr_id_paso = @w_paso
                                    and td_vigencia_doc = 'V' )

   update wf_asig_actividad
   set aa_claim = 'S'
   where aa_id_asig_act = (select max(a.aa_id_asig_act) from wf_asig_actividad a where a.aa_id_inst_act = @i_task_inst_id)  
   
return 0

GO
