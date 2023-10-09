select count(1) from cob_workflow..wf_r_proceso
go
truncate table cob_workflow..wf_r_proceso
go

declare @w_tipo         char (1),
  @w_id_inst_proceso    int,
  @w_id_proceso         smallint,
  @w_version_proc       smallint,
  @w_ofi                smallint
select @w_tipo = 'I'
set rowcount 1
select @w_id_inst_proceso = io_id_inst_proc,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc > 0
 order by io_id_inst_proc asc

while (@@rowcount > 0)
begin
    exec cob_workflow..sp_m_res_proceso_wf
    @i_tipo              = @w_tipo,
    @i_id_inst_proceso   = @w_id_inst_proceso,
    @i_id_proceso        = @w_id_proceso,
    @i_version_proc      = @w_version_proc,
    @s_ofi               = @w_ofi,
	@i_oficina_inicio    = @w_ofi,
	@i_canal             = 12



    select @w_id_inst_proceso = io_id_inst_proc,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN   'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc > @w_id_inst_proceso
 order by io_id_inst_proc asc
end

select @w_tipo = 'F'
select @w_id_inst_proceso = io_id_inst_proc,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN 'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc > 0
   and io_estado = 'TER'
 order by io_id_inst_proc asc

while (@@rowcount > 0)
begin

    exec cob_workflow..sp_m_res_proceso_wf
    @i_tipo              = @w_tipo,
    @i_id_inst_proceso   = @w_id_inst_proceso,
    @i_id_proceso        = @w_id_proceso,
    @i_version_proc      = @w_version_proc,
    @s_ofi               = @w_ofi,
	@i_oficina_inicio    = @w_ofi,
	@i_canal             = 12



    select @w_id_inst_proceso = io_id_inst_proc,
       @w_id_proceso      = io_codigo_proc,
       @w_version_proc    = io_version_proc,
       --@w_tipo            = (CASE io_estado WHEN   'TER' THEN 'F' ELSE  'I' END),
       @w_ofi             = io_oficina_inicio
  from cob_workflow..wf_inst_proceso
 where io_id_inst_proc > @w_id_inst_proceso
   and io_estado = 'TER'
 order by io_id_inst_proc asc
end

set rowcount 0
go
select count(1) from cob_workflow..wf_r_proceso
go
