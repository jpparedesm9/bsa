--Clienta: María del Carmen Montoya Vega ID: 40274
--Código Santander: 10766443
--No cuenta correcta: 56706901275, por favor colocar este número de cuenta que es el mismo que tenemos en el comprobante (que se anexo en el fichero).
--No cuenta incorrecta: 56524418838

use cobis
go

print 'Caso 106181 - Cliente: 40274 - '
declare @w_cliente int, @w_cuenta varchar(24)
select @w_cliente = 40274, @w_cuenta = '56524418838'

--select 'CUENTA' = ea_cta_banco, * from cobis..cl_ente_aux where ea_ente = @w_cliente
update cobis..cl_ente_aux 
set    ea_cta_banco = @w_cuenta
where ea_ente = @w_cliente