use cob_workflow
go

update wf_asig_actividad
set aa_estado = tmp_aa_estado
FROM wf_asig_actividad_tmp_156189
where aa_id_asig_act = tmp_aa_id_asig_act
AND aa_id_asig_act in (
  select tmp_aa_id_asig_act 
	from wf_asig_actividad_tmp_156189 where tmp_aa_id_inst_act in 
	(
		select ia_id_inst_act 
		  from wf_inst_proceso
	inner join wf_inst_actividad on  io_id_inst_proc = ia_id_inst_proc
		 where io_estado = 'TER' and ia_estado = 'ACT' and ia_tipo_dest is null 
	)      and tmp_aa_estado = 'PEN'
)
go
