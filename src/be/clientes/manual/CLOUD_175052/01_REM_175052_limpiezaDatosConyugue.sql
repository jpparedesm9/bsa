use cobis
go

-- Clientes con estado civil DI, SO, y VI (Divorciado, Soltero y Viudo)
select *
into #cl_ente_disovi
from cobis..cl_ente
where p_estado_civil in ('DI', 'SO', 'VI')

--select p_estado_civil,* from #cl_ente_disovi

-- Conyuges antes de borrado
select * from cobis..cl_conyuge
where co_ente in (select en_ente from #cl_ente_disovi)

-- Borrado de conyuges
delete from cobis..cl_conyuge
where co_ente in (select en_ente from #cl_ente_disovi)

-- Conyuges despues de borrado
select * from cobis..cl_conyuge
where co_ente in (select en_ente from #cl_ente_disovi)

--borrado tabla temporal
drop table #cl_ente_disovi

go 
