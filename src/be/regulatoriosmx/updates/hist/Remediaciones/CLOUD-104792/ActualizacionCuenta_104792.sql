use cobis
go

declare @w_codigo_cliente int

select @w_codigo_cliente = 32775


select ea_cta_banco,*
from cobis..cl_ente_aux
where ea_ente = @w_codigo_cliente


update cobis..cl_ente_aux
set    ea_cta_banco = '60604367733'
where  ea_ente = @w_codigo_cliente

select ea_cta_banco,*
from cobis..cl_ente_aux
where ea_ente = @w_codigo_cliente