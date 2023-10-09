
select distinct 'grupo' = tg_grupo,'tramite' = tg_tramite, 'nombre'= op_nombre
into #nombre_grupos
from cob_credito..cr_tramite_grupal,
     cob_cartera..ca_operacion
where tg_tramite = op_tramite     

select *
from #nombre_grupos,
     cobis..cl_grupo
where grupo = gr_grupo
and   upper (nombre) <> upper(gr_nombre)

update cob_cartera..ca_operacion
set    op_nombre =  gr_nombre
from  #nombre_grupos,
     cobis..cl_grupo     
where tramite  = op_tramite
and   grupo    = gr_grupo
and   upper (op_nombre) <> upper(gr_nombre)

