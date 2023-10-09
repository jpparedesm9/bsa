---------------
--CASO 113430
---------------
declare @w_cliente int
select @w_cliente = 14125 

print 'update genero'
update cobis..cl_ente
set    p_sexo = 'F'
where  en_ente = @w_cliente

print 'update rfc-curp'
update cobis..cl_ente
set    --en_nit = 'DODN970514M71',     -- 'DODN970514M71'      -- rfc
       en_ced_ruc = 'DODN970514MMSMZN03'--, -- 'DODN970514HMSMZN03' -- curp-numeroDocumento
       --en_rfc = 'DODN970514M71'      -- 'DODN970514M71'      -- rfc
where  en_ente = @w_cliente

update cobis..cl_ente_aux
set    ea_ced_ruc = 'DODN970514MMSMZN03'--,  ---'DODN970514HMSMZN03' --curp-numero de documento
       --ea_nit = 'DODN970514M71'       ---'DODN970514M71'      --ruc       
where  ea_ente = @w_cliente

go

declare @w_cliente int
select @w_cliente = 49558

print 'update genero'
update cobis..cl_ente
set    p_sexo = 'F'
where  en_ente = @w_cliente
go