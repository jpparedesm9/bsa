use cobis
go

update cl_ente_aux set
ea_consulto_renapo = 'N'
where ea_consulto_renapo is null

go