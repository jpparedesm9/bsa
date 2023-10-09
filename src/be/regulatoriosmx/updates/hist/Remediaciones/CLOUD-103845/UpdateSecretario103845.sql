
select *
from cobis..cl_cliente_grupo
where cg_grupo = 254

update cobis..cl_cliente_grupo
set  cg_rol = 'M'
where cg_grupo = 254
and   cg_ente  = 6706


update cobis..cl_cliente_grupo
set  cg_rol = 'S'
where cg_grupo = 254
and   cg_ente = 6696

select *
from cobis..cl_cliente_grupo
where cg_grupo = 254