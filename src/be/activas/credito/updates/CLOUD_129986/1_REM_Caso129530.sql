use cob_credito
go

declare @w_gar float, @w_tramite int, @w_proceso int

IF OBJECT_ID ('dbo.act_tramite_tmp_caso_129530') IS NOT NULL
	DROP table dbo.act_tramite_tmp_caso_129530

create table act_tramite_tmp_caso_129530 (
    tramite    int,
	porcentaje float,  
	proceso    int
)

select @w_proceso = 20530

select @w_tramite = io_campo_3
from   cob_workflow..wf_inst_proceso 
where io_id_inst_proc = @w_proceso

insert into act_tramite_tmp_caso_129530
select io_campo_3, null, io_id_inst_proc
from   cob_workflow..wf_inst_proceso 
where  io_id_inst_proc > = @w_proceso
and    io_campo_4 = 'GRUPAL'

select 'ini' = 'ini', tr_porc_garantia, * 
from   cob_credito..cr_tramite, act_tramite_tmp_caso_129530 
where  tr_tramite = tramite

delete act_tramite_tmp_caso_129530
where  tramite in (select tr_tramite from cob_credito..cr_tramite where tr_tramite < @w_tramite)

update act_tramite_tmp_caso_129530
set    porcentaje = tr_porc_garantia
from   cob_credito..cr_tramite
where  tr_tramite = tramite

select @w_gar = pa_float
from   cobis..cl_parametro 
where  pa_nemonico = 'PGARGR'
and    pa_producto = 'CCA'

select 'ant' = 'ant', tr_porc_garantia, * 
from   cob_credito..cr_tramite, act_tramite_tmp_caso_129530 
where  tr_tramite = tramite

update cob_credito..cr_tramite
set    tr_porc_garantia = @w_gar
from   act_tramite_tmp_caso_129530
where  tr_tramite = tramite

select 'desp' = 'desp', tr_porc_garantia, * 
from   cob_credito..cr_tramite, act_tramite_tmp_caso_129530
where  tr_tramite = tramite

go
