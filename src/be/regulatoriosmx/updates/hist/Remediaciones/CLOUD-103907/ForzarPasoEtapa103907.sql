use cob_workflow
go

declare @w_id_inst_proc  int,
        @w_id_inst_act   int,
        @w_id_paso       int,
        @w_nombre_act    varchar(30),
        @w_id_asig_act   int, 
        @w_codigo_res    int,
        @w_id_empresa    int,
        @w_fecha_proceso datetime

select @w_id_inst_proc = 1315--Codigo Proceso
select @w_codigo_res = 1 --OK
select @w_id_empresa = 1

select @w_fecha_proceso = fp_fecha from cobis..ba_fecha_proceso

select @w_id_inst_act = ia_id_inst_act,
       @w_id_paso	  = ia_id_paso,
	   @w_nombre_act  = ia_nombre_act
  from cob_workflow..wf_inst_actividad
 where ia_id_inst_proc = @w_id_inst_proc
   and ia_estado 	= 'ACT'
   and ia_tipo_dest is null
   
--Asignación actividad
select @w_id_asig_act = aa_id_asig_act
  from cob_workflow..wf_asig_actividad
 where aa_id_inst_act = @w_id_inst_act

	exec cob_workflow..sp_resp_actividad_wf 
		@s_ssn  			= 	1, 
		@s_user             = 	'OPERADOR',
		@s_sesn             = 	1,
		@s_term             = 	'CONSOLA',
		@s_date             = 	@w_fecha_proceso,
		@s_srv              = 	'CTSSERV',
		@s_lsrv             = 	'CTSSRV',
		@s_ofi              = 	9001,		
		@t_trn 				= 	73505,
		@i_operacion 		= 	'C',
		@i_actualiza_var 	= 	'N',
		@i_asig_manual 		= 	0,
		@i_id_inst_proc 	= 	@w_id_inst_proc,
		@i_id_inst_act 		= 	@w_id_inst_act,
		@i_id_asig_act 		= 	@w_id_asig_act,
		@i_id_paso 			= 	@w_id_paso,
		@i_codigo_res 		= 	@w_codigo_res,
		@i_id_empresa 		= 	@w_id_empresa