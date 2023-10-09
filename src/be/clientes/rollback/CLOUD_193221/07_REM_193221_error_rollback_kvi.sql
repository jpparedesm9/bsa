-- REQ 193221- B2B Grupal Digital
use cobis
go

--Antes
select * from cobis..cl_errores where numero in (103199, 103204)

delete from cobis..cl_errores where numero in (103199, 103204)

--Despues
select * from cobis..cl_errores where numero in (103199, 103204)

go
