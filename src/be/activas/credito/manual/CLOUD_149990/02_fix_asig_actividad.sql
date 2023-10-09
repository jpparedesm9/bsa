use cob_workflow
go
--1582
SELECT aa_estado, * from wf_asig_actividad
where aa_id_asig_act in (
  select aa_id_asig_act 
	from wf_asig_actividad where aa_id_inst_act in 
	(
		select ia_id_inst_act 
		  from wf_inst_proceso
	inner join wf_inst_actividad on  io_id_inst_proc = ia_id_inst_proc
		 where io_estado = 'TER' and ia_estado = 'ACT' and ia_tipo_dest is null 
	)      and aa_estado = 'PEN'
)
go

update wf_asig_actividad
set aa_estado = 'COM'
where aa_id_asig_act in (
  select aa_id_asig_act 
	from wf_asig_actividad where aa_id_inst_act in 
	(
		select ia_id_inst_act 
		  from wf_inst_proceso
	inner join wf_inst_actividad on  io_id_inst_proc = ia_id_inst_proc
		 where io_estado = 'TER' and ia_estado = 'ACT' and ia_tipo_dest is null 
	)      and aa_estado = 'PEN'
)
go
