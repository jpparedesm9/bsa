use cobis
go

delete from cl_seqnos where tabla='cu_avaluos' and bdatos='cob_custodia'
go

insert into cl_seqnos values ('cob_custodia', 'cu_avaluos', 0, 'cu_avaluosKey')
go
