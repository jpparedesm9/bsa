use cobis
go

update cobis..cl_cliente_grupo
set cg_rol = 'M'
where cg_grupo   = 98
and cg_ente = 2807

go



