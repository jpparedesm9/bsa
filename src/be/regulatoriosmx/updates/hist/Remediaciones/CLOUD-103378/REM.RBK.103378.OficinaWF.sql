use cob_workflow 
go 



---se actualiza los valores de la tabla bakcup

update cob_workflow..wf_inst_proceso set 
io_oficina_inicio  = isnull(a.io_oficina_inicio,0),
io_oficina_entrega = isnull(a.io_oficina_entrega,0)
from wf_inst_proceso_103378 a , wf_inst_proceso b
where a.io_campo_3 = b.io_campo_3


go