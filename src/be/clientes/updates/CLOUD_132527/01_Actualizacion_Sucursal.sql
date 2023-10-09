use cobis
go


select grupo = gr_grupo, 
       operacion = max(op_operacion),
       sucursal  = convert(int,null)
into #grupos
from cob_credito..cr_tramite_grupal,
	 cob_cartera..ca_operacion,
	 cobis..cl_grupo
where tg_operacion = op_operacion
and   tg_grupo     = gr_grupo
and   gr_sucursal  <> op_oficina
group by gr_grupo


update #grupos set
sucursal = op_oficina
from cob_cartera..ca_operacion
where operacion = op_operacion
	  
update  cobis..cl_grupo set
gr_sucursal = sucursal
from #grupos
where grupo = gr_grupo
go
