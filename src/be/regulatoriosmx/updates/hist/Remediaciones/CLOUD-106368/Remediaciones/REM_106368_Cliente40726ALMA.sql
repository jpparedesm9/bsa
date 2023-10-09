
declare @w_cliente int, @w_cuenta varchar(24), @w_buc varchar(20)
select @w_cliente = 40726
select @w_cuenta = '060605131431'
select @w_buc = '45963289'

--select 'BUC' = en_banco, * from cobis..cl_ente where en_ente = @w_cliente
update cobis..cl_ente
set    en_banco = @w_buc
where  en_ente = @w_cliente

--select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
update cobis..cl_ente_aux 
set    ea_cta_banco  = @w_cuenta,
       ea_estado_std = 'CLI',
	   ea_estado     = 'A'
where ea_ente = @w_cliente
print 'fin'
go
