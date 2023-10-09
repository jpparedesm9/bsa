use cobis
go

print 'Caso 113018 - Cliente: 84575  - selec'
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20), @w_num_operacion int
select @w_cliente = 84575
select @w_cuenta = '25001990127' -- antes cuenta 56607239267

update cobis..cl_ente_aux 
set    ea_cta_banco = @w_cuenta
where ea_ente = @w_cliente

go
