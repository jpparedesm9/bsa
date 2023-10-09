declare @w_funcionario int, @w_jefe int
select @w_funcionario = 301
select @w_jefe = 0 -- antes 0

select fu_jefe, * from cobis..cl_funcionario
where fu_funcionario = @w_funcionario

update cobis..cl_funcionario
set    fu_jefe =  @w_jefe
where  fu_funcionario = @w_funcionario

select fu_jefe, * from cobis..cl_funcionario
where fu_funcionario = @w_funcionario
go
