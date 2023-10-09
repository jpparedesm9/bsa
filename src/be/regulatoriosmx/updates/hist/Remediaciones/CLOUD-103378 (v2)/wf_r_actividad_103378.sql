select count(1) from cob_workflow..wf_r_actividades_proc
go
truncate table cob_workflow..wf_r_actividades_proc
go

declare @w_tipo         char (1),
  @w_id_inst_act    int,
  @w_id_proceso         smallint,
  @w_version_proc       smallint,
  @w_ofi                smallint,
  @w_id_actividad       int
select @w_tipo = 'I'
set rowcount 1
select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
 where ia_id_inst_act > 0
 order by ia_id_inst_act asc

while (@@rowcount > 0)
begin
    exec cob_workflow..sp_m_res_act_proc_wf
    @i_tipo              = @w_tipo,
    @i_id_inst_act       = @w_id_inst_act,
    @i_id_proceso        = @w_id_proceso,
    @i_version      = @w_version_proc,
    @s_ofi               = @w_ofi,
    @i_id_actividad      = @w_id_actividad



select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
 where ia_id_inst_act > @w_id_inst_act
 order by ia_id_inst_act asc
end

select @w_tipo = 'F'
select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
 where ia_id_inst_act > 0
   and ia_estado =   'COM'
 order by ia_id_inst_act asc

while (@@rowcount > 0)
begin

    exec cob_workflow..sp_m_res_act_proc_wf
    @i_tipo              = @w_tipo,
    @i_id_inst_act       = @w_id_inst_act,
    @i_id_proceso        = @w_id_proceso,
    @i_version      = @w_version_proc,
    @s_ofi               = @w_ofi,
    @i_id_actividad      = @w_id_actividad


select @w_id_inst_act     = ia_id_inst_act,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio,
       @w_id_actividad    = ia_codigo_act
  from cob_workflow..wf_inst_proceso
inner join cob_workflow..wf_inst_actividad on ia_id_inst_proc = io_id_inst_proc
 where ia_id_inst_act > @w_id_inst_act
   and ia_estado =   'COM'
 order by ia_id_inst_act asc
end

set rowcount 0
go
select count(1) from cob_workflow..wf_r_actividades_proc
go
