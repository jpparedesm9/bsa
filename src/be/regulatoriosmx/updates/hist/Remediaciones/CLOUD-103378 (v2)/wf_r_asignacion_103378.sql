select count(1) from cob_workflow..wf_r_asignacion_act
go
truncate table cob_workflow..wf_r_asignacion_act
go

declare @w_tipo         char (1),
  @w_id_inst_act        int,
  @w_id_asig_act        int,
  @w_id_proceso         smallint,
  @w_version_proc       smallint,
  @w_ofi                smallint,
  @w_id_actividad       int,
  @w_id_usuario         int,
  @w_id_rol             int
select @w_tipo = 'I'
set rowcount 1
select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act,
       @w_id_asig_act     = aa_id_asig_act,
       @w_id_usuario      = aa_id_destinatario,
       @w_id_rol          = aa_id_rol
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
inner join cob_workflow..wf_asig_actividad on aa_id_inst_act  = ia_id_inst_act
 where aa_id_asig_act > 0
 order by aa_id_asig_act asc

while (@@rowcount > 0)
begin
    exec cob_workflow..sp_m_res_asig_act_wf
    @i_operacion              = @w_tipo,
    @i_id_inst_act       = @w_id_inst_act,
    @i_id_proceso        = @w_id_proceso,
    @i_version_proc      = @w_version_proc,
    @s_ofi               = @w_ofi,
    @i_id_actividad      = @w_id_actividad,
    @i_id_usuario        = @w_id_usuario,
    @i_id_rol            = @w_id_rol



select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act,
       @w_id_asig_act     = aa_id_asig_act,
       @w_id_usuario      = aa_id_destinatario,
       @w_id_rol          = aa_id_rol
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
inner join cob_workflow..wf_asig_actividad on aa_id_inst_act  = ia_id_inst_act
 where aa_id_asig_act > @w_id_asig_act
 order by aa_id_asig_act asc
end

select @w_tipo = 'F'
select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act,
       @w_id_asig_act     = aa_id_asig_act,
       @w_id_usuario      = aa_id_destinatario,
       @w_id_rol          = aa_id_rol
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
inner join cob_workflow..wf_asig_actividad on aa_id_inst_act  = ia_id_inst_act
 where aa_id_asig_act > 0
   and aa_estado =   'COM'
 order by aa_id_asig_act asc

while (@@rowcount > 0)
begin

    exec cob_workflow..sp_m_res_asig_act_wf
    @i_operacion              = @w_tipo,
    @i_id_inst_act       = @w_id_inst_act,
    @i_id_proceso        = @w_id_proceso,
    @i_version_proc      = @w_version_proc,
    @s_ofi               = @w_ofi,
    @i_id_actividad      = @w_id_actividad,
    @i_id_usuario        = @w_id_usuario,
    @i_id_rol            = @w_id_rol


select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act,
       @w_id_asig_act     = aa_id_asig_act,
       @w_id_usuario      = aa_id_destinatario,
       @w_id_rol          = aa_id_rol
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
inner join cob_workflow..wf_asig_actividad on aa_id_inst_act  = ia_id_inst_act
 where aa_id_asig_act > @w_id_asig_act
   and aa_estado =   'COM'
 order by aa_id_asig_act asc
end

set rowcount 0
go
select count(1) from cob_workflow..wf_r_asignacion_act
go
