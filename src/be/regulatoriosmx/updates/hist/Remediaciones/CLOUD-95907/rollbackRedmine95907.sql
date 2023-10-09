-------------------
--ROLLBACK CAMBIO DE ASESOR
-------------------
use cobis
go

select en_oficial,* from cl_ente where en_ente = 1951

update cl_ente
set en_oficial= 32
where en_ente = 1951

select en_oficial,* from cl_ente where en_ente = 1951

