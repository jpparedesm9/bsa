use cobis
go
update cl_grupo
SET gr_representante = cg_ente
from cl_grupo
inner join cl_cliente_grupo on gr_grupo = cg_grupo
where cg_rol = 'P'