use cobis
go

update cl_oficina set of_bloqueada = 'N'
where of_subtipo in ( 'R','Z')
and of_bloqueada is null