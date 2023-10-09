use cobis
go

truncate table cl_funcionario


insert into cl_funcionario
select * from cl_funcionario_104770
go
